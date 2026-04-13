import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/functions/storage_utils.dart';
import 'package:minna/comman/pages/main%20home/home.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _otpFocusNodes = List.generate(4, (_) => FocusNode());

  bool _isLoading = false;
  String? _errorMessage;

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
        _errorMessage = null;
      });
      context.read<LoginBloc>().add(LoginEvent.otpVerification(otp: otp));
    } else {
      setState(() {
        _errorMessage = "Please enter the complete 4-digit code";
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
        setState(() => _isLoading = state.isLoading);

        if (state.isLoggedIn == true) {
          StorageUtils.setIntroShown();
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const HomePage()),
            (route) => false,
          );
        }

        if (state.errorMessage != null) {
          setState(() {
            _errorMessage = state.errorMessage;
          });
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Iconsax.arrow_left, color: textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 32),

                        Text(
                          'Verify OTP',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: maincolor1,
                            letterSpacing: -1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 15,
                              color: textSecondary,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                            ),
                            children: [
                              const TextSpan(
                                text: 'We have sent a 4-digit code to\n',
                              ),
                              TextSpan(
                                text: '+91 ${widget.phoneNumber}',
                                style: TextStyle(
                                  color: maincolor1,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 48),

                        // OTP Input Fields
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(4, (index) {
                            return Flexible(
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                height: 68,
                                decoration: BoxDecoration(
                                  color: cardColor,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: _otpFocusNodes[index].hasFocus
                                        ? secondaryColor
                                        : borderSoft,
                                    width: _otpFocusNodes[index].hasFocus
                                        ? 2
                                        : 1.5,
                                  ),
                                  boxShadow: [
                                    if (_otpFocusNodes[index].hasFocus)
                                      BoxShadow(
                                        color: secondaryColor.withOpacity(0.1),
                                        blurRadius: 12,
                                        offset: const Offset(0, 6),
                                      ),
                                  ],
                                ),
                                child: Center(
                                  child: TextField(
                                    controller: _otpControllers[index],
                                    focusNode: _otpFocusNodes[index],
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    maxLength: 1,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                      color: maincolor1,
                                    ),
                                    decoration: const InputDecoration(
                                      counterText: '',
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      if (value.length == 1 && index < 3) {
                                        FocusScope.of(context).requestFocus(
                                          _otpFocusNodes[index + 1],
                                        );
                                      } else if (value.isEmpty && index > 0) {
                                        FocusScope.of(context).requestFocus(
                                          _otpFocusNodes[index - 1],
                                        );
                                      } else if (value.length == 1 &&
                                          index == 3) {
                                        _verifyOtp();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),

                        if (_errorMessage != null) ...[
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Iconsax.danger,
                                color: errorColor,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _errorMessage!,
                                style: const TextStyle(
                                  color: errorColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],

                        const SizedBox(height: 48),

                        // Verify Button
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _verifyOtp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: maincolor1,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              elevation: 8,
                              shadowColor: maincolor1.withOpacity(0.4),
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

                        const Spacer(),
                        const SizedBox(height: 32),

                        // Resend Section
                        Column(
                          children: [
                            Text(
                              "Didn't receive the code?",
                              style: TextStyle(
                                fontSize: 14,
                                color: textLight,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: _isLoading
                                  ? null
                                  : () {
                                      setState(() => _errorMessage = null);
                                      _resetOtpFields();
                                      context.read<LoginBloc>().add(
                                        LoginEvent.numbnerLogin(
                                          phoneNo: widget.phoneNumber,
                                        ),
                                      );
                                    },
                              style: TextButton.styleFrom(
                                foregroundColor: secondaryColor,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 8,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "Resend Code",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
