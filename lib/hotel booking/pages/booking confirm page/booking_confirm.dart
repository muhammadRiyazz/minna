import 'package:flutter/material.dart';
import 'package:minna/comman/core/api.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/hotel%20booking/domain/hotel%20details%20/hotel_details.dart';
import 'package:minna/hotel%20booking/domain/rooms/rooms.dart';

class BookingPreviewPage extends StatefulWidget {
  final Room room;
  final HotelSearchRequest hotelSearchRequest;
  final HotelDetail hotel;
  final List<Map<String, dynamic>> passengers;

  const BookingPreviewPage({
    super.key,
    required this.room,
    required this.hotelSearchRequest,
    required this.hotel,
    required this.passengers,
  });

  @override
  State<BookingPreviewPage> createState() => _BookingPreviewPageState();
}

class _BookingPreviewPageState extends State<BookingPreviewPage> {
  final Razorpay _razorpay = Razorpay();
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    setState(() {
      _isProcessing = false;
    });
    _showPaymentSuccessBottomSheet(response);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() {
      _isProcessing = false;
    });
    _showPaymentFailedBottomSheet(response);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    setState(() {
      _isProcessing = false;
    });
    // _showExternalWalletBottomSheet(response);
  }

  void _processPayment(double amount) {
    setState(() {
      _isProcessing = true;
    });

    var options = {
      'key': razorpaykey, // Replace with your actual Razorpay key
      'amount': (amount * 100).toInt(), // Amount in paise
      'name': 'Minna Hotels',
      'description': 'Hotel Booking - ${widget.hotel.hotelName}',
      'prefill': {
        'contact': widget.passengers.first['Phone'] ?? '',
        'email': widget.passengers.first['Email'] ?? '',
      },
      'theme': {'color': '#${maincolor1!.value.toRadixString(16).substring(2)}'}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });
      _showErrorDialog('Payment Error', 'Failed to initialize payment: $e');
    }
  }
