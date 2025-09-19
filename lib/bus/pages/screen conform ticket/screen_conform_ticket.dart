import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:minna/bus/application/change%20location/location_bloc.dart';
import 'package:minna/bus/domain/BlockTicket/block_ticket_request_modal.dart';
import 'package:minna/bus/domain/seatlayout/seatlayoutmodal.dart';
import 'package:minna/bus/domain/updated%20fare%20respo/update_fare.dart';
import 'package:minna/bus/infrastructure/bookTicket/book_ticket.dart';
import 'package:minna/bus/infrastructure/inset%20data/insert_data.dart';
import 'package:minna/bus/pages/screen%20conform%20ticket/widget/bottom_sheet.dart';
import 'package:minna/bus/pages/sceen%20Time%20out/screen_time_out.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/core/api.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ScreenConfirmTicket extends StatefulWidget {
  const ScreenConfirmTicket({
    super.key,
    required this.alldata,
    required this.blockKey,
    required this.selectedSeats,
    this.updatedFare,
  });

  final BlockTicketRequest alldata;
  final UpdatedFareResponse? updatedFare;
  final String blockKey;
  final List<Seat> selectedSeats;

  @override
  State<ScreenConfirmTicket> createState() => _ScreenConfirmTicketState();
}

class _ScreenConfirmTicketState extends State<ScreenConfirmTicket> {
  late double totalBaseFare;
  late double totalFare;

  late String _blockId;
  bool _isBooking = false;
  bool isLoading = false;
  bool isError = false;
  String? _paymentId;
  String? _orderId; // Added to store order ID
 
  static const int _initialSeconds = 7 * 60;
  int _secondsRemaining = _initialSeconds;
  Timer? _timer;

  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    totalBaseFare = widget.selectedSeats
        .map((s) => double.tryParse(s.baseFare) ?? 0.0)
        .fold(0.0, (a, b) => a + b);
    totalFare = widget.selectedSeats
        .map((s) => double.tryParse(s.fare) ?? 0.0)
        .fold(0.0, (a, b) => a + b);
    _startTimer();

    _insertData();
    _initRazorpay();
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
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsRemaining == 0) {
        t.cancel();
        _navigateToTimeout();
      } else {
        setState(() {
          _secondsRemaining -= 1;
        });
      }
    });
  }

  String get _timerText {
    final m = _secondsRemaining ~/ 60;
    final s = _secondsRemaining % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  Future<bool> _onWillPop() async {
    if (_timer != null) {
      showBottomSheetbooking(
        context: context,
        timer: _timer!,
        busORFlight: 'bus',
      );
    }
    return false;
  }

  void _navigateToTimeout() {
    _timer?.cancel();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const ScreenTimeOut()));
  }

  // API Payment Details Save
  Future<Map<String, dynamic>> _savePaymentDetails(
      String orderId, String transactionId, int status) async {
    log("_savePaymentDetails --called");

    try {
      final response = await http.post(
        Uri.parse('${baseUrl}paysave'),
        body: {
          'id': _blockId,
          'order_id': orderId,
          'transaction_id': transactionId,
          'status': status.toString(),
          'table':"bus_blockrequest"
        },
      );
      log(response.body.toString());
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return {
          'success': jsonResponse['statusCode'] == 200,
          'message': jsonResponse['message']
        };
      }
      return {'success': false, 'message': 'Failed to save payment details'};
    } catch (e) {
      log(e.toString());
      return {'success': false, 'message': 'Error: $e'};
    }
  }

//   // API Payment Capture
//  Future<Map<String, dynamic>> _capturePayment(
//     String paymentId,
//     String signature,
//     String orderId,
//     String amount) async {
//   log("_capturePayment --called");

//   final body = {
//     'id': _blockId,
//     'payment_id': paymentId,
//     'signature': signature,
//     'order_id': orderId,
//     'amount': amount,
//     'table': "bus_blockrequest",
//   };

//   log("Capture Payment Request Body: ${jsonEncode(body)}"); // ✅ log body

//   try {
    // final response = await http.post(
    //   Uri.parse('${baseUrl}paycapture'),
    //   body: body,
    // );

    // log("Capture Payment Response: ${response.body}");

    // if (response.statusCode == 200) {
    //   final jsonResponse = jsonDecode(response.body);
    //   return {
    //     'success': jsonResponse['statusCode'] == 200,
    //     'message': jsonResponse['message']
    //   };
    // }
