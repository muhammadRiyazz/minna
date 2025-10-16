// hotel_booking_confirmation_page.dart
import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/core/api.dart';
import 'package:minna/comman/functions/create_order_id.dart';
import 'package:minna/hotel%20booking/application/bloc/hotel_booking_confirm_bloc.dart';
import 'package:minna/hotel%20booking/domain/authentication/authendication.dart';
import 'package:minna/hotel%20booking/domain/hotel%20details%20/hotel_details.dart';
import 'package:minna/hotel%20booking/domain/rooms/rooms.dart' hide CancelPolicy;
import 'package:razorpay_flutter/razorpay_flutter.dart';

class HotelBookingConfirmationPage extends StatefulWidget {
      final String prebookId;

  final Room room;
  final HotelSearchRequest hotelSearchRequest;
  final HotelDetail hotel;
  final List<Map<String, dynamic>> passengers;
  final List<List<Map<String, dynamic>>>? roomPassengers;
  // final String tableId;
  final String bookingId;
  final PreBookResponse preBookResponse;

  const HotelBookingConfirmationPage({
    super.key,
    required this.room,
        required this.prebookId,

    required this.hotelSearchRequest,
    required this.hotel,
    required this.passengers,
    required this.roomPassengers,
    // required this.tableId,
    required this.bookingId,
    required this.preBookResponse,
  });

  @override
  State<HotelBookingConfirmationPage> createState() => _HotelBookingConfirmationPageState();
}

class _HotelBookingConfirmationPageState extends State<HotelBookingConfirmationPage> {
  late Timer _timer;
  int _remainingSeconds = 8 * 60; // 8 minutes
  bool _isTimerExpired = false;
  late Razorpay _razorpay;
  String? _orderId;
  String _displayTime = '08:00';

