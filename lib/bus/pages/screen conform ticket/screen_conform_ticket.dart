import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/bus/application/change%20location/location_bloc.dart';
import 'package:minna/bus/domain/BlockTicket/block_respo.dart';
import 'package:minna/bus/domain/BlockTicket/block_ticket_request_modal.dart';
import 'package:minna/bus/domain/seatlayout/seatlayoutmodal.dart';
import 'package:minna/bus/infrastructure/bookTicket/book_ticket.dart';
import 'package:minna/bus/infrastructure/inset%20data/insert_data.dart';
import 'package:minna/bus/pages/screen%20conform%20ticket/widget/bottom_sheet.dart';
import 'package:minna/bus/pages/sceen%20Time%20out/screen_time_out.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/core/api.dart';
import 'package:minna/comman/functions/create_order_id.dart';
import 'package:minna/comman/functions/refund_payment.dart';
import 'package:minna/comman/functions/save_payment.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ScreenConfirmTicket extends StatefulWidget {
  const ScreenConfirmTicket({
    super.key,
    required this.alldata,
    required this.blockKey,
    required this.selectedSeats,
    required this.blockResponse
  });

  final BlockTicketRequest alldata;
  final String blockKey;
  final List<Seat> selectedSeats;
  final BlockResponse blockResponse;

  @override
  State<ScreenConfirmTicket> createState() => _ScreenConfirmTicketState();
}

class _ScreenConfirmTicketState extends State<ScreenConfirmTicket> {
  // State variables
  late double totalBaseFare;
  late double totalFare;
  late double updatedFare;
  late double updatedServiceTax;

  late String _blockId;
  bool _isBooking = false;
  bool _isLoading = false;
  bool _isError = false;
  String? _paymentId;
  String? _orderId;
  
  // Timer constants
  static const int _initialSeconds = 8 * 60;
  int _secondsRemaining = _initialSeconds;
  Timer? _timer;

