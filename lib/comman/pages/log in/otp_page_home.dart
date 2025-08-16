import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                /// Status Box - success OR error
                if (_showSuccess)
                  _statusBox(
                    icon: Icons.check_circle,
                    color: Colors.green,
                    text: 'Login Successfully Completed',
                    subtitle: 'You can now continue using the app.',
                  )
                else if (_showError)
                  _statusBox(
                    icon: Icons.error,
                    color: Colors.red,
                    text: _errorMessage ?? "Something went wrong",
                    subtitle: 'Please try again or resend OTP.',
                  ),

                /// OTP Input and Buttons
                if (!_showSuccess && !_isLoading) ...[
                  const Text(
                    'Verify OTP',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'OTP sent to +91 ${widget.phoneNumber}',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (index) {
                      return SizedBox(
                        width: 60,
                        child: TextField(
                          controller: _otpControllers[index],
                          focusNode: _otpFocusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.length == 1 && index < 3) {
                              FocusScope.of(
                                context,
                              ).requestFocus(_otpFocusNodes[index + 1]);
                            } else if (value.isEmpty && index > 0) {
                              FocusScope.of(
                                context,
                              ).requestFocus(_otpFocusNodes[index - 1]);
                            } else if (value.length == 1 && index == 3) {
                              _verifyOtp();
                            }
                          },
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _verifyOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: maincolor1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Verify',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _showError = false;
                          _errorMessage = null;
                          _showSuccess = false;
                        });
                        _resetOtpFields();
                        context.read<LoginBloc>().add(
                          LoginEvent.numbnerLogin(phoneNo: widget.phoneNumber),
                        );
                      },
                      child: const Text(
                        "Resend OTP",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],

                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Center(child: CircularProgressIndicator()),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _statusBox({
    required IconData icon,
    required Color color,
    required String text,
    String? subtitle,
  }) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Center(child: Icon(icon, size: 100, color: color)),
        const SizedBox(height: 16),
        Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Center(
            child: Text(
              subtitle,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
        const SizedBox(height: 40),
      ],
    );
  }
}