//     return {'success': false, 'message': 'Failed to capture payment'};
//   } catch (e) {
//     log("Capture Payment Error: $e");
//     return {'success': false, 'message': 'Error: $e'};
//   }
// }

  // API Payment Refund
  Future<Map<String, dynamic>> _refundPayment(
      String transactionId, double amount) async {
    log('_refundPayment --callled');
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}payrefund'),
        body: {
          'id': _blockId,
          'transaction_id': transactionId,
          'amount': (amount* 100).toString(),
          'table':"bus_blockrequest"

        },
      );
      log(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return {
          'success': jsonResponse['statusCode'] == 200,
          'message': jsonResponse['message']
        };
      }
      return {'success': false, 'message': 'Failed to process refund'};
    } catch (e) {
      log(e.toString());
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // Create Order API
  Future<String?> _createOrder(double amount) async {
    try {
      final response = await http.post(
        Uri.parse("${baseUrl}createOrder"),
        body: {
          "amount": (amount * 100).toStringAsFixed(0),
        },
      );
log(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['statusCode'] == 200) {
          return data['message']['order_id']; // Extract order_id from response
        } else {
          log("Error creating order: ${data['message']}");
          return null;
        }
      } else {
        log("HTTP Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      log("Exception in createOrder: $e");
      return null;
    }
  }

  void _onBookNow() async {
    setState(() => _isBooking = true);

    // Create order first
    final orderId = await _createOrder(totalFare);
    if (orderId == null) {
      setState(() => _isBooking = false);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to create order. Please try again.")));
      return;
    }
    
    setState(() {
      _orderId = orderId;
    });

    final passenger = widget.alldata.inventoryItems?.isNotEmpty == true
        ? widget.alldata.inventoryItems!.first.passenger
        : null;

    final name = passenger?.name ?? "Passenger";
    final phone = passenger?.mobile ?? "0000000000";
    final email = passenger?.email ?? "email@example.com";
    final amount = totalFare.toStringAsFixed(0);

    var options = {
      'key': razorpaykey,
      'amount': (double.parse(amount) * 100),
      'name': name,
      'order_id': _orderId, // Use the created order ID
      'description': 'Bus Ticket Payment',
      'prefill': {'contact': phone, 'email': email},
      'theme': {'color': maincolor1!.value.toRadixString(16)},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      setState(() => _isBooking = false);
      log("Razorpay Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error starting Razorpay")));
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    log("Payment paymentId: ${response.paymentId}");
    log("Payment orderId: ${response.orderId}");
    log("Payment signature: ${response.signature}");

    setState(() {
      _paymentId = response.paymentId;
    });

    // Step 1: Save payment details
    final saveResult = await _savePaymentDetails(
        response.orderId!, response.paymentId!, 1);
    
    if (!saveResult['success']) {
      _showErrorDialog("Payment details could not be saved. Please contact support.");
      setState(() => _isBooking = false);
      return;
    }

    try {
      await bookNow(
        selectedseatsCount: widget.selectedSeats.length,
        blockID: _blockId,
        blockKey: widget.blockKey,
        context: context,
        paymentId: response.paymentId!,
        amount: totalFare
      );
      
      _timer?.cancel();
    } catch (e) {
      // If booking fails, initiate refund
      final refundResult = await _refundPayment(response.paymentId!, 1);
      
      _showErrorDialog(
        "Booking failed. ${refundResult['success'] ? 
          'Refund has been initiated.' : 
          'Please contact support for refund.'}");
      
      log("Booking Error: $e");
    }
    
    setState(() => _isBooking = false);
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    log("Payment Failed: ${response.message}");
    
    // Save failed payment details
    if (_paymentId != null && _orderId != null) {
      await _savePaymentDetails(_orderId!, _paymentId!, 2);
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Payment failed. Please try again.")));
    setState(() => _isBooking = false);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log("External Wallet: ${response.walletName}");
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Booking Issue"),
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

  Future<void> _insertData() async {
    setState(() {
      isLoading = true;
      isError = false;
    });

    try {
      final locationState = context.read<LocationBloc>().state;

      final resp = await addTicketDetals(
        locationState: locationState,
        alldata: widget.alldata,
        boardingpoint: widget.alldata.boardingPointID!,
        droppingPoint: widget.alldata.droppingPointID!,
        selectedseatslist: widget.selectedSeats,
      );

      if (resp.statusCode == 200) {
        final jsonResponse = jsonDecode(resp.body);
        final message = jsonResponse['message'];
        log(message.toString());
        _blockId = message.toString();
        setState(() {
          isLoading = false;
          isError = false;
        });
      } else {
        setState(() {
          isLoading = false;
          isError = true;
        });
      }
    } catch (e) {
      log("Insert Data Error: $e");
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
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
              const Icon(Icons.timer, color: Colors.yellow),
              const SizedBox(width: 4),
              Text(
                _timerText,
                style: TextStyle(
                  color: _secondsRemaining < 60 ? Colors.red : Colors.yellow,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          leading: BackButton(
            onPressed: () {
              if (_timer != null) {
                showBottomSheetbooking(
                  context: context,
                  timer: _timer!,
                  busORFlight: 'bus',
                );
              }
            },
          ),
        ),
        body: SafeArea(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : isError
                  ? const Center(child: Text("Something went wrong!"))
                  : Column(
                      children: [
                        const SizedBox(height: 5),
                        Expanded(child: _buildDetailsCard()),
                        _buildBookButton(),
                      ],
                    ),
        ),
      ),
    );
  }

  Widget _buildDetailsCard() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      children: [
        Card(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const SizedBox(height: 8),
                Column(
                  children: List.generate(
                    widget.alldata.inventoryItems?.length ?? 0,
                    (index) {
                      final seat = widget.alldata.inventoryItems![index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: maincolor1!.withOpacity(0.1),
                          child: const Icon(
                            Icons.person,
                            color: Colors.black54,
                          ),
                        ),
                        title: Text(seat.passenger.name),
                        subtitle: Text('Seat No: ${seat.seatName}'),
                        trailing: Text(
                          '₹ ${seat.fare}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                ),
                const Divider(height: 32, thickness: 1.2),
                _buildFareRow('Total Base Fare', totalBaseFare),
                const SizedBox(height: 8),
                _buildFareRow('GST', totalFare - totalBaseFare),
                const SizedBox(height: 12),
                _buildFareRow(
                  'Total Payable',
                  totalFare,
                  amountStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: maincolor1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFareRow(String label, double amount, {TextStyle? amountStyle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        Text(
          '₹ ${amount.toStringAsFixed(2)}',
          style: amountStyle ?? const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildBookButton() {
    final isEnabled = !_isBooking;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: isEnabled ? _onBookNow : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: maincolor1,
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
              : const Text(
                  'BOOK NOW',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}