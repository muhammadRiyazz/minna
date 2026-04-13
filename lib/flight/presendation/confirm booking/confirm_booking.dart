import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;
import 'package:minna/flight/infrastracture/booking%20confirm/booking.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:minna/comman/core/api.dart';
import 'package:minna/comman/pages/main home/home.dart';
import 'package:minna/flight/application/booking/booking_bloc.dart';
import 'package:minna/flight/domain/fare%20request%20and%20respo/fare_respo.dart';
import 'package:minna/flight/domain/reprice%20/reprice_respo.dart';
import 'package:minna/flight/presendation/booking%20page/widget.dart/booking_card.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/pages/log%20in/login_page.dart';
import 'package:minna/comman/const/const.dart';

class BookingConfirmationScreen extends StatefulWidget {
  const BookingConfirmationScreen({
    super.key,
    required this.flightinfo,
    required this.triptype,
  });

  final FFlightOption flightinfo;
  final String triptype;

  @override
  State<BookingConfirmationScreen> createState() =>
      _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {
  // Timer variables
  late Timer _timer;
  int _remainingSeconds = 8 * 60; // 8 minutes in seconds
  bool _isTimeExpired = false;
  Set<int> expandedIndexes = {};
  late Razorpay _razorpay;
  bool _isPaymentButtonLoading = false;

  // Commission service
  // final FlightCommissionService _commissionService = FlightCommissionService();
  // double _commissionAmount = 0;
  // double _totalWithCommission = 0;

  @override
  void initState() {
    super.initState();
    context.read<LoginBloc>().add(const LoginEvent.loginInfo());
    _startTimer();
    _initializeRazorpay();
  }

  // void _calculateCommission() {
  //   try {
  //     log('_calculateCommission -------------');
  //     final baseAmount = widget.flightinfo.flightFares!.first.totalAmount;

  //     final travelType = widget.triptype ;

  //     _commissionAmount = _commissionService.calculateCommission(
  //       actualAmount: baseAmount??0,
  //       travelType: travelType,
  //     );

  //     _totalWithCommission = _commissionService.getTotalAmountWithCommission(
  //       actualAmount: baseAmount??0,
  //       travelType: travelType,
  //     );
  //   } catch (e) {
  //     log('Error calculating commission: $e');
  //     // Fallback: use base amount if commission calculation fails
  //     _commissionAmount = 0;
  //   _totalWithCommission = widget.flightinfo.flightFares!.first.totalAmount??0;
  //   }
  // }

  void _initializeRazorpay() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _isTimeExpired = true;
          _timer.cancel();
        }
      });
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    log("Payment Success: ${response.paymentId}");

    setState(() {
      _isPaymentButtonLoading = false;
    });

    context.read<BookingBloc>().add(
      BookingEvent.verifyFlightPayment(
        paymentId: response.paymentId!,
        orderId: response.orderId!,
        signature: response.signature!,
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    log("Payment Error: ${response.code} - ${response.message}");

    setState(() {
      _isPaymentButtonLoading = false;
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log("External Wallet: ${response.walletName}");
  }

  Future<String?> _createFlightOrder(BookingState state) async {
    try {
      log('Creating flight order with body: ${state.bookingdata!.toJson()}');
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userId = prefs.getString('userId');

      final Map<String, String> body = {
        'userId': userId ?? '',
        'bookingPayload': jsonEncode(state.bookingdata!.toJson()),
        'commission': state.totalCommission.toString(),
        'totalFare':
            ((state.totalAmountWithCommission ?? 0) -
                    (state.totalCommission ?? 0))
                .toStringAsFixed(2),
      };

      log('Creating flight order with body: $body');

      final response = await http.post(
        Uri.parse('${baseUrl}create-razorpay-order-for-flight'),
        body: body,
      );

      log('Flight order response: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          return data['order_id'];
        } else {
          log(
            'Error from create-razorpay-order-for-flight: ${data['message']}',
          );
          return null;
        }
      } else {
        log('HTTP Error in _createFlightOrder: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Exception in _createFlightOrder: $e');
      return null;
    }
  }

  void _openRazorpayPayment(BookingState state) async {
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

    if (_isPaymentButtonLoading) {
      return; // Prevent multiple clicks
    }

    setState(() {
      _isPaymentButtonLoading = true;
    });

    try {
      // Use total amount with commission for payment
      final amount = state.totalAmountWithCommission ?? 0;
      final orderId = await _createFlightOrder(state);

      final bookingData = state.bookingdata;
      if (bookingData == null) {
        setState(() {
          _isPaymentButtonLoading = false;
        });
        return;
      }

      final passenger = bookingData.passengers.isNotEmpty
          ? bookingData.passengers.first
          : null;

      final options = {
        'key': razorpaykey,
        'amount': (amount * 100).toInt(),
        'name': 'Flight Booking',
        'order_id': orderId,
        'description': 'Flight Ticket Payment',
        'prefill': {
          'contact': passenger?.contact ?? '0000000000',
          'email': passenger?.email ?? 'user@example.com',
        },
        'theme': {'color': maincolor1.value.toRadixString(16)},
      };

      _razorpay.open(options);
    } catch (e) {
      log('Error opening Razorpay: $e');
      setState(() {
        _isPaymentButtonLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingBloc, BookingState>(
      listener: (context, state) {
        if (state.isBookingCompleted == true ||
            state.isBookingConfirmed == true) {
          // Additional success handling if needed
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          final state = context.read<BookingBloc>().state;
          if (state.isBookingCompleted == true ||
              state.isBookingConfirmed == true ||
              state.bookingFailed == true) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
              (route) => false,
            );
            return false;
          }
          await _showBottomSheetbooking(
            context: context,
            state: state,
          );
          return false;
        },
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: BlocBuilder<BookingBloc, BookingState>(
            builder: (context, state) {
              if ((state.isBookingCompleted == true ||
                      state.bookingFailed == true) &&
                  _isPaymentButtonLoading) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _isPaymentButtonLoading = false;
                  });
                });
              }

              if (state.isLoading) {
                return _buildLoadingScreen();
              }

              if (state.isBookingCompleted == true ||
                  state.isBookingConfirmed == true) {
                return _buildSuccessUI(state);
              }

              if (state.bookingError != null && state.bookingFailed == true) {
                return _buildErrorUI(state);
              }

              final bookingData = state.bookingdata;
              if (bookingData == null) {
                return _buildNoDataScreen();
              }

              return _buildBookingConfirmationUI(state);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: secondaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(secondaryColor),
                      strokeWidth: 3,
                    ),
                  ),
                  Center(
                    child: Icon(
                      Iconsax.airplane,
                      color: secondaryColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Preparing Your Booking',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: maincolor1,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Please wait while we process your flight details',
              style: TextStyle(fontSize: 14, color: textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoDataScreen() {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: maincolor1,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: secondaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Iconsax.danger, color: secondaryColor, size: 50),
            ),
            SizedBox(height: 24),
            Text(
              'No Booking Data',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: maincolor1,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Unable to load booking information.\nPlease try again.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: textSecondary),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: maincolor1,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingConfirmationUI(BookingState state) {
    final isProcessing =
        state.isCreatingOrder == true ||
        state.isPaymentProcessing == true ||
        state.isConfirmingBooking == true ||
        state.isSavingFinalBooking == true;

    return CustomScrollView(
      slivers: [
        // Enhanced SliverAppBar with Timer
        SliverAppBar(
          backgroundColor: maincolor1,
          expandedHeight: 140,
          floating: false,
          pinned: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Iconsax.arrow_left, color: Colors.white),
            onPressed: () =>
                _showBottomSheetbooking(context: context, state: state),
          ),
          actions: [
            // Timer in actions (top-right corner)
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _isTimeExpired ? Iconsax.timer_pause : Iconsax.timer_1,
                    color: _isTimeExpired ? Colors.red : secondaryColor,
                    size: 16,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    _isTimeExpired ? 'Expired' : _formatTime(_remainingSeconds),
                    style: TextStyle(
                      color: _isTimeExpired ? Colors.red : secondaryColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            title: const Text(
              'Final Confirmation',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
            centerTitle: true,
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [maincolor1, maincolor1.withOpacity(0.8)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Opacity(
                opacity: 0.1,
                child: Icon(Iconsax.airplane, size: 120, color: Colors.white),
              ),
            ),
          ),
        ),

        // Time Expired Warning
        if (_isTimeExpired)
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: secondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Iconsax.warning_2, color: errorColor),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Booking session has expired. Please start over to book your flight.',
                      style: TextStyle(
                        color: errorColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        // Processing Indicator
        if (isProcessing)
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: secondaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: secondaryColor.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(secondaryColor),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Processing...',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: maincolor1,
                          ),
                        ),
                        Text(
                          _getProcessingText(state),
                          style: TextStyle(
                            color: maincolor1.withOpacity(0.6),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

        // Flight Details
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: FlightbookingCard(flightOption: widget.flightinfo),
          ),
        ),

        // Passenger Details
        SliverToBoxAdapter(
          child: _buildPassengerExpansionSection(state.bookingdata!.passengers),
        ),

        // Fare Breakdown with Commission
        SliverToBoxAdapter(
          child: _buildEnhancedFareBreakdownWithCommission(state),
        ),

        // Payment Button Section
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_isTimeExpired) ...[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: errorColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: errorColor.withOpacity(0.2)),
                    ),
                    child: Column(
                      children: [
                        Icon(Iconsax.timer_pause, color: errorColor, size: 40),
                        SizedBox(height: 8),
                        Text(
                          'Session Expired',
                          style: TextStyle(
                            color: errorColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Your booking session has ended. Please restart the booking process.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: textSecondary, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: maincolor1,
                      foregroundColor: Colors.white,
                      minimumSize: Size.fromHeight(56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => HomePage()),
                        (route) => false,
                      );
                    },
                    child: Text('Start New Booking'),
                  ),
                ] else ...[
                  _buildPaymentButton(state, isProcessing),
                ],
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getProcessingText(BookingState state) {
    if (state.isCreatingOrder == true) return 'Creating payment order...';
    if (state.isPaymentProcessing == true) return 'Processing payment...';
    if (state.isConfirmingBooking == true) return 'Confirming your booking...';
    if (state.isSavingFinalBooking == true) return 'Saving booking details...';
    return 'Processing...';
  }

  Widget _buildPaymentButton(BookingState state, bool isProcessing) {
    final bool shouldShowLoading = _isPaymentButtonLoading || isProcessing;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: maincolor1,
        foregroundColor: Colors.white,
        minimumSize: Size.fromHeight(56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
      ),
      onPressed:
          // () {
          //   bookingConfirmApi(state.bookingdata!);
          // },
          shouldShowLoading ? null : () => _openRazorpayPayment(state),
      child: shouldShowLoading
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
                Icon(Iconsax.lock, size: 20),
                SizedBox(width: 12),
                Text(
                  'Pay ₹${state.totalAmountWithCommission!.toStringAsFixed(0)}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
    );
  }

  Widget _buildSuccessUI(BookingState state) {
    final bookingData = state.bookingdata;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: successColor,
          expandedHeight: 200,
          floating: false,
          pinned: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Iconsax.arrow_left, color: Colors.white),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
                (route) => false,
              );
            },
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: const Text(
              'Booking Confirmed',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
            centerTitle: true,
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, successColor.withOpacity(0.8)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Opacity(
                opacity: 0.1,
                child: Icon(
                  Iconsax.tick_circle,
                  size: 150,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 32),

                // Success Message Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: successColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: successColor.withOpacity(0.1)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: successColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Iconsax.tick_circle,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Congratulations!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: maincolor1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your flight has been booked successfully.\nAn e-ticket has been sent to your email.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: textSecondary,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                        ),
                      ),
                      if (state.alhindPnr != null) ...[
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: maincolor1.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'PNR: ${state.alhindPnr}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: maincolor1,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                if (bookingData != null) ...[
                  FlightbookingCard(flightOption: widget.flightinfo),
                  const SizedBox(height: 16),
                  _buildPassengerExpansionSection(bookingData.passengers),
                  const SizedBox(height: 16),
                  _buildEnhancedFareBreakdownWithCommission(state),
                ],
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),

        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: maincolor1,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    shadowColor: maincolor1.withOpacity(0.3),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomePage()),
                      (route) => false,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Iconsax.home_1, size: 20),
                      const SizedBox(width: 12),
                      const Text(
                        'Back to Home',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorUI(BookingState state) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: maincolor1,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Iconsax.arrow_left, color: Colors.white),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                  (route) => false,
                );
              },
            ),
            title: const Text(
              'Booking Failed',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            centerTitle: true,
            pinned: true,
          ),

          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  // Premium Error Icon
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: secondaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Iconsax.danger,
                        color: secondaryColor,
                        size: 50,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Booking Failed',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: maincolor1,
                      letterSpacing: -0.5,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'We encountered an issue while processing your booking. Please try again or contact support.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: textSecondary,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Security/Contact Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: secondaryColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: secondaryColor.withOpacity(0.1),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: secondaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Iconsax.shield_security,
                            color: secondaryColor,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Secure Transaction',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: secondaryColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Your payment transaction is protected. No funds will be deducted for failed bookings.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: textSecondary,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: maincolor1,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      shadowColor: maincolor1.withOpacity(0.3),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      'Return to Home',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPassengerExpansionSection(List<RePassenger> passengers) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: maincolor1.withOpacity(0.02),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: maincolor1.withOpacity(0.05),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Iconsax.user, size: 18, color: maincolor1),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Passenger Details',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: maincolor1,
                      ),
                    ),
                    Text(
                      'Information for ${passengers.length} traveller${passengers.length > 1 ? 's' : ''}',
                      style: TextStyle(
                        fontSize: 11,
                        color: textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ...passengers.asMap().entries.map(
            (entry) => _buildPassengerExpansionTile(entry.value, entry.key),
          ),
        ],
      ),
    );
  }

  Widget _buildPassengerExpansionTile(RePassenger passenger, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          backgroundColor: backgroundColor,
          collapsedBackgroundColor: Colors.transparent,
          iconColor: maincolor1,
          collapsedIconColor: maincolor1,
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: maincolor1.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(
              passenger.paxType == 'ADT'
                  ? Iconsax.user
                  : passenger.paxType == 'CHD'
                  ? Iconsax.user_tag
                  : Iconsax.user_octagon,
              color: maincolor1,
              size: 20,
            ),
          ),
          title: Text(
            '${passenger.title} ${passenger.firstName} ${passenger.lastName}',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14,
              color: maincolor1,
            ),
          ),
          subtitle: Text(
            '${passenger.paxType == 'ADT'
                ? 'Adult'
                : passenger.paxType == 'CHD'
                ? 'Child'
                : 'Infant'} • ${passenger.nationality}',
            style: TextStyle(
              fontSize: 12,
              color: textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          children: [
            Container(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPassengerDetailRow(
                      'Date of Birth:',
                      convertMsDateToFormattedDate(passenger.dob!),
                    ),
                    _buildPassengerDetailRow(
                      'Contact:',
                      passenger.contact ?? '',
                    ),
                    _buildPassengerDetailRow('Email:', passenger.email ?? ''),
                    if (passenger.passportNo != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: maincolor1.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: maincolor1.withOpacity(0.1),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: maincolor1,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Iconsax.note_21,
                                color: Colors.white,
                                size: 14,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Passport Information',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                color: maincolor1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildPassengerDetailRow(
                        'Passport No:',
                        passenger.passportNo!,
                      ),
                      _buildPassengerDetailRow(
                        'Country of Issue:',
                        passenger.countryOfIssue ?? 'N/A',
                      ),
                      _buildPassengerDetailRow(
                        'Expiry Date:',
                        passenger.dateOfExpiry ?? 'N/A',
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPassengerDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 13,
                color: textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedFareBreakdownWithCommission(BookingState bookingstate) {
    final fare =
        bookingstate.bookingdata!.journey.flightOption.flightFares.first;
    final passengers = bookingstate.bookingdata!.passengers;

    // Calculate passenger counts by type
    final adultCount = passengers.where((p) => p.paxType == 'ADT').length;
    final childCount = passengers.where((p) => p.paxType == 'CHD').length;
    final infantCount = passengers.where((p) => p.paxType == 'INF').length;

    // Calculate base fare totals by passenger type
    double adultBaseFare = 0;
    double adultTax = 0;
    double childBaseFare = 0;
    double childTax = 0;
    double infantBaseFare = 0;
    double infantTax = 0;
    double totalDiscount = 0;

    // Calculate base fares from fare types
    for (final fareType in fare.fares) {
      switch (fareType.ptc) {
        case 'ADT':
          adultBaseFare = (fareType.baseFare ?? 0) * adultCount;
          adultTax = (fareType.tax ?? 0) * adultCount;
          totalDiscount += (fareType.discount ?? 0) * adultCount;
          break;
        case 'CHD':
          childBaseFare = (fareType.baseFare ?? 0) * childCount;
          childTax = (fareType.tax ?? 0) * childCount;
          totalDiscount += (fareType.discount ?? 0) * childCount;
          break;
        case 'INF':
          infantBaseFare = (fareType.baseFare ?? 0) * infantCount;
          infantTax = (fareType.tax ?? 0) * infantCount;
          totalDiscount += (fareType.discount ?? 0) * infantCount;
          break;
      }
    }

    // Calculate totals
    double totalBaseFare = adultBaseFare + childBaseFare + infantBaseFare;
    double totalTax = adultTax + childTax + infantTax;
    double totalAdditionalCharges = 0;

    // Calculate additional charges (baggage, meals, seats)
    final additionalChargesList = _calculateAdditionalCharges(passengers);
    totalAdditionalCharges = additionalChargesList.fold(
      0,
      (sum, charge) => sum + charge.amount,
    );

    // Calculate final total
    double subtotal = totalBaseFare + totalTax + totalAdditionalCharges;
    double serviceCharge = bookingstate.totalCommission ?? 0;
    double finalTotal = subtotal + serviceCharge - totalDiscount;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: maincolor1.withOpacity(0.02),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: maincolor1.withOpacity(0.05),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Iconsax.receipt_2, size: 18, color: maincolor1),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fare Breakdown',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: maincolor1,
                      ),
                    ),
                    Text(
                      'Complete cost summary',
                      style: TextStyle(
                        fontSize: 11,
                        color: textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 1),

          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                // Adult Section
                if (adultCount > 0)
                  _buildPassengerTypeSection(
                    'Adult',
                    adultCount,
                    adultBaseFare / adultCount,
                    adultTax / adultCount,
                  ),

                // Child Section
                if (childCount > 0)
                  _buildPassengerTypeSection(
                    'Child',
                    childCount,
                    childBaseFare / childCount,
                    childTax / childCount,
                  ),

                // Infant Section
                if (infantCount > 0)
                  _buildPassengerTypeSection(
                    'Infant',
                    infantCount,
                    infantBaseFare / infantCount,
                    infantTax / infantCount,
                  ),

                // Divider
                if (adultCount > 0 || childCount > 0 || infantCount > 0)
                  Divider(height: 24, color: Colors.grey.shade300),

                // Additional Services Section
                if (additionalChargesList.isNotEmpty) ...[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(bottom: 12),
                    child: Text(
                      'Additional Services',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: maincolor1,
                      ),
                    ),
                  ),

                  Column(
                    children: additionalChargesList.asMap().entries.map((
                      entry,
                    ) {
                      final index = entry.key;
                      final charge = entry.value;
                      return _buildAdditionalChargeRow(
                        charge.label,
                        charge.amount,
                        index: index + 1,
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 16),
                ],

                // Summary Section
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _buildSummaryRow('Total Base Fare', totalBaseFare),
                      _buildSummaryRow('Total Taxes', totalTax),

                      if (totalAdditionalCharges > 0)
                        _buildSummaryRow(
                          'Additional Services',
                          totalAdditionalCharges,
                        ),

                      _buildSummaryRow(
                        'Service Charge',
                        serviceCharge,
                        isCommission: true,
                      ),

                      if (totalDiscount > 0)
                        _buildSummaryRow(
                          'Discount',
                          -totalDiscount,
                          isDiscount: true,
                        ),

                      Divider(height: 16, color: Colors.grey.shade400),

                      _buildSummaryRow(
                        'Total Payable',
                        finalTotal,
                        isTotal: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Calculate all additional charges
  List<AdditionalCharge> _calculateAdditionalCharges(
    List<RePassenger> passengers,
  ) {
    final List<AdditionalCharge> charges = [];

    for (final passenger in passengers) {
      final ssr = passenger.ssrAvailability;
      if (ssr != null) {
        final passengerName =
            '${passenger.title} ${passenger.firstName} ${passenger.lastName}';

        // Baggage charges
        if (ssr.baggageInfo != null) {
          for (final baggageInfo in ssr.baggageInfo!) {
            if (baggageInfo.baggages != null) {
              for (final baggage in baggageInfo.baggages!) {
                if (baggage.amount != null && baggage.amount! > 0) {
                  charges.add(
                    AdditionalCharge(
                      'Extra Baggage - $passengerName',
                      baggage.amount!,
                    ),
                  );
                }
              }
            }
          }
        }

        // Meal charges
        if (ssr.mealInfo != null) {
          for (final mealInfo in ssr.mealInfo!) {
            if (mealInfo.meals != null) {
              for (final meal in mealInfo.meals!) {
                if (meal.amount != null && meal.amount! > 0) {
                  charges.add(
                    AdditionalCharge(
                      'Meal - ${meal.name} - $passengerName',
                      meal.amount!,
                    ),
                  );
                }
              }
            }
          }
        }

        // Seat charges
        if (ssr.seatInfo != null) {
          for (final seatInfo in ssr.seatInfo!) {
            if (seatInfo.seats != null) {
              for (final seat in seatInfo.seats!) {
                if (seat.fare != null && seat.fare!.isNotEmpty) {
                  final seatFare = double.tryParse(seat.fare!);
                  if (seatFare != null && seatFare > 0) {
                    charges.add(
                      AdditionalCharge(
                        'Seat Selection - $passengerName',
                        seatFare,
                      ),
                    );
                  }
                }
              }
            }
          }
        }
      }
    }

    return charges;
  }

  // Build passenger type section (Adult, Child, Infant)
  Widget _buildPassengerTypeSection(
    String type,
    int count,
    double baseFare,
    double tax,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Passenger type header
        Padding(
          padding: const EdgeInsets.only(bottom: 12, top: 8),
          child: Row(
            children: [
              Container(
                width: 3,
                height: 14,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '$type${count > 1 ? ' ($count)' : ''}',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  color: maincolor1,
                ),
              ),
            ],
          ),
        ),

        // Base Fare
        _buildFareRow('Base Fare', baseFare, count),

        // Taxes
        _buildFareRow('Taxes', tax, count),

        const SizedBox(height: 8),
      ],
    );
  }

  // Build individual fare row
  Widget _buildFareRow(String label, double amount, int passengerCount) {
    final totalAmount = amount * passengerCount;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              if (passengerCount > 1) ...[
                Text(
                  '₹${amount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 12, color: textSecondary),
                ),
                Text(
                  ' × $passengerCount',
                  style: TextStyle(fontSize: 12, color: textSecondary),
                ),
                SizedBox(width: 8),
              ],
              Text(
                '₹${totalAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Build additional charge row
  Widget _buildAdditionalChargeRow(
    String label,
    double amount, {
    required int index,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: secondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              label.contains('Baggage')
                  ? Iconsax.bag_2
                  : label.contains('Meal')
                  ? Iconsax.coffee
                  : Iconsax.box,
              size: 14,
              color: secondaryColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: maincolor1.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            '₹${amount.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: maincolor1,
            ),
          ),
        ],
      ),
    );
  }

  // Build summary row
  Widget _buildSummaryRow(
    String label,
    double amount, {
    bool isDiscount = false,
    bool isCommission = false,
    bool isTotal = false,
  }) {
    final isNegative = amount < 0;
    final displayAmount = isNegative ? -amount : amount;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.w900 : FontWeight.w600,
              color: isTotal ? maincolor1 : maincolor1.withOpacity(0.7),
            ),
          ),
          Text(
            '${isNegative ? '-' : ''}₹${displayAmount.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: isTotal ? 20 : 14,
              fontWeight: isTotal ? FontWeight.w900 : FontWeight.w700,
              color: isTotal
                  ? secondaryColor
                  : (isDiscount ? Colors.green : maincolor1),
            ),
          ),
        ],
      ),
    );
  }
}

