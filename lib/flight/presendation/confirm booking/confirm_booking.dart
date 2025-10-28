import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/core/api.dart';
import 'package:minna/comman/functions/create_order_id.dart';
import 'package:minna/comman/pages/main%20home/home.dart';
import 'package:minna/flight/application/booking/booking_bloc.dart';
import 'package:minna/flight/domain/booking%20request%20/booking_request.dart';
import 'package:minna/flight/domain/fare%20request%20and%20respo/fare_respo.dart';
import 'package:minna/flight/domain/reprice%20/reprice_respo.dart';
import 'package:minna/flight/presendation/booking%20page/widget.dart/booking_card.dart';
import 'package:minna/flight/presendation/widgets.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:minna/flight/infrastracture/commission/commission_service.dart';

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
  // Theme colors
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37);
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);
  final Color _errorColor = Color(0xFFE53935);
  final Color _successColor = Color(0xFF4CAF50);
  final Color _warningColor = Color(0xFFFF9800);

  // Timer variables
  late Timer _timer;
  int _remainingSeconds = 8 * 60; // 8 minutes in seconds
  bool _isTimeExpired = false;
  Set<int> expandedIndexes = {};
  late Razorpay _razorpay;
  bool _isPaymentButtonLoading = false;
  String? _lastRefundState;

  // Commission service
  // final FlightCommissionService _commissionService = FlightCommissionService();
  // double _commissionAmount = 0;
  // double _totalWithCommission = 0;

  @override
  void initState() {
    super.initState();
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
      BookingEvent.confirmFlightBooking(
        paymentId: response.paymentId!,
        orderId: response.orderId!,
        signature: response.signature!,
      )
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

  void _openRazorpayPayment(BookingState state) async {
    if (_isPaymentButtonLoading) {
      return; // Prevent multiple clicks
    }

    setState(() {
      _isPaymentButtonLoading = true;
    });

    try {
      // Use total amount with commission for payment
      final amount = state.totalAmountWithCommission??0;
      final orderId = await createOrder(amount);

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
        'theme': {'color': _primaryColor.value.toRadixString(16)},
      };

      _razorpay.open(options);
    } catch (e) {
      log('Error opening Razorpay: $e');
      setState(() {
        _isPaymentButtonLoading = false;
      });
    }
  }

  void _showRefundInitiatedDialog(BuildContext context) {
    if (ModalRoute.of(context)?.isCurrent != true) return;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: _successColor),
            SizedBox(width: 8),
            Text("Refund Initiated"),
          ],
        ),
        content: Text("Your payment has been refunded due to booking failure. The amount will be credited to your account within 3-7 working days."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => HomePage()),
                (route) => false,
              );
            },
            child: Text("OK", style: TextStyle(color: _primaryColor)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingBloc, BookingState>(
      listener: (context, state) {
        final currentRefundState = '${state.refundInitiated}_${state.refundFailed}';
        
        if (currentRefundState != _lastRefundState) {
          _lastRefundState = currentRefundState;
          
          if (state.refundInitiated == true) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showRefundInitiatedDialog(context);
            });
          }
        }

        if (state.isBookingCompleted == true || state.isBookingConfirmed == true) {
          _lastRefundState = null;
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          await _showBottomSheetbooking(
            context: context,
            state: context.read<BookingBloc>().state,
          );
          return false;
        },
        child: Scaffold(
          backgroundColor: _backgroundColor,
          body: BlocBuilder<BookingBloc, BookingState>(
            builder: (context, state) {
              if ((state.isBookingCompleted == true || state.bookingFailed == true) && _isPaymentButtonLoading) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _isPaymentButtonLoading = false;
                  });
                });
              }

              if (state.isLoading) {
                return _buildLoadingScreen();
              }

              if (state.isBookingCompleted == true || state.isBookingConfirmed == true) {
                return _buildSuccessUI(state);
              }

              if (state.bookingError != null && state.bookingFailed == true) {
                return _buildErrorUI(state);
              }

              final bookingData = state.bookingdata;
              if (bookingData == null) {
                return _buildNoDataScreen();
              }

              return _buildBookingConfirmationUI(state,);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: _secondaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(_secondaryColor),
                      strokeWidth: 3,
                    ),
                  ),
                  Center(
                    child: Icon(
                      Icons.flight_takeoff_rounded,
                      color: _secondaryColor,
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
                color: _primaryColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Please wait while we process your flight details',
              style: TextStyle(
                fontSize: 14,
                color: _textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoDataScreen() {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
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
                color: _secondaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                color: _secondaryColor,
                size: 50,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'No Booking Data',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: _primaryColor,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Unable to load booking information.\nPlease try again.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: _textSecondary,
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
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

  Widget _buildBookingConfirmationUI(BookingState state, ) {
    final isProcessing = state.isCreatingOrder == true || 
                         state.isPaymentProcessing == true ||
                         state.isConfirmingBooking == true ||
                         state.isSavingFinalBooking == true ||
                         state.isRefundProcessing == true;

    return CustomScrollView(
      slivers: [
        // Enhanced SliverAppBar with Timer
        SliverAppBar(
          backgroundColor: _primaryColor,
          expandedHeight: 140,
          floating: false,
          pinned: true,
          elevation: 4,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => _showBottomSheetbooking(
              context: context,
              state: state,
            ),
          ),
          actions: [
            // Timer in actions (top-right corner)
            Container(
              margin: EdgeInsets.only(right: 16, top: 12),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _isTimeExpired ? _errorColor : _secondaryColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: _isTimeExpired ? _errorColor.withOpacity(0.3) : _secondaryColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _isTimeExpired ? Icons.timer_off_rounded : Icons.timer_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                  SizedBox(width: 6),
                  Text(
                    _isTimeExpired ? 'Expired' : _formatTime(_remainingSeconds),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            title: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Confirm Booking',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            centerTitle: true,
          ),
        ),

        // Time Expired Warning
        if (_isTimeExpired)
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _secondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: _errorColor),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Booking session has expired. Please start over to book your flight.',
                      style: TextStyle(
                        color: _errorColor,
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
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _secondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: _secondaryColor,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _getProcessingText(state),
                      style: TextStyle(
                        color: _textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
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
          child: _buildEnhancedFareBreakdownWithCommission( state ),
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
                      color: _errorColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _errorColor.withOpacity(0.2)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.timer_off_rounded, color: _errorColor, size: 40),
                        SizedBox(height: 8),
                        Text(
                          'Session Expired',
                          style: TextStyle(
                            color: _errorColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Your booking session has ended. Please restart the booking process.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
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
    if (state.isRefundProcessing == true) return 'Processing refund...';
    return 'Processing...';
  }

  Widget _buildPaymentButton(BookingState state, bool isProcessing) {





    final bool shouldShowLoading = _isPaymentButtonLoading || isProcessing;
    
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        minimumSize: Size.fromHeight(56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 2,
      ),
      onPressed: shouldShowLoading ? null : () => _openRazorpayPayment(state),
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
                Icon(Icons.lock_rounded, size: 20),
                SizedBox(width: 12),
                Text(
                  'Pay ₹${state.totalAmountWithCommission! .toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
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
          backgroundColor: _successColor,
          expandedHeight: 240,
          floating: false,
          pinned: true,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => _showBottomSheetbooking(
              context: context,
              state: state,
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'Booking Confirmed!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _successColor,
                    Color(0xFF43A047),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.check_rounded, color: Colors.white, size: 60),
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'PNR: ${state.alhindPnr ?? 'Not available'}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _successColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _successColor.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _successColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.email_rounded, color: Colors.white, size: 20),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Your e-ticket has been sent to your registered email address.',
                        style: TextStyle(
                          fontSize: 14,
                          color: _textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              if (bookingData != null) ...[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: FlightbookingCard(flightOption: widget.flightinfo),
                ),

                _buildPassengerExpansionSection(bookingData.passengers),

                SizedBox(height: 16),

                _buildEnhancedFareBreakdownWithCommission( state),
              ],
              SizedBox(height: 32),
            ],
          ),
        ),

        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: Size.fromHeight(56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => HomePage()),
                      (route) => false,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home_rounded, size: 20),
                      SizedBox(width: 12),
                      Text(
                        'Go to Home',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorUI(BookingState state) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: _primaryColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
              onPressed: () => _showBottomSheetbooking(context:  context,state:  state),
            ),
            title: Text(
              'Booking Failed',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            pinned: true,
          ),

          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 32),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: _secondaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.error_outline_rounded,
                      color: _secondaryColor,
                      size: 50,
                    ),
                  ),
                  
                  SizedBox(height: 20),
                  
                  Text(
                    'Booking Failed',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: _primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: 10),
                  
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Sorry, there is an issue on booking.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: _textSecondary,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 32),
                  
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: _secondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        if (state.refundInitiated == true) ...[
                          Icon(
                            Icons.check_circle_rounded,
                            color: _successColor,
                            size: 40,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Refund Initiated',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: _successColor,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Your payment is being refunded and will be processed within 3-7 working days.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: _textSecondary,
                            ),
                          ),
                        ] else if (state.refundFailed == true) ...[
                          Icon(
                            Icons.warning_rounded,
                            color: _warningColor,
                            size: 40,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Refund Issue',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: _warningColor,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Please contact support for assistance with your refund.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: _textSecondary,
                            ),
                          ),
                        ] else ...[
                          Icon(
                            Icons.security_rounded,
                            color: _secondaryColor,
                            size: 40,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Payment Protected',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: _secondaryColor,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Your payment is secure and will be automatically refunded if deducted.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: _textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  
                  Spacer(),
                  
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primaryColor,
                        foregroundColor: Colors.white,
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
                      child: Text(
                        'Go to Home',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
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
        color: _cardColor,
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
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _secondaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.people_rounded,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  'Passenger Details',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _primaryColor,
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                  decoration: BoxDecoration(
                    color: _secondaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    passengers.length.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...passengers.asMap().entries.map((entry) => _buildPassengerExpansionTile(entry.value, entry.key)),
        ],
      ),
    );
  }

  Widget _buildPassengerExpansionTile(RePassenger passenger, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: ExpansionTile(
        backgroundColor: _backgroundColor,
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _secondaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            passenger.paxType == 'ADT' 
                ? Icons.person_rounded 
                : passenger.paxType == 'CHD' 
                    ? Icons.child_care_rounded 
                    : Icons.child_friendly_rounded,
            color: _secondaryColor,
            size: 20,
          ),
        ),
        title: Text(
          '${passenger.title} ${passenger.firstName} ${passenger.lastName}',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: _textPrimary,
          ),
        ),
        subtitle: Text(
          '${passenger.paxType == 'ADT' ? 'Adult' : passenger.paxType == 'CHD' ? 'Child' : 'Infant'} • ${passenger.nationality}',
          style: TextStyle(
            fontSize: 12,
            color: _textSecondary,
          ),
        ),
        children: [
          Container(
            color: _cardColor,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPassengerDetailRow('Date of Birth:', convertMsDateToFormattedDate(passenger.dob!)),
                  _buildPassengerDetailRow('Contact:', passenger.contact ?? ''),
                  _buildPassengerDetailRow('Email:', passenger.email ?? ''),
                  if (passenger.passportNo != null) ...[
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _secondaryColor.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _secondaryColor.withOpacity(0.2)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: _secondaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.airplane_ticket_rounded, color: Colors.white, size: 14),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Passport Information',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: _primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    _buildPassengerDetailRow('Passport No:', passenger.passportNo!),
                    _buildPassengerDetailRow('Country of Issue:', passenger.countryOfIssue ?? 'N/A'),
                    _buildPassengerDetailRow('Expiry Date:', passenger.dateOfExpiry ?? 'N/A'),
                  ],
                ],
              ),
            ),
          ),
        ],
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
              color: _textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 13,
                color: _textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

 Widget _buildEnhancedFareBreakdownWithCommission(BookingState bookingstate) {
  final fare = bookingstate.bookingdata! .journey.flightOption.flightFares.first;
  final passengers = bookingstate.bookingdata!.passengers;
  
  // Calculate passenger counts by type
  final adultCount = passengers.where((p) => p.paxType == 'ADT').length;
  final childCount = passengers.where((p) => p.paxType == 'CHD').length;
  final infantCount = passengers.where((p) => p.paxType == 'INF').length;
  
  // Calculate totals
  double totalBaseFare = 0;
  double totalTax = 0;
  double totalDiscount = 0;
  
 

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: _cardColor,
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
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: _secondaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.receipt_rounded,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 12),
              Text(
                'Fare Breakdown',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _primaryColor,
                ),
              ),
              SizedBox(width: 8),
           
            ],
          ),
        ),
        Divider(height: 1),
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // // Passenger Summary
              // if (adultCount > 0 || childCount > 0 || infantCount > 0)
              //   Container(
              //     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              //     decoration: BoxDecoration(
              //       color: _backgroundColor,
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           'Passengers',
              //           style: TextStyle(
              //             fontSize: 12,
              //             fontWeight: FontWeight.w600,
              //             color: _textPrimary,
              //           ),
              //         ),
              //         Text(
              //           '${adultCount > 0 ? '$adultCount Adult${adultCount > 1 ? 's' : ''}' : ''}'
              //           '${childCount > 0 ? '${adultCount > 0 ? ', ' : ''}$childCount Child${childCount > 1 ? 'ren' : ''}' : ''}'
              //           '${infantCount > 0 ? '${(adultCount > 0 || childCount > 0) ? ', ' : ''}$infantCount Infant${infantCount > 1 ? 's' : ''}' : ''}',
              //           style: TextStyle(
              //             fontSize: 12,
              //             color: _textSecondary,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // SizedBox(height: 16),

              // Base Fare Breakdown by Passenger Type
              ...fare.fares.map((fareType) {
                final passengerType = fareType.ptc;
                int passengerCount = 0;
                
                switch (passengerType) {
                  case 'ADT':
                    passengerCount = adultCount;
                    break;
                  case 'CHD':
                    passengerCount = childCount;
                    break;
                  case 'INF':
                    passengerCount = infantCount;
                    break;
                }
                
                if (passengerCount == 0) return SizedBox.shrink();

                final baseFare = fareType.baseFare ?? 0;
                final tax = fareType.tax ?? 0;
                final discount = fareType.discount ?? 0;
                
                // Add to totals
                totalBaseFare += baseFare * passengerCount;
                totalTax += tax * passengerCount;
                totalDiscount += discount * passengerCount;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Passenger Type Header
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${_getPassengerTypeName(passengerType!)}'
                            '${passengerCount > 1 ? ' ($passengerCount)' : ''}',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: _primaryColor,
                            ),
                          ),
                          if (passengerCount > 1)
                            Text(
                              '× $passengerCount',
                              style: TextStyle(
                                fontSize: 12,
                                color: _textSecondary,
                              ),
                            ),
                        ],
                      ),
                    ),
                    
                    // Base Fare
                    _fareRow(
                      'Base Fare',
                      '₹',
                      baseFare,
                      passengerCount: passengerCount,
                    ),
                    
                    // Taxes & Fees
                    _fareRow(
                      'Taxes',
                      '₹',
                      tax,
                      passengerCount: passengerCount,
                    ),
                    
                    // Discount
                    // if (discount > 0)
                    //   _fareRow(
                    //     'Discount',
                    //     '₹',
                    //     discount,
                    //     passengerCount: passengerCount,
                    //     isDiscount: true,
                    //   ),
                    
                    // Passenger Type Total
                    // if (passengerCount > 1)
                    //   Container(
                    //     margin: EdgeInsets.symmetric(vertical: 8),
                    //     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    //     decoration: BoxDecoration(
                    //       color: _backgroundColor,
                    //       borderRadius: BorderRadius.circular(8),
                    //     ),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text(
                    //           '${_getPassengerTypeName(passengerType)} Total',
                    //           style: TextStyle(
                    //             fontSize: 13,
                    //             fontWeight: FontWeight.w600,
                    //             color: _textPrimary,
                    //           ),
                    //         ),
                    //         Text(
                    //           '₹${((baseFare + tax - discount) * passengerCount).toStringAsFixed(0)}',
                    //           style: TextStyle(
                    //             fontSize: 13,
                    //             fontWeight: FontWeight.w700,
                    //             color: _secondaryColor,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    
                    Divider(height: 24, color: Colors.grey.shade300),
                  ],
                );
              }).toList(),

              // Commission Section
              // Container(
              //   padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              //   decoration: BoxDecoration(
              //     color: _secondaryColor.withOpacity(0.05),
              //     borderRadius: BorderRadius.circular(12),
              //     border: Border.all(color: _secondaryColor.withOpacity(0.2)),
              //   ),
              //   child: Column(
              //     children: [
              //       _fareRow(
              //         'Service Charge',
              //         '₹',
              //         commissionAmount,
              //         isCommission: true,
              //       ),
              //       SizedBox(height: 8),
              //       Text(
              //         'Applicable for $travelType flights',
              //         style: TextStyle(
              //           fontSize: 11,
              //           color: _textSecondary,
              //           fontStyle: FontStyle.italic,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              // SizedBox(height: 16),

              // Summary Section
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _summaryRow('Total Base Fare', '₹', totalBaseFare),
                    _summaryRow('Total Taxes', '₹', totalTax),
                                        _summaryRow('Service Charge', '₹',  bookingstate.  totalCommission!, isCommission: true),

                    if (totalDiscount > 0)
                      _summaryRow('Discount', '₹', totalDiscount, isDiscount: true),
                    Divider(height: 16, color: Colors.grey.shade400),
                    _summaryRow(
                      'Total Payable',
                      '₹',
                  bookingstate.     totalAmountWithCommission!,
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

String _getPassengerTypeName(String paxType) {
  switch (paxType) {
    case 'ADT':
      return 'Adult';
    case 'CHD':
      return 'Child';
    case 'INF':
      return 'Infant';
    default:
      return paxType;
  }
}

Widget _fareRow(
  String label,
  String symbol,
  double amount, {
  int passengerCount = 1,
  bool isDiscount = false,
  bool isCommission = false,
}) {
  if (amount == 0) return SizedBox.shrink();

  final totalAmount = amount * passengerCount;

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isDiscount ? _successColor : (isCommission ? _secondaryColor : _textPrimary),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
          children: [
            if (passengerCount > 1 && label=='Base Fare') ...[
              Text(
                NumberFormat.currency(symbol: symbol).format(amount),
                style: TextStyle(
                  fontSize: 10,
                  color: _textSecondary,
                ),
              ),
              Text(
                ' × $passengerCount',
                style: TextStyle(
                  fontSize: 10,
                  color: _textSecondary,
                ),
              ),
              SizedBox(width: 8),
            ],
            Text(
              (isDiscount ? '-' : '') + NumberFormat.currency(symbol: symbol).format(totalAmount),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDiscount ? _successColor : (isCommission ? _secondaryColor : _textPrimary),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _summaryRow(
  String label,
  String symbol,
  double amount, {
  bool isDiscount = false,
  bool isCommission = false,
  bool isTotal = false,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 15 : 14,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: isDiscount ? _successColor : 
                  (isCommission ? _secondaryColor : 
                  (isTotal ? _primaryColor : _textPrimary)),
          ),
        ),
        Text(
          (isDiscount ? '-' : '') + NumberFormat.currency(symbol: symbol).format(amount),
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600,
            color: isDiscount ? _successColor : 
                  (isCommission ? _secondaryColor : 
                  (isTotal ? _secondaryColor : _textPrimary)),
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
  final _primaryColor = Colors.black;
  final _secondaryColor = Color(0xFFD4AF37);
  final _errorColor = Color(0xFFE53935);

  final isSuccess = state.isBookingConfirmed ?? false;
  final isError = state.bookingError != null;

  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Container(
        height: isSuccess ? 350 : 360,
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          children: [
            Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            SizedBox(height: 24),

            if (isSuccess) ...[
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check_circle_rounded, color: _secondaryColor, size: 40),
              ),
              SizedBox(height: 16),
              Text(
                'Booking Completed Successfully!',textAlign:TextAlign.center ,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: _primaryColor),
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'PNR: ${state.alhindPnr ?? ''}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: _primaryColor,
                  ),
                ),
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
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
                child: Text(
                  'Go to Home',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ] else if (isError) ...[
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.error_outline_rounded, color: _errorColor, size: 40),
              ),
              SizedBox(height: 16),
              Text(
                'Booking Failed',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: _errorColor,
                ),
              ),
              SizedBox(height: 12),
               Text(
                'Are you sure you want to go back?',textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: _errorColor,
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _primaryColor,
                    side: BorderSide(color: Colors.grey.shade300),
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
                  child: Text(
                    'Go Home',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ] else ...[
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.flight_takeoff_rounded, color: _secondaryColor, size: 40),
              ),
              SizedBox(height: 16),
              Text(
                'Are you sure you want to go back?',textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: _primaryColor,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'This flight seems popular! Hurry, book before all the seats get filled',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: Size.fromHeight(56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Continue Booking',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 5),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => HomePage()),
                    (route) => false,
                  );
                },
                child: Text(
                  'Exit Booking',
                  style: TextStyle(
                    color: _primaryColor,
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