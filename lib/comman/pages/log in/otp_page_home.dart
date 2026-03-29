import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/const/const.dart';

class OtpBottomSheet extends StatefulWidget {
  final String phoneNumber;
  const OtpBottomSheet({super.key, required this.phoneNumber});

  @override
  State<OtpBottomSheet> createState() => _OtpBottomSheetState();
}

class _OtpBottomSheetState extends State<OtpBottomSheet> {
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _otpFocusNodes = List.generate(4, (_) => FocusNode());

  bool _isLoading = false;
  bool _showSuccess = false;
  bool _showError = false;
  String? _errorMessage;

  // Modern Premium Theme Variables
  final Color _primaryColor = maincolor1; // Deep Ocean Blue
  final Color _secondaryColor = secondaryColor; // Gold
  final Color _backgroundColor = backgroundColor;
  final Color _cardColor = cardColor;
  final Color _textPrimary = textPrimary;
  final Color _textSecondary = textSecondary;
  final Color _textLight = textLight;
  final Color _errorColor = errorColor;
  final Color _successColor = const Color(0xFF0D9488);
  final Color _borderColor = borderSoft;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_otpFocusNodes[0]);
    });
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _otpFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _verifyOtp() {
    String otp = _otpControllers.map((e) => e.text).join();
    if (otp.length == 4) {
      setState(() {
        _isLoading = true;
        _showError = false;
        _errorMessage = null;
        _showSuccess = false;
      });
      context.read<LoginBloc>().add(LoginEvent.otpVerification(otp: otp));
    } else {
      setState(() {
        _showError = true;
        _errorMessage = "Enter valid 4-digit OTP";
        _showSuccess = false;
      });
    }
  }

  void _resetOtpFields() {
    for (var controller in _otpControllers) {
      controller.clear();
    }
    FocusScope.of(context).requestFocus(_otpFocusNodes[0]);
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

        if (state.isLoggedIn == true) {
          setState(() {
            _showSuccess = true;
            _showError = false;
            _errorMessage = null;
          });
        }

        if (state.errorMessage != null) {
          setState(() {
            _showSuccess = false;
            _showError = true;
            _errorMessage = state.errorMessage;
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: _cardColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(32),
            ),
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

                Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Status Content OR Input Content
                      if (_showSuccess)
                        _buildStatusBox(
                          icon: Iconsax.verify,
                          color: _successColor,
                          title: 'Verification Done',
                          subtitle: 'Your profile has been authenticated securely.',
                          buttonText: 'CONTINUE',
                          onButtonPressed: () => Navigator.pop(context),
                        )
                      else if (_showError)
                        _buildStatusBox(
                          icon: Iconsax.danger,
                          color: _errorColor,
                          title: 'Access Denied',
                          subtitle: _errorMessage ?? "The OTP you entered is incorrect.",
                          buttonText: 'TRY AGAIN',
                          onButtonPressed: _resetOtpFields,
                        )
                      else if (_isLoading)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 60),
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 4,
                                    color: _secondaryColor,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  'Verifying Security Code...',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: _textSecondary,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Verify OTP',
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w900,
                                      color: _primaryColor,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Enter the 4-digit code sent to you',
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
                                child: Icon(Iconsax.close_circle, color: _textSecondary, size: 20),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 32),

                        // Animated Target Number
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: _primaryColor.withOpacity(0.04),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: _primaryColor.withOpacity(0.06)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Iconsax.mobile, size: 16, color: _primaryColor),
                              const SizedBox(width: 10),
                              Text(
                                '+91 ${widget.phoneNumber}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: _primaryColor,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Modernized OTP Input Fields
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(4, (index) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 65,
                              height: 65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: _otpFocusNodes[index].hasFocus
                                      ? _secondaryColor
                                      : _borderColor,
                                  width: _otpFocusNodes[index].hasFocus ? 2.5 : 1,
                                ),
                                color: _otpFocusNodes[index].hasFocus 
                                    ? Colors.white 
                                    : _backgroundColor,
                                boxShadow: _otpFocusNodes[index].hasFocus
                                    ? [BoxShadow(color: _secondaryColor.withOpacity(0.1), blurRadius: 10)]
                                    : [],
                              ),
                              child: Center(
                                child: TextField(
                                  controller: _otpControllers[index],
                                  focusNode: _otpFocusNodes[index],
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  maxLength: 1,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    color: _primaryColor,
                                  ),
                                  decoration: const InputDecoration(
                                    counterText: '',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  onChanged: (value) {
                                    if (value.length == 1 && index < 3) {
                                      FocusScope.of(context).requestFocus(_otpFocusNodes[index + 1]);
                                    } else if (value.isEmpty && index > 0) {
                                      FocusScope.of(context).requestFocus(_otpFocusNodes[index - 1]);
                                    } else if (value.length == 1 && index == 3) {
                                      _verifyOtp();
                                    }
                                  },
                                ),
                              ),
                            );
                          }),
                        ),
                        
                        const SizedBox(height: 40),

                        // VERIFY Button
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: _verifyOtp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _secondaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              elevation: 8,
                              shadowColor: _secondaryColor.withOpacity(0.4),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'VERIFY NOW',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Icon(Iconsax.verify, size: 20),
                              ],
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 24),

                        // Resend Section
                        Center(
                          child: Column(
                            children: [
                              Text(
                                "Didn't receive the code?",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: _textLight,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _showError = false;
                                    _errorMessage = null;
                                  });
                                  _resetOtpFields();
                                  context.read<LoginBloc>().add(
                                    LoginEvent.numbnerLogin(phoneNo: widget.phoneNumber),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: _secondaryColor,
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  backgroundColor: _secondaryColor.withOpacity(0.05),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Iconsax.refresh, size: 16),
                                    const SizedBox(width: 8),
                                    const Text(
                                      "Resend Security Code",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBox({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required String buttonText,
    required VoidCallback onButtonPressed,
  }) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 50, color: color),
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: color,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 15,
              color: _textSecondary,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: onButtonPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 4,
              shadowColor: color.withOpacity(0.3),
            ),
            child: Text(
              buttonText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}