import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/core/api.dart';
import 'package:minna/comman/pages/main%20home/home.dart';
import 'package:minna/flight/application/booking/booking_bloc.dart';
import 'package:minna/flight/domain/booking%20request%20/booking_request.dart';
import 'package:minna/flight/domain/fare%20request%20and%20respo/fare_respo.dart';
import 'package:minna/flight/domain/reprice%20/reprice_respo.dart';
import 'package:minna/flight/presendation/booking%20page/widget.dart/booking_card.dart';
import 'package:minna/flight/presendation/widgets.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class BookingConfirmationScreen extends StatefulWidget {
  const BookingConfirmationScreen({super.key, required this.flightinfo});

  final FFlightOption flightinfo;

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
  bool _isProcessingPayment = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _initializeRazorpay();
  }

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
    setState(() => _isProcessingPayment = false);
    context.read<BookingBloc>().add(const BookingEvent.confirmBooking());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    log("Payment Error: ${response.code} - ${response.message}");
    setState(() => _isProcessingPayment = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Payment failed: ${response.message ?? 'Unknown error'}"),
        backgroundColor: _errorColor,
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log("External Wallet: ${response.walletName}");
    setState(() => _isProcessingPayment = false);
  }

  Future<void> _initiatePayment(BookingState state) async {
    if (state.bookingdata == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Booking data not available")),
      );
      return;
    }

    setState(() => _isProcessingPayment = true);

    try {
      final passenger = state.bookingdata!.passengers.isNotEmpty
          ? state.bookingdata!.passengers.first
          : null;

      final options = {
        'key': razorpaykey,
        'amount': (state.bookingdata!.journey.flightOption.flightFares.first.totalAmount * 100).toInt(),
        'name': 'Flight Booking',
        'description': 'Flight Ticket Payment',
        'prefill': {
          'contact': passenger?.contact ?? '0000000000',
          'email': passenger?.email ?? 'user@example.com',
        },
        'theme': {'color': _primaryColor.value.toRadixString(16)},
      };

      _razorpay.open(options);
    } catch (e) {
      setState(() => _isProcessingPayment = false);
      log("Razorpay Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error initiating payment")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _showBottomSheetbooking(
          context: context,
          state: context.read<BookingBloc>().state,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: _backgroundColor,
        body: BlocConsumer<BookingBloc, BookingState>(
          listener: (context, state) {
            if (state.bookingError != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.bookingError!),
                  backgroundColor: _errorColor,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return _buildLoadingScreen();
            }

            if (state.isBookingConfirmed != null && state.isBookingConfirmed!) {
              return _buildSuccessUI(state);
            }

            if (state.bookingError != null) {
              return _buildErrorUI(state);
            }

            final bookingData = state.bookingdata;
            if (bookingData == null) {
              return _buildNoDataScreen();
            }

            return _buildBookingConfirmationUI(state, bookingData);
          },
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

  Widget _buildBookingConfirmationUI(BookingState state, BBBookingRequest bookingData) {
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
    // background: Container(
    //   decoration: BoxDecoration(
    //     gradient: LinearGradient(
    //       begin: Alignment.topLeft,
    //       end: Alignment.bottomRight,
    //       colors: [
    //         _primaryColor,
    //         Color(0xFF2D2D2D),
    //       ],
    //     ),
    //   ),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.end,
    //     children: [
    //       // Additional timer display in expanded area (optional)
    //       if (!_isTimeExpired)
    //         Container(
    //           margin: EdgeInsets.only(bottom: 20),
    //           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //           child: Text(
    //             'Complete your booking within ${_formatTime(_remainingSeconds)}',
    //             style: TextStyle(
    //               color: Colors.white.withOpacity(0.9),
    //               fontSize: 14,
    //               fontWeight: FontWeight.w500,
    //             ),
    //             textAlign: TextAlign.center,
    //           ),
    //         ),
    //     ],
    //   ),
    // ),
  ),
),
        // Time Expired Warning
        if (_isTimeExpired)
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
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

        // Flight Details
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: FlightbookingCard(flightOption: widget.flightinfo),
          ),
        ),

        // Passenger Details
        SliverToBoxAdapter(
          child: _buildPassengerExpansionSection(bookingData.passengers),
        ),

        // Fare Breakdown
        SliverToBoxAdapter(
          child: _buildEnhancedFareBreakdown(bookingData.journey.flightOption),
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
                  state.isLoading || _isProcessingPayment
                      ? LinearProgressIndicator(
                          color: _secondaryColor,
                          backgroundColor: _secondaryColor.withOpacity(0.2),
                        )
                      : _buildPaymentButton(
                          context,
                          'Pay & Confirm Booking',
                          () => _initiatePayment(state),
                        ),
                ],
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ],
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
          leading:IconButton(
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
                padding: EdgeInsets.all(20),
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

                _buildEnhancedFareBreakdown(bookingData.journey.flightOption),
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

  // ... (Keep all the existing _buildPassengerExpansionSection, _buildPassengerExpansionTile, 
  // _buildPassengerDetailRow, _buildEnhancedFareBreakdown, _buildErrorUI, _fareRow methods 
  // but update them to use the theme colors and maintain the same structure)

  Widget _buildPassengerExpansionSection(List<RePassenger> passengers) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              // color: _primaryColor,
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
          ...passengers.map(_buildPassengerExpansionTile),
        ],
      ),
    );
  }

  Widget _buildPassengerExpansionTile(RePassenger passenger) {
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

  Widget _buildEnhancedFareBreakdown(BBFlightOption flightOption) {
    final fare = flightOption.flightFares.first;
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
              // color: _primaryColor,
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
              ],
            ),
          ),
          Divider(height: 1,),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...fare.fares.asMap().entries.map((entry) {
                  int index = entry.key;
                  var f = entry.value;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          '${f.ptc} Passenger',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: _primaryColor,
                          ),
                        ),
                      ),
                      _fareRow('Base Fare', '₹', f.baseFare),
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (expandedIndexes.contains(index)) {
                              expandedIndexes.remove(index);
                            } else {
                              expandedIndexes.add(index);
                            }
                          });
                        },
                        child: _fareRow(
                          'Taxes & Fees',
                          '₹',
                          f.tax,
                          trailing: Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(
                              expandedIndexes.contains(index)
                                  ? Icons.expand_less_rounded
                                  : Icons.expand_more_rounded,
                              size: 20,
                              color: _secondaryColor,
                            ),
                          ),
                        ),
                      ),
                      if ((f.discount ?? 0) > 0)
                        _fareRow(
                          'Discount',
                          '₹',
                          f.discount,
                          isDiscount: true,
                        ),
                      SizedBox(height: 12),
                      if (expandedIndexes.contains(index) && f.splitup != null && f.splitup!.isNotEmpty)
                        ...f.splitup!.map(
                          (s) => _fareRow(
                            '${s.category}',
                            '₹',
                            s.amount,
                            isSub: true,
                          ),
                        ),
                      Divider(height: 24, color: Colors.grey.shade300),
                    ],
                  );
                }),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: _secondaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _secondaryColor.withOpacity(0.2)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Payable',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: _primaryColor,
                          ),
                        ),
                        Text(
                          NumberFormat.currency(symbol: '₹').format(fare.totalAmount),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: _secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorUI(BookingState state) {
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _errorColor.withOpacity(0.8),
                      _errorColor,
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: _errorColor.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 3,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                  size: 60,
                ),
              ),
              SizedBox(height: 32),
              Text(
                'Booking Failed',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: _errorColor,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'We encountered an issue with your booking',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: _textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _secondaryColor.withOpacity(0.05),
                      _secondaryColor.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _secondaryColor.withOpacity(0.2)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _secondaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.security_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Refund Protection',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: _primaryColor,
                            ),
                          ),
                          SizedBox(height: 8),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                                color: _textSecondary,
                                height: 1.4,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Your money is safe! ',
                                  style: TextStyle(fontWeight: FontWeight.w700, color: _primaryColor),
                                ),
                                TextSpan(
                                  text: 'If any amount was deducted, it will be automatically refunded to your account within ',
                                ),
                                TextSpan(
                                  text: '3-7 working days',
                                  style: TextStyle(fontWeight: FontWeight.w700, color: _primaryColor),
                                ),
                                TextSpan(text: '.'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
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
    );
  }

  Widget _fareRow(
    String label,
    String symbol,
    double? amount, {
    bool isDiscount = false,
    bool isSub = false,
    Widget? trailing,
  }) {
    if (amount == null || amount == 0) return SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: isSub ? 12 : 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: isDiscount ? _successColor : _textPrimary,
                fontWeight: isSub ? FontWeight.normal : FontWeight.w500,
              ),
            ),
          ),
          Row(
            children: [
              Text(
                (isDiscount ? '-' : '') + NumberFormat.currency(symbol: symbol).format(amount),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSub ? FontWeight.normal : FontWeight.w600,
                  color: isDiscount ? _successColor : _textPrimary,
                ),
              ),
              if (trailing != null) trailing,
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentButton(BuildContext context, String text, VoidCallback onPressed) {
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
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock_rounded, size: 20),
          SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ... (Keep the existing _showBottomSheetbooking and convertMsDateToFormattedDate functions)
Future<dynamic> _showBottomSheetbooking({
  required BuildContext context,
  BookingState? state,
}) {
  final _primaryColor = Colors.black;
  final _secondaryColor = Color(0xFFD4AF37);
  final _errorColor = Color(0xFFE53935);

  final isSuccess = state?.isBookingConfirmed ?? false;
  final isError = state?.bookingError != null;

  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Container(
        height: isSuccess ? 350 : 380,
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
                  'PNR: ${state?.alhindPnr ?? ''}',
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
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _errorColor.withOpacity(0.1),
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
                state?.bookingError ?? 'An error occurred',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
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
                'Are you sure you want to go back?',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: _primaryColor,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'This flight seems popular! Hurry, book before all the seats get filled',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 12),
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