import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/bus/pages/screen%20conform%20ticket/widget/bottom_sheet.dart';
import 'package:minna/bus/pages/screen%20conform%20ticket/widget/refundinitiated.dart';
import 'package:minna/bus/pages/screen%20fail%20ticket/screen_fail_ticket.dart';
import 'package:minna/cab/application/confirm%20booking/confirm_booking_bloc.dart';
import 'package:minna/cab/application/hold%20cab/hold_cab_bloc.dart';
import 'package:minna/cab/domain/hold%20data/hold_data.dart';
import 'package:minna/cab/function/commission_data.dart';
import 'package:minna/cab/pages/payment%20page/confirmed_page.dart';
import 'package:minna/comman/core/api.dart';
import 'package:minna/comman/functions/create_order_id.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/widgets/status_bottom_sheet.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:iconsax/iconsax.dart';

class BookingConfirmationPage extends StatefulWidget {
  const BookingConfirmationPage({
    super.key,
    required this.requestData,
    required this.tableID,
    required this.bookingId,
  });

  final Map<String, dynamic> requestData;
  final String tableID;
  final String bookingId;

  @override
  State<BookingConfirmationPage> createState() =>
      _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingConfirmationPage> {
  late Timer _timer;
  int _remainingSeconds = 6 * 60;
  bool _isTimerExpired = false;
  late Razorpay _razorpay;
  String? _orderId;
  late CommissionProvider commissionProvider;
  double? _amountWithCommission;
  bool _commissionLoading = true;
  String _displayTime = '06:00';

  // Theme standardizing: Use global constants directly from const.dart

  @override
  void initState() {
    super.initState();
    _startOptimizedTimer();
    _initRazorpay();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preCalculateCommissions();
    });
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

  Future<void> _preCalculateCommissions() async {
    commissionProvider = context.read<CommissionProvider>();
    try {
      await commissionProvider.getCommission();

      final state = context.read<HoldCabBloc>().state;
      if (state is HoldCabSuccess) {
        final fare = state.data.cabRate?.fare;
        if (fare != null) {
          final amount = double.parse(fare.totalAmount.toString());
          final calculated = await commissionProvider
              .calculateAmountWithCommission(amount);
          setState(() {
            _amountWithCommission = calculated;
            _commissionLoading = false;
          });
        }
      }
    } catch (e) {
      log('Commission pre-calculation error: $e');
      setState(() {
        _commissionLoading = false;
      });
    }
  }

  void _initRazorpay() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    log("Payment paymentId: ${response.paymentId}");
    log("Payment orderId: ${response.orderId}");
    log("Payment signature: ${response.signature}");

    // Round to nearest integer to match Razorpay's charge (which uses toStringAsFixed(0))
    double? amount = _amountWithCommission?.roundToDouble();
    final state = context.read<HoldCabBloc>().state;

    if (amount == null && state is HoldCabSuccess) {
      final BookingData cabData = state.data;
      amount = double.parse(cabData.cabRate!.fare.totalAmount.toString());
    }
    log('paymentDone call');
    context.read<ConfirmBookingBloc>().add(
      ConfirmBookingEvent.paymentDone(
        orderId: response.orderId ?? _orderId ?? '',
        transactionId: response.paymentId ?? '',
        status: 1,
        tableid: widget.tableID,
        table: "cab_data",
        bookingid: widget.bookingId,
        amount: amount ?? 0,
      ),
    );
    log(amount.toString());
    _timer.cancel();
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    log("Payment Failed: ${response.message}");

