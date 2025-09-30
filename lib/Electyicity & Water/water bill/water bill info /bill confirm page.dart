// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:minna/Electyicity%20&%20Water/application/fetch%20bill/fetch_bill_bloc.dart';
// import 'package:minna/comman/const/const.dart';
// // import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:shimmer/shimmer.dart';

// class WaterBillDetailsPage extends StatefulWidget {
//   final String provider;
//   const WaterBillDetailsPage({super.key, required this.provider});

//   @override
//   State<WaterBillDetailsPage> createState() => _WaterBillDetailsPageState();
// }

// class _WaterBillDetailsPageState extends State<WaterBillDetailsPage> {
//   // late Razorpay _razorpay;

//   @override
//   void initState() {
//     super.initState();
//     // _razorpay = Razorpay();
//   }

//   @override
//   void dispose() {
//     // _razorpay.clear();
//     super.dispose();
//   }

//   void _submitBillPayment(String paymentId) {
//     // TODO: Implement your API call here
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text("Payment Successful: $paymentId")));
//   }

//   // void _startRazorpayWithCallbacks(
//   //   String amount,
//   //   String name,
//   //   String phone,
//   //   String email, {
//   //   required Function(String paymentId) onSuccess,
//   //   required Function() onFailure,
//   // }) {
//   //   var options = {
//   //     'key': 'rzp_test_xxxxxxxx', // Replace with your Razorpay Key
//   //     'amount': int.parse(amount) * 100,
//   //     'name': name,
//   //     'description': 'Water Bill Payment',
//   //     'prefill': {'contact': phone, 'email': email},
//   //     'theme': {'color': '#3399cc'},
//   //   };

//   //   _razorpay = Razorpay();
//   //   _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (
//   //     PaymentSuccessResponse response,
//   //   ) {
//   //     onSuccess(response.paymentId ?? "");
//   //     _razorpay.clear();
//   //   });
//   //   _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (
//   //     PaymentFailureResponse response,
//   //   ) {
//   //     onFailure();
//   //     _razorpay.clear();
//   //   });
//   //   _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (
//   //     ExternalWalletResponse response,
//   //   ) {
//   //     onFailure();
//   //     _razorpay.clear();
//   //   });

//   //   try {
//   //     _razorpay.open(options);
//   //   } catch (e) {
//   //     onFailure();
//   //     debugPrint('Error: $e');
//   //   }
//   // }

//   void _onPayNowTap(String amount, String name, String phone, String email) {
//     showModalBottomSheet(
//       context: context,
//       isDismissible: false,
//       isScrollControlled: true,
//       builder: (ctx) {
//         String status = "loading"; // loading, success, failed
//         String message = "Waiting for payment status...";

//         return StatefulBuilder(
//           builder: (context, setStateBottomSheet) {
//             // Future.delayed(const Duration(milliseconds: 500), () {
//             //   _startRazorpayWithCallbacks(
//             //     amount,
//             //     name,
//             //     phone,
//             //     email,
//             //     onSuccess: (paymentId) {
//             //       setStateBottomSheet(() {
//             //         status = "success";
//             //         message = "Payment Successful\nID: $paymentId";
//             //       });
//             //       Future.delayed(const Duration(seconds: 2), () {
//             //         Navigator.pop(context);
//             //         _submitBillPayment(paymentId);
//             //       });
//             //     },
//             //     onFailure: () {
//             //       setStateBottomSheet(() {
//             //         status = "failed";
//             //         message = "Payment Failed. Please try again.";
//             //       });
//             //       Future.delayed(const Duration(seconds: 2), () {
//             //         Navigator.pop(context);
//             //       });
//             //     },
//             //   );
//             // });

//             IconData icon;
//             Color iconColor;

//             if (status == "success") {
//               icon = Icons.check_circle_outline;
//               iconColor = maincolor1!;
//             } else if (status == "failed") {
//               icon = Icons.cancel_outlined;
//               iconColor = Colors.red;
//             } else {
//               icon = Icons.hourglass_empty;
//               iconColor = maincolor1!;
//             }

