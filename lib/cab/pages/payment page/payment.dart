import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/bus/pages/screen%20conform%20ticket/widget/refundinitiated.dart';
import 'package:minna/bus/pages/screen%20fail%20ticket/screen_fail_ticket.dart';
import 'package:minna/cab/application/confirm%20booking/confirm_booking_bloc.dart';
import 'package:minna/cab/application/hold%20cab/hold_cab_bloc.dart';
import 'package:minna/cab/domain/hold%20data/hold_data.dart';
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
  State<BookingConfirmationPage> createState() =>
      _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingConfirmationPage> {
  late Timer _timer;
  int _remainingSeconds = 6 * 60; // 6 minutes in seconds
  bool _isTimerExpired = false;
  late Razorpay _razorpay;
  String? _orderId;






















  @override
  void initState() {
    super.initState();
    _startTimer();
    _initRazorpay();
  }

  @override
  void dispose() {
    _timer.cancel();
    _razorpay.clear();
    super.dispose();
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


     double? amount ;
final state = context.read<HoldCabBloc>().state;

if (state is HoldCabSuccess) {
  final BookingData cabData = state.data;
  amount=double.parse(cabData.cabRate!.fare.totalAmount.toString()) ;
}
    // Trigger the payment done event
    context.read<ConfirmBookingBloc>().add(
      ConfirmBookingEvent.paymentDone(
        orderId: response.orderId ?? _orderId ?? '',
        transactionId: response.paymentId ?? '',
        status: 1,
        tableid: widget.tableID,
        table: "cab_data",
        bookingid: widget.bookingId,
        amount: amount??0,
      ),
    );




    _timer.cancel();
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    log("Payment Failed: ${response.message}");

    // Trigger the payment fail event
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

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        setState(() {
          _isTimerExpired = true;
        });
        _timer.cancel();
        _showTimeExpiredDialog();
      }
    });
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
    final orderId = await createOrder(double.parse(amount));
    if (orderId == null) {
      log("orderId creating error");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to create order. Please try again."),
        ),
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Payment error: $e")));
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
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const AlertDialog(
                        title: Text("Processing Refund"),
                        content: Text(
                          "Please wait while we process your refund.",
                        ),
                      ),
                    );
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
                    // Navigate to refund initiated page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScreenRefundInitiated(
                         
                        ),
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
                    // Navigate to failed page with refund failure
                    log(' Navigate to failed page with refund failure');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScreenFailTicket(
                       
                        ),
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
                      // Initiate refund automatically
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
                      // Show error dialog
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
                // Navigate to success page
                log('Navigate to success page');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CabSuccessPage(bookingResponse: data),
                  ),
                );
              },
              paymentFailed: (message, orderId, tableid, bookingid) {
                // Navigate to failed page
                log("Navigate to failed page");
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => FailedPage(
                //       message: message,
                //       onRetry: () {
                //         // Retry payment logic
                //         final holdState = context.read<HoldCabBloc>().state;
                //         if (holdState is HoldCabSuccess) {
                //           _onBookNow(holdState.data.cabRate!.fare.totalAmount.toString());
                //         }
                //       },
                //     ),
                //   ),
                // );
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
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _remainingSeconds < 60
                        ? Colors.red
                        : Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.timer, size: 16, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        _formatTime(_remainingSeconds),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            centerTitle: true,
            backgroundColor: maincolor1,
            iconTheme: IconThemeData(color: Colors.white),
            shape: RoundedRectangleBorder(
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
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 64, color: Colors.red),
                        SizedBox(height: 16),
                        Text(
                          "Error Occurred",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).popUntil((route) => route.isFirst);
                          },
                          child: Text("Go to Home"),
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
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTripInformation(bookingData),
                SizedBox(height: 10),
                _buildCabDetails(bookingData),
                SizedBox(height: 10),
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
    log(bookingData.tripType.toString());
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.route, color: maincolor1, size: 22),
                SizedBox(width: 10),
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
            SizedBox(height: 16),

            // Display different UI based on trip type
            if (bookingData.tripType == 1) // One Way
              _buildOneWayTrip(bookingData),

            if (bookingData.tripType == 2) // Round Trip
              _buildRoundTrip(bookingData),

            if (bookingData.tripType == 3) // Multi City
              _buildMultiCityTrip(bookingData),

            if (bookingData.tripType == 4) // Airport Transfer
              _buildAirportTransfer(bookingData),

            if (bookingData.tripType == 10) // Day Rental
              _buildDayRental(bookingData),

            Divider(height: 30, thickness: 1, color: Colors.grey[200]),

            // Common trip details
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
    final hours = minutes ~/ 60; // integer division
    final mins = minutes % 60; // remainder
    if (hours > 0 && mins > 0) {
      return "$hours hr $mins min";
    } else if (hours > 0) {
      return "$hours hr";
    } else {
      return "$mins min";
    }
  }

  // ✅ One Way Trip UI
  Widget _buildOneWayTrip(BookingData bookingData) {
    final route = bookingData.routes.first;
    return _buildHorizontalRouteCard(
      route.source.address,
      route.destination.address,
    );
  }

  // ✅ Round Trip UI
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
        SizedBox(height: 10),
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
        shrinkWrap: true, // ✅ prevents unbounded height
        itemCount: bookingData.routes.length,
        itemBuilder: (context, index) {
          final route = bookingData.routes[index];
          return Padding(
            padding: const EdgeInsets.only(right: 7),
            child: SizedBox(
              width: 200, // ✅ give fixed width for each card
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

  // ✅ Airport Transfer UI
  Widget _buildAirportTransfer(BookingData bookingData) {
    final route = bookingData.routes.first;
    return _buildHorizontalRouteCard(
      route.source.address,
      route.destination.address,
      label: "Airport Transfer",
    );
  }

  // ✅ Day Rental UI
  Widget _buildDayRental(BookingData bookingData) {
    final route = bookingData.routes.first;
    return _buildHorizontalRouteCard(
      route.source.address,
      route.destination.address,
      label: "Day Rental",
    );
  }

  /// 🔥 Reusable Horizontal Route Card
  Widget _buildHorizontalRouteCard(
    String source,
    String destination, {
    String? label,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
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
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (label != null)
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey,
                    ),
                  ),
                Text(
                  source,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: maincolor1),
          SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
              Text(
                value,
                style: TextStyle(
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
        padding: EdgeInsets.all(16),
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
            SizedBox(height: 16),
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
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cab.type,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
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
            SizedBox(height: 12),
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
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Fare Breakdown",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: maincolor1,
              ),
            ),
            SizedBox(height: 16),
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
              Divider(height: 24),
              _buildFareRow(
                "Total Amount",
                "₹${fare.totalAmount}",
                isTotal: true,
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
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                "₹${fare?.totalAmount ?? 0}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: maincolor1,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
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
                            bookingData.cabRate!.fare.totalAmount.toString(),
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
                      ? SizedBox(
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
                          style: TextStyle(
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
      padding: EdgeInsets.symmetric(vertical: 6),
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
      labelStyle: TextStyle(fontSize: 12),
      visualDensity: VisualDensity.compact,
    );
  }

  Widget buildShimmerLoading() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
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
          SizedBox(height: 16),
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
          SizedBox(height: 16),
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
