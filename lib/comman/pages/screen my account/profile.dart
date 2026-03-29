import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/core/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Theme Variables
  final Color _primaryColor = maincolor1;
  final Color _secondaryColor = secondaryColor;
  final Color _backgroundColor = backgroundColor;
  final Color _cardColor = cardColor;
  final Color _textPrimary = textPrimary;
  final Color _textLight = textLight;
  final Color _errorColor = errorColor;
  final Color _successColor = const Color(0xFF0D9488);
  final Color _warningColor = const Color(0xFFD97706);

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
        Uri.parse('${baseUrl}mobiprofile'),
        body: {'userId': userId},
      );
      log(response.body.toString());
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
      final response = await http
          .post(
            Uri.parse('${baseUrl}profile-update'),
            body: {
              'userId': userId,
              'name': nameController.text.trim(),
              'email': emailController.text.trim(),
              'address': addressController.text.trim(),
            },
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'SUCCESS') {
          _showSuccessSnackBar('Profile updated successfully!');
          setState(() {
            name = nameController.text.trim();
            email = emailController.text.trim();
            address = addressController.text.trim();
          });
        } else {
          _showErrorSnackBar(
            data['statusDesc'] ?? 'Update failed. Please try again.',
          );
        }
      } else {
        _showErrorSnackBar('Server error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Update error: $e');
      if (e is http.ClientException) {
        _showErrorSnackBar(
          'Network error: Please check your internet connection',
        );
      } else {
        _showErrorSnackBar('Update failed. Please try again.');
      }
    } finally {
      setState(() {
        isUpdating = false;
        checkForChanges();
      });
    }
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Iconsax.tick_circle, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        backgroundColor: _successColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Iconsax.danger, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        backgroundColor: _errorColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _showWarningSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Iconsax.warning_2, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        backgroundColor: _warningColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
    if (value == null || value.trim().isEmpty) return 'Full name is required';
    if (value.trim().length < 2) return 'Name must be at least 2 characters';
    if (!_nameRegExp.hasMatch(value.trim())) return 'Letters and spaces only';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty)
      return 'Email address is required';
    if (!_emailRegExp.hasMatch(value.trim())) return 'Enter a valid email';
    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) return 'Address is required';
    if (value.trim().length < 10) return 'Min. 10 characters required';
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
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: _primaryColor,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        actions: [
          if (!isLoading)
            IconButton(
              icon: const Icon(Iconsax.refresh, color: Colors.white),
              onPressed: fetchProfile,
              tooltip: 'Refresh Profile',
            ),
        ],
      ),
      body: isLoading
          ? _buildShimmerLoader()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                onChanged: checkForChanges,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Container(
                  decoration: BoxDecoration(
                    color: _cardColor,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                    border: Border.all(
                      color: _secondaryColor.withOpacity(0.05),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              Container(
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      _secondaryColor.withOpacity(0.1),
                                      _secondaryColor.withOpacity(0.05),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  border: Border.all(
                                    color: _secondaryColor.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _cardColor,
                                    ),
                                    child: Icon(
                                      Iconsax.user,
                                      size: 44,
                                      color: _secondaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: _secondaryColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: _cardColor,
                                      width: 3,
                                    ),
                                  ),
                                  child: const Icon(
                                    Iconsax.camera,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        _buildLabel('Phone Number'),
                        const SizedBox(height: 10),
                        _buildReadOnlyField('+91 $phone', Iconsax.call),
                        const SizedBox(height: 24),
                        _buildLabel('Full Name *'),
                        const SizedBox(height: 10),
                        _buildEditableField(
                          controller: nameController,
                          hint: 'Enter your full name',
                          icon: Iconsax.user,
                          validator: _validateName,
                          maxLength: 50,
                        ),
                        const SizedBox(height: 24),
                        _buildLabel('Email Address *'),
                        const SizedBox(height: 10),
                        _buildEditableField(
                          controller: emailController,
                          hint: 'Enter your email address',
                          icon: Iconsax.sms,
                          validator: _validateEmail,
                          keyboardType: TextInputType.emailAddress,
                          maxLength: 100,
                        ),
                        const SizedBox(height: 24),
                        _buildLabel('Delivery Address *'),
                        const SizedBox(height: 10),
                        _buildEditableField(
                          controller: addressController,
                          hint: 'Enter your complete address',
                          icon: Iconsax.location,
                          validator: _validateAddress,
                          maxLines: 3,
                          maxLength: 200,
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isButtonEnabled && !isUpdating
                                ? updateProfile
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _secondaryColor,
                              foregroundColor: Colors.white,
                              disabledBackgroundColor: _secondaryColor
                                  .withOpacity(0.4),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                            child: isUpdating
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: Colors.white,
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Iconsax.document_upload, size: 20),
                                      SizedBox(width: 10),
                                      Text(
                                        'Update Profile',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: Text(
                            '* Required internal information',
                            style: TextStyle(
                              fontSize: 12,
                              color: _textLight.withOpacity(0.7),
                              fontWeight: FontWeight.w500,
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
        fontWeight: FontWeight.w800,
        fontSize: 13,
        color: _textPrimary.withOpacity(0.8),
        letterSpacing: 0.2,
      ),
    );
  }

  Widget _buildReadOnlyField(String value, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _secondaryColor.withOpacity(0.05)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _secondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: _secondaryColor, size: 18),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                value.isNotEmpty ? value : 'Not provided',
                style: TextStyle(
                  color: value.isNotEmpty ? _textPrimary : _textLight,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Icon(Iconsax.lock, size: 16, color: _textLight.withOpacity(0.5)),
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
        fontWeight: FontWeight.w700,
      ),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _secondaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: _secondaryColor, size: 18),
          ),
        ),
        hintText: hint,
        hintStyle: TextStyle(color: _textLight, fontWeight: FontWeight.w500),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: _secondaryColor.withOpacity(0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: _secondaryColor.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: _secondaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: _errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: _errorColor, width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: maxLines > 1 ? 16 : 12,
        ),
        counterText: '',
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
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 8),
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
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