    context.read<ConfirmBookingBloc>().add(
      ConfirmBookingEvent.paymentFail(
        orderId: _orderId ?? '',
        tableid: widget.tableID,
        bookingid: widget.bookingId,
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
    StatusBottomSheet.show(
      context: context,
      type: StatusType.error,
      title: 'Time Expired',
      message:
          'Your booking time has expired. Please try again from the beginning.',
      primaryButtonText: 'Go to Home',
      onPrimaryPressed: () {
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
    );
  }

  void _onWillPop() async {
    showBottomSheetbooking(
      context: context,
      timer: _timer,
      busORFlight: 'This cabs seems popular! Hurry, book before it’s gone.',
      primaryColor: maincolor1,
      secondaryColor: secondaryColor,
    );
  }

  void _onBookNow(String amount) async {
    log("_onBookNow -----");
    context.read<ConfirmBookingBloc>().add(ConfirmBookingEvent.startLoading());

    try {
      final orderId = await createOrder(double.parse(amount));
      if (orderId == null) {
        log("orderId creating error");
        context.read<ConfirmBookingBloc>().add(
          ConfirmBookingEvent.stopLoading(),
        );

        _showCustomSnackbar(
          "Failed to create order. Please try again.",
          isError: true,
        );
        return;
      }

      setState(() {
        _orderId = orderId;
      });

      final passenger = widget.requestData;
      log(passenger.toString());

      // ✅ Extract traveller details safely
      final traveller = passenger['traveller'] ?? {};
      final primaryContact = traveller['primaryContact'] ?? {};

      final firstName = traveller['firstName'] ?? '';
      final lastName = traveller['lastName'] ?? '';
      final name = ('$firstName $lastName').trim().isNotEmpty
          ? '$firstName $lastName'
          : 'Passenger';

      final phone = primaryContact['number']?.toString() ?? '0000000000';
      final email = traveller['email'] ?? 'email@example.com';

      // ✅ Razorpay payment options with updated theme
      var options = {
        'key': razorpaykey,
        'amount': (double.parse(amount) * 100).toString(),
        'name': 'MT Trip', // Your brand name
        'description': 'Cab Booking Payment',
        'order_id': orderId,
        // 'image': 'https://i.ibb.co/your-image-id/mtlogo.jpg', // Your logo
        'prefill': {'contact': phone, 'email': email, 'name': name},
        'theme': {
          'color': '#D4AF37', // Gold for buttons and text
          'backdrop_color': '#000000', // Black background
        },
        'notes': {
          'contact': phone,
          'email': email,
          'name': name,
          'booking_type': 'Cab Booking',
          'service': 'MT Trip Cab Service',
        },
      };

      // Platform-specific configurations
      if (Theme.of(context).platform == TargetPlatform.iOS) {
        options['ios'] = {'hide_top_bar': false};
      }

      if (Theme.of(context).platform == TargetPlatform.android) {
        options['android'] = {'hide_logo': false, 'send_sms_hash': true};
      }

      try {
        _razorpay.open(options);
      } catch (e) {
        log("Razorpay Error: $e");
        context.read<ConfirmBookingBloc>().add(
          ConfirmBookingEvent.stopLoading(),
        );
        // _showCustomSnackbar("Payment error: $e", isError: true);
      }
    } catch (e) {
      log("Error in _onBookNow: $e");
      context.read<ConfirmBookingBloc>().add(ConfirmBookingEvent.stopLoading());
      // _showCustomSnackbar("An error occurred: $e", isError: true);
    }
  }

  void _showCustomSnackbar(String message, {bool isError = false}) {
    final color = isError ? errorColor : successColor;
    final icon = isError
        ? Icons.error_outline_rounded
        : Icons.check_circle_rounded;

    final snackBar = SnackBar(
      margin: const EdgeInsets.fromLTRB(16, 20, 16, 10),
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      duration: const Duration(seconds: 3),
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showServerErrorBottomSheet(BuildContext context) {
    StatusBottomSheet.show(
      context: context,
      type: StatusType.error,
      title: 'Connection Issue',
      message:
          'Server issue detected. Connection failed. Please try again later or contact support.',
      showContactSupport: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ConfirmBookingBloc, ConfirmBookingState>(
          listener: (context, state) {
            state.whenOrNull(
              refundProcessing:
                  (orderId, transactionId, amount, tableid, bookingid) {
                    // Show processing dialog
                  },
              paymentSavedFailed:
                  (
                    message,
                    orderId,
                    transactionId,
                    amount,
                    tableid,
                    shouldRefund,
                    bookingid,
                  ) {
                    if (shouldRefund) {
                      context.read<ConfirmBookingBloc>().add(
                        ConfirmBookingEvent.initiateRefund(
                          orderId: orderId,
                          transactionId: transactionId,
                          amount: amount,
                          tableid: tableid,
                          bookingid: bookingid,
                        ),
                      );
                    }
                  },
              refundInitiated:
                  (
                    message,
                    orderId,
                    transactionId,
                    amount,
                    tableid,
                    bookingid,
                  ) {
                    log('Navigate to refund initiated page');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScreenRefundInitiated(),
                      ),
                    );
                  },
              refundFailed:
                  (
                    message,
                    orderId,
                    transactionId,
                    amount,
                    tableid,
                    bookingid,
                  ) {
                    log('Navigate to failed page with refund failure');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScreenFailTicket(),
                      ),
                    );
                  },
              error:
                  (
                    message,
                    shouldRefund,
                    orderId,
                    transactionId,
                    amount,
                    tableid,
                    bookingid,
                  ) {
                    if (shouldRefund) {
                      context.read<ConfirmBookingBloc>().add(
                        ConfirmBookingEvent.initiateRefund(
                          orderId: orderId,
                          transactionId: transactionId,
                          amount: amount,
                          tableid: tableid,
                          bookingid: bookingid,
                        ),
                      );
                    } else {
                      log(message);

                      log('--------------');
                      // showDialog(
                      //   context: context,
                      //   builder: (context) => AlertDialog(
                      //     title: const Text("Error"),
                      //     content: Text(message),
                      //     actions: [
                      //       TextButton(
                      //         onPressed: () => Navigator.pop(context),
                      //         child: const Text("OK"),
                      //       ),
                      //     ],
                      //   ),
                      // );
                    }
                  },
              success: (data) {
                log('Navigate to success page');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CabSuccessPage(bookingResponse: data),
                  ),
                );
              },
              paymentFailed: (message, orderId, tableid, bookingid) {
                log("Navigate to failed page");
              },
            );
          },
        ),
      ],
      child: WillPopScope(
        onWillPop: () async {
          _onWillPop();

          return false;
        },
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () => _onWillPop(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    "Confirm Booking",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _remainingSeconds <= 60
                        ? errorColor.withOpacity(0.9)
                        : secondaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(14),
                    // border: Border.all(
                    //   color: _remainingSeconds <= 60
                    //       ? Colors.white
                    //       : secondaryColor.withOpacity(0.5),
                    //   width: 1,
                    // ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Iconsax.timer_1,
                        color: _remainingSeconds <= 60
                            ? Colors.white
                            : secondaryColor,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _displayTime,
                        style: TextStyle(
                          color: _remainingSeconds <= 60
                              ? Colors.white
                              : secondaryColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            backgroundColor: maincolor1,
            foregroundColor: Colors.white,
            elevation: 0,
            toolbarHeight: 70,
          ),
          body: BlocBuilder<HoldCabBloc, HoldCabState>(
            builder: (context, state) {
              if (state is HoldCabLoading) {
                return _buildShimmerLoading();
              } else if (state is HoldCabSuccess) {
                final bookingData = state.data;
                return _buildContent(bookingData, context);
              } else if (state is HoldCabError) {
                return _buildErrorState(state.message);
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BookingData bookingData, BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTripInformation(bookingData),
                const SizedBox(height: 16),
                _buildCabDetails(bookingData),
                const SizedBox(height: 16),
                _buildFareBreakdown(bookingData),
              ],
            ),
          ),
        ),
        _buildPaymentButton(bookingData, context),
      ],
    );
  }

  Widget _buildTripInformation(BookingData bookingData) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: maincolor1.withOpacity(0.05)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: secondaryColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Iconsax.routing,
                    color: secondaryColor,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 14),
                const Text(
                  "Trip Information",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),

            // const SizedBox(height: 14),

            // if (bookingData.tripType == 1) _buildOneWayTrip(bookingData),
            // if (bookingData.tripType == 2) _buildRoundTrip(bookingData),
            // if (bookingData.tripType == 3) _buildMultiCityTrip(bookingData),
            // if (bookingData.tripType == 4) _buildAirportTransfer(bookingData),
            // if (bookingData.tripType == 10) _buildDayRental(bookingData),
            // const SizedBox(height: 24),
            // Divider(height: 1, color: borderSoft.withOpacity(0.5)),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildInfoChip(
                  Iconsax.calendar_1,
                  "Date",
                  bookingData.startDate,
                ),
                _buildInfoChip(Iconsax.clock, "Time", bookingData.startTime),
                _buildInfoChip(
                  Iconsax.more,
                  "Distance",
                  "${bookingData.totalDistance} km",
                ),
                _buildInfoChip(
                  Iconsax.timer_1,
                  "Duration",
                  _formatDuration(bookingData.estimatedDuration.toInt()),
                ),
                _buildInfoChip(Iconsax.car, "Trip Type", bookingData.tripDesc),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (hours > 0 && mins > 0) {
      return "$hours hr $mins min";
    } else if (hours > 0) {
      return "$hours hr";
    } else {
      return "$mins min";
    }
  }

  Widget _buildOneWayTrip(BookingData bookingData) {
    final route = bookingData.routes.first;
    return _buildRouteCard(route.source.address, route.destination.address);
  }

  Widget _buildRoundTrip(BookingData bookingData) {
    final route = bookingData.routes.first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRouteCard(
          route.source.address,
          route.destination.address,
          label: "Onward",
        ),
        const SizedBox(height: 12),
        _buildRouteCard(
          route.destination.address,
          route.source.address,
          label: "Return",
        ),
      ],
    );
  }

  Widget _buildMultiCityTrip(BookingData bookingData) {
    return Column(
      children: bookingData.routes.asMap().entries.map((entry) {
        final index = entry.key;
        final route = entry.value;
        return Padding(
          padding: EdgeInsets.only(
            bottom: index < bookingData.routes.length - 1 ? 12 : 0,
          ),
          child: _buildRouteCard(
            route.source.address,
            route.destination.address,
            label: "Leg ${index + 1}",
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAirportTransfer(BookingData bookingData) {
    final route = bookingData.routes.first;
    return _buildRouteCard(
      route.source.address,
      route.destination.address,
      label: "Airport Transfer",
    );
  }

  Widget _buildDayRental(BookingData bookingData) {
    final route = bookingData.routes.first;
    return _buildRouteCard(
      route.source.address,
      route.destination.address,
      label: "Day Rental",
    );
  }

  Widget _buildRouteCard(String source, String destination, {String? label}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: secondaryColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  label.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: secondaryColor,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const Icon(Iconsax.record, size: 14, color: successColor),
                  Container(
                    width: 1.5,
                    height: 35,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [successColor, errorColor.withOpacity(0.5)],
                      ),
                    ),
                  ),
                  const Icon(Iconsax.location, size: 14, color: errorColor),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      source,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: textPrimary,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      destination,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: textPrimary,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderSoft),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: secondaryColor),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontSize: 9,
                  color: textLight,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: maincolor1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCabDetails(BookingData bookingData) {
    final cab = bookingData.cabRate?.cab;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: maincolor1.withOpacity(0.05)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: secondaryColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Iconsax.car,
                    color: secondaryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 14),
                const Text(
                  "Cab Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (cab != null) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: borderSoft),
                    ),
                    child: cab.image.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              cab.image,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(
                                    Iconsax.car,
                                    size: 32,
                                    color: secondaryColor,
                                  ),
                                );
                              },
                            ),
                          )
                        : const Center(
                            child: Icon(
                              Iconsax.car,
                              size: 32,
                              color: secondaryColor,
                            ),
                          ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cab.type,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: maincolor1,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: maincolor1.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            cab.category.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 10,
                              color: maincolor1,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildFeatureChip(
                              "${cab.seatingCapacity} Seats",
                              Iconsax.user_tick,
                            ),
                            _buildFeatureChip(
                              "${cab.bagCapacity} Bags",
                              Iconsax.bag_2,
                            ),
                            if (cab.isAssured == "1")
                              _buildFeatureChip("Assured", Iconsax.verify),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFareBreakdown(BookingData bookingData) {
    final fare = bookingData.cabRate?.fare;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: maincolor1.withOpacity(0.05)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: secondaryColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Iconsax.receipt_2,
                    color: secondaryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 14),
                const Text(
                  "Fare Breakdown",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (fare != null) ...[
              _buildFareRow("Base Fare", "₹${fare.baseFare}"),
              if (fare.driverAllowance > 0)
                _buildFareRow("Driver Allowance", "₹${fare.driverAllowance}"),
              if (fare.gst > 0) _buildFareRow("GST", "₹${fare.gst}"),
              if (fare.stateTax > 0)
                _buildFareRow("State Tax", "₹${fare.stateTax}"),
              if (fare.tollTax > 0)
                _buildFareRow("Toll Tax", "₹${fare.tollTax}"),
              if (fare.airportFee > 0)
                _buildFareRow("Airport Fee", "₹${fare.airportFee}"),
              if (fare.additionalCharge > 0)
                _buildFareRow(
                  "Additional Charges",
                  "₹${fare.additionalCharge}",
                ),
              const SizedBox(height: 16),
              Divider(height: 1, color: borderSoft.withOpacity(0.5)),
              const SizedBox(height: 16),
              if (_commissionLoading)
                _buildLoadingRow()
              else if (_amountWithCommission != null)
                Column(
                  children: [
                    _buildFareRow(
                      "Service Charges & Fees",
                      "₹${(_amountWithCommission! - double.parse(fare.totalAmount.toString())).toStringAsFixed(0)}",
                      isHighlighted: true,
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: maincolor1.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: maincolor1.withOpacity(0.1)),
                      ),
                      child: _buildTotalRow(
                        "Total Amount",
                        "₹${_amountWithCommission!.toStringAsFixed(0)}",
                      ),
                    ),
                  ],
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentButton(BookingData bookingData, BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 30,
            offset: const Offset(0, -10),
          ),
        ],
        border: Border.all(color: maincolor1.withOpacity(0.05)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TOTAL AMOUNT",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: textLight,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "₹${_amountWithCommission?.toStringAsFixed(0) ?? '0'}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: maincolor1,
                      letterSpacing: -1,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: successColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: const [
                    Icon(Iconsax.shield_tick, size: 14, color: successColor),
                    SizedBox(width: 6),
                    Text(
                      "Secure Payment",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          BlocBuilder<ConfirmBookingBloc, ConfirmBookingState>(
            builder: (context, state) {
              final isLoading = state is ConfirmBookingLoading;
              final isExpired = _isTimerExpired;

              return SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: (isExpired || isLoading)
                      ? null
                      : () {
                          _onBookNow(
                            _amountWithCommission!
                                .toStringAsFixed(0)
                                .toString(),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isExpired ? textLight : maincolor1,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: 0,
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isExpired ? "TIMER EXPIRED" : "CONFIRM & PAY NOW",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Icon(Iconsax.arrow_right_3, size: 20),
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

  Widget _buildFareRow(
    String label,
    String amount, {
    bool isHighlighted = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isHighlighted ? secondaryColor : textSecondary,
              fontWeight: isHighlighted ? FontWeight.w800 : FontWeight.w600,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 14,
              color: isHighlighted ? secondaryColor : textPrimary,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 16,
            color: maincolor1,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 22,
            color: maincolor1,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Calculating...",
            style: TextStyle(fontSize: 14, color: textSecondary),
          ),
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: secondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: maincolor1.withOpacity(0.04),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: maincolor1.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: maincolor1),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              color: textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: errorColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 48,
                color: errorColor,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Error Occurred",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: textSecondary),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: maincolor1,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Go to Home"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 240,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
