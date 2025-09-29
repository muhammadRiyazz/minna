import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/bus/pages/screen%20conform%20ticket/widget/refundinitiated.dart';
import 'package:minna/bus/pages/screen%20fail%20ticket/screen_fail_ticket.dart';
import 'package:minna/cab/application/confirm%20booking/confirm_booking_bloc.dart';
import 'package:minna/cab/application/hold%20cab/hold_cab_bloc.dart';
import 'package:minna/cab/domain/hold%20data/hold_data.dart';
import 'package:minna/cab/function/commission_data.dart';
import 'package:minna/cab/pages/payment%20page/confirmed_page.dart';
import 'package:minna/comman/const/const.dart';
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
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.timer_off, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text(
                "Time Expired",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Your booking time has expired. Please try again.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: const Text("Go to Home"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<bool> _onWillPop() async {
    final shouldExit = await showModalBottomSheet<bool>(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Exit Booking?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                "Are you sure you want to exit the booking process?",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text("Continue Booking"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: maincolor1,
                      ),
                      child: const Text(
                        "Exit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

    return shouldExit ?? false;
  }

  void _onBookNow(String amount) async {
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
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to create order. Please try again."))
        );
        return;
      }

      setState(() {
        _orderId = orderId;
      });

      final passenger = widget.requestData;
      final name = passenger['name'] ?? "Passenger";
      final phone = passenger['mobile'] ?? "0000000000";
      final email = passenger['email'] ?? "email@example.com";

      var options = {
        'key': razorpaykey,
        'amount': (double.parse(amount) * 100).toString(),
        'name': name,
        'order_id': orderId,
        'description': 'Cab Booking Payment',
        'prefill': {'contact': phone, 'email': email},
        'theme': {'color': maincolor1!.value.toRadixString(16)},
      };

      try {
        _razorpay.open(options);
      } catch (e) {
        log("Razorpay Error: $e");
        context.read<ConfirmBookingBloc>().add(
          ConfirmBookingEvent.stopLoading(),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Payment error: $e"))
        );
      }
    } catch (e) {
      log("Error in _onBookNow: $e");
      context.read<ConfirmBookingBloc>().add(
        ConfirmBookingEvent.stopLoading(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e"))
      );
    }
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
                    builder: (context) => const ScreenRefundInitiated(),
                  ),
                );
              },
              refundFailed: (message, orderId, transactionId, amount, tableid, bookingid) {
                log('Navigate to failed page with refund failure');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScreenFailTicket(),
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
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Booking Confirmation",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.timer, color: Colors.white),
                      const SizedBox(width: 5),
                      Text(
                        _displayTime,
                        style: const TextStyle(
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
            centerTitle: true,
            backgroundColor: maincolor1,
            iconTheme: const IconThemeData(color: Colors.white),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
          ),
          body: BlocBuilder<HoldCabBloc, HoldCabState>(
            builder: (context, state) {
              if (state is HoldCabLoading) {
                return buildShimmerLoading();
              } else if (state is HoldCabSuccess) {
                final bookingData = state.data;
                return _buildContent(bookingData, context);
              } else if (state is HoldCabError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 64, color: Colors.red),
                        const SizedBox(height: 16),
                        const Text(
                          "Error Occurred",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).popUntil((route) => route.isFirst);
                          },
                          child: const Text("Go to Home"),
                        ),
                      ],
                    ),
                  ),
                );
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
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTripInformation(bookingData),
                const SizedBox(height: 10),
                _buildCabDetails(bookingData),
                const SizedBox(height: 10),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.route, color: maincolor1, size: 22),
                const SizedBox(width: 10),
                Text(
                  "Trip Information",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: maincolor1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

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

            const Divider(height: 30, thickness: 1, color: Colors.grey),
            const SizedBox(height: 16),

            Wrap(
              spacing: 20,
              runSpacing: 15,
              children: [
                _buildInfoChip(
                  Icons.calendar_today,
                  "Date",
                  bookingData.startDate,
                ),
                _buildInfoChip(
                  Icons.access_time,
                  "Time",
                  bookingData.startTime,
                ),
                _buildInfoChip(
                  Icons.alt_route,
                  "Distance",
                  "${bookingData.totalDistance} km",
                ),
                _buildInfoChip(
                  Icons.timer,
                  "Duration",
                  formatDuration(bookingData.estimatedDuration.toInt()),
                ),
                _buildInfoChip(
                  Icons.directions_car,
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

  String formatDuration(int minutes) {
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
    return _buildHorizontalRouteCard(
      route.source.address,
      route.destination.address,
    );
  }

  Widget _buildRoundTrip(BookingData bookingData) {
    final route = bookingData.routes.first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHorizontalRouteCard(
          route.source.address,
          route.destination.address,
          label: "Onward",
        ),
        const SizedBox(height: 10),
        _buildHorizontalRouteCard(
          route.destination.address,
          route.source.address,
          label: "Return",
        ),
      ],
    );
  }

  Widget _buildMultiCityTrip(BookingData bookingData) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: bookingData.routes.length,
        itemBuilder: (context, index) {
          final route = bookingData.routes[index];
          return Padding(
            padding: const EdgeInsets.only(right: 7),
            child: SizedBox(
              width: 200,
              child: _buildHorizontalRouteCard(
                route.source.address,
                route.destination.address,
                label: "Leg ${index + 1}",
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAirportTransfer(BookingData bookingData) {
    final route = bookingData.routes.first;
    return _buildHorizontalRouteCard(
      route.source.address,
      route.destination.address,
      label: "Airport Transfer",
    );
  }

  Widget _buildDayRental(BookingData bookingData) {
    final route = bookingData.routes.first;
    return _buildHorizontalRouteCard(
      route.source.address,
      route.destination.address,
      label: "Day Rental",
    );
  }

  Widget _buildHorizontalRouteCard(
    String source,
    String destination, {
    String? label,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Icon(Icons.circle, size: 10, color: Colors.green),
              Container(width: 2, height: 30, color: Colors.grey),
              Icon(Icons.location_on, size: 18, color: Colors.red),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (label != null)
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey,
                    ),
                  ),
                Text(
                  source,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey)),
                    Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),
                Text(
                  destination,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: maincolor1),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
              Text(
                value,
                style:  TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
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

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Cab Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: maincolor1,
              ),
            ),
            const SizedBox(height: 16),
            if (cab != null) ...[
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: cab.image.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              cab.image,
                              fit: BoxFit.contain,
                            ),
                          )
                        : Icon(
                            Icons.directions_car,
                            size: 30,
                            color: maincolor1,
                          ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cab.type,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          cab.category,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 12),
            if (cab != null) ...[
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  _buildFeatureChip(
                    "${cab.seatingCapacity} Seats",
                    Icons.people,
                  ),
                  _buildFeatureChip("${cab.bagCapacity} Bags", Icons.luggage),
                  if (cab.isAssured == "1")
                    _buildFeatureChip("Assured", Icons.verified),
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

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Fare Breakdown",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: maincolor1)),
            const SizedBox(height: 16),
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
                    "Additional Charges", "₹${fare.additionalCharge}"),
              const Divider(height: 24),
              if (_commissionLoading)
                const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator())
              else if (_amountWithCommission != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildFareRow(
                        "Service Charges & Other",
                        "₹${(_amountWithCommission! - double.parse(fare.totalAmount.toString())).toStringAsFixed(0)}"),
                    _buildFareRow("Total Amount",
                        "₹${_amountWithCommission!.toStringAsFixed(0)}"),
                  ],
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentButton(BookingData bookingData, BuildContext context) {
    final fare = bookingData.cabRate?.fare;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
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
              const Text(
                "Amount to Pay:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                        "₹${_amountWithCommission?.toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: maincolor1,
                        ),
                      ),
            ],
          ),
          const SizedBox(height: 16),
          BlocBuilder<ConfirmBookingBloc, ConfirmBookingState>(
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: (_isTimerExpired || state is ConfirmBookingLoading)
                      ? null
                      : () {
                          _onBookNow(
                            _amountWithCommission!.toStringAsFixed(0).toString(),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isTimerExpired ? Colors.grey : maincolor1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: state is ConfirmBookingLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : Text(
                          _isTimerExpired
                              ? "TIME EXPIRED"
                              : "PROCEED TO PAYMENT",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFareRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isTotal ? Colors.black : Colors.grey[600],
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: isTotal ? maincolor1 : Colors.black,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(String text, IconData icon) {
    return Chip(
      label: Text(text),
      avatar: Icon(icon, size: 16),
      backgroundColor: Colors.blue.shade50,
      labelStyle: const TextStyle(fontSize: 12),
      visualDensity: VisualDensity.compact,
    );
  }

  Widget buildShimmerLoading() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}