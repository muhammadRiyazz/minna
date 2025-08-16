// import 'package:minna/comman/const/const.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _phoneController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   final FocusNode _phoneFocusNode = FocusNode();
//   bool _showOtpSection = false;

//   final List<TextEditingController> _otpControllers = List.generate(
//     6,
//     (_) => TextEditingController(),
//   );
//   final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       FocusScope.of(context).requestFocus(_phoneFocusNode);
//     });
//   }

//   @override
//   void dispose() {
//     _phoneController.dispose();
//     _phoneFocusNode.dispose();
//     for (var c in _otpControllers) {
//       c.dispose();
//     }
//     for (var f in _otpFocusNodes) {
//       f.dispose();
//     }
//     super.dispose();
//   }

//   Future<void> _handleGetOtp() async {
//     if (_formKey.currentState!.validate()) {
//       await Future.delayed(const Duration(seconds: 1)); // Simulate OTP send
//       setState(() => _showOtpSection = true);
//       FocusScope.of(context).requestFocus(_otpFocusNodes[0]);
//     }
//   }

//   void _verifyOtp() {
//     String otp = _otpControllers.map((c) => c.text).join();
//     if (otp.length == 6) {
//       // Implement your logic here
//       Navigator.pop(context);
//     }
//   }

//   void _resendOtp() {
//     // Implement resend OTP logic
//     FocusScope.of(context).requestFocus(_otpFocusNodes[0]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Skip Button
//                 Align(
//                   alignment: Alignment.topRight,
//                   child: TextButton(
//                     onPressed: () {
//                       Navigator.pop(context); // Replace with your skip logic
//                     },
//                     child: const Text("Skip"),
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 Text(
//                   _showOtpSection ? 'Verify OTP' : 'Login',
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   _showOtpSection
//                       ? 'Enter the OTP sent to +91${_phoneController.text}'
//                       : 'Enter your mobile number to continue',
//                   style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                 ),
//                 const SizedBox(height: 24),

//                 if (!_showOtpSection) ...[
//                   TextFormField(
//                     controller: _phoneController,
//                     focusNode: _phoneFocusNode,
//                     keyboardType: TextInputType.phone,
//                     inputFormatters: [
//                       FilteringTextInputFormatter.digitsOnly,
//                       LengthLimitingTextInputFormatter(10),
//                     ],
//                     decoration: InputDecoration(
//                       labelText: 'Mobile Number',
//                       prefix: const Padding(
//                         padding: EdgeInsets.only(right: 8.0),
//                         child: Text(
//                           '+91',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       border: const OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty)
//                         return 'Enter mobile number';
//                       if (value.length != 10)
//                         return 'Enter valid 10-digit number';
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 24),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: TextButton(
//                       onPressed: _handleGetOtp,
//                       style: TextButton.styleFrom(
//                         backgroundColor: maincolor1,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                       child: const Text(
//                         'Get OTP',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w900,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ] else ...[
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: List.generate(6, (index) {
//                       return SizedBox(
//                         width: 40,
//                         child: TextFormField(
//                           controller: _otpControllers[index],
//                           focusNode: _otpFocusNodes[index],
//                           textAlign: TextAlign.center,
//                           keyboardType: TextInputType.number,
//                           maxLength: 1,
//                           decoration: const InputDecoration(
//                             counterText: '',
//                             border: OutlineInputBorder(),
//                           ),
//                           onChanged: (value) {
//                             if (value.isNotEmpty && index < 5) {
//                               FocusScope.of(
//                                 context,
//                               ).requestFocus(_otpFocusNodes[index + 1]);
//                             }
//                             if (value.isEmpty && index > 0) {
//                               FocusScope.of(
//                                 context,
//                               ).requestFocus(_otpFocusNodes[index - 1]);
//                             }
//                             if (index == 5 && value.isNotEmpty) {
//                               _verifyOtp();
//                             }
//                           },
//                         ),
//                       );
//                     }),
//                   ),
//                   const SizedBox(height: 16),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: InkWell(
//                       onTap: _resendOtp,
//                       child: Text(
//                         'Resend OTP',
//                         style: TextStyle(
//                           color: maincolor1,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: TextButton(
//                       onPressed: _verifyOtp,
//                       style: TextButton.styleFrom(
//                         backgroundColor: maincolor1,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                       child: const Text(
//                         'Verify',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w900,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
