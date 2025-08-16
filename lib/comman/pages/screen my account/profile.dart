import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

  String userId = '';
  String phone = '';
  String name = '';
  String email = '';
  String address = '';

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserIdAndProfile();
  }

  Future<void> fetchUserIdAndProfile() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId') ?? '';
    await fetchProfile();
  }

  Future<void> fetchProfile() async {
    setState(() => isLoading = true);
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}profile'),
        body: {'userId': userId},
      );

      final data = json.decode(response.body);
      if (data['status'] == 'SUCCESS') {
        final profile = data['data'];
        setState(() {
          name = profile['name'] ?? '';
          phone = profile['phno'] ?? '';
          email = profile['email'] ?? '';
          address = profile['address'] ?? '';

          nameController.text = name;
          emailController.text = email;
          addressController.text = address;
        });
      }
    } catch (e) {
      debugPrint('Fetch error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}profile-update'),
        body: {
          'userId': userId,
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'address': addressController.text.trim(),
        },
      );

      final data = json.decode(response.body);
      if (data['status'] == 'SUCCESS') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: const [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 10),
                Expanded(child: Text('Profile updated successfully')),
              ],
            ),
            backgroundColor: Colors.green.shade600,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            duration: const Duration(seconds: 2),
          ),
        );
        await fetchProfile();
        setState(() => isButtonEnabled = false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white),
                const SizedBox(width: 10),
                Expanded(child: Text(data['statusDesc'] ?? 'Update failed')),
              ],
            ),
            backgroundColor: Colors.red.shade600,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      debugPrint('Update error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  void checkForChanges() {
    final hasChanged =
        nameController.text.trim() != name ||
        emailController.text.trim() != email ||
        addressController.text.trim() != address;

    setState(() {
      isButtonEnabled = hasChanged;
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
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'My Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: maincolor1,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      body: isLoading
          ? _buildShimmerLoader()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Form(
                key: _formKey,
                onChanged: checkForChanges,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Icon(
                            Icons.person,
                            size: 80,
                            color: maincolor1,
                          ),
                        ),
                        const SizedBox(height: 30),

                        _buildLabel('Phone Number'),
                        _buildReadOnlyField('+91 $phone', Icons.phone),

                        const SizedBox(height: 15),
                        _buildLabel('Name'),
                        _buildEditableField(
                          nameController,
                          'Enter your name',
                          Icons.person_outline,
                        ),

                        const SizedBox(height: 15),
                        _buildLabel('Email'),
                        _buildEditableField(
                          emailController,
                          'Enter your email',
                          Icons.email_outlined,
                          isEmail: true,
                        ),

                        const SizedBox(height: 15),
                        _buildLabel('Address'),
                        _buildEditableField(
                          addressController,
                          'Enter your address',
                          Icons.location_on_outlined,
                        ),

                        if (isButtonEnabled) const SizedBox(height: 20),

                        if (isButtonEnabled)
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: updateProfile,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: maincolor1,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Update Profile',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white, // 👈 Font color white
                                  fontSize: 16,
                                ),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  Widget _buildReadOnlyField(String value, IconData icon) {
    return TextFormField(
      initialValue: value,
      enabled: false,
      style: const TextStyle(
        color: Colors.black87,
      ), // normal enabled field text color
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: maincolor1),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(12),
        ),

        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
      ),
    );
  }

  Widget _buildEditableField(
    TextEditingController controller,
    String hint,
    IconData icon, {
    bool isEmail = false,
  }) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.trim().isEmpty) return 'Required';
        if (isEmail && !RegExp(r'\S+@\S+\.\S+').hasMatch(value))
          return 'Enter a valid email';
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: maincolor1),
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

Widget _buildShimmerLoader() {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: CircleAvatar(radius: 40, backgroundColor: Colors.white),
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
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(width: 100, height: 12, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 48,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    ),
  );
}
