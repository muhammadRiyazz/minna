import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/core/api.dart';
import 'package:minna/comman/functions/create_order_id.dart';
import 'package:minna/hotel%20booking/application/hotel/hotel_booking_confirm_bloc.dart';
import 'package:minna/hotel%20booking/domain/authentication/authendication.dart';
import 'package:minna/hotel%20booking/domain/hotel%20list/hotel_list.dart'
    hide CancelPolicy;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/pages/log%20in/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:minna/hotel%20booking/functions/hotel_payment_utils.dart';
import 'package:minna/hotel%20booking/functions/auth.dart';

class HotelBookingConfirmationPage extends StatefulWidget {
  final String prebookId;
  final RoomDetail room;
  final HotelSearchItem hotel;
  final List<Map<String, dynamic>> passengers;
  final List<List<Map<String, dynamic>>>? roomPassengers;
  final String bookingId;
  final PreBookResponseWithAuth preBookResponse;
  final String guestNationalityCode;

  const HotelBookingConfirmationPage({
    super.key,
    required this.prebookId,
    required this.room,

    required this.hotel,
    required this.passengers,
    required this.roomPassengers,
    required this.bookingId,
    required this.preBookResponse,
    required this.guestNationalityCode,
  });

  @override
  State<HotelBookingConfirmationPage> createState() =>
      _HotelBookingConfirmationPageState();
}

