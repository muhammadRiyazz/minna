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
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shimmer/shimmer.dart';

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
  State<BookingConfirmationPage> createState() => _BookingConfirmationPageState();
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

  // New Color Theme
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37); // Gold
  final Color _accentColor = Color(0xFFC19B3C); // Darker Gold
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);
  final Color _errorColor = Color(0xFFE53935);
  final Color _successColor = Color(0xFF00C853);
  final Color _warningColor = Color(0xFFFF9800);

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

  Future<void> _preCalculateCommissions() async {
    commissionProvider = context.read<CommissionProvider>();
    try {
      await commissionProvider.getCommission();

      final state = context.read<HoldCabBloc>().state;
      if (state is HoldCabSuccess) {
        final fare = state.data.cabRate?.fare;
        if (fare != null) {
          final amount = double.parse(fare.totalAmount.toString());
          final calculated = await commissionProvider.calculateAmountWithCommission(amount);
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

    double? amount;
    final state = context.read<HoldCabBloc>().state;

    if (state is HoldCabSuccess) {
      final BookingData cabData = state.data;
      amount = double.parse(cabData.cabRate!.fare.totalAmount.toString());
    }

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
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _cardColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
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
                const SizedBox(height: 20),
                Text(
                  "Time Expired",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Your booking time has expired. Please try again.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: _textSecondary,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
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
      },
    );
  }

  void _onWillPop() async {
   showBottomSheetbooking(
      context: context,
      timer: _timer,
      busORFlight: 
       'This cabs seems popular! Hurry, book before it’s gone.',
      primaryColor: _primaryColor,
      secondaryColor: _secondaryColor,
    );

  }
void _onBookNow(String amount) async {
  log("_onBookNow -----");
  context.read<ConfirmBookingBloc>().add(
    ConfirmBookingEvent.startLoading(),
  );

  try {
    final orderId = await createOrder(double.parse(amount));
    if (orderId == null) {
      log("orderId creating error");
      context.read<ConfirmBookingBloc>().add(
        ConfirmBookingEvent.stopLoading(),
      );

      _showCustomSnackbar("Failed to create order. Please try again.", isError: true);
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
    final name = ('$firstName $lastName').trim().isNotEmpty ? '$firstName $lastName' : 'Passenger';

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
      'prefill': {
        'contact': phone, 
        'email': email,
        'name': name,
      },
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
      options['ios'] = {
        'hide_top_bar': false,
      };
    }

    if (Theme.of(context).platform == TargetPlatform.android) {
      options['android'] = {
        'hide_logo': false,
        'send_sms_hash': true,
      };
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
    context.read<ConfirmBookingBloc>().add(
      ConfirmBookingEvent.stopLoading(),
    );
    // _showCustomSnackbar("An error occurred: $e", isError: true);
  }
}

  void _showCustomSnackbar(String message, {bool isError = false}) {
    final color = isError ? _errorColor : _successColor;
    final icon = isError ? Icons.error_outline_rounded : Icons.check_circle_rounded;

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
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
              paymentSavedFailed: (message, orderId, transactionId, amount, tableid, shouldRefund, bookingid) {
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
              refundInitiated: (message, orderId, transactionId, amount, tableid, bookingid) {
                log('Navigate to refund initiated page');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  ScreenRefundInitiated(),
                  ),
                );
              },
              refundFailed: (message, orderId, transactionId, amount, tableid, bookingid) {
                log('Navigate to failed page with refund failure');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  ScreenFailTicket(),
                  ),
                );
              },
              error: (message, shouldRefund, orderId, transactionId, amount, tableid, bookingid) {
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
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Error"),
                      content: Text(message),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
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
        onWillPop:()async{
           _onWillPop();

           return false;
        },
        child: Scaffold(
          backgroundColor: _backgroundColor,
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Confirm Booking",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: _remainingSeconds <= 60 ? _errorColor.withOpacity(0.9) : _secondaryColor.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.timer_rounded, color: Colors.white, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        _displayTime,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            centerTitle: true,
            backgroundColor: _primaryColor,
            foregroundColor: Colors.white,
            elevation: 0,
           
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
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.route_rounded, color: _secondaryColor, size: 22),
                ),
                const SizedBox(width: 12),
                Text(
                  "Trip Information",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            if (bookingData.tripType == 1)
              _buildOneWayTrip(bookingData),

            if (bookingData.tripType == 2)
              _buildRoundTrip(bookingData),

            if (bookingData.tripType == 3)
              _buildMultiCityTrip(bookingData),

            if (bookingData.tripType == 4)
              _buildAirportTransfer(bookingData),

            if (bookingData.tripType == 10)
              _buildDayRental(bookingData),

            const SizedBox(height: 20),
            Divider(height: 1, color: Colors.grey.shade200),
            const SizedBox(height: 20),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildInfoChip(
                  Icons.calendar_today_rounded,
                  "Date",
                  bookingData.startDate,
                ),
                _buildInfoChip(
                  Icons.access_time_rounded,
                  "Time",
                  bookingData.startTime,
                ),
                _buildInfoChip(
                  Icons.alt_route_rounded,
                  "Distance",
                  "${bookingData.totalDistance} km",
                ),
                _buildInfoChip(
                  Icons.timer_rounded,
                  "Duration",
                  _formatDuration(bookingData.estimatedDuration.toInt()),
                ),
                _buildInfoChip(
                  Icons.directions_car_rounded,
                  "Trip Type",
                  bookingData.tripDesc,
                ),
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
    return _buildRouteCard(
      route.source.address,
      route.destination.address,
    );
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
          padding: EdgeInsets.only(bottom: index < bookingData.routes.length - 1 ? 12 : 0),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _secondaryColor,
                ),
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Icon(Icons.circle, size: 12, color: _successColor),
                  Container(width: 2, height: 20, color: _textLight),
                  Icon(Icons.location_on_rounded, size: 16, color: _errorColor),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      source,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 1,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      destination,
                      style: TextStyle(
                        fontSize: 14,
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
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: _secondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: _secondaryColor),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: _textLight,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _textPrimary,
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
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.directions_car_rounded, color: _secondaryColor, size: 22),
                ),
                const SizedBox(width: 12),
                Text(
                  "Cab Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (cab != null) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: _backgroundColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: cab.image.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              cab.image,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Icon(
                                    Icons.directions_car_rounded,
                                    size: 32,
                                    color: _secondaryColor,
                                  ),
                                );
                              },
                            ),
                          )
                        : Center(
                            child: Icon(
                              Icons.directions_car_rounded,
                              size: 32,
                              color: _secondaryColor,
                            ),
                          ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cab.type,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          cab.category,
                          style: TextStyle(
                            fontSize: 14,
                            color: _textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 6,
                          children: [
                            _buildFeatureChip(
                              "${cab.seatingCapacity} Seats",
                              Icons.people_alt_rounded,
                            ),
                            _buildFeatureChip("${cab.bagCapacity} Bags", Icons.luggage_rounded),
                            if (cab.isAssured == "1")
                              _buildFeatureChip("Assured", Icons.verified_rounded),
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
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),

          
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.receipt_long_rounded, color: _secondaryColor, size: 22),
                ),
                const SizedBox(width: 12),
                Text(
                  "Fare Breakdown",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
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
                _buildFareRow("Additional Charges", "₹${fare.additionalCharge}"),
              const SizedBox(height: 12),
              Divider(height: 1, color: Colors.grey.shade300),
              const SizedBox(height: 16),
              if (_commissionLoading)
                _buildLoadingRow()
              else if (_amountWithCommission != null)
                Column(
                  children: [
                    _buildFareRow(
                      "Service Charges & Other",
                      "₹${(_amountWithCommission! - double.parse(fare.totalAmount.toString())).toStringAsFixed(0)}",
                    ),
                    const SizedBox(height: 12),
                    _buildTotalRow("Total Amount", "₹${_amountWithCommission!.toStringAsFixed(0)}"),
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardColor,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Amount to Pay:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _textPrimary,
                ),
              ),
              Text(
                "₹${_amountWithCommission?.toStringAsFixed(0) ?? '0'}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _secondaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          BlocBuilder<ConfirmBookingBloc, ConfirmBookingState>(
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: (_isTimerExpired || state is ConfirmBookingLoading)
                      ? null
                      : () {
                          _onBookNow(
                            _amountWithCommission!.toStringAsFixed(0).toString(),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isTimerExpired ? Colors.grey : _primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                    shadowColor: _secondaryColor.withOpacity(0.3),
                  ),
                  child: state is ConfirmBookingLoading
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
                            Icon(Icons.lock_rounded, size: 20),
                            const SizedBox(width: 12),
                            Text(
                              _isTimerExpired ? "TIME EXPIRED" : "PROCEED TO PAYMENT",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
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

  Widget _buildFareRow(String label, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: _textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 14,
              color: _textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: _textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 18,
              color: _secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
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
            style: TextStyle(
              fontSize: 14,
              color: _textSecondary,
            ),
          ),
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: _secondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _secondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _secondaryColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: _secondaryColor),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: _textPrimary,
              fontWeight: FontWeight.w500,
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
                color: _errorColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.error_outline_rounded, size: 48, color: _errorColor),
            ),
            const SizedBox(height: 24),
            Text(
              "Error Occurred",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: _textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: _textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
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
                color: _cardColor,
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
                color: _cardColor,
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
                color: _cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}