  // Payment
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _initializeFares();
    _startTimer();
    _insertData();
    _initRazorpay();
  }

  void _initializeFares() {
    // Calculate initial fares from selected seats
    totalBaseFare = widget.selectedSeats
        .map((s) => double.tryParse(s.baseFare) ?? 0.0)
        .fold(0.0, (a, b) => a + b);

    totalFare = widget.selectedSeats
        .map((s) => double.tryParse(s.fare) ?? 0.0)
        .fold(0.0, (a, b) => a + b);

    // Get updated fares from block response
    updatedFare = double.tryParse(widget.blockResponse.fareBreakup?.updatedFare ?? '0') ?? totalFare;
    updatedServiceTax = double.tryParse(widget.blockResponse.fareBreakup?.updatedServiceTax ?? '0') ?? 0.0;

    // Show fare update dialog if fares changed
    if (_hasFareChanged()) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showFareUpdateDialog();
      });
    }
  }

  bool _hasFareChanged() {
    return updatedFare != totalFare;
  }

  void _showFareUpdateDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.orange),
            SizedBox(width: 8),
            Text("Fare Updated", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "The operator has updated the fare during block time.",
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 12),
            _buildFareComparisonRow("Original Fare", totalFare),
            _buildFareComparisonRow("Updated Fare", updatedFare),
            const SizedBox(height: 8),
            Text(
              "This updated fare will be collected from you.",
              style: TextStyle(
                color: Colors.orange[800],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK, Continue"),
          )
        ],
      ),
    );
  }

  Widget _buildFareComparisonRow(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(
            '₹ ${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: label.contains("Updated") ? Colors.orange : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _initRazorpay() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _razorpay.clear();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
        _navigateToTimeout();
      } else {
        setState(() {
          _secondsRemaining -= 1;
        });
      }
    });
  }

  String get _timerText {
    final minutes = _secondsRemaining ~/ 60;
    final seconds = _secondsRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Color get _timerColor {
    if (_secondsRemaining < 60) return Colors.red;
    if (_secondsRemaining < 180) return Colors.orange;
    return Colors.yellow;
  }

  Future<bool> _onWillPop() async {
    if (_timer != null) {
      _showExitConfirmation();
    }
    return false;
  }

  void _showExitConfirmation() {
    showBottomSheetbooking(
      context: context,
      timer: _timer!,
      busORFlight: 'bus',
    );
  }

  void _navigateToTimeout() {
    _timer?.cancel();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const ScreenTimeOut()),
    );
  }

  Future<void> _insertData() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _isError = false;
      });
    }

    try {
      final locationState = context.read<LocationBloc>().state;

      final response = await addTicketDetals(
        locationState: locationState,
        alldata: widget.alldata,
        boardingpoint: widget.alldata.boardingPointID!,
        droppingPoint: widget.alldata.droppingPointID!,
        selectedseatslist: widget.selectedSeats,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final message = jsonResponse['message'];
        
        if (message != null) {
          _blockId = message.toString();
          
          if (mounted) {
            setState(() {
              _isLoading = false;
              _isError = false;
            });
          }
        } else {
          throw Exception('Invalid response: message is null');
        }
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      log("Insert Data Error: $e");
      
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isError = true;
        });
        
        _showErrorSnackBar("Failed to initialize booking. Please try again.");
      }
    }
  }

  void _onBookNow() async {
    if (_isBooking || _isLoading || _isError) return;

    if (!mounted) return;

    setState(() => _isBooking = true);

    try {
      // Create Razorpay order
      final orderId = await createOrder(_getCurrentFare());
      
      if (orderId == null) {
        throw Exception("Failed to create payment order");
      }

      setState(() => _orderId = orderId);

      // Prepare payment options
      final options = await _preparePaymentOptions(orderId);
      
      // Open Razorpay checkout
      _razorpay.open(options);
      
    } catch (e) {
      log("Booking initialization error: $e");
      
      if (mounted) {
        setState(() => _isBooking = false);
        _showErrorSnackBar("Failed to initialize payment. Please try again.");
      }
    }
  }

  double _getCurrentFare() {
    return _hasFareChanged() ? updatedFare : totalFare;
  }

  Future<Map<String, dynamic>> _preparePaymentOptions(String orderId) async {
    final passenger = widget.alldata.inventoryItems?.isNotEmpty == true
        ? widget.alldata.inventoryItems!.first.passenger
        : null;

    final amount = _getCurrentFare();

    return {
      'key': razorpaykey,
      'amount': (amount * 100).toInt(),
      'name': passenger?.name ?? "Passenger",
      'order_id': orderId,
      'description': 'Bus Ticket Payment - ${widget.selectedSeats.length} seat(s)',
      'prefill': {
        'contact': passenger?.mobile ?? "0000000000",
        'email': passenger?.email ?? "email@example.com"
      },
      'theme': {'color': maincolor1!.value.toRadixString(16)},
      'timeout': 300, // 5 minutes timeout
    };
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    log("Payment Success - Payment ID: ${response.paymentId}, Order ID: ${response.orderId}");

    if (!mounted) return;

    setState(() {
      _paymentId = response.paymentId;
    });

    try {
      // Step 1: Save payment details
      final saveResult = await savePaymentDetails(
        orderId: response.orderId ?? '',
        status: 1,
        table: "bus_blockrequest",
        tableid: _blockId,
        transactionId: response.paymentId ?? '',
      );

      if (!saveResult['success']) {
        throw Exception("Failed to save payment details: ${saveResult['message']}");
      }

      // Step 2: Process booking
      await bookNow(
        selectedseatsCount: widget.selectedSeats.length,
        blockID: _blockId,
        blockKey: widget.blockKey,
        context: context,
        paymentId: response.paymentId!,
        amount: _getCurrentFare(),
      );

      // Success - cancel timer
      _timer?.cancel();

      // if (mounted) {
      //   // _showSuccessDialog();
      // }

    } catch (e) {
      log("Booking processing error: $e");
      
      // Attempt refund on failure
      await _handleBookingFailure(response.paymentId!, e.toString());
    } finally {
      if (mounted) {
        setState(() => _isBooking = false);
      }
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    log("Payment Failed: ${response.message} - ${response.error}");

    // Save failed payment details if we have an order ID
    if (_orderId != null) {
      try {
        await savePaymentDetails(
          orderId: _orderId!,
          status: 2,
          table: "bus_blockrequest",
          tableid: _blockId,
          transactionId: _paymentId ?? '',
        );
      } catch (e) {
        log("Error saving failed payment: $e");
      }
    }

    if (mounted) {
      setState(() => _isBooking = false);
      _showErrorSnackBar("Payment failed. Please try again.");
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log("External Wallet: ${response.walletName}");
    // Handle external wallet payment if needed
  }

  Future<void> _handleBookingFailure(String paymentId, String error) async {
    try {
      final refundResult = await refundPayment(
        transactionId: paymentId,
        amount: _getCurrentFare(),
        tableId: _blockId,
        table: 'bus_blockrequest',
      );

      if (mounted) {
        _showErrorDialog(
          "Booking failed. ${refundResult['success'] ? 
            'Refund has been initiated successfully.' : 
            'Failed to initiate refund. Please contact support.'}",
          errorDetails: error,
        );
      }
    } catch (refundError) {
      log("Refund error: $refundError");
      
      if (mounted) {
        _showErrorDialog(
          "Booking failed and refund could not be processed. Please contact support immediately.",
          errorDetails: "$error | Refund Error: $refundError",
        );
      }
    }
  }

  // void _showSuccessDialog() {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) => AlertDialog(
  //       title: const Row(
  //         children: [
  //           Icon(Icons.check_circle, color: Colors.green),
  //           SizedBox(width: 8),
  //           Text("Booking Successful!"),
  //         ],
  //       ),
  //       content: const Text("Your bus tickets have been booked successfully."),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text("OK"),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void _showErrorDialog(String message, {String? errorDetails}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red),
            SizedBox(width: 8),
            Text("Booking Issue"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message),
            if (errorDetails != null) ...[
              const SizedBox(height: 8),
              Text(
                "Error details: $errorDetails",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: maincolor1,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(Icons.timer, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                _timerText,
                style: TextStyle(
                  color: _timerColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _showExitConfirmation,
          ),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("Initializing booking..."),
          ],
        ),
      );
    }

    if (_isError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              "Failed to initialize booking",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("Please try again later"),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _insertData,
              child: const Text("Retry"),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        const SizedBox(height: 8),
        Expanded(child: _buildDetailsCard()),
        _buildBookButton(),
      ],
    );
  }

  Widget _buildDetailsCard() {
    final currentFare = _getCurrentFare();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Passenger details section
                _buildPassengerSection(),
                const Divider(height: 32, thickness: 1.2),
                
                // Fare update warning (if applicable)
                if (_hasFareChanged()) _buildFareUpdateWarning(),
                
                // Fare breakdown section
                _buildFareBreakdown(currentFare),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPassengerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Passenger Details",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...widget.alldata.inventoryItems?.map((item) => ListTile(
          leading: CircleAvatar(
            backgroundColor: maincolor1!.withOpacity(0.1),
            child: const Icon(Icons.person, color: Colors.black54),
          ),
          title: Text(item.passenger.name),
          subtitle: Text('Seat ${item.seatName}'),
          trailing: Text(
            '₹ ${item.fare}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        )) ?? [const Text("No passenger data")],
      ],
    );
  }

  Widget _buildFareUpdateWarning() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.orange, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Fare Updated During Block Time",
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "The fare has been updated by the operator. New fare will be collected.",
                  style: TextStyle(color: Colors.orange[800], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFareBreakdown(double currentFare) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Fare Breakdown",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buildFareRow('Base Fare', totalBaseFare),
        const SizedBox(height: 8),
        _buildFareRow('Service Tax / GST', updatedServiceTax),
        const Divider(height: 20),
        _buildFareRow(
          'Total Amount',
          currentFare,
          isTotal: true,
          isUpdated: _hasFareChanged(),
        ),
        if (_hasFareChanged()) ...[
          const SizedBox(height: 8),
          Text(
            "Note: Fare was updated during the booking process",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildFareRow(String label, double amount, {bool isTotal = false, bool isUpdated = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isUpdated && isTotal ? Colors.orange : Colors.black87,
          ),
        ),
        Text(
          '₹ ${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isUpdated && isTotal ? Colors.orange : maincolor1,
          ),
        ),
      ],
    );
  }

  Widget _buildBookButton() {
    final isEnabled = !_isBooking && !_isLoading && !_isError;
    final currentFare = _getCurrentFare();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: isEnabled ? _onBookNow : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: isEnabled ? maincolor1 : Colors.grey[400],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
            child: _isBooking
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2.5,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'BOOK NOW',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '₹ ${currentFare.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}