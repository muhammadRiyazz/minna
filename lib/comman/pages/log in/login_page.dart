import 'package:iconsax/iconsax.dart';
import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/pages/log%20in/otp_page_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBottomSheet extends StatefulWidget {
  final int login;
  const LoginBottomSheet({super.key, required this.login});

  @override
  _LoginBottomSheetState createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FocusNode _phoneFocusNode = FocusNode();
  bool _isLoading = false;

  // Modern Premium Theme Variables
  final Color _primaryColor = maincolor1; // Deep Ocean Blue
  final Color _secondaryColor = secondaryColor; // Gold
  final Color _backgroundColor = backgroundColor;
  final Color _cardColor = cardColor;
  final Color _textPrimary = textPrimary;
  final Color _textSecondary = textSecondary;
  final Color _textLight = textLight;
  final Color _errorColor = errorColor;
  final Color _borderColor = borderSoft;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_phoneFocusNode);
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  Future<void> _handleGetOtp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final phoneNumber = _phoneController.text;
      context.read<LoginBloc>().add(
        LoginEvent.numbnerLogin(phoneNo: phoneNumber),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isLoading) {
          setState(() => _isLoading = true);
        } else {
          setState(() => _isLoading = false);
        }

        if (state.navigateToOtp == true) {
          context.read<LoginBloc>().add(const LoginEvent.resetNavigation());
          Navigator.pop(context); // Close the login bottom sheet
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) =>
                OtpBottomSheet(phoneNumber: _phoneController.text),
          );
        }

        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: _errorColor,
              content: Row(
                children: [
                  const Icon(Iconsax.danger, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      state.errorMessage!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: _cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 30,
                offset: const Offset(0, -10),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Handle decoration
                const SizedBox(height: 12),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: _textLight.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 12),

                Stack(
                  children: [
                    // Background Decorative Element
                    Positioned(
                      right: -20,
                      top: -10,
                      child: Icon(
                        Iconsax.login_1,
                        size: 140,
                        color: _primaryColor.withOpacity(0.04),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header with Close
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Welcome Back',
                                        style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.w900,
                                          color: _primaryColor,
                                          letterSpacing: -0.5,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Enter your mobile number to continue',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: _textSecondary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: _backgroundColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: _borderColor),
                                    ),
                                    child: Icon(
                                      Iconsax.close_circle,
                                      color: _textSecondary,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 32),

                            // Login Required Warning
                            if (widget.login == 1) ...[
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: _primaryColor.withOpacity(0.03),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: _primaryColor.withOpacity(0.1),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Iconsax.info_circle,
                                      color: _primaryColor,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        'Please log in to proceed with your booking or activity.',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: _textPrimary,
                                          fontWeight: FontWeight.w600,
                                          height: 1.4,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],

                            // Phone Label & Input
                            Text(
                              'MOBILE NUMBER',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: _textLight,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              decoration: BoxDecoration(
                                color: _backgroundColor,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: _borderColor),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _primaryColor.withOpacity(0.05),
                                      borderRadius:
                                          const BorderRadius.horizontal(
                                            left: Radius.circular(20),
                                          ),
                                    ),
                                    child: const Text(
                                      '+91',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16,
                                        color: textPrimary,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _phoneController,
                                      focusNode: _phoneFocusNode,
                                      keyboardType: TextInputType.phone,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: textPrimary,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: '0000 000 000',
                                        hintStyle: TextStyle(
                                          color: _textLight.withOpacity(0.5),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        border: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 20,
                                            ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty)
                                          return 'Please enter number';
                                        if (value.length != 10)
                                          return 'Invalid number';
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),

                            // GET OTP Button
                            SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _handleGetOtp,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _secondaryColor,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 8,
                                  shadowColor: _secondaryColor.withOpacity(0.4),
                                ),
                                child: _isLoading
                                    ? const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'GET OTP',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          Icon(Iconsax.arrow_right_3, size: 20),
                                        ],
                                      ),
                              ),
                            ),

                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