Future<dynamic> _showBottomSheetbooking({
  required BuildContext context,
  required BookingState state,
}) {
  final isSuccess = state.isBookingConfirmed ?? false;
  final isError = state.bookingError != null;

  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: maincolor1.withOpacity(0.1),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 32),

            if (isSuccess) ...[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Iconsax.tick_circle,
                  color: Colors.green,
                  size: 48,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Booking Confirmed!',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  color: maincolor1,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your flight has been booked successfully',
                style: TextStyle(
                  fontSize: 14,
                  color: maincolor1.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: maincolor1.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: maincolor1.withOpacity(0.08)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'PNR: ',
                      style: TextStyle(
                        fontSize: 14,
                        color: maincolor1.withOpacity(0.5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      state.alhindPnr ?? 'Processing...',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: maincolor1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: maincolor1,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                    (route) => false,
                  );
                },
                child: const Text(
                  'Go to Dashboard',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ),
            ] else if (isError) ...[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Iconsax.close_circle,
                  color: Colors.red,
                  size: 48,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Booking Failed',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  color: maincolor1,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  state.bookingError ??
                      'Something went wrong while processing your booking.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: maincolor1.withOpacity(0.5),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: maincolor1,
                        side: BorderSide(color: maincolor1.withOpacity(0.1)),
                        minimumSize: const Size.fromHeight(60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const HomePage()),
                          (route) => false,
                        );
                      },
                      child: const Text('Go Home'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: maincolor1,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Try Again'),
                    ),
                  ),
                ],
              ),
            ] else ...[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Iconsax.airplane, color: secondaryColor, size: 48),
              ),
              const SizedBox(height: 24),
              Text(
                'Exit Booking?',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  color: maincolor1,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Are you sure you want to go back? Your selected seats and fares might change.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: maincolor1.withOpacity(0.5),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: maincolor1,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 0,
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Continue Booking',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                    (route) => false,
                  );
                },
                child: Text(
                  'Exit Anyway',
                  style: TextStyle(
                    color: maincolor1.withOpacity(0.5),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      );
    },
  );
}

String convertMsDateToFormattedDate(String msDate) {
  final timestampString = RegExp(r'\d+').firstMatch(msDate)?.group(0);

  if (timestampString == null) return 'Invalid date';

  final timestamp = int.parse(timestampString);
  final date = DateTime.fromMillisecondsSinceEpoch(timestamp);

  final formattedDate =
      "${date.day.toString().padLeft(2, '0')}-"
      "${date.month.toString().padLeft(2, '0')}-"
      "${date.year}";

  return formattedDate;
}

class AdditionalCharge {
  final String label;
  final double amount;

  AdditionalCharge(this.label, this.amount);
}
