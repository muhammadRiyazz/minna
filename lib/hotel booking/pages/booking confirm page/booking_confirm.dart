import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/core/api.dart';
import 'package:minna/hotel%20booking/application/hotel/hotel_booking_confirm_bloc.dart';
import 'package:minna/hotel%20booking/domain/authentication/authendication.dart';
import 'package:minna/hotel%20booking/domain/hotel%20list/hotel_list.dart'
    hide CancelPolicy;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:minna/hotel%20booking/functions/auth.dart';
import 'package:shimmer/shimmer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/pages/log%20in/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool _isServiceChargeLoading = true;

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

  // Service Charge
  double _serviceChargePercentage = 0.0;
  final AuthApiService _apiService = AuthApiService();
  late HotelBookingConfirmBloc _confirmBloc;

  @override
  void initState() {
    super.initState();
    _confirmBloc = context.read<HotelBookingConfirmBloc>();
    _confirmBloc.add(const HotelBookingConfirmEvent.reset());
    context.read<LoginBloc>().add(const LoginEvent.loginInfo());
    _startOptimizedTimer();
    _initRazorpay();
    _fetchServiceCharge();
  }

  Future<void> _fetchServiceCharge() async {
    setState(() => _isServiceChargeLoading = true);
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
    } finally {
      if (mounted) {
        setState(() => _isServiceChargeLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _razorpay.clear();
    _confirmBloc.add(const HotelBookingConfirmEvent.reset());
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
    log("Hotel Payment Success Callback: ${response.paymentId}");

    context.read<HotelBookingConfirmBloc>().add(
      HotelBookingConfirmEvent.verifyPayment(
        paymentId: response.paymentId ?? '',
        orderId: response.orderId ?? _orderId ?? '',
        signature: response.signature ?? '',
        traceId: "",
        tokenId: widget.preBookResponse.token,
      ),
    );
    _timer.cancel();
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    log("Hotel Payment Failed Callback: ${response.message}");
    context.read<HotelBookingConfirmBloc>().add(
      const HotelBookingConfirmEvent.stopLoading(),
    );
    // Error View will handle this via Bloc state if we emit error,
    // but Razorpay cancellation is usually just a stop loading or a specific error emit.
    // For now, let's just show an error state in the Bloc.
    context.read<HotelBookingConfirmBloc>().add(
      const HotelBookingConfirmEvent.reset(), // Reset to initial to allow retry
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
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: _errorColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Iconsax.timer_1,
                        size: 40,
                        color: _errorColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Booking Session Expired",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1A1A1A),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Your hotel booking session has expired due to inactivity. Please restart the process to secure your stay.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: _textSecondary,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
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
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Return to Home",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
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
    );
  }

  double _getBaseAmount() {
    final preBookRoom = widget
        .preBookResponse
        .preBookResponse
        .hotelResult
        .firstOrNull
        ?.rooms
        .firstOrNull;
    if (preBookRoom != null) {
      return preBookRoom.totalFare + preBookRoom.totalTax;
    }
    return widget.room.totalFare + widget.room.totalTax;
  }

  double _calculateServiceCharge(double netAmount) {
    if (_serviceChargePercentage > 0) {
      return (netAmount * _serviceChargePercentage) / 100;
    }
    return 0.0;
  }

  double _getTotalAmount() {
    log('_getTotalAmount-------------------');

    final netAmount = _getNetAmount();
    log(netAmount.toString());
    return netAmount + _calculateServiceCharge(netAmount);
  }

  // Add a new method to get just the net amount (room fare without taxes)
  double _getNetAmount() {
    log('_getNetAmount-------------------');
    final preBookRoom = widget
        .preBookResponse
        .preBookResponse
        .hotelResult
        .firstOrNull
        ?.rooms
        .firstOrNull;
    if (preBookRoom != null) {
      log(preBookRoom.netAmount.toString());
      // This returns just the NET amount (room fare without taxes)
      return preBookRoom.netAmount;
    }
    // Fallback to widget.room data
    log(widget.room.netAmount.toString());
    return widget.room.netAmount;
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
    final netAmount = preBookRoom?.netAmount ?? roomFare;
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
    // If we're already in a success state, we don't need a confirmation dialog
    final currentState = _confirmBloc.state;
    if (currentState is HotelBookingConfirmSuccess) {
      if (context.mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
      return false;
    }

    final shouldExit = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top Handle
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: _warningColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Iconsax.warning_2,
                        color: _warningColor,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Title
                  const Text(
                    "Exit Hotel Booking?",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1A1A1A),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Subtitle
                  Text(
                    "Are you sure you want to stop the booking process? Your progress will be lost.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _textSecondary,
                      fontSize: 15,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Actions
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context, false),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            "Continue with Booking",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).popUntil((route) => route.isFirst);
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            "Yes, Exit Process",
                            style: TextStyle(
                              color: _errorColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    return shouldExit ?? false;
  }

  void _onProceedToPayment({
    required double totalAmount,
    required double serviceChargeAmount,
  }) async {
    final isLoggedIn = context.read<LoginBloc>().state.isLoggedIn ?? false;

    if (!isLoggedIn) {
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const LoginBottomSheet(login: 1),
      );

      final newLoginState = context.read<LoginBloc>().state;
      if (newLoginState.isLoggedIn != true) return;
    }

    if (_isTimerExpired) {
      _showErrorDialog("Booking time has expired. Please try again.");
      return;
    }

    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final userId = preferences.getString('userId') ?? '';
      final bookingPayload = await _generateBookingRequest();
      final netAmount = _getNetAmount();

      context.read<HotelBookingConfirmBloc>().add(
        HotelBookingConfirmEvent.createOrder(
          userId: userId,
          bookingPayload: bookingPayload,
          amount: totalAmount,
          serviceCharge: _calculateServiceCharge(netAmount),
        ),
      );
    } catch (e) {
      log("Error initiating payment: $e");
      _showErrorDialog("Failed to prepare booking. Please try again.");
    }
  }

  void _openRazorpay(Map<String, dynamic> orderData, double totalAmount) {
    _orderId = orderData['order_id']?.toString();
    final leadPassenger = _getLeadPassenger();
    final name =
        "${leadPassenger['Title'] ?? 'Mr.'} ${leadPassenger['FirstName'] ?? ''} ${leadPassenger['LastName'] ?? ''}"
            .trim();
    final phone = leadPassenger['Phone'] ?? leadPassenger['Phoneno'] ?? '';
    final email = leadPassenger['Email'] ?? '';

    var options = {
      'key': razorpaykey,
      'amount': (totalAmount * 100).toInt(),
      'name': 'MT Hotels',
      'order_id': _orderId,
      'description': 'Hotel Booking - ${widget.hotel.hotelDetails.hotelName}',
      'prefill': {'contact': phone, 'email': email, 'name': name},
      'theme': {'color': '#002855'}, // Deep Ocean Blue
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      log("Razorpay Open Error: $e");
      _showErrorDialog("Could not open payment gateway.");
    }
  }

  void _showErrorDialog(String message) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => _buildErrorViewContent(
        message,
      ), // Using the full-screen view as a template or just show it via Bloc
    );
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

    return BlocConsumer<HotelBookingConfirmBloc, HotelBookingConfirmState>(
      listener: (context, state) {
        state.maybeWhen(
          orderCreated: (orderData) => _openRazorpay(orderData, totalAmount),
          orElse: () {},
        );
      },
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) async {
            if (didPop) return;

            // 1. If Booking Successful -> Go back to Home
            if (state is HotelBookingConfirmSuccess) {
              if (context.mounted) {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
              return;
            }

            // 2. If Loading -> DON'T ALLOW BACK
            if (state is HotelBookingConfirmLoading) {
              return;
            }

            // 3. Otherwise -> Normal confirm exit
            final shouldExit = await _onWillPop();
            if (shouldExit && context.mounted) {
              Navigator.of(context).pop();
            }
          },
          child: state.maybeWhen(
            success: (data) => _buildSuccessViewContent(data),
            error: (message, data) => _buildErrorViewContent(message),
            orElse: () => Scaffold(
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
                          const SizedBox(height: 120),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: _buildBottomActionBar(
                totalAmount,
                state is HotelBookingConfirmLoading,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHotelSummaryCard() {
    return Container(
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Hotel Information', Iconsax.status),
            const SizedBox(height: 20),
            Text(
              widget.hotel.hotelDetails.hotelName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: _textPrimary,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Iconsax.location, color: _secondaryColor, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.hotel.hotelDetails.address,
                    style: TextStyle(
                      color: _textSecondary,
                      fontSize: 14,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Iconsax.house, color: _secondaryColor, size: 18),
                const SizedBox(width: 10),
                Text(
                  '${widget.roomPassengers?.length ?? 1} Room${(widget.roomPassengers?.length ?? 1) > 1 ? 's' : ''}',
                  style: TextStyle(
                    color: _textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomInfoCard() {
    return Container(
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Booking Stays', Iconsax.calendar_1),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2,
              children: [
                _buildDetailItem('Check-in', '14:00', Iconsax.login_1),
                _buildDetailItem('Check-out', '12:00', Iconsax.logout_1),
                _buildDetailItem('Duration', '1 Night', Iconsax.clock),
                _buildDetailItem(
                  'Guests',
                  '${widget.passengers.length}',
                  Iconsax.user,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildDetailItem(
              'Room Type',
              widget.room.name.join(', '),
              Iconsax.house_2,
            ),
            const SizedBox(height: 12),
            _buildDetailItem(
              'Meal Plan',
              widget.room.mealType.isNotEmpty
                  ? widget.room.mealType
                  : 'Not Included',
              Iconsax.coffee,
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

  Widget _buildPassengerSummaryCard() {
    final totalGuests = widget.passengers.length;
    final totalRooms = widget.roomPassengers?.length ?? 1;

    return Container(
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Guest Summary', Iconsax.user_octagon),
            const SizedBox(height: 16),
            Text(
              '$totalGuests guest${totalGuests > 1 ? 's' : ''} across $totalRooms room${totalRooms > 1 ? 's' : ''}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: _textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            if (widget.roomPassengers != null)
              ...widget.roomPassengers!.asMap().entries.map((entry) {
                final roomIndex = entry.key;
                final room = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Icon(Iconsax.user_tag, size: 14, color: _secondaryColor),
                      const SizedBox(width: 10),
                      Text(
                        'Room ${roomIndex + 1}: ${room.length} guest${room.length > 1 ? 's' : ''}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: _textSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  // Widget _buildPriceBreakdown(PreBookRoom? preBookRoom) {
  //   final totalAmount = _getTotalAmount();
  //   final roomFare = preBookRoom?.totalFare ?? widget.room.totalFare;
  //   final roomTax = preBookRoom?.totalTax ?? widget.room.totalTax;
  //   final baseAmountForServiceCharge = roomFare + roomTax;
  //   final serviceChargeAmount = (_serviceChargePercentage > 0)
  //       ? (baseAmountForServiceCharge * _serviceChargePercentage) / 100
  //       : 0.0;

  //   return Container(
  //     decoration: BoxDecoration(
  //       color: _cardColor,
  //       borderRadius: BorderRadius.circular(16),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.08),
  //           blurRadius: 12,
  //           offset: Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: Padding(
  //       padding: EdgeInsets.all(20),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           _buildSectionHeader('Price Breakdown', Icons.receipt_long_rounded),
  //           SizedBox(height: 16),
  //           _buildPriceRow('Room Fare', roomFare),
  //           SizedBox(height: 8),
  //           _buildPriceRow('Taxes & Fees', roomTax),
  //           SizedBox(height: 8),
  //           _buildPriceRow('Service Charge', serviceChargeAmount),
  //           Divider(height: 20, color: Colors.grey.shade300),
  //           _buildPriceRow('Total Amount', totalAmount, isTotal: true),
  //           SizedBox(height: 12),
  //           if (preBookRoom?.isRefundable == true)
  //             Container(
  //               padding: EdgeInsets.all(16),
  //               decoration: BoxDecoration(
  //                 color: _successColor.withOpacity(0.1),
  //                 borderRadius: BorderRadius.circular(12),
  //                 border: Border.all(color: _successColor.withOpacity(0.3)),
  //               ),
  //               child: Row(
  //                 children: [
  //                   Icon(
  //                     Icons.check_circle_rounded,
  //                     color: _successColor,
  //                     size: 20,
  //                   ),
  //                   SizedBox(width: 12),
  //                   Expanded(
  //                     child: Text(
  //                       'Fully Refundable - Free cancellation available',
  //                       style: TextStyle(
  //                         color: _successColor,
  //                         fontSize: 14,
  //                         fontWeight: FontWeight.w500,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

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
                          final baseAmount = _getBaseAmount();
                          final calculatedServiceCharge =
                              _calculateServiceCharge(baseAmount);
                          _onProceedToPayment(
                            totalAmount: totalAmount,
                            serviceChargeAmount: calculatedServiceCharge,
                          );
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
          onPressed: () {
            log('_onWillPop-------------------');
            _onWillPop();
          },
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

  Widget _buildPriceDetailedCard(double totalAmount) {
    if (_isServiceChargeLoading) {
      return _buildPriceShimmerCard();
    }

    final netAmount = _getNetAmount();
    final taxAmount = widget.room.totalTax;
    final serviceChargeAmount = _calculateServiceCharge(netAmount);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _primaryColor,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSummaryPriceRow(
            'Room Rate',
            '₹${netAmount.toStringAsFixed(2)}',
            Colors.white.withOpacity(0.9),
          ),
          const SizedBox(height: 12),
          _buildSummaryPriceRow(
            'Service Charge',
            '₹${serviceChargeAmount.toStringAsFixed(2)}',
            Colors.white.withOpacity(0.9),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Divider(color: Colors.white24, thickness: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Payable',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                '₹${totalAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: _secondaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceShimmerCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _primaryColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.white.withOpacity(0.1),
        highlightColor: Colors.white.withOpacity(0.2),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 14,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                  height: 14,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 14,
                  width: 110,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                  height: 14,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(color: Colors.white12, thickness: 1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 18,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                  height: 28,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ],
        ),
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

  Widget _buildBottomActionBar(double totalAmount, bool isLoading) {
    final bool isActuallyLoading = isLoading || _isServiceChargeLoading;

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
                if (_isServiceChargeLoading)
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade200,
                    highlightColor: Colors.grey.shade100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 10,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          height: 18,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Text(
                    '₹${totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
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
              onPressed: isActuallyLoading
                  ? null
                  : () {
                      final netAmount = _getNetAmount();
                      _onProceedToPayment(
                        totalAmount: totalAmount,
                        serviceChargeAmount: _calculateServiceCharge(netAmount),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: _secondaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
                disabledBackgroundColor: _secondaryColor.withOpacity(0.5),
              ),
              child: isActuallyLoading
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Confirm & Pay',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Iconsax.arrow_right_3, size: 18),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessViewContent(Map<String, dynamic> response) {
    final data = response['data'] ?? {};
    final hotelName = data['hotel_name'] ?? widget.hotel.hotelDetails.hotelName;
    final confNo = data['confirmation_no'] ?? 'N/A';
    final checkIn = data['check_in'] ?? '';
    final checkOut = data['check_out'] ?? '';
    final double totalAmount =
        double.tryParse(data['total_amount']?.toString() ?? '0') ?? 0.0;
    final bookingId = data['booking_id']?.toString() ?? '';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Stack(
        children: [
          // Background Gradient decoration
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF002855).withOpacity(0.05),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  // Success Header
                  Center(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.2),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.check_circle_rounded,
                            size: 80,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Booking Confirmed!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF002855),
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Your reservation at $hotelName is all set.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blueGrey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Ticket Layout
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 24,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Top part of ticket
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'VOUCHER DETAILS',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF94A3B8),
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        0xFF002855,
                                      ).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      'PAID',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xFF002855),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              _buildTicketRow('Booking ID', '#$bookingId'),
                              const SizedBox(height: 12),
                              _buildTicketRow(
                                'Confirmation No',
                                confNo,
                                isBold: true,
                              ),
                            ],
                          ),
                        ),

                        // DASHED LINE with circular cutouts
                        Row(
                          children: [
                            SizedBox(
                              width: 12,
                              height: 24,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8FAFC),
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.05),
                                    width: 0.5,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return Flex(
                                      direction: Axis.horizontal,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: List.generate(
                                        (constraints.constrainWidth() / 10)
                                            .floor(),
                                        (index) => SizedBox(
                                          width: 5,
                                          height: 1,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                              height: 24,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8FAFC),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                  ),
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.05),
                                    width: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Bottom part of ticket
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildInfoItem(
                                      'CHECK-IN',
                                      checkIn,
                                      Icons.login_rounded,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _buildInfoItem(
                                      'CHECK-OUT',
                                      checkOut,
                                      Icons.logout_rounded,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(height: 48, thickness: 0.5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total Amount Paid',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF64748B),
                                    ),
                                  ),
                                  Text(
                                    '₹${(totalAmount.toStringAsFixed(2))}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xFF002855),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 60),
                  // Actions
                  Column(
                    children: [
                      _buildActionButton('GO TO MY BOOKINGS', () {
                        // Navigate to bookings page logic
                        Navigator.of(
                          context,
                        ).popUntil((route) => route.isFirst);
                      }, isPrimary: true),
                      const SizedBox(height: 16),
                      _buildActionButton(
                        'BACK TO HOME',
                        () => Navigator.of(
                          context,
                        ).popUntil((route) => route.isFirst),
                        isPrimary: false,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
            color: const Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: const Color(0xFF94A3B8)),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: Color(0xFF94A3B8),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorViewContent(String message) {
    // Detect refund scenario
    final isRefundScenario =
        message.toLowerCase().contains('refund') ||
        message.toLowerCase().contains('not done');
    final title = isRefundScenario
        ? 'Booking Not Completed'
        : 'Something Went Wrong';
    final icon = isRefundScenario
        ? Iconsax.info_circle
        : Icons.sentiment_dissatisfied_rounded;
    final iconColor = isRefundScenario
        ? Colors.orange.shade700
        : const Color(0xFFE11D48);
    final bgColor = isRefundScenario
        ? const Color(0xFFFFF7ED)
        : const Color(0xFFFFF1F2);
    final borderColor = isRefundScenario
        ? const Color(0xFFFFEDD5)
        : const Color(0xFFFFE4E6);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: borderColor, width: 8),
                ),
                child: Icon(icon, size: 60, color: iconColor),
              ),
              const SizedBox(height: 40),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF002855),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey[700],
                    height: 1.6,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'If your money was debited, it will be refunded automatically within 5-7 working days.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              _buildActionButton(
                isRefundScenario ? 'GO TO HOME' : 'TRY AGAIN',
                () {
                  if (isRefundScenario) {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  } else {
                    context.read<HotelBookingConfirmBloc>().add(
                      const HotelBookingConfirmEvent.reset(),
                    );
                  }
                },
              ),
              if (!isRefundScenario) ...[
                const SizedBox(height: 16),
                _buildActionButton('CONTACT SUPPORT', () {
                  final Uri whatsappUri = Uri.parse(
                    "https://wa.me/917511100557",
                  );
                  launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
                }, isPrimary: false),
              ],
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    VoidCallback onPressed, {
    bool isPrimary = true,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? const Color(0xFF002855) : Colors.white,
          foregroundColor: isPrimary ? Colors.white : const Color(0xFF002855),
          side: isPrimary
              ? null
              : const BorderSide(color: Color(0xFF002855), width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 18),
          elevation: isPrimary ? 2 : 0,
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1),
        ),
      ),
    );
  }
}
