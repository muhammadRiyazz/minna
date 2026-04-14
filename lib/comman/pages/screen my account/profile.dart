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
        }
      }
    } catch (e) {
      debugPrint('Fetch error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

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
          _showErrorSnackBar(data['statusDesc'] ?? 'Update failed');
        }
      }
    } catch (e) {
      _showErrorSnackBar('Update failed. Please try again.');
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
            Text(message, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(20),
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
            Text(message, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        backgroundColor: errorColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(20),
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
      backgroundColor: backgroundColor,
      body: isLoading
          ? _buildShimmerLoader()
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Stack(
                children: [
                  // 1. Immersive Header
                  _buildImmersiveHeader(),

                  // 2. Profile Content
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 180,
                      left: 20,
                      right: 20,
                      bottom: 40,
                    ),
                    child: Column(children: [_buildProfileCard()]),
                  ),

                  // Back Button
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 10,
                    left: 10,
                    child: IconButton(
                      icon: const Icon(
                        Iconsax.arrow_left_2,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildImmersiveHeader() {
    return Container(
      height: 260,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [maincolor1, maincolor1.withOpacity(0.8)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            right: 20,
            child: Icon(
              Iconsax.user,
              size: 150,
              color: Colors.white.withOpacity(0.04),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'PROFILE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 40,
                  height: 3,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Form(
          key: _formKey,
          onChanged: checkForChanges,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildModernAvatar(),
              const SizedBox(height: 40),

              _buildSectionTitle('CONTACT DETAILS'),
              const SizedBox(height: 16),
              _buildReadOnlyField('+91 $phone', Iconsax.call, 'Phone'),
              const SizedBox(height: 20),

              _buildSectionTitle('PERSONAL INFORMATION'),
              const SizedBox(height: 16),
              _buildEditableField(
                controller: nameController,
                hint: 'Full Name',
                icon: Iconsax.user,
                validator: (v) => v!.isEmpty ? 'Name required' : null,
              ),
              const SizedBox(height: 16),
              _buildEditableField(
                controller: emailController,
                hint: 'Email Address',
                icon: Iconsax.sms,
                validator: (v) =>
                    !_emailRegExp.hasMatch(v!) ? 'Invalid email' : null,
              ),
              const SizedBox(height: 16),
              _buildEditableField(
                controller: addressController,
                hint: 'Complete Address',
                icon: Iconsax.location,
                maxLines: 3,
                validator: (v) => v!.length < 5 ? 'Address too short' : null,
              ),

              const SizedBox(height: 40),
              _buildUpdateButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernAvatar() {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: Colors.white, width: 4),
              boxShadow: [
                BoxShadow(
                  color: maincolor1.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                color: maincolor1.withOpacity(0.05),
                child: const Icon(Iconsax.user, size: 45, color: maincolor1),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: maincolor1,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: const Icon(Iconsax.camera, size: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w900,
        color: textLight.withOpacity(0.8),
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildReadOnlyField(String value, IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderSoft),
      ),
      child: Row(
        children: [
          Icon(icon, color: maincolor1, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: textLight,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Icon(Iconsax.lock, size: 16, color: textLight.withOpacity(0.4)),
        ],
      ),
    );
  }

  Widget _buildEditableField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 15,
          color: textLight.withOpacity(0.6),
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(icon, color: maincolor1, size: 20),
        filled: true,
        fillColor: backgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: maincolor1, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        contentPadding: const EdgeInsets.all(20),
      ),
    );
  }

  Widget _buildUpdateButton() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: isButtonEnabled && !isUpdating ? updateProfile : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: maincolor1,
          foregroundColor: Colors.white,
          disabledBackgroundColor: maincolor1.withOpacity(0.4),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: isUpdating
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.tick_circle),
                  const SizedBox(width: 12),
                  Text(
                    'SAVE CHANGES',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildShimmerLoader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          children: [
            const SizedBox(height: 40),
            Container(
              width: 110,
              height: 110,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 40),
            ...List.generate(
              4,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