void _showPaymentSuccessBottomSheet(PaymentSuccessResponse response) {
  showModalBottomSheet(
    context: context,
   isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: false, // Prevent closing by tapping outside
    enableDrag: false, // Prevent closing by dragging down
    builder: (context) => WillPopScope(

        onWillPop: () async {
        // Prevent closing by back button
        return false;
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            // Header with warning icon (since booking failed)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Payment Successful!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[800],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'But hotel booking failed to confirm',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.orange[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status Alert Box
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.red[200]!),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.error_outline, color: Colors.red[700], size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Booking Status: Failed',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[700],
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Text(
                            'We apologize for the inconvenience. Your payment was successful but we were unable to confirm your hotel booking. Your amount will be refunded shortly.',
                            style: TextStyle(
                              color: Colors.red[700],
                              fontSize: 14,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    
                    // Payment Details
                    Text(
                      'Payment Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 16),
                    
                    _buildSuccessDetailItem(
                      'Transaction ID',
                      response.paymentId ?? 'N/A',
                      Icons.receipt,
                      Colors.green,
                    ),
                    SizedBox(height: 12),
                    _buildSuccessDetailItem(
                      'Amount Paid',
                      '₹${(widget.room.totalFare + widget.room.totalTax).toStringAsFixed(2)}',
                      Icons.currency_rupee,
                      Colors.green,
                    ),
                    SizedBox(height: 12),
                    _buildSuccessDetailItem(
                      'Payment Status',
                      'Completed',
                      Icons.check_circle,
                      Colors.green,
                    ),
                    SizedBox(height: 12),
                    _buildSuccessDetailItem(
                      'Payment Date',
                      '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                      Icons.calendar_today,
                      Colors.blue,
                    ),
                    
                    SizedBox(height: 24),
                    
                    // Refund Information
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue[200]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.refresh, color: Colors.blue[700]),
                              SizedBox(width: 8),
                              Text(
                                'Refund Information',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[700],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          // _buildRefundTimeline(),
                          SizedBox(height: 12),
                          Text(
                            '• Refund will be processed to your original payment method\n• Typically takes 5-7 business days\n• You will receive confirmation email and SMS\n• Contact support if not received within 7 days',
                            style: TextStyle(
                              color: Colors.blue[700],
                              fontSize: 12,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 24),
                    
                    // // Support Information
                    // Container(
                    //   padding: EdgeInsets.all(16),
                    //   decoration: BoxDecoration(
                    //     color: Colors.grey[100],
                    //     borderRadius: BorderRadius.circular(12),
                    //     border: Border.all(color: Colors.grey[300]!),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       Icon(Icons.support_agent, color: maincolor1, size: 24),
                    //       SizedBox(width: 12),
                    //       Expanded(
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               'Need Help?',
                    //               style: TextStyle(
                    //                 fontWeight: FontWeight.bold,
                    //                 color: Colors.grey[800],
                    //               ),
                    //             ),
                    //             SizedBox(height: 4),
                    //             Text(
                    //               'Contact our 24/7 support team',
                    //               style: TextStyle(
                    //                 color: Colors.grey[600],
                    //                 fontSize: 12,
                    //               ),
                    //             ),
                    //             SizedBox(height: 4),
                    //             Text(
                    //               '📞 +91-XXXXXXXXXX',
                    //               style: TextStyle(
                    //                 color: maincolor1,
                    //                 fontWeight: FontWeight.w500,
                    //                 fontSize: 12,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            
            // Bottom Actions
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[300]!)),
              ),
              child: Row(
                children: [
               
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: maincolor1,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Back to Home',style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  // void _showPaymentSuccessBottomSheet(PaymentSuccessResponse response) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) => Container(
  //       height: MediaQuery.of(context).size.height * 0.8,
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(24),
  //           topRight: Radius.circular(24),
  //         ),
  //       ),
  //       child: Column(
  //         children: [
  //           // Header with success icon
  //           Container(
  //             width: double.infinity,
  //             padding: EdgeInsets.all(24),
  //             decoration: BoxDecoration(
  //               color: Colors.green[50],
  //               borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(24),
  //                 topRight: Radius.circular(24),
  //               ),
  //             ),
  //             child: Column(
  //               children: [
  //                 Container(
  //                   width: 80,
  //                   height: 80,
  //                   decoration: BoxDecoration(
  //                     color: Colors.green,
  //                     shape: BoxShape.circle,
  //                   ),
  //                   child: Icon(
  //                     Icons.check,
  //                     color: Colors.white,
  //                     size: 40,
  //                   ),
  //                 ),
  //                 SizedBox(height: 16),
  //                 Text(
  //                   'Payment Successful!',
  //                   style: TextStyle(
  //                     fontSize: 24,
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.green[800],
  //                   ),
  //                 ),
  //                 SizedBox(height: 8),
  //                 Text(
  //                   'Your booking has been confirmed',
  //                   style: TextStyle(
  //                     fontSize: 16,
  //                     color: Colors.green[700],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
            
  //           Expanded(
  //             child: SingleChildScrollView(
  //               padding: EdgeInsets.all(24),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   // Booking DetailsFR
  //                   _buildSuccessDetailItem(
  //                     'Booking ID',
  //                     '#${DateTime.now().millisecondsSinceEpoch}',
  //                     Icons.confirmation_number,
  //                   ),
  //                   SizedBox(height: 16),
  //                   _buildSuccessDetailItem(
  //                     'Transaction ID',
  //                     response.paymentId ?? 'N/A',
  //                     Icons.receipt,
  //                   ),
  //                   SizedBox(height: 16),
  //                   _buildSuccessDetailItem(
  //                     'Hotel',
  //                     widget.hotel.hotelName,
  //                     Icons.hotel,
  //                   ),
  //                   SizedBox(height: 16),
  //                   _buildSuccessDetailItem(
  //                     'Check-in',
  //                     widget.hotelSearchRequest.checkIn,
  //                     Icons.calendar_today,
  //                   ),
  //                   SizedBox(height: 16),
  //                   _buildSuccessDetailItem(
  //                     'Amount Paid',
  //                     '₹${(widget.room.totalFare + widget.room.totalTax).toStringAsFixed(2)}',
  //                     Icons.currency_rupee,
  //                   ),
                    
  //                   SizedBox(height: 24),
                    
  //                   // Important Information
  //                   Container(
  //                     padding: EdgeInsets.all(16),
  //                     decoration: BoxDecoration(
  //                       color: Colors.blue[50],
  //                       borderRadius: BorderRadius.circular(12),
  //                       border: Border.all(color: Colors.blue[200]!),
  //                     ),
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Row(
  //                           children: [
  //                             Icon(Icons.info, color: Colors.blue[700]),
  //                             SizedBox(width: 8),
  //                             Text(
  //                               'Important Information',
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 color: Colors.blue[700],
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         SizedBox(height: 8),
  //                         Text(
  //                           '• Booking confirmation will be sent to your email\n• Present this booking ID at hotel reception\n• Free cancellation available as per policy',
  //                           style: TextStyle(
  //                             color: Colors.blue[700],
  //                             fontSize: 12,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
            
  //           // Bottom Actions
  //           Container(
  //             padding: EdgeInsets.all(16),
  //             decoration: BoxDecoration(
  //               border: Border(top: BorderSide(color: Colors.grey[300]!)),
  //             ),
  //             child: Row(
  //               children: [
  //                 Expanded(
  //                   child: OutlinedButton(
  //                     onPressed: () {
  //                       Navigator.pop(context); // Close bottom sheet
  //                       _shareBookingDetails();
  //                     },
  //                     style: OutlinedButton.styleFrom(
  //                       padding: EdgeInsets.symmetric(vertical: 12),
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                       ),
  //                       side: BorderSide(color: maincolor1!),
  //                     ),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Icon(Icons.share, color: maincolor1),
  //                         SizedBox(width: 8),
  //                         Text(
  //                           'Share',
  //                           style: TextStyle(color: maincolor1),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(width: 12),
  //                 Expanded(
  //                   child: ElevatedButton(
  //                     onPressed: () {
  //                       Navigator.popUntil(context, (route) => route.isFirst);
  //                     },
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: maincolor1,
  //                       padding: EdgeInsets.symmetric(vertical: 12),
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                       ),
  //                     ),
  //                     child: Text('Done'),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  void _showPaymentFailedBottomSheet(PaymentFailureResponse response) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Header with error icon
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                // color: Colors.red[50],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Payment Failed',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[800],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'We couldn\'t process your payment',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red[700],
                    ),
                  ),
                ],
              ),
            ),
            
         
            // Bottom Actions
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[300]!)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(color: Colors.grey[400]!),
                      ),
                      child: Text(
                        'Try Again Later',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _processPayment(widget.room.totalFare + widget.room.totalTax);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: maincolor1,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Retry Payment',style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void _showExternalWalletBottomSheet(ExternalWalletResponse response) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) => Container(
  //       height: MediaQuery.of(context).size.height * 0.5,
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(24),
  //           topRight: Radius.circular(24),
  //         ),
  //       ),
  //       child: Column(
  //         children: [
  //           Container(
  //             width: double.infinity,
  //             padding: EdgeInsets.all(24),
  //             decoration: BoxDecoration(
  //               color: Colors.blue[50],
  //               borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(24),
  //                 topRight: Radius.circular(24),
  //               ),
  //             ),
  //             child: Column(
  //               children: [
  //                 Icon(
  //                   Icons.account_balance_wallet,
  //                   size: 60,
  //                   color: Colors.blue[700],
  //                 ),
  //                 SizedBox(height: 16),
  //                 Text(
  //                   'External Wallet',
  //                   style: TextStyle(
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.blue[800],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Expanded(
  //             child: Padding(
  //               padding: EdgeInsets.all(24),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Text(
  //                     'Redirected to ${response.walletName}',
  //                     style: TextStyle(
  //                       fontSize: 18,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                   SizedBox(height: 16),
  //                   Text(
  //                     'Please complete the payment in your external wallet app.',
  //                     textAlign: TextAlign.center,
  //                     style: TextStyle(
  //                       color: Colors.grey[600],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           Container(
  //             padding: EdgeInsets.all(16),
  //             child: ElevatedButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: maincolor1,
  //                 padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(8),
  //                 ),
  //               ),
  //               child: Text('OK'),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildSuccessDetailItem(String title, String value, IconData icon, MaterialColor green) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: maincolor1, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _shareBookingDetails() {
    // Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Booking details shared!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double totalAmount = widget.room.totalFare + widget.room.totalTax;
    final int nights = _calculateNights();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Booking Preview',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(color: maincolor1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHotelSummaryCard(),
                  SizedBox(height: 10),
                  _buildBookingDetailsCard(nights),
                  SizedBox(height: 10),
                  _buildPassengerDetailsCard(),
                  SizedBox(height: 10),
                  _buildPriceBreakdownCard(totalAmount, nights),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          _buildBottomPaymentSection(totalAmount, context),
        ],
      ),
    );
  }

  int _calculateNights() {
    final checkIn = DateTime.parse(widget.hotelSearchRequest.checkIn);
    final checkOut = DateTime.parse(widget.hotelSearchRequest.checkOut);
    return checkOut.difference(checkIn).inDays;
  }

  Widget _buildHotelSummaryCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.hotel, color: maincolor1, size: 24),
                SizedBox(width: 8),
                Text(
                  'Hotel Information',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: maincolor1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              widget.hotel.hotelName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              widget.hotel.address,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingDetailsCard(int nights) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_today, color: maincolor1, size: 20),
                SizedBox(width: 8),
                Text(
                  'Booking Details',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: maincolor1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    'Check-in',
                    widget.hotelSearchRequest.checkIn,
                    Icons.login,
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                    'Check-out',
                    widget.hotelSearchRequest.checkOut,
                    Icons.logout,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    'Duration',
                    '$nights Nights',
                    Icons.access_time,
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                    'Guests',
                    '${widget.passengers.length} Person${widget.passengers.length > 1 ? 's' : ''}',
                    Icons.people,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            _buildDetailItem(
              'Room Type',
              widget.room.name.join(', '),
              Icons.king_bed,
            ),
            SizedBox(height: 8),
            _buildDetailItem(
              'Meal Plan',
              widget.room.mealType,
              Icons.restaurant,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey[600]),
            SizedBox(width: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  Widget _buildPassengerDetailsCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, color: maincolor1, size: 24),
                SizedBox(width: 8),
                Text(
                  'Passenger Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: maincolor1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            ...widget.passengers.asMap().entries.map((entry) {
              final index = entry.key;
              final passenger = entry.value;
              return Container(
                margin: EdgeInsets.only(bottom: 12),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Passenger ${index + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: maincolor1,
                          ),
                        ),
                        if (passenger['LeadPassenger'] == true) ...[
                          SizedBox(width: 8),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.amber[50],
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.amber!),
                            ),
                            child: Text(
                              'Lead',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.amber[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                        Spacer(),
                        Text(
                          _getPaxTypeText(passenger['PaxType']),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${passenger['Title']} ${passenger['FirstName']} ${passenger['LastName']}',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 4),
                    Text('Age: ${passenger['Age']} years'),
                    SizedBox(height: 4),
                    Text('Email: ${passenger['Email']}'),
                    SizedBox(height: 4),
                    Text('Phone: ${passenger['Phone']}'),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  String _getPaxTypeText(int paxType) {
    switch (paxType) {
      case 1: return 'Adult';
      case 2: return 'Child';
      case 3: return 'Infant';
      default: return 'Adult';
    }
  }

  Widget _buildPriceBreakdownCard(double totalAmount, int nights) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.receipt, color: maincolor1, size: 24),
                SizedBox(width: 8),
                Text(
                  'Price Breakdown',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: maincolor1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            _buildPriceRow('Room Fare (${nights} nights)', widget.room.totalFare),
            _buildPriceRow('Taxes & Fees', widget.room.totalTax),
            Divider(height: 20),
            _buildPriceRow(
              'Total Amount',
              totalAmount,
              isTotal: true,
            ),
            SizedBox(height: 8),
            if (widget.room.isRefundable)
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.green!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 16),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Fully Refundable - Free cancellation available',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Spacer(),
          Text(
            '₹${amount.toStringAsFixed(2)}',
            style: TextStyle(
              color: isTotal ? maincolor1 : Colors.grey[800],
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPaymentSection(double totalAmount, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  'Total Amount:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                Spacer(),
                Text(
                  '₹${totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: maincolor1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _isProcessing
                      ? ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: maincolor1!.withOpacity(0.7),
                            padding: EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Processing...',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ElevatedButton.icon(
                          onPressed: () {
                            _processPayment(totalAmount);
                          },
                          icon: Icon(Icons.payment, size: 20, color: Colors.white),
                          label: Text(
                            'Pay Now',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: maincolor1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 14),
                            elevation: 2,
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}