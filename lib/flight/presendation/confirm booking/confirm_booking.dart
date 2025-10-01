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
  Set<int> expandedIndexes = {};
  late Razorpay _razorpay;
  bool _isProcessingPayment = false;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
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
        backgroundColor: Colors.red,
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
      // Get the first passenger for payment details
      final passenger = state.bookingdata!.passengers.isNotEmpty
          ? state.bookingdata!.passengers.first
          : null;

      final options = {
        'key': razorpaykey,
        'amount':
            (state
                        .bookingdata!
                        .journey
                        .flightOption
                        .flightFares
                        .first
                        .totalAmount *
                    100)
                .toInt(), // Convert to paise
        'name': 'Flight Booking',
        'description': 'Flight Ticket Payment',
        'prefill': {
          'contact': passenger?.contact ?? '0000000000',
          'email': passenger?.email ?? 'user@example.com',
        },
        'theme': {'color': maincolor1!.value.toRadixString(16)},
      };

      _razorpay.open(options);
    } catch (e) {
      setState(() => _isProcessingPayment = false);
      log("Razorpay Error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Error initiating payment")));
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
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: maincolor1,
          title: const Text(
            'Booking Confirmation',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: BlocConsumer<BookingBloc, BookingState>(
          listener: (context, state) {
            if (state.bookingError != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.bookingError!),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.isBookingConfirmed != null && state.isBookingConfirmed!) {
              return _buildSuccessUI(state);
            }

            if (state.bookingError != null) {
              return _buildErrorUI(state);
            }

            final bookingData = state.bookingdata;
            if (bookingData == null) {
              return const Center(child: Text('No booking data available'));
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  FlightbookingCard(flightOption: widget.flightinfo),
                  _buildPassengerExpansionSection(bookingData.passengers),
                  const SizedBox(height: 10),
                  _buildEnhancedFareBreakdown(bookingData.journey.flightOption),
                  const SizedBox(height: 20),
                  state.isLoading || _isProcessingPayment
                      ? const LinearProgressIndicator()
                      : buildPaymentButton(context, 'Confirm Booking', () {
                          _initiatePayment(state);
                        }),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSuccessUI(BookingState state) {
    final bookingData = state.bookingdata;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 40),
          Icon(Icons.check_circle, color: maincolor1, size: 80),
          const SizedBox(height: 20),
          Text(
            'Booking Confirmed!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: maincolor1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'PNR: ${state.alhindPnr ?? 'Not available'}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                SizedBox(height: 8),
                Text(
                  'Your e-ticket will be sent to your registered email address shortly.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: maincolor1),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          if (bookingData != null) ...[
            FlightbookingCard(flightOption: widget.flightinfo),
            _buildPassengerExpansionSection(bookingData.passengers),
            const SizedBox(height: 10),
            _buildEnhancedFareBreakdown(bookingData.journey.flightOption),
          ],

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: maincolor1,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                shadowColor: maincolor1!.withOpacity(0.3),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => HomePage()),
                  (route) => false,
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.confirmation_num, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    'Go Home',
                    style: TextStyle(fontSize: 16, color: Colors.white),
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
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: .5),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: maincolor1,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Text(
                'Passenger Details',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ...passengers.map(_buildPassengerExpansionTile),
        ],
      ),
    );
  }

  Widget _buildPassengerExpansionTile(RePassenger passenger) {
    return ExpansionTile(
      backgroundColor: Colors.blue.shade50,
      leading: Icon(
        passenger.paxType == 'ADT' ? Icons.person : Icons.child_friendly,
        color: Colors.blue,
      ),
      title: Text(
        '${passenger.title} ${passenger.firstName} ${passenger.lastName}',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      subtitle: Text(
        '${passenger.paxType == 'ADT' ? 'Adult' : 'Child'} • ${passenger.nationality}',
        style: const TextStyle(fontSize: 12),
      ),
      children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPassengerDetailRow(
                  'Date of Birth:',
                  convertMsDateToFormattedDate(passenger.dob!),
                ),
                _buildPassengerDetailRow('Contact:', passenger.contact ?? ''),
                _buildPassengerDetailRow('Email:', passenger.email ?? ''),
                if (passenger.passportNo != null) ...[
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.blue.shade50),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Passport Information',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
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
    );
  }

  Widget _buildPassengerDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade600)),
          Flexible(child: Text(value, textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  Widget _buildEnhancedFareBreakdown(BBFlightOption flightOption) {
    final fare = flightOption.flightFares.first;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300, width: .5),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.1),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: maincolor1,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                child: Text(
                  'Fare Breakdown',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...fare.fares.asMap().entries.map((entry) {
                    int index = entry.key;
                    var f = entry.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${f.ptc}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 6),
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
                            'Taxes',
                            '₹',
                            f.tax,
                            trailing: Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Icon(
                                expandedIndexes.contains(index)
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                                size: 20,
                                color: maincolor1,
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
                        const SizedBox(height: 6),
                        if (expandedIndexes.contains(index) &&
                            f.splitup != null &&
                            f.splitup!.isNotEmpty)
                          ...f.splitup!.map(
                            (s) => _fareRow(
                              '${s.category}',
                              '₹',
                              s.amount,
                              isSub: true,
                            ),
                          ),
                        const Divider(height: 20),
                      ],
                    );
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Payable',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        NumberFormat.currency(
                          symbol: '₹',
                        ).format(fare.totalAmount),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
Widget _buildErrorUI(BookingState state) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          // Animated Error Icon
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.red.shade400,
                  Colors.red.shade600,
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 3,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.close_rounded,
              color: Colors.white,
              size: 60,
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Error Title with Animation
          Text(
            'Booking Failed',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.red.shade700,
              letterSpacing: -0.5,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Text(
            'We encountered an issue with your booking',textAlign: TextAlign.center,
            style: TextStyle(
              
              fontSize: 16,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
              
            ),
          ),
          
          
          // Error Details Card
          // Container(
          //   width: double.infinity,
          //   padding: const EdgeInsets.all(20),
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       begin: Alignment.topLeft,
          //       end: Alignment.bottomRight,
          //       colors: [
          //         Colors.red.shade50,
          //         Colors.red.shade100.withOpacity(0.7),
          //       ],
          //     ),
          //     borderRadius: BorderRadius.circular(20),
          //     border: Border.all(
          //       color: Colors.red.shade200,
          //       width: 1.5,
          //     ),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.red.withOpacity(0.1),
          //         blurRadius: 20,
          //         spreadRadius: 2,
          //         offset: const Offset(0, 8),
          //       ),
          //     ],
          //   ),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Container(
          //         padding: const EdgeInsets.all(10),
          //         decoration: BoxDecoration(
          //           color: Colors.red.shade100,
          //           shape: BoxShape.circle,
          //         ),
          //         child: Icon(
          //           Icons.warning_amber_rounded,
          //           color: Colors.red.shade700,
          //           size: 24,
          //         ),
          //       ),
          //       const SizedBox(width: 16),
          //       Expanded(
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               'Error Details',
          //               style: TextStyle(
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.w700,
          //                 color: Colors.red.shade800,
          //               ),
          //             ),
          //             const SizedBox(height: 8),
          //             Text(
          //               state.bookingError ?? 'An unexpected error occurred while processing your booking. Please try again.',
          //               style: TextStyle(
          //                 fontSize: 14,
          //                 color: Colors.red.shade700,
          //                 height: 1.4,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          
          const SizedBox(height: 20),
          
          // Refund Information Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue.shade50,
                  Colors.blue.shade100.withOpacity(0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.blue.shade200,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.security_rounded,
                    color: Colors.blue.shade700,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Refund Protection',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue.shade800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue.shade700,
                            height: 1.4,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Your money is safe! ',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: 'If any amount was deducted, it will be automatically refunded to your account within ',
                            ),
                            const TextSpan(
                              text: '3-7 working days',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            const TextSpan(text: '.'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // const SizedBox(height: 32),
          
          // // Quick Actions
          // Text(
          //   'Quick Actions',
          //   style: TextStyle(
          //     fontSize: 18,
          //     fontWeight: FontWeight.w700,
          //     color: Colors.grey.shade800,
          //   ),
          // ),
          
          // const SizedBox(height: 16),
          
          // Row(
          //   children: [
          //     Expanded(
          //       child: Container(
          //         height: 80,
          //         padding: const EdgeInsets.all(16),
          //         decoration: BoxDecoration(
          //           color: Colors.grey.shade50,
          //           borderRadius: BorderRadius.circular(16),
          //           border: Border.all(color: Colors.grey.shade200),
          //         ),
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Icon(
          //               Icons.support_agent_rounded,
          //               color: maincolor1,
          //               size: 24,
          //             ),
          //             const SizedBox(height: 6),
          //             Text(
          //               'Support',
          //               style: TextStyle(
          //                 fontSize: 12,
          //                 fontWeight: FontWeight.w600,
          //                 color: Colors.grey.shade700,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //     const SizedBox(width: 12),
          //     Expanded(
          //       child: Container(
          //         height: 80,
          //         padding: const EdgeInsets.all(16),
          //         decoration: BoxDecoration(
          //           color: Colors.grey.shade50,
          //           borderRadius: BorderRadius.circular(16),
          //           border: Border.all(color: Colors.grey.shade200),
          //         ),
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Icon(
          //               Icons.history_rounded,
          //               color: maincolor1,
          //               size: 24,
          //             ),
          //             const SizedBox(height: 6),
          //             Text(
          //               'History',
          //               style: TextStyle(
          //                 fontSize: 12,
          //                 fontWeight: FontWeight.w600,
          //                 color: Colors.grey.shade700,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //     const SizedBox(width: 12),
          //     Expanded(
          //       child: Container(
          //         height: 80,
          //         padding: const EdgeInsets.all(16),
          //         decoration: BoxDecoration(
          //           color: Colors.grey.shade50,
          //           borderRadius: BorderRadius.circular(16),
          //           border: Border.all(color: Colors.grey.shade200),
          //         ),
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Icon(
          //               Icons.home_rounded,
          //               color: maincolor1,
          //               size: 24,
          //             ),
          //             const SizedBox(height: 6),
          //             Text(
          //               'Home',
          //               style: TextStyle(
          //                 fontSize: 12,
          //                 fontWeight: FontWeight.w600,
          //                 color: Colors.grey.shade700,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          
          const SizedBox(height: 40),
          
       
          
          
          // Back Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: OutlinedButton(
              onPressed: () {
  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => HomePage()),
                    (route) => false,
                  );              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.grey.shade700,
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Go Back',
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
    if (amount == null || amount == 0) return const SizedBox.shrink();

    final bool isMainItem =
        label == 'Base Fare' || label == 'Taxes' || label == 'Discount';

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: isSub ? 12 : 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: isDiscount ? Colors.green : Colors.black87,
              ),
            ),
          ),
          Row(
            children: [
              Text(
                (isDiscount ? '-' : '') +
                    NumberFormat.currency(symbol: symbol).format(amount),
                style: TextStyle(
                  fontWeight: isMainItem ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                  color: isDiscount ? Colors.green : Colors.black87,
                ),
              ),
              if (trailing != null) trailing,
            ],
          ),
        ],
      ),
    );
  }
}