class _HotelBookingConfirmationPageState
    extends State<HotelBookingConfirmationPage> {
  late Timer _timer;
  int _remainingSeconds = 8 * 60; // 8 minutes
  bool _isTimerExpired = false;
  late Razorpay _razorpay;
  String? _orderId;
  String _displayTime = '08:00';

  // Theme colors
  final Color _primaryColor = maincolor1;
  final Color _secondaryColor = secondaryColor;
  final Color _backgroundColor = const Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = const Color(0xFF1A1A1A);
  final Color _textSecondary = const Color(0xFF6C757D);
  final Color _textLight = const Color(0xFFADB5BD);
  final Color _errorColor = const Color(0xFFD62828);
  final Color _successColor = const Color(0xFF2D6A4F);
  final Color _warningColor = const Color(0xFFF77F00);
  final Color _borderColor = const Color(0xFFE9ECEF);

  // Service Charge
  double _serviceChargePercentage = 0.0;
  final AuthApiService _apiService = AuthApiService();

  @override
  void initState() {
    super.initState();
    context.read<LoginBloc>().add(const LoginEvent.loginInfo());
    _startOptimizedTimer();
    _initRazorpay();
    _fetchServiceCharge();
  }

  Future<void> _fetchServiceCharge() async {
    try {
      final result = await _apiService.getServiceCharge();
      if (result.isSuccess && result.data != null) {
        if (mounted) {
          setState(() {
            _serviceChargePercentage = result.data!.percentage;
          });
        }
      }
    } catch (e) {
      log("Error fetching service charge: $e");
    }
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
        final shouldRebuild =
            _displayTime != newDisplayTime || _remainingSeconds <= 10;

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

    try {
      context.read<HotelBookingConfirmBloc>().add(
        HotelBookingConfirmEvent.startLoading(),
      );

      final bookingRequest = await _generateBookingRequest();
      final totalAmount = _getTotalAmount();

      // NEW: Verify payment before proceeding
      log("🔹 Verifying Hotel Payment...");
      final isVerified = await verifyHotelRazorpayPayment(
        paymentId: response.paymentId ?? '',
        orderId: response.orderId ?? _orderId ?? '',
        signature: response.signature ?? '',
        traceId: "", // As per current implementation logic
        tokenId: widget.preBookResponse.token,
      );

      if (!isVerified) {
        log("❌ Hotel Payment Verification Failed");
        context.read<HotelBookingConfirmBloc>().add(
          HotelBookingConfirmEvent.stopLoading(),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              "Payment verification failed. Please contact support.",
            ),
            backgroundColor: _errorColor,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      log("✅ Hotel Payment Verified. Proceeding to book...");

      context.read<HotelBookingConfirmBloc>().add(
        HotelBookingConfirmEvent.paymentDone(
          prebookId: widget.prebookId,
          orderId: response.orderId ?? _orderId ?? '',
          transactionId: response.paymentId ?? '',
          bookingId: widget.bookingId,
          amount: totalAmount,
          bookingRequest: bookingRequest,
        ),
      );

      _timer.cancel();
    } catch (e) {
      log("Error in payment success handler: $e");
      context.read<HotelBookingConfirmBloc>().add(
        HotelBookingConfirmEvent.stopLoading(),
      );
    }
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
                  child: Icon(
                    Icons.timer_off_rounded,
                    size: 40,
                    color: _errorColor,
                  ),
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
                  style: TextStyle(fontSize: 16, color: _textSecondary),
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
    final preBookRoom = widget
        .preBookResponse
        .preBookResponse
        .hotelResult
        .firstOrNull
        ?.rooms
        .firstOrNull;

    double baseAmount;
    if (preBookRoom != null) {
      // This returns the base amount (room fare + taxes)
      baseAmount = preBookRoom.totalFare + preBookRoom.totalTax;
    } else {
      // Fallback to widget.room data
      baseAmount = widget.room.totalFare + widget.room.totalTax;
    }

    if (_serviceChargePercentage > 0) {
      final serviceCharge = (baseAmount * _serviceChargePercentage) / 100;
      return baseAmount + serviceCharge;
    }

    return baseAmount;
  }

  // Add a new method to get just the net amount (room fare without taxes)
  double _getNetAmount() {
    final preBookRoom = widget
        .preBookResponse
        .preBookResponse
        .hotelResult
        .firstOrNull
        ?.rooms
        .firstOrNull;
    if (preBookRoom != null) {
      // This returns just the NET amount (room fare without taxes)
      return preBookRoom.totalFare;
    }
    // Fallback to widget.room data
    return widget.room.totalFare;
  }

  Future<Map<String, dynamic>> _generateBookingRequest() async {
    final hotelRoomsDetails = <Map<String, dynamic>>[];
    final totalRooms = widget.roomPassengers?.length ?? 1;
    final isSingleRoom = totalRooms == 1;

    // Get hotel result from prebook response
    final hotelResult =
        widget.preBookResponse.preBookResponse.hotelResult.firstOrNull;
    if (hotelResult == null) {
      throw Exception("No hotel result found in prebook response");
    }

    // Get the correct prebook room to calculate net amount
    final preBookRoom = widget
        .preBookResponse
        .preBookResponse
        .hotelResult
        .firstOrNull
        ?.rooms
        .firstOrNull;

    // Calculate amounts
    final roomFare = preBookRoom?.totalFare ?? widget.room.totalFare;
    final roomTax = preBookRoom?.totalTax ?? widget.room.totalTax;
    final netAmount = roomFare; // Net amount is room fare without taxes
    final totalAmount = roomFare + roomTax;

    // Get required authentication fields
    final token = widget.preBookResponse.token;
    final agencyId = widget.preBookResponse.agencyId;
    final traceId = ""; // Using empty string as per your code

    if (token.isEmpty) {
      throw Exception("Token is required for booking");
    }

    // Build passenger data
    if (widget.roomPassengers != null) {
      for (final room in widget.roomPassengers!) {
        final hotelPassengers = <Map<String, dynamic>>[];

        for (final passenger in room) {
          hotelPassengers.add({
            "Title": passenger['Title'] ?? "Mr.",
            "FirstName": passenger['FirstName'] ?? "",
            "MiddleName": passenger['MiddleName'] ?? "",
            "LastName": passenger['LastName'] ?? "",
            "Email": passenger['Email'] ?? null,
            "PaxType": passenger['PaxType'] ?? 1,
            "LeadPassenger": passenger['LeadPassenger'] ?? false,
            "Age": passenger['Age'] ?? 0,
            "PassportNo":
                passenger['PassportNo'] ?? passenger['Passport'] ?? null,
            "PassportIssueDate": passenger['PassportIssueDate'] ?? null,
            "PassportExpDate": passenger['PassportExpDate'] ?? null,
            "Phoneno": passenger['Phoneno'] ?? passenger['Phone'] ?? null,
            "PaxId": passenger['PaxId'] ?? 0,
            "GSTCompanyAddress": passenger['GSTCompanyAddress'] ?? null,
            "GSTCompanyContactNumber":
                passenger['GSTCompanyContactNumber'] ?? null,
            "GSTCompanyName": passenger['GSTCompanyName'] ?? null,
            "GSTNumber": passenger['GSTNumber'] ?? null,
            "GSTCompanyEmail": passenger['GSTCompanyEmail'] ?? null,
            "PAN": passenger['PAN'] ?? null,
          });
        }

        // Ensure at least one passenger is marked as LeadPassenger
        if (hotelPassengers.isNotEmpty &&
            !hotelPassengers.any((p) => p['LeadPassenger'] == true)) {
          hotelPassengers[0]['LeadPassenger'] = true;
        }

        hotelRoomsDetails.add({"HotelPassenger": hotelPassengers});
      }
    } else {
      // Fallback to single room structure
      final hotelPassengers = <Map<String, dynamic>>[];

      for (final passenger in widget.passengers) {
        hotelPassengers.add({
          "Title": passenger['Title'] ?? "Mr.",
          "FirstName": passenger['FirstName'] ?? "",
          "MiddleName": passenger['MiddleName'] ?? "",
          "LastName": passenger['LastName'] ?? "",
          "Email": passenger['Email'] ?? null,
          "PaxType": passenger['PaxType'] ?? 1,
          "LeadPassenger": passenger['LeadPassenger'] ?? false,
          "Age": passenger['Age'] ?? 0,
          "PassportNo":
              passenger['PassportNo'] ?? passenger['Passport'] ?? null,
          "PassportIssueDate": passenger['PassportIssueDate'] ?? null,
          "PassportExpDate": passenger['PassportExpDate'] ?? null,
          "Phoneno": passenger['Phoneno'] ?? passenger['Phone'] ?? null,
          "PaxId": passenger['PaxId'] ?? 0,
          "GSTCompanyAddress": passenger['GSTCompanyAddress'] ?? null,
          "GSTCompanyContactNumber":
              passenger['GSTCompanyContactNumber'] ?? null,
          "GSTCompanyName": passenger['GSTCompanyName'] ?? null,
          "GSTNumber": passenger['GSTNumber'] ?? null,
          "GSTCompanyEmail": passenger['GSTCompanyEmail'] ?? null,
          "PAN": passenger['PAN'] ?? null,
        });
      }

      // Ensure at least one passenger is marked as LeadPassenger
      if (hotelPassengers.isNotEmpty &&
          !hotelPassengers.any((p) => p['LeadPassenger'] == true)) {
        hotelPassengers[0]['LeadPassenger'] = true;
      }

      hotelRoomsDetails.add({"HotelPassenger": hotelPassengers});
    }

    // Base booking request - COMMON for both modes
    final bookingRequest = <String, dynamic>{
      "BookingCode": widget.room.bookingCode,
      "IsVoucherBooking": true,
      "GuestNationality": widget.guestNationalityCode,
      "EndUserIp": "192.168.9.119",
      "HotelRoomsDetails": hotelRoomsDetails,
      "NetAmount": netAmount, // Add NetAmount for ALL bookings
    };

    // Determine booking mode
    final requestedBookingMode = isSingleRoom ? 5 : 1;
    bookingRequest["RequestedBookingMode"] = requestedBookingMode;

    if (isSingleRoom) {
      // For single room bookings (Mode 5)
      bookingRequest["ClientReferenceId"] = _generateClientReferenceId();
      log("Single Room Booking (Mode 5) - NetAmount: $netAmount");
    } else {
      // For multi-room bookings (Mode 1)
      // Based on the API documentation you provided, Mode 1 needs these additional fields
      bookingRequest["TokenId"] = token;
      bookingRequest["TraceId"] = traceId;
      bookingRequest["AgencyId"] = agencyId; // Use default if not provided
      log(
        "Multi-Room Booking (Mode 1) - NetAmount: $netAmount, Token: $token, AgencyId: ${agencyId}",
      );
    }

    // Log the final request for debugging
    log("Generated Booking Request: ${jsonEncode(bookingRequest)}");

    return bookingRequest;
  }

  String _generateClientReferenceId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = (1000 + (timestamp % 9000)).toString();
    return 'HOTEL_${timestamp}_$random';
  }

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
                  child: Icon(
                    Icons.exit_to_app_rounded,
                    color: _warningColor,
                    size: 30,
                  ),
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
                  style: TextStyle(color: _textSecondary, fontSize: 15),
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
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).popUntil((route) => route.isFirst);
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
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
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
    final isLoggedIn = context.read<LoginBloc>().state.isLoggedIn ?? false;

    if (!isLoggedIn) {
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const LoginBottomSheet(login: 1),
      );

      // Re-check login status after bottom sheet is closed
      final newLoginState = context.read<LoginBloc>().state;
      if (newLoginState.isLoggedIn != true) {
        return;
      }
    }

    if (_isTimerExpired) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Booking time has expired. Please try again."),
          backgroundColor: _errorColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
      return;
    }

    context.read<HotelBookingConfirmBloc>().add(
      HotelBookingConfirmEvent.startLoading(),
    );

    try {
      // Get the TOTAL amount (room fare + taxes) for Razorpay
      final totalAmount = _getTotalAmount();
      final netAmount = _getNetAmount();
      final totalRooms = widget.roomPassengers?.length ?? 1;
      final isSingleRoom = totalRooms == 1;

      // 1. Get User ID
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final userId = preferences.getString('userId') ?? '';

      // 2. Get Service Charge
      double serviceChargeAmount = 0;
      final baseAmountForServiceCharge =
          widget
                  .preBookResponse
                  .preBookResponse
                  .hotelResult
                  .firstOrNull
                  ?.rooms
                  .firstOrNull !=
              null
          ? (widget
                    .preBookResponse
                    .preBookResponse
                    .hotelResult
                    .firstOrNull!
                    .rooms
                    .firstOrNull!
                    .totalFare +
                widget
                    .preBookResponse
                    .preBookResponse
                    .hotelResult
                    .firstOrNull!
                    .rooms
                    .firstOrNull!
                    .totalTax)
          : (widget.room.totalFare + widget.room.totalTax);

      if (_serviceChargePercentage > 0) {
        serviceChargeAmount =
            (baseAmountForServiceCharge * _serviceChargePercentage) / 100;
        log(
          "✅ Using state service charge: $_serviceChargePercentage% -> $serviceChargeAmount",
        );
      } else {
        try {
          final chargeResult = await _apiService.getServiceCharge();
          if (chargeResult.isSuccess && chargeResult.data != null) {
            final percentage = chargeResult.data!.percentage;
            serviceChargeAmount =
                (baseAmountForServiceCharge * percentage) / 100;
            log(
              "✅ Fetched service charge in payment: $percentage% -> $serviceChargeAmount",
            );
          }
        } catch (e) {
          log("⚠️ Could not fetch service charge, using 0: $e");
        }
      }

      // 3. Generate Booking Payload
      final bookingPayload = await _generateBookingRequest();

      // 4. Create Order using Hotel-specific API
      final orderData = await createHotelRazorpayOrder(
        userId: userId,
        bookingPayload: bookingPayload,
        amount: totalAmount,
        serviceCharge: serviceChargeAmount,
      );

      if (orderData == null) {
        log("Order ID creation failed");
        context.read<HotelBookingConfirmBloc>().add(
          HotelBookingConfirmEvent.stopLoading(),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Failed to create order. Please try again."),
            backgroundColor: _errorColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
        return;
      }

      final orderId = orderData['order_id']?.toString();
      if (orderId == null) {
        log("Invalid order data received");
        context.read<HotelBookingConfirmBloc>().add(
          HotelBookingConfirmEvent.stopLoading(),
        );
        return;
      }

      setState(() {
        _orderId = orderId;
      });

      final leadPassenger = _getLeadPassenger();
      final name =
          "${leadPassenger['Title']} ${leadPassenger['FirstName']} ${leadPassenger['LastName']}"
              .trim();
      final phone = leadPassenger['Phone'] ?? leadPassenger['Phoneno'] ?? '';
      final email = leadPassenger['Email'] ?? '';

      var options = {
        'key': razorpaykey,
        'amount': (totalAmount * 100)
            .toInt(), // Charge TOTAL amount (with taxes)
        'name': 'MT Hotels',
        'order_id': orderId,
        'description': 'Hotel Booking - ${widget.hotel.hotelDetails.hotelName}',
        'prefill': {'contact': phone, 'email': email, 'name': name},
        'theme': {'color': '#000000'},
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
            content: Text("Payment error: ${e.toString()}"),
            backgroundColor: _errorColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    } catch (e) {
      log("Error in payment process: $e");
      context.read<HotelBookingConfirmBloc>().add(
        HotelBookingConfirmEvent.stopLoading(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred: ${e.toString()}"),
          backgroundColor: _errorColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
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

    // Return first passenger as fallback
    return widget.passengers.first;
  }

  void _showServerErrorBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                color: Colors.red,
                size: 48,
              ),
              const SizedBox(height: 16),
              const Text(
                'Connection Error',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Server issue detected. Connection failed. Please try again later.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalAmount = _getTotalAmount();

    return MultiBlocListener(
      listeners: [
        BlocListener<HotelBookingConfirmBloc, HotelBookingConfirmState>(
          listener: (context, state) {
            // state.maybeWhen(
            //   paymentFail: (orderId, prebookId, bookingId) {
            //     _showPaymentFailedSheet();
            //   },
            //   serverError: () {
            //     _showServerErrorBottomSheet(context);
            //   },
            //   orElse: () {},
            // );
          },
        ),
      ],
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) return;
          final shouldExit = await _onWillPop();
          if (shouldExit && context.mounted) {
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
          backgroundColor: _backgroundColor,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildAppBar(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildTimerSection(),
                      const SizedBox(height: 16),
                      _buildHotelSummaryCard(),
                      const SizedBox(height: 16),
                      _buildRoomInfoCard(),
                      const SizedBox(height: 16),
                      _buildPassengerSummaryCard(),
                      const SizedBox(height: 16),
                      _buildPriceDetailedCard(totalAmount),
                      const SizedBox(height: 120), // Spacing for bottom bar
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: _buildBottomActionBar(totalAmount),
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
              widget.hotel.hotelDetails.hotelName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _textPrimary,
              ),
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on_rounded,
                  color: _secondaryColor,
                  size: 16,
                ),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    widget.hotel.hotelDetails.address,
                    style: TextStyle(color: _textSecondary),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.room_service_rounded,
                  color: _secondaryColor,
                  size: 16,
                ),
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
            SizedBox(height: 10),
            _buildSectionHeader(
              'Booking Details',
              Icons.calendar_month_rounded,
            ),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.8,
              children: [
                _buildDetailItem('Check-in', '14:00', Icons.login_rounded),
                _buildDetailItem('Check-out', '12:00', Icons.logout_rounded),
                _buildDetailItem(
                  'Duration',
                  '1 Night',
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
              widget.room.mealType.isNotEmpty
                  ? widget.room.mealType
                  : 'Not Included',
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
              style: TextStyle(fontSize: 15, color: _textPrimary),
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
                    style: TextStyle(fontSize: 13, color: _textSecondary),
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceBreakdown(PreBookRoom? preBookRoom) {
    final totalAmount = _getTotalAmount();
    final roomFare = preBookRoom?.totalFare ?? widget.room.totalFare;
    final roomTax = preBookRoom?.totalTax ?? widget.room.totalTax;
    final baseAmountForServiceCharge = roomFare + roomTax;
    final serviceChargeAmount = (_serviceChargePercentage > 0)
        ? (baseAmountForServiceCharge * _serviceChargePercentage) / 100
        : 0.0;

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
            SizedBox(height: 8),
            _buildPriceRow('Service Charge', serviceChargeAmount),
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
                    Icon(
                      Icons.check_circle_rounded,
                      color: _successColor,
                      size: 20,
                    ),
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
    String formatPolicyDate(String dateString) {
      try {
        final date = DateTime.parse(dateString);
        return DateFormat('dd MMM yyyy').format(date);
      } catch (e) {
        return dateString;
      }
    }

    String formatChargeType(String chargeType) {
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

    String getPolicyDescription(CancelPolicy policy) {
      final formattedDate = formatPolicyDate(policy.fromDate);
      final chargeType = formatChargeType(policy.chargeType);
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
                  if (preBookRoom.cancelPolicies.isNotEmpty &&
                      preBookRoom.cancelPolicies.first.cancellationCharge == 0)
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _successColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _successColor.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: _successColor,
                            size: 18,
                          ),
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
                    final isLast =
                        index == preBookRoom.cancelPolicies.length - 1;

                    return Container(
                      margin: EdgeInsets.only(bottom: isLast ? 0 : 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                    getPolicyDescription(policy),
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
                  }),

                  if (preBookRoom.cancelPolicies.isNotEmpty)
                    Container(
                      margin: EdgeInsets.only(top: 12),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _warningColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _warningColor.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: _warningColor,
                            size: 16,
                          ),
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
                      : () {
                          // _showServerErrorBottomSheet(context);
                          _onProceedToPayment();
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isTimerExpired
                        ? Colors.grey
                        : _primaryColor,
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
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.payment_rounded, size: 22),
                            SizedBox(width: 12),
                            Text(
                              _isTimerExpired
                                  ? "TIME EXPIRED"
                                  : "PROCEED TO PAYMENT",
                              style: TextStyle(
                                //       fontSize: 14,
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

  void _showPaymentFailedSheet() {
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
                  child: Icon(
                    Icons.error_outline_rounded,
                    size: 40,
                    color: _errorColor,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Payment Failed",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Your payment could not be processed. Please try again or use a different payment method.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: _textSecondary),
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
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
                      "Try Again",
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

  void _showRefundInitiatedSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
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
                CircleAvatar(
                  radius: 50,
                  backgroundColor: _secondaryColor.withOpacity(0.1),
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: _secondaryColor,
                    size: 60,
                  ),
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
                        child: Icon(
                          Icons.credit_card_rounded,
                          color: _successColor,
                          size: 28,
                        ),
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
                  onPressed: () =>
                      Navigator.of(context).popUntil((route) => route.isFirst),
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
              CircleAvatar(
                radius: 45,
                backgroundColor: _secondaryColor.withOpacity(0.1),
                child: const Icon(
                  Icons.error_outline_rounded,
                  color: Colors.orange,
                  size: 60,
                ),
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
              ),
              const SizedBox(height: 12),
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
                      child: Icon(
                        Icons.credit_card_rounded,
                        color: _successColor,
                        size: 28,
                      ),
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
                            "If the amount is debited from your account and you haven't received a refund yet, please contact our support team.",
                            style: TextStyle(
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
                onPressed: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
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

  Widget _buildAppBar() {
    return SliverAppBar(
      backgroundColor: _primaryColor,
      expandedHeight: 180,
      pinned: true,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: const Text(
          'Confirm Booking',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&q=80',
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    _primaryColor.withOpacity(0.8),
                    _primaryColor,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimerSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: _errorColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _errorColor.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _errorColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.timer_outlined, color: _errorColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Complete Booking in',
                  style: TextStyle(fontSize: 12, color: _textSecondary),
                ),
                Text(
                  _displayTime,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _errorColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.hotel_class_rounded,
                  color: _secondaryColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.hotel.hotelDetails.hotelName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _textPrimary,
                      ),
                    ),
                    Text(
                      widget.hotel.hotelDetails.address,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: _textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSimpleInfo(
                'Hotel Code',
                widget.hotel.hotelDetails.hotelCode,
              ),
              // _buildSimpleInfo('Currency', widget.hotel.hotelDetails.c),
              _buildSimpleInfo(
                'Ratings',
                widget.hotel.hotelDetails.hotelRating.toString(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 11, color: _textSecondary)),
        const SizedBox(height: 4),
        Text(
          value.isEmpty ? 'N/A' : value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildRoomInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.king_bed_outlined, color: _primaryColor, size: 20),
              const SizedBox(width: 12),
              Text(
                'Room Information',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            widget.room.name.join(', '),
            style: TextStyle(fontSize: 13, color: _textSecondary, height: 1.4),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildAmenityChip('Premium Stay'),
              _buildAmenityChip('Verified Room'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmenityChip(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: _textSecondary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPassengerSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.people_outline_rounded,
                color: _primaryColor,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                'Passenger Summary',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.passengers.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final p = widget.passengers[index];
              return Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: _primaryColor.withOpacity(0.05),
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontSize: 10,
                        color: _primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${p['Title'] ?? ''} ${p['FirstName'] ?? ''} ${p['LastName'] ?? ''}',
                    style: TextStyle(
                      fontSize: 13,
                      color: _textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  if (p['LeadPassenger'] == true)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _secondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'LEAD',
                        style: TextStyle(
                          fontSize: 8,
                          color: _secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPriceDetailedCard(double totalAmount) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _primaryColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSummaryPriceRow(
            'Base Price',
            '₹${widget.room.totalFare.toStringAsFixed(2)}',
            Colors.white70,
          ),
          const SizedBox(height: 12),
          _buildSummaryPriceRow(
            'Taxes & Fees',
            '₹${widget.room.totalTax.toStringAsFixed(2)}',
            Colors.white70,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: Colors.white24),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Payable',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '₹${totalAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: _secondaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryPriceRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 13, color: color)),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActionBar(double totalAmount) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Payable',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
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
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _onProceedToPayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: _secondaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Confirm & Pay',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward_rounded, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