//             return Container(
//               padding: const EdgeInsets.all(24),
//               height: 240,
//               width: double.infinity,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(icon, size: 60, color: iconColor),
//                   const SizedBox(height: 20),
//                   Text(
//                     message,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: status == 'failed' ? Colors.red : Colors.black87,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   status == 'loading'
//                       ? Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 12),
//                           child: LinearProgressIndicator(
//                             color: maincolor1,
//                             minHeight: 2,
//                           ),
//                         )
//                       : SizedBox(),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: maincolor1,
//         title: const Text("Water Bill", style: TextStyle(color: Colors.white)),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: BlocBuilder<FetchBillBloc, FetchBillState>(
//         builder: (context, state) {
//           return state.when(
//             initial: () => const SizedBox.shrink(),
//             loading: () => _buildShimmer(),
//             error: (message) => buildErrorWidget(message),
//             success: (bill) {
//               if (bill.billAmount == "0") {
//                 return const Center(
//                   child: Text(
//                     "Payment already billed.",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                   ),
//                 );
//               }

//               return SingleChildScrollView(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 20),
//                         child: Column(
//                           children: [
//                             Text(
//                               "₹ ${bill.billAmount}",
//                               style: const TextStyle(
//                                 fontSize: 30,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             Text(
//                               widget.provider,
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.black54,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.1),
//                             spreadRadius: 2,
//                             blurRadius: 10,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(15.0),
//                         child: Column(
//                           children: [
//                             _buildDetailRow(
//                               "Account Holder Name",
//                               bill.customerName,
//                             ),
//                             _buildDetailRow("Consumer Number", bill.billNumber),
//                             _buildDetailRow(
//                               "Bill Period",
//                               bill.billPeriod.isNotEmpty
//                                   ? bill.billPeriod
//                                   : "N/A",
//                             ),
//                             _buildDetailRow("Bill Due Date", bill.dueDate),
//                             _buildDetailRow("Bill Number", bill.billNumber),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                       child: ElevatedButton.icon(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: maincolor1,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           foregroundColor: Colors.white,
//                         ),
//                         icon: const Icon(Icons.payment),
//                         label: const Text(
//                           "Pay Now",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         onPressed: () {
//                           _onPayNowTap(
//                             bill.billAmount,
//                             bill.customerName,
//                             "9876543210", // Replace with user's actual phone
//                             "user@email.com", // Replace with user's actual email
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               label,
//               style: const TextStyle(fontWeight: FontWeight.w500),
//             ),
//           ),
//           Text(value, style: const TextStyle(color: Colors.black87)),
//         ],
//       ),
//     );
//   }

//   Widget _buildShimmer() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 20),
//               child: Column(
//                 children: [
//                   Shimmer.fromColors(
//                     baseColor: Colors.grey.shade300,
//                     highlightColor: Colors.grey.shade100,
//                     child: Container(
//                       width: 120,
//                       height: 30,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Shimmer.fromColors(
//                     baseColor: Colors.grey.shade300,
//                     highlightColor: Colors.grey.shade100,
//                     child: Container(
//                       width: 180,
//                       height: 16,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.1),
//                   spreadRadius: 2,
//                   blurRadius: 10,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Column(
//                 children: List.generate(5, (index) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Shimmer.fromColors(
//                             baseColor: Colors.grey.shade300,
//                             highlightColor: Colors.grey.shade100,
//                             child: Container(
//                               height: 14,
//                               width: 100,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         Shimmer.fromColors(
//                           baseColor: Colors.grey.shade300,
//                           highlightColor: Colors.grey.shade100,
//                           child: Container(
//                             height: 14,
//                             width: 120,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Shimmer.fromColors(
//             baseColor: Colors.grey.shade300,
//             highlightColor: Colors.grey.shade100,
//             child: Container(
//               width: double.infinity,
//               height: 50,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Widget buildErrorWidget(String message) {
//   return Center(
//     child: Padding(
//       padding: const EdgeInsets.all(14.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Icon
//           Icon(
//             Icons.warning_amber_rounded,
//             color: Colors.orangeAccent,
//             size: 60,
//           ),
//           const SizedBox(height: 16),

//           // Main title
//           Text(
//             'Oops! Something went wrong',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey[800],
//             ),
//           ),
//           const SizedBox(height: 5),

//           // Sub message
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Text(
//               "We couldn't fetch your bill.\nPlease check the entered data and try again.",
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//             ),
//           ),
//           const SizedBox(height: 20),
//         ],
//       ),
//     ),
//   );
// }