  // Theme colors
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37);
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);
  final Color _errorColor = Color(0xFFE53935);
  final Color _successColor = Color(0xFF4CAF50);
  final Color _warningColor = Color(0xFFFF9800);

  @override
  void initState() {
    super.initState();
    _startOptimizedTimer();
    _initRazorpay();
  }

  @override
  void dispose() {
    _timer.cancel();
    _razorpay.clear();
    super.dispose();
  }

  void _startOptimizedTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        
        final newDisplayTime = _formatTime(_remainingSeconds);
        final shouldRebuild = _displayTime != newDisplayTime || _remainingSeconds <= 10;
        
        if (shouldRebuild) {
          _displayTime = newDisplayTime;
          if (mounted) {
            setState(() {});
          }
        }
      } else {
        _isTimerExpired = true;
        _timer.cancel();
        if (mounted) {
          _showTimeExpiredDialog();
        }
      }
    });
  }

  void _initRazorpay() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    log("Hotel Payment Success: ${response.paymentId}");
    
    final bookingRequest = _generateBookingRequest();
    final totalAmount = _getTotalAmount();

    context.read<HotelBookingConfirmBloc>().add(
      HotelBookingConfirmEvent.paymentDone(
        prebookId:widget.prebookId ,
        orderId: response.orderId ?? _orderId ??  '' ,
        transactionId: response.paymentId ?? '' ,
        bookingId: widget.bookingId,
        amount: totalAmount,
        bookingRequest: bookingRequest,
      ),
    );

    _timer.cancel();
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    log("Hotel Payment Failed: ${response.message}");

    context.read<HotelBookingConfirmBloc>().add(
      HotelBookingConfirmEvent.paymentFail(
        orderId: _orderId ?? '',
        prebookId: widget.prebookId,
        bookingId: widget.bookingId,
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log("External Wallet: ${response.walletName}");
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _showTimeExpiredDialog() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _cardColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: _errorColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.timer_off_rounded, size: 40, color: _errorColor),
                ),
                SizedBox(height: 20),
                Text(
                  "Booking Time Expired",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Your hotel booking time has expired. Please try again.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: _textSecondary,
                  ),
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      "Go to Home",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  double _getTotalAmount() {
    // Use PreBook response data for accurate pricing
    final preBookRoom = widget.preBookResponse.hotelResult.firstOrNull?.rooms.firstOrNull;
    if (preBookRoom != null) {
      return preBookRoom.totalFare + preBookRoom.totalTax;
    }
    // Fallback to room data
    return widget.room.totalFare + widget.room.totalTax;
  }

  Map<String, dynamic> _generateBookingRequest() {
    final hotelRoomsDetails = <Map<String, dynamic>>[];
    final totalRooms = widget.roomPassengers?.length ?? 1;
    final isSingleRoom = totalRooms == 1;
    final totalAmount = _getTotalAmount();

    // Use room-wise structure if available
    if (widget.roomPassengers != null) {
      for (final room in widget.roomPassengers!) {
        final hotelPassengers = <Map<String, dynamic>>[];
        
        for (final passenger in room) {
          hotelPassengers.add({
            "Title": passenger['Title'] ?? "Mr.",
            "FirstName": passenger['FirstName'] ?? "",
            "MiddleName": "",
            "LastName": passenger['LastName'] ?? "",
            "Email": passenger['Email'],
            "PaxType": passenger['PaxType'] ?? 1,
            "LeadPassenger": passenger['LeadPassenger'] ?? false,
            "Age": passenger['Age'] ?? 0,
            "PassportNo": passenger['Passport'],
            "PassportIssueDate": null,
            "PassportExpDate": null,
            "Phoneno": passenger['Phone'],
            "PaxId": 0,
            "GSTCompanyAddress": null,
            "GSTCompanyContactNumber": null,
            "GSTCompanyName": null,
            "GSTNumber": null,
            "GSTCompanyEmail": null,
            // "PAN": passenger['PAN'],
          });
        }
        
        hotelRoomsDetails.add({
          "HotelPassenger": hotelPassengers,
        });
      }
    } else {
      // Fallback to single room structure
      final hotelPassengers = <Map<String, dynamic>>[];
      
      for (final passenger in widget.passengers) {
        hotelPassengers.add({
          "Title": passenger['Title'] ?? "Mr.",
          "FirstName": passenger['FirstName'] ?? "",
          "MiddleName": "",
          "LastName": passenger['LastName'] ?? "",
          "Email": passenger['Email'],
          "PaxType": passenger['PaxType'] ?? 1,
          "LeadPassenger": passenger['LeadPassenger'] ?? false,
          "Age": passenger['Age'] ?? 0,
          "PassportNo": passenger['Passport'],
          "PassportIssueDate": null,
          "PassportExpDate": null,
          "Phoneno": passenger['Phone'],
          "PaxId": 0,
          "GSTCompanyAddress": null,
          "GSTCompanyContactNumber": null,
          "GSTCompanyName": null,
          "GSTNumber": null,
          "GSTCompanyEmail": null,
          // "PAN": passenger['PAN'],
        });
      }
      
      hotelRoomsDetails.add({
        "HotelPassenger": hotelPassengers,
      });
    }

    final bookingRequest = {
      "BookingCode": widget.room.bookingCode,
      "IsVoucherBooking": true, // Set to true for direct voucher
      "GuestNationality": "IN",
      "EndUserIp": "192.168.9.119",
      "RequestedBookingMode": isSingleRoom ? 5 : 1,
      "HotelRoomsDetails": hotelRoomsDetails,
    };

    // Add additional fields for single room booking
    if (isSingleRoom) {
      bookingRequest["NetAmount"] = totalAmount;
      bookingRequest["ClientReferenceId"] = _generateClientReferenceId();
    } else {
      bookingRequest["TokenId"] = widget.room.bookingCode;
      bookingRequest["TraceId"] = _generateTraceId();
      bookingRequest["AgencyId"] = 56870;
    }

    return bookingRequest;
  }

  String _generateTraceId() {
    return '${DateTime.now().millisecondsSinceEpoch}';
  }

  String _generateClientReferenceId() {
    return 'hotel_ref_${DateTime.now().millisecondsSinceEpoch}';
  }

    // Bottom Sheet 1: Refund Initiated
 
  
  Future<bool> _onWillPop() async {
    final shouldExit = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _cardColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: _warningColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.exit_to_app_rounded, color: _warningColor, size: 30),
                ),
                SizedBox(height: 16),
                Text(
                  "Exit Hotel Booking?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Are you sure you want to exit the booking process?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _textSecondary,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context, false),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: _textSecondary,
                          side: BorderSide(color: Colors.grey.shade400),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          "Continue Booking",
                          style: TextStyle(fontWeight: FontWeight.w600,fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){                    Navigator.of(context).popUntil((route) => route.isFirst);
},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          "Exit",
                          style: TextStyle(fontWeight: FontWeight.w600,fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    return shouldExit ?? false;
  }

  void _onProceedToPayment() async {
    
    context.read<HotelBookingConfirmBloc>().add(
      HotelBookingConfirmEvent.startLoading(),
    );

    try {
      final totalAmount = _getTotalAmount();
      final orderId = await createOrder(totalAmount);
      
      if (orderId == null) {
        log("Order ID creation failed");
        context.read<HotelBookingConfirmBloc>().add(
          HotelBookingConfirmEvent.stopLoading(),
        );
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to create order. Please try again."),
            backgroundColor: _errorColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          )
        );
        return;
      }

      setState(() {
        _orderId = orderId;
      });

      final leadPassenger = _getLeadPassenger();
      final name = "${leadPassenger['Title']} ${leadPassenger['FirstName']} ${leadPassenger['LastName']}";
      final phone = leadPassenger['Phone'] ?? '';
      final email = leadPassenger['Email'] ?? '';

      var options = {
        'key': razorpaykey,
        'amount': (totalAmount * 100).toInt(),
        'name': 'MT Hotels',
        'order_id': orderId,
        'description': 'Hotel Booking - ${widget.hotel.hotelName}',
        'prefill': {'contact': phone, 'email': email},
        'theme': {'color': '#000000'}
      };

      try {
        _razorpay.open(options);
      } catch (e) {
        log("Razorpay Error: $e");
        context.read<HotelBookingConfirmBloc>().add(
          HotelBookingConfirmEvent.stopLoading(),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Payment error: $e"),
            backgroundColor: _errorColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          )
        );
      }
    } catch (e) {
      log("Error in payment process: $e");
      context.read<HotelBookingConfirmBloc>().add(
        HotelBookingConfirmEvent.stopLoading(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred: $e"),
          backgroundColor: _errorColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        )
      );
    }
  }

  Map<String, dynamic> _getLeadPassenger() {
    // Find lead passenger from all rooms
    for (final room in widget.roomPassengers ?? [widget.passengers]) {
      for (final passenger in room) {
        if (passenger['LeadPassenger'] == true) {
          return passenger;
        }
      }
    }
    return widget.passengers.first;
  }

  @override
  Widget build(BuildContext context) {
    final totalAmount = _getTotalAmount();
    final totalRooms = widget.roomPassengers?.length ?? 1;
    final totalGuests = widget.passengers.length;
    final preBookRoom = widget.preBookResponse.hotelResult.firstOrNull?.rooms.firstOrNull;

    return MultiBlocListener(
      listeners: [
        BlocListener<HotelBookingConfirmBloc, HotelBookingConfirmState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (data, bookingId, confirmationNo, bookingRefNo ,booktableId) {
                log("HotelBookingSuccessPage---");
               
              },
              paymentFailed: (message, orderId, bookingId) {
              },
              refundInitiated: (message, orderId, transactionId, amount, tableId, bookingId) {
_showRefundInitiatedSheet(context);           
   },
              refundFailed: (message, orderId, transactionId, amount, bookingId ) {
_showContactSupportSheet(context);            
  },
              error: (message, shouldRefund, orderId, transactionId, amount, booktableId, bookingId ) {
                if (shouldRefund) {
                  log("shouldRefund -----");
                  context.read<HotelBookingConfirmBloc>().add(
                    HotelBookingConfirmEvent.initiateRefund(
                      orderId: orderId,
                      transactionId: transactionId,
                      amount: amount,
                      booktableId: booktableId,
                      bookingId: bookingId,
                    ),
                  );
                } else {
                  // _showContactSupportSheet();              

                  // showDialog(
                  //   context: context,
                  //   builder: (context) => AlertDialog(
                  //     title: Text("Booking Error", style: TextStyle(color: _errorColor)),
                  //     content: Text(message),
                  //     actions: [
                  //       TextButton(
                  //         onPressed: () => Navigator.pop(context),
                  //         child: Text('OK', style: TextStyle(color: _primaryColor)),
                  //       ),
                  //     ],
                  //   ),
                  // );
                }
              },
            );
          },
        ),
      ],
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: _backgroundColor,
          body: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    // App Bar
                    SliverAppBar(
                      backgroundColor: _primaryColor,
                      expandedHeight: 140,
                      floating: false,
                      pinned: true,
                      elevation: 4,
                      shadowColor: Colors.black.withOpacity(0.3),
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
                        onPressed: (){_onWillPop();},
                      ),
                      title: Text(
                        "Confirm Hotel Booking",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      centerTitle: true,
                      // flexibleSpace: FlexibleSpaceBar(
                      //   background: Container(
                      //     decoration: BoxDecoration(
                      //       gradient: LinearGradient(
                      //         colors: [_primaryColor, Color(0xFF2D2D2D)],
                      //         begin: Alignment.topLeft,
                      //         end: Alignment.bottomRight,
                      //       ),
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(bottom: 20, left: 24, right: 24),
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.end,
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text(
                      //             'Complete Your Booking',
                      //             style: TextStyle(
                      //               color: Colors.white,
                      //               fontSize: 18,
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           ),
                      //           SizedBox(height: 8),
                      //           Text(
                      //             '$totalGuests guest${totalGuests > 1 ? 's' : ''} across $totalRooms room${totalRooms > 1 ? 's' : ''}',
                      //             style: TextStyle(
                      //               color: Colors.white70,
                      //               fontSize: 14,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(60),
                        child: Container(
                          color: _primaryColor,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Time remaining:',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.timer, color: Colors.white, size: 18),
                                    SizedBox(width: 8),
                                    Text(
                                      _displayTime,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Main Content
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _buildHotelSummary(),
                            SizedBox(height: 16),
                            _buildBookingDetails(),
                            SizedBox(height: 16),
                            _buildGuestSummary(),
                            SizedBox(height: 16),
                            _buildPriceBreakdown(preBookRoom),
                            if (preBookRoom?.cancelPolicies.isNotEmpty == true) ...[
                              SizedBox(height: 16),
                              _buildCancellationPolicy(preBookRoom!),
                            ],
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _buildPaymentSection(totalAmount),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHotelSummary() {
    return Container(
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Hotel Information', Icons.hotel_rounded),
            SizedBox(height: 16),
            Text(
              widget.hotel.hotelName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _textPrimary,
              ),
            ),
            SizedBox(height: 8),
            Row(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on_rounded, color: _secondaryColor, size: 16),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    widget.hotel.address,
                    style: TextStyle(color: _textSecondary),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.room_service_rounded, color: _secondaryColor, size: 16),
                SizedBox(width: 6),
                Text(
                  '${widget.roomPassengers?.length ?? 1} Room${(widget.roomPassengers?.length ?? 1) > 1 ? 's' : ''}',
                  style: TextStyle(color: _textSecondary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingDetails() {
    final checkIn = DateTime.parse(widget.hotelSearchRequest.checkIn);
    final checkOut = DateTime.parse(widget.hotelSearchRequest.checkOut);
    final nights = checkOut.difference(checkIn).inDays;
    final dateFormat = DateFormat('dd MMM yyyy');

    return Container(
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            _buildSectionHeader('Booking Details', Icons.calendar_month_rounded),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.8,
              children: [
                _buildDetailItem(
                  'Check-in',
                  dateFormat.format(checkIn),
                  Icons.login_rounded,
                ),
                _buildDetailItem(
                  'Check-out',
                  dateFormat.format(checkOut),
                  Icons.logout_rounded,
                ),
                _buildDetailItem(
                  'Duration',
                  '$nights ${nights > 1 ? 'Nights' : 'Night'}',
                  Icons.access_time_rounded,
                ),
                _buildDetailItem(
                  'Guests',
                  '${widget.passengers.length}',
                  Icons.people_rounded,
                ),
              ],
            ),
            SizedBox(height: 12),
            _buildDetailItem(
              'Room Type',
              widget.room.name.join(', '),
              Icons.king_bed_rounded,
            ),
            SizedBox(height: 12),
            _buildDetailItem(
              'Meal Plan',
              widget.room.mealType.isNotEmpty ? widget.room.mealType : 'Not Included',
              Icons.restaurant_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: _secondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: _secondaryColor, size: 16),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    color: _textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuestSummary() {
    final totalGuests = widget.passengers.length;
    final totalRooms = widget.roomPassengers?.length ?? 1;

    return Container(
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Guest Summary', Icons.people_alt_rounded),
            SizedBox(height: 12),
            Text(
              '$totalGuests guest${totalGuests > 1 ? 's' : ''} across $totalRooms room${totalRooms > 1 ? 's' : ''}',
              style: TextStyle(
                fontSize: 15,
                color: _textPrimary,
              ),
            ),
            SizedBox(height: 8),
            if (widget.roomPassengers != null)
              ...widget.roomPassengers!.asMap().entries.map((entry) {
                final roomIndex = entry.key;
                final room = entry.value;
                return Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'Room ${roomIndex + 1}: ${room.length} guest${room.length > 1 ? 's' : ''}',
                    style: TextStyle(
                      fontSize: 13,
                      color: _textSecondary,
                    ),
                  ),
                );
              }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceBreakdown(PreBookRoom? preBookRoom) {
    final totalAmount = _getTotalAmount();
    final roomFare = preBookRoom?.totalFare ?? widget.room.totalFare;
    final roomTax = preBookRoom?.totalTax ?? widget.room.totalTax;

    return Container(
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Price Breakdown', Icons.receipt_long_rounded),
            SizedBox(height: 16),
            _buildPriceRow('Room Fare', roomFare),
            SizedBox(height: 8),
            _buildPriceRow('Taxes & Fees', roomTax),
            Divider(height: 20, color: Colors.grey.shade300),
            _buildPriceRow('Total Amount', totalAmount, isTotal: true),
            SizedBox(height: 12),
            if (preBookRoom?.isRefundable == true)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _successColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _successColor.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle_rounded, color: _successColor, size: 20),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Fully Refundable - Free cancellation available',
                        style: TextStyle(
                          color: _successColor,
                          fontSize: 14,
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

 Widget _buildCancellationPolicy(PreBookRoom preBookRoom) {
  // Format date from "2024-01-01T00:00:00" to "01 Jan 2024"
  String _formatPolicyDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return dateString; // Return original if parsing fails
    }
  }

  // Format charge type to be more readable
  String _formatChargeType(String chargeType) {
    switch (chargeType.toLowerCase()) {
      case 'flat':
        return 'Flat Charge';
      case 'percentage':
        return 'Percentage';
      case 'night':
        return 'Per Night';
      default:
        return chargeType;
    }
  }

  // Get policy description based on charge type and amount
  String _getPolicyDescription(CancelPolicy policy) {
    final formattedDate = _formatPolicyDate(policy.fromDate);
    final chargeType = _formatChargeType(policy.chargeType);
    final charge = policy.cancellationCharge;

    if (policy.chargeType.toLowerCase() == 'percentage') {
      return 'Before $formattedDate: $chargeType - ${charge.toStringAsFixed(0)}% of booking amount';
    } else if (policy.chargeType.toLowerCase() == 'flat') {
      return 'Before $formattedDate: $chargeType - ₹${charge.toStringAsFixed(0)}';
    } else if (policy.chargeType.toLowerCase() == 'night') {
      return 'Before $formattedDate: $chargeType - ₹${charge.toStringAsFixed(0)} per night';
    } else {
      return 'Before $formattedDate: $chargeType - ₹${charge.toStringAsFixed(0)}';
    }
  }

  return Container(
    decoration: BoxDecoration(
      color: _cardColor,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Cancellation Policy', Icons.policy_rounded),
          SizedBox(height: 10),
          
          if (preBookRoom.cancelPolicies.isEmpty)
            Text(
              'Free cancellation available',
              style: TextStyle(
                fontSize: 14,
                color: _successColor,
                fontWeight: FontWeight.w500,
              ),
            )
          else
            Column(
              children: [
                // Free cancellation period if available
                if (preBookRoom.cancelPolicies.isNotEmpty && 
                    preBookRoom.cancelPolicies.first.cancellationCharge == 0)
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _successColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _successColor.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle_rounded, color: _successColor, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Free cancellation available',
                            style: TextStyle(
                              color: _successColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                
               

                ...preBookRoom.cancelPolicies.asMap().entries.map((entry) {
                  final index = entry.key;
                  final policy = entry.value;
                  final isLast = index == preBookRoom.cancelPolicies.length - 1;

                  return Container(
                    margin: EdgeInsets.only(bottom: isLast ? 0 : 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Timeline indicator
                   
                        
                        // Policy content
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: _backgroundColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _getPolicyDescription(policy),
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: _textPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                               
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),

                // Additional information
                if (preBookRoom.cancelPolicies.isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _warningColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _warningColor.withOpacity(0.3)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info_outline_rounded, color: _warningColor, size: 16),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Cancellation policies are subject to hotel terms and conditions. Please review carefully before booking.',
                            style: TextStyle(
                              fontSize: 12,
                              color: _textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
        ],
      ),
    ),
  );
}

  Widget _buildPriceRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: isTotal ? _textPrimary : _textSecondary,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 16 : 14,
          ),
        ),
        Spacer(),
        Text(
          '₹${amount.toStringAsFixed(2)}',
          style: TextStyle(
            color: isTotal ? _primaryColor : _textPrimary,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 18 : 14,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _secondaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: _secondaryColor, size: 20),
        ),
        SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: _textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentSection(double totalAmount) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                'Total Amount:',
                style: TextStyle(
                  fontSize: 15,
                  color: _textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Text(
                '₹${totalAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          BlocBuilder<HotelBookingConfirmBloc, HotelBookingConfirmState>(
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: 
                
                  (_isTimerExpired || state is HotelBookingConfirmLoading)
                      ? null
                      :
                      
                      
                      _onProceedToPayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isTimerExpired ? Colors.grey : _primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                  ),
                  child: state is HotelBookingConfirmLoading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.payment_rounded, size: 22),
                            SizedBox(width: 12),
                            Text(
                              _isTimerExpired ? "TIME EXPIRED" : "PROCEED TO PAYMENT",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
 void _showRefundInitiatedSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent, // transparent for better design
      builder: (context) {
        final height = MediaQuery.of(context).size.height * 0.7;
        return WillPopScope(
             onWillPop: () async {
            Navigator.of(context).popUntil((route) => route.isFirst);
            return false;
          },
          child: Container(
            height: height,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(height: 30),
                // Success / Refund icon
                CircleAvatar(
                  radius: 50,
                  backgroundColor: _secondaryColor.withOpacity(0.1),
                  child:  Icon(Icons.check_circle_rounded,
                      color: _secondaryColor, size: 60),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Sorry, hotel booking failed",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                              const SizedBox(height: 10),
          
                     Text(
                                  "We couldn't complete your hotel booking",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: _textSecondary,
                                    fontSize: 16,
                                    height: 1.5,
                                  ),
                                ),
                                                            const SizedBox(height: 20),
          
                  Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                              color: _secondaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: _successColor.withOpacity(0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.credit_card_rounded, color: _successColor, size: 28),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Refund Initiated",
                                          style: TextStyle(
                                            color: _textPrimary,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 6),
                                        Text(
                                          "Your amount will be credited back to your account shortly",
                                          style: TextStyle(
                                            color: _textSecondary,
                                            fontSize: 14,
                                            height: 1.4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                const Spacer(),
                ElevatedButton(
                  onPressed: () =>                                 Navigator.of(context).popUntil((route) => route.isFirst),
          
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Okay, Got It"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ------------------- 2️⃣ Contact Support Sheet -------------------
  void _showContactSupportSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final height = MediaQuery.of(context).size.height * 0.75;
        return Container(
          height: height,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: _secondaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 25),
              // Alert Icon
              CircleAvatar(
                radius: 45,
                backgroundColor: _secondaryColor.withOpacity(0.1),
                child: const Icon(Icons.error_outline_rounded,
                    color: Colors.orange, size: 60),
              ),
              const SizedBox(height: 25),
              const Text(
                "Sorry, hotel booking failed",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
   Text(
                                  "We couldn't complete your hotel booking",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: _textSecondary,
                                    fontSize: 16,
                                    height: 1.5,
                                  ),
                                ),              const SizedBox(height: 12),

                 Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                              color: _secondaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: _successColor.withOpacity(0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.credit_card_rounded, color: _successColor, size: 28),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
  Text(
                                          "The refund is still pending.",
                                          style: TextStyle(
                                            color: _textPrimary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 6),
                                        Text(
                                          "If the amount is debited from your account and you ,haven’t received a refund yet, please contact our support team."
                                                                                               , style: TextStyle(
                                            color: _textSecondary,
                                            fontSize: 13,
                                            height: 1.4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
           
    const Spacer(),
                ElevatedButton(
                  onPressed: () =>                                 Navigator.of(context).popUntil((route) => route.isFirst),
          
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Okay, Got It"),
                ),           
            ],
          ),
        );
      },
    );
  }
}