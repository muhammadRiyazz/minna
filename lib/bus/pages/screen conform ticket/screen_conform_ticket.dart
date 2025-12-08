import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/bus/application/change%20location/location_bloc.dart';
import 'package:minna/bus/domain/BlockTicket/block_respo.dart';
import 'package:minna/bus/domain/BlockTicket/block_ticket_request_modal.dart';
import 'package:minna/bus/domain/seatlayout/seatlayoutmodal.dart';
import 'package:minna/bus/infrastructure/bookTicket/book_ticket.dart';
import 'package:minna/bus/infrastructure/inset%20data/insert_data.dart';
import 'package:minna/bus/pages/screen%20conform%20ticket/widget/bottom_sheet.dart';
import 'package:minna/bus/pages/sceen%20Time%20out/screen_time_out.dart';
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

  // Color Theme - Black & Gold Premium
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37); // Gold
  final Color _accentColor = Color(0xFFC19B3C); // Darker Gold
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);
  final Color _errorColor = Color(0xFFE53935);
  final Color _successColor = Color(0xFF388E3C);
  final Color _warningColor = Color(0xFFF57C00);

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
      builder: (_) => Dialog(
        backgroundColor: _cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _warningColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.warning_amber_rounded, color: _warningColor, size: 40),
              ),
              SizedBox(height: 16),
              Text(
                "Fare Updated",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
              ),
              SizedBox(height: 12),
              Text(
                "The operator has updated the fare during block time.",
                style: TextStyle(color: _textSecondary),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildFareComparisonRow("Original Fare", totalFare),
                    SizedBox(height: 8),
                    _buildFareComparisonRow("Updated Fare", updatedFare, isUpdated: true),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                "This updated fare will be collected from you.",
                style: TextStyle(
                  color: _warningColor,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Continue with Updated Fare",
                    style: TextStyle(
                      color: _secondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFareComparisonRow(String label, double amount, {bool isUpdated = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(
          fontSize: 14,
          color: isUpdated ? _secondaryColor : _textSecondary,
          fontWeight: isUpdated ? FontWeight.w600 : FontWeight.normal,
        )),
        Text(
          '₹ ${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isUpdated ? _secondaryColor : _textPrimary,
            fontSize: isUpdated ? 16 : 14,
          ),
        ),
      ],
    );
  }