Future<dynamic> _showBottomSheetbooking({
  required BuildContext context,
  BookingState? state,
}) {
  final isSuccess = state?.isBookingConfirmed ?? false;
  final isError = state?.bookingError != null;

  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: isSuccess ? 250 : 300,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          children: [
            Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 215, 205, 205),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(height: 20),

            if (isSuccess) ...[
              Icon(Icons.check_circle, color: maincolor1, size: 50),
              const SizedBox(height: 10),
              const Text(
                'Booking Completed Successfully!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'PNR: ${state?.alhindPnr ?? ''}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: maincolor1,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: maincolor1,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => HomePage()),
                    (route) => false,
                  );
                },
                child: const Text(
                  'Go to Home',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ] else if (isError) ...[
              Icon(Icons.error_outline, color: Colors.red, size: 50),
              const SizedBox(height: 10),
              const Text(
                'Booking Failed',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                state?.bookingError ?? 'An error occurred',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        side: BorderSide(color: maincolor1!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: (){  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => HomePage()),
                    (route) => false,
                  );},
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: maincolor1),
                      ),
                    ),
                  ),
                 
                ],
              ),
            ] else ...[
              Text(
                'Are You sure you want to go back?',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: maincolor1,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'This flight seems popular! Hurry, book before all the seats get filled',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: maincolor1,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Continue Booking',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
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
                  style: TextStyle(color: maincolor1),
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
