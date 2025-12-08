import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:minna/comman/core/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Color Theme
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37);
  final Color _accentColor = Color(0xFFC19B3C);
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);
  final Color _errorColor = Color(0xFFE53935);
  final Color _successColor = Color(0xFF00C853);
  final Color _warningColor = Color(0xFFFF9800);

  bool isLoading = true;
  bool isButtonEnabled = false;
  bool isUpdating = false;

  String userId = '';
  String phone = '';
  String name = '';
  String email = '';
  String address = '';

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  // Validation patterns
  final RegExp _nameRegExp = RegExp(r'^[a-zA-Z\s]{2,50}$');
  final RegExp _emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final RegExp _addressRegExp = RegExp(r'^[\w\s\-,.#]{10,200}$');

  @override
  void initState() {
    super.initState();
    fetchUserIdAndProfile();
  }

  Future<void> fetchUserIdAndProfile() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId') ?? '';
    if (userId.isEmpty) {
      _showErrorSnackBar('User not found. Please login again.');
      return;
    }
    await fetchProfile();
  }

  Future<void> fetchProfile() async {
    setState(() => isLoading = true);
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}profile'),
        body: {'userId': userId},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'SUCCESS') {
          final profile = data['data'];
          setState(() {
            name = profile['name']?.toString().trim() ?? '';
            phone = profile['phno']?.toString().trim() ?? '';
            email = profile['email']?.toString().trim() ?? '';
            address = profile['address']?.toString().trim() ?? '';

            nameController.text = name;
            emailController.text = email;
            addressController.text = address;
          });
        } else {
          _showErrorSnackBar(data['statusDesc'] ?? 'Failed to load profile');
        }
      } else {
        _showErrorSnackBar('Server error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Fetch error: $e');
      _showErrorSnackBar('Network error: Please check your connection');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> updateProfile() async {
    if (!_formKey.currentState!.validate()) {
      _showWarningSnackBar('Please fix the errors before submitting');
      return;
    }

    setState(() {
      isUpdating = true;
      isButtonEnabled = false;
    });

    try {
      final response = await http.post(
        Uri.parse('${baseUrl}profile-update'),
        body: {
          'userId': userId,
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'address': addressController.text.trim(),
        },
      ).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'SUCCESS') {
          _showSuccessSnackBar('Profile updated successfully!');
          // Update local state with new values
          setState(() {
            name = nameController.text.trim();
            email = emailController.text.trim();
            address = addressController.text.trim();
          });
        } else {
          _showErrorSnackBar(data['statusDesc'] ?? 'Update failed. Please try again.');
        }
      } else {
        _showErrorSnackBar('Server error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Update error: $e');
      if (e is http.ClientException) {
        _showErrorSnackBar('Network error: Please check your internet connection');
      } else {
        _showErrorSnackBar('Update failed. Please try again.');
      }
    } finally {
      setState(() {
        isUpdating = false;
        checkForChanges(); // Re-check changes after update
      });
    }
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: _cardColor, size: 20),
            SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: _successColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          textColor: _cardColor,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: _cardColor, size: 20),
            SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: _errorColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'RETRY',
          textColor: _cardColor,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            fetchProfile();
          },
        ),
      ),
    );
  }

  void _showWarningSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: _cardColor, size: 20),
            SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: _warningColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void checkForChanges() {
    final hasChanged =
        nameController.text.trim() != name ||
        emailController.text.trim() != email ||
        addressController.text.trim() != address;

    setState(() {
      isButtonEnabled = hasChanged && !isUpdating;
    });
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    if (value.trim().length > 50) {
      return 'Name cannot exceed 50 characters';
    }
    if (!_nameRegExp.hasMatch(value.trim())) {
      return 'Please enter a valid name (letters and spaces only)';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email address is required';
    }
    if (!_emailRegExp.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    if (value.trim().length > 100) {
      return 'Email cannot exceed 100 characters';
    }
    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Address is required';
    }
    if (value.trim().length < 10) {
      return 'Address must be at least 10 characters';
    }
    if (value.trim().length > 200) {
      return 'Address cannot exceed 200 characters';
    }
    if (!_addressRegExp.hasMatch(value.trim())) {
      return 'Please enter a valid address';
    }
    return null;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: _cardColor),
        title: Text(
          'My Profile',
          style: TextStyle(
            color: _cardColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: _primaryColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        actions: [
          if (!isLoading)
            IconButton(
              icon: Icon(Icons.refresh_rounded, color: _cardColor),
              onPressed: fetchProfile,
              tooltip: 'Refresh Profile',
            ),
        ],
      ),
      body: isLoading
          ? _buildShimmerLoader()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                onChanged: checkForChanges,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Container(
                  decoration: BoxDecoration(
                    color: _cardColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: _secondaryColor.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile Avatar
                        Center(
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _secondaryColor.withOpacity(0.1),
                              border: Border.all(
                                color: _secondaryColor,
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: _secondaryColor.withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.person_rounded,
                              size: 50,
                              color: _secondaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Phone Number (Read-only)
                        _buildLabel('Phone Number'),
                        const SizedBox(height: 8),
                        _buildReadOnlyField('+91 $phone', Icons.phone_rounded),

                        const SizedBox(height: 20),
                        
                        // Name
                        _buildLabel('Full Name *'),
                        const SizedBox(height: 8),
                        _buildEditableField(
                          controller: nameController,
                          hint: 'Enter your full name',
                          icon: Icons.person_outline_rounded,
                          validator: _validateName,
                          maxLength: 50,
                        ),

                        const SizedBox(height: 20),
                        
                        // Email
                        _buildLabel('Email Address *'),
                        const SizedBox(height: 8),
                        _buildEditableField(
                          controller: emailController,
                          hint: 'Enter your email address',
                          icon: Icons.email_outlined,
                          validator: _validateEmail,
                          keyboardType: TextInputType.emailAddress,
                          maxLength: 100,
                        ),

                        const SizedBox(height: 20),
                        
                        // Address
                        _buildLabel('Delivery Address *'),
                        const SizedBox(height: 8),
                        _buildEditableField(
                          controller: addressController,
                          hint: 'Enter your complete address (min. 10 characters)',
                          icon: Icons.location_on_outlined,
                          validator: _validateAddress,
                          maxLines: 3,
                          maxLength: 200,
                        ),

                        // Update Button
                        if (isButtonEnabled) const SizedBox(height: 24),
                        if (isButtonEnabled)
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isUpdating ? null : updateProfile,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _secondaryColor,
                                foregroundColor: _cardColor,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                                shadowColor: _secondaryColor.withOpacity(0.3),
                                disabledBackgroundColor: _secondaryColor.withOpacity(0.5),
                              ),
                              child: isUpdating
                                  ? SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: _cardColor,
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.save_rounded, size: 20),
                                        SizedBox(width: 8),
                                        Text(
                                          'Update Profile',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),

                        // Required fields note
                        if (!isButtonEnabled) const SizedBox(height: 16),
                        if (!isButtonEnabled)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              '* Required fields',
                              style: TextStyle(
                                fontSize: 12,
                                color: _textLight,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: _textPrimary,
      ),
    );
  }

  Widget _buildReadOnlyField(String value, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _textLight.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: _secondaryColor, size: 20),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                value.isNotEmpty ? value : 'Not provided',
                style: TextStyle(
                  color: value.isNotEmpty ? _textSecondary : _textLight,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(Icons.lock_outline_rounded, size: 16, color: _textLight),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    int? maxLength,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(
        color: _textPrimary,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: _secondaryColor),
        hintText: hint,
        hintStyle: TextStyle(color: _textLight),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _textLight.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _textLight.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _secondaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _errorColor, width: 2),
        ),
        contentPadding:  EdgeInsets.symmetric(
          horizontal: 16,
          vertical: maxLines > 1 ? 16 : 0,
        ),
        counterText: '',
        errorMaxLines: 2,
      ),
    );
  }

  Widget _buildShimmerLoader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _cardColor,
                ),
              ),
            ),
            const SizedBox(height: 30),
            ...List.generate(4, (index) => _buildShimmerField()),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: 100,
              height: 14,
              decoration: BoxDecoration(
                color: _cardColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 48,
              width: double.infinity,
              decoration: BoxDecoration(
                color: _cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}