void _initRazorpay() {
  _razorpay = Razorpay();
  
  try {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  } catch (e) {
    log("Razorpay initialization error: $e");
    if (mounted) {
      _showErrorSnackBar("Payment service unavailable. Please try again.");
    }
  }
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
    if (_secondsRemaining < 60) return _errorColor;
    if (_secondsRemaining < 180) return _warningColor;
    return _secondaryColor;
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
      busORFlight: 
       'This bus seems popular! Hurry, book before all the seats get filled',
      primaryColor: _primaryColor,
      secondaryColor: _secondaryColor,
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

// Future<Map<String, dynamic>> _preparePaymentOptions(String orderId) async {
//   final passenger = widget.alldata.inventoryItems?.isNotEmpty == true
//       ? widget.alldata.inventoryItems!.first.passenger
//       : null;

//   final amount = _getCurrentFare();

//   Map<String, dynamic> options = {
//     'key': razorpaykey,
//     'amount': (amount * 100).toInt(),
//     'name': 'MT Trip',
//     'description': 'Bus Ticket Booking - ${widget.selectedSeats.length} seat(s)',
//     'order_id': orderId,
//     'prefill': {
//       'contact': passenger?.mobile ?? "0000000000",
//       'email': passenger?.email ?? "email@example.com",
//       'name': passenger?.name ?? "Passenger",
//     },
//     'theme': {
//       'color': '#D4AF37', // Gold as primary color
//       'backdrop_color': '#000000', // Black as backdrop
//     },
//     'notes': {
//       'booking_reference': _blockId,
//       'trip': '${widget.alldata.source} to ${widget.alldata.destination}',
//     },
//   };

//   // Try to load logo, but don't break the payment if it fails
//   try {
//     // Correct asset path - remove 'asset/' prefix if using Flutter asset system
//     final ByteData imageData = await rootBundle.load('asset/mtlogo.jpg');
//     final Uint8List bytes = imageData.buffer.asUint8List();
//     final String base64Image = base64Encode(bytes);
    
//     options['image'] = 'data:image/jpg;base64,$base64Image'; // Changed to jpg
//     log("Logo loaded successfully");
//   } catch (e) {
//     log("Failed to load logo: $e");
//     // Fallback to hosted logo or skip
//     options['image'] = 'https://via.placeholder.com/256x256/D4AF37/000000?text=MT+Trip';
//   }

//   // Platform-specific configurations
//   if (Theme.of(context).platform == TargetPlatform.iOS) {
//     options['ios'] = {
//       'hide_top_bar': false,
//     };
//   }

//   if (Theme.of(context).platform == TargetPlatform.android) {
//     options['android'] = {
//       'hide_logo': false,
//       'send_sms_hash': true,
//     };
//   }

//   return options;
// }

Future<Map<String, dynamic>> _preparePaymentOptions(String orderId) async {
  final passenger = widget.alldata.inventoryItems?.isNotEmpty == true
      ? widget.alldata.inventoryItems!.first.passenger
      : null;

  final amount = _getCurrentFare();

  Map<String, dynamic> options = {
    'key': razorpaykey,
    'amount': (amount * 100).toInt(),
    'name': 'MT Trip',
    'description': 'Bus Ticket Booking - ${widget.selectedSeats.length} seat(s)',
    'order_id': orderId,
    // 'image': 'https://i.ibb.co/your-image-id/mtlogo.jpg', // Use hosted image
    'prefill': {
      'contact': passenger?.mobile ?? "0000000000",
      'email': passenger?.email ?? "email@example.com",
      'name': passenger?.name ?? "Passenger",
    },
    'theme': {
      'color': '#D4AF37', // Gold color for buttons and text
      'backdrop_color': '#000000', // Black background
    },
    'notes': {
      'contact': passenger?.mobile ?? "0000000000",
      'email': passenger?.email ?? "email@example.com",
      'name': passenger?.name ?? "Passenger",
      'booking_reference': _blockId,
      'trip': '${widget.alldata.source} to ${widget.alldata.destination}',
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

  return options;
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

    } catch (e) {
      log("Booking processing error: $e");
      
      // Attempt refund on failure
      // await _handleBookingFailure(response.paymentId!, e.toString());
    } finally {
      if (mounted) {
        setState(() => _isBooking = false);
      }
    }
  }

void _handlePaymentError(PaymentFailureResponse response) async {
  log("Payment Failed: ${response.message} - Error: ${response.error}");

  String errorMessage = "Payment failed. Please try again.";
  
  // Extract error code from the error map
  dynamic errorCode;
  if (response.error is Map) {
    errorCode = (response.error as Map)['code'];
  }

  // iOS-specific error messages
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    if (errorCode != null) {
      switch (errorCode) {
        case 1:
          errorMessage = "Payment cancelled by user";
          break;
        case 2:
          errorMessage = "Network error. Please check your connection";
          break;
        case 3:
          errorMessage = "Payment failed due to technical issue";
          break;
        default:
          errorMessage = response.message ?? "Payment failed";
      }
    } else {
      // Fallback error message parsing for iOS
      if (response.message?.toLowerCase().contains('cancelled') == true) {
        errorMessage = "Payment cancelled by user";
      } else if (response.message?.toLowerCase().contains('network') == true) {
        errorMessage = "Network error. Please check your connection";
      }
    }
  }

  // Android-specific error messages
  if (Theme.of(context).platform == TargetPlatform.android) {
    if (errorCode != null) {
      switch (errorCode) {
        case 1:
          errorMessage = "Payment cancelled by user";
          break;
        case 2:
          errorMessage = "Network error. Please check your connection";
          break;
        default:
          errorMessage = response.message ?? "Payment failed";
      }
    }
  }

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
    _showErrorSnackBar(errorMessage);
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

  void _showErrorDialog(String message, {String? errorDetails}) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: _cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _errorColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.error_outline_rounded, color: _errorColor, size: 40),
              ),
              SizedBox(height: 16),
              Text(
                "Booking Issue",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
              ),
              SizedBox(height: 12),
              Text(
                message,
                style: TextStyle(color: _textSecondary),
                textAlign: TextAlign.center,
              ),
              if (errorDetails != null) ...[
                SizedBox(height: 8),
                Text(
                  "Error details: $errorDetails",
                  style: TextStyle(fontSize: 12, color: _textLight),
                  textAlign: TextAlign.center,
                ),
              ],
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "OK",
                    style: TextStyle(
                      color: _secondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.error_outline_rounded, color: _errorColor, size: 20),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Error',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    message,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: _errorColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: _errorColor.withOpacity(0.2), width: 1),
        ),
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        duration: Duration(seconds: 4),
        elevation: 8,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: _backgroundColor,
        appBar: AppBar(

          backgroundColor: _primaryColor,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.timer_rounded, color:                      Colors.white,
),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _timerColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(                    color: Colors.white,
),
                ),
                child: Text(
                  _timerText,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          leading: IconButton(
            color: Colors.white,
            icon: Icon(Icons.arrow_back_rounded, ),
            onPressed: _showExitConfirmation,
          ),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: _secondaryColor),
            SizedBox(height: 20),
            Text(
              "Initializing Booking...",
              style: TextStyle(
                fontSize: 16,
                color: _textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Please wait while we prepare your booking",
              style: TextStyle(
                fontSize: 14,
                color: _textLight,
              ),
            ),
          ],
        ),
      );
    }

    if (_isError) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _errorColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.error_outline_rounded, size: 64, color: _errorColor),
              ),
              SizedBox(height: 24),
              Text(
                "Failed to Initialize Booking",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                "We encountered an issue while setting up your booking. Please try again.",
                style: TextStyle(
                  fontSize: 14,
                  color: _textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _insertData,
                  child: Text(
                    "Try Again",
                    style: TextStyle(
                      color: _secondaryColor,
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
    }

    return Column(
      children: [
        SizedBox(height: 8),
        Expanded(child: _buildDetailsCard()),
        _buildBookButton(),
      ],
    );
  }

  Widget _buildDetailsCard() {
    final currentFare = _getCurrentFare();

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      children: [
        // Trip Summary Card
        _buildTripSummaryCard(),
        SizedBox(height: 10),
        
        // Booking Details Card
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            decoration: BoxDecoration(
              color: _cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 16,
                  spreadRadius: 1,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Passenger details section
                  _buildPassengerSection(),
                  SizedBox(height: 20),
                  Divider(height: 1, color: _textLight.withOpacity(0.3)),
                  SizedBox(height: 20),
                  
                  // Fare update warning (if applicable)
                  if (_hasFareChanged()) ...[
                    _buildFareUpdateWarning(),
                    SizedBox(height: 20),
                  ],
                  
                  // Fare breakdown section
                  _buildFareBreakdown(currentFare),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTripSummaryCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            spreadRadius: 1,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _secondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.directions_bus_rounded,
              color: _secondaryColor,
              size: 24,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ready to Book",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "${widget.selectedSeats.length} ${widget.selectedSeats.length == 1 ? 'Seat' : 'Seats'} • ${widget.alldata.inventoryItems?.first.passenger.name ?? 'Passenger'}",
                  style: TextStyle(
                    fontSize: 14,
                    color: _textSecondary,
                  ),
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }

  Widget _buildPassengerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.people_alt_rounded, color: _secondaryColor, size: 20),
            SizedBox(width: 8),
            Text(
              "Passenger Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _textPrimary,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        ...widget.alldata.inventoryItems?.map((item) => Container(
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _textLight.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_rounded,
                  color: _secondaryColor,
                  size: 20,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.passenger.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: _textPrimary,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Seat ${item.seatName} • ${item.passenger.gender} • ${item.passenger.age} years',
                      style: TextStyle(
                        fontSize: 12,
                        color: _textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '₹ ${item.fare}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _secondaryColor,
                ),
              ),
            ],
          ),
        )) ?? [SizedBox()],
      ],
    );
  }

  Widget _buildFareUpdateWarning() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _warningColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _warningColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, color: _warningColor, size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Fare Updated",
                  style: TextStyle(
                    color: _warningColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "The fare has been updated by the operator during block time.",
                  style: TextStyle(
                    color: _warningColor.withOpacity(0.8),
                    fontSize: 12,
                  ),
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
        Row(
          children: [
            Icon(Icons.receipt_long_rounded, color: _secondaryColor, size: 20),
            SizedBox(width: 8),
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
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildFareRow('Base Fare', totalBaseFare),
              SizedBox(height: 12),
              _buildFareRow('Service Tax / GST', updatedServiceTax),
              SizedBox(height: 12),
              Divider(height: 1, color: _textLight.withOpacity(0.3)),
              SizedBox(height: 12),
              _buildFareRow(
                'Total Amount',
                currentFare,
                isTotal: true,
                isUpdated: _hasFareChanged(),
              ),
            ],
          ),
        ),
        if (_hasFareChanged()) ...[
          SizedBox(height: 12),
          Text(
            "Note: Fare was updated during the booking process",
            style: TextStyle(
              fontSize: 12,
              color: _textLight,
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
            color: isUpdated && isTotal ? _secondaryColor : _textPrimary,
          ),
        ),
        Text(
          '₹ ${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isUpdated && isTotal ? _secondaryColor : _secondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBookButton() {
    final isEnabled = !_isBooking && !_isLoading && !_isError;
    final currentFare = _getCurrentFare();

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: isEnabled ? _onBookNow : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: isEnabled ? _primaryColor : _textLight,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: _isBooking
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(_secondaryColor),
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Processing Payment...',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock_rounded, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'PAY NOW',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '₹ ${currentFare.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
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