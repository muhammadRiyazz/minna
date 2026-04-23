import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/functions/storage_utils.dart';
import 'package:minna/comman/pages/log%20in/otp_screen.dart';
import 'package:minna/comman/pages/main%20home/home.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:upgrader/upgrader.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FocusNode _phoneFocusNode = FocusNode();
  bool _isLoading = false;

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

  void _skipLogin() async {
    await StorageUtils.setIntroShown();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        setState(() => _isLoading = state.isLoading);

        if (state.navigateToOtp == true) {
          context.read<LoginBloc>().add(const LoginEvent.resetNavigation());
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  OtpScreen(phoneNumber: _phoneController.text),
            ),
          );
        }
      },
      child: UpgradeAlert(
        upgrader: Upgrader(durationUntilAlertAgain: Duration.zero),
        showIgnore: false,
        showLater: true,
        showReleaseNotes: false,
        barrierDismissible: false,
        onLater: () {
          // Navigator.pop(context); // Upgrader handles the pop if you return true
          return false;
        },
        child: Scaffold(
          backgroundColor: backgroundColor,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      // Onboarding-Themed Image Header
                      Expanded(
                        flex: 3,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.asset(
                                'asset/splash/onboarding1.jpeg',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(color: maincolor1),
                              ),
                            ),
                            // Onboarding Gradient Fade Effect
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.4),
                                      Colors.transparent,
                                      backgroundColor,
                                    ],
                                    stops: const [0.0, 0.5, 1.0],
                                  ),
                                ),
                              ),
                            ),
                            // Skip Button (Positioned Top Right)
                            Positioned(
                              top: MediaQuery.of(context).padding.top + 10,
                              right: 16,
                              child: TextButton(
                                onPressed: _skipLogin,
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  backgroundColor: Colors.black.withOpacity(
                                    0.1,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  'Skip',
                                  style: TextStyle(
                                    color: maincolor1,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Login Content (Centered form)
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Welcome Text (Onboarding Style)
                                Text(
                                  'Welcome back!',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w900,
                                    color: maincolor1,
                                    letterSpacing: -1,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Enter your mobile number to explore the world again.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: textSecondary,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 48),

                                // Attractive Input Card
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'MOBILE NUMBER',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                        color: textLight,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: backgroundColor,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: _phoneFocusNode.hasFocus
                                              ? maincolor1
                                              : borderSoft,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 14,
                                            ),
                                            child: const Text(
                                              '+91',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 16,
                                                color: textPrimary,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 1,
                                            height: 24,
                                            color: borderSoft,
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                              controller: _phoneController,
                                              focusNode: _phoneFocusNode,
                                              keyboardType: TextInputType.phone,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                LengthLimitingTextInputFormatter(
                                                  10,
                                                ),
                                              ],
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800,
                                                color: textPrimary,
                                                letterSpacing: 1.5,
                                              ),
                                              decoration: InputDecoration(
                                                hintText: '0000 000 000',
                                                hintStyle: TextStyle(
                                                  color: textLight.withOpacity(
                                                    0.4,
                                                  ),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                border: InputBorder.none,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                    ),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty)
                                                  return 'Enter number';
                                                if (value.length != 10)
                                                  return 'Invalid number';
                                                return null;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    // Action Button
                                    SizedBox(
                                      width: double.infinity,
                                      height: 60,
                                      child: ElevatedButton(
                                        onPressed: _isLoading
                                            ? null
                                            : _handleGetOtp,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: maincolor1,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              18,
                                            ),
                                          ),
                                          elevation: 8,
                                          shadowColor: maincolor1.withOpacity(
                                            0.4,
                                          ),
                                        ),
                                        child: _isLoading
                                            ? const SizedBox(
                                                width: 24,
                                                height: 24,
                                                child:
                                                    CircularProgressIndicator(
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
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 16,
                                                      letterSpacing: 1,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Icon(
                                                    Iconsax.arrow_right_3,
                                                    size: 20,
                                                  ),
                                                ],
                                              ),
                                      ),
                                    ),
                                  ],
                                ),

                                // const Spacer(),
                                // Terms Footer
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 24,
                                    horizontal: 24,
                                  ),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: TextStyle(
                                        color: textSecondary,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      children: [
                                        const TextSpan(
                                          text:
                                              'By continuing, you agree to our ',
                                        ),
                                        TextSpan(
                                          text: 'Terms of Service',
                                          style: TextStyle(
                                            color: maincolor1,
                                            fontWeight: FontWeight.w800,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () async {
                                              final Uri url = Uri.parse(
                                                'https://mttrip.in/terms-and-conditions',
                                              );
                                              if (!await launchUrl(url)) {
                                                debugPrint(
                                                  'Could not launch $url',
                                                );
                                              }
                                            },
                                        ),
                                        const TextSpan(text: ' & '),
                                        TextSpan(
                                          text: 'Privacy Policy',
                                          style: TextStyle(
                                            color: maincolor1,
                                            fontWeight: FontWeight.w800,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () async {
                                              final Uri url = Uri.parse(
                                                'https://mttrip.in/privacy-policy',
                                              );
                                              if (!await launchUrl(url)) {
                                                debugPrint(
                                                  'Could not launch $url',
                                                );
                                              }
                                            },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}
}
