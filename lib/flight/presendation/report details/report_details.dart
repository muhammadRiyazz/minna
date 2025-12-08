// screens/report_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minna/flight/domain/report/report_model.dart';

// Add this class definition at the top of your file
class AdditionalCharge {
  final String label;
  final double amount;

  AdditionalCharge(this.label, this.amount);
}

class ReportDetailScreen extends StatelessWidget {
  final ReportData report;

  const ReportDetailScreen({super.key, required this.report});

  // Updated color scheme matching your cab booking details
  static final Color _primaryColor = Colors.black;
  static final Color _secondaryColor = Color(0xFFD4AF37); // Gold
  static final Color _accentColor = Color(0xFFC19B3C); // Darker Gold
  static final Color _backgroundColor = Color(0xFFF8F9FA);
  static final Color _cardColor = Colors.white;
  static final Color _textPrimary = Colors.black;
  static final Color _textSecondary = Color(0xFF666666);
  static final Color _textLight = Color(0xFF999999);
  static final Color _errorColor = Color(0xFFE53935);
  static final Color _successColor = Color(0xFF4CAF50);
  static final Color _warningColor = Color(0xFFFF9800);

  @override
  Widget build(BuildContext context) {
    final response = report.response;
    
    if (response == null) {
      return Scaffold(
        backgroundColor: _backgroundColor,
        appBar: AppBar(
          title: Text('Flight Details'),
          backgroundColor: _primaryColor,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: _errorColor,
                size: 64,
              ),
              SizedBox(height: 16),
              Text(
                'Invalid Report Data',
                style: TextStyle(
                  color: _textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'This report contains invalid data and cannot be displayed.',
                style: TextStyle(
                  color: _textSecondary,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: Text(
          'Flight Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: _primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          // Header Section
          SliverAppBar(
            backgroundColor: _primaryColor,
            expandedHeight: 160.0,
            pinned: false,
            floating: false,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [_primaryColor, _primaryColor.withOpacity(0.8)],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Booking Reference',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                report.alhindPnr ?? 'N/A',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: _successColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: _successColor,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 12,
                                  color: _successColor,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'Confirmed',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Content Sections
          SliverList(
            delegate: SliverChildListDelegate([
              // Booking Summary Card
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildSummaryCard(),
              ),

              // Flight Details Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildFlightDetailsCard(response),
              ),

              SizedBox(height: 16),

              // Passenger Details Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildPassengerDetailsCard(response),
              ),

              SizedBox(height: 16),

              // Fare Breakdown Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildFareBreakdownCard(response),
              ),

              SizedBox(height: 100),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'BOOKING SUMMARY',
                style: TextStyle(
                  color: _textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.0,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '₹${report.amount}',
                  style: TextStyle(
                    color: _secondaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          _buildSummaryItem('PNR Number', report.response?.alhindPnr ?? 'N/A', Icons.airplane_ticket),
          _buildSummaryItem('Trip Type', report.response?.tripMode == 'O' ? 'One Way' : 'Round Trip', Icons.flight),
          _buildSummaryItem('Booking Date', _formatDate(report.createdDate), Icons.calendar_today),
          _buildSummaryItem('Booking Time', report.createdTime, Icons.access_time),
          _buildSummaryItem('Currency', report.response?.currency ?? 'INR', Icons.currency_rupee),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _secondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 16, color: _secondaryColor),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: _textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlightDetailsCard(ResponseData response) {
    final flightLegs = response.journey.flightOption.flightLegs;
    
    return Container(
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.flight_takeoff, color: _secondaryColor, size: 16),
              ),
              SizedBox(width: 12),
              Text(
                'FLIGHT DETAILS',
                style: TextStyle(
                  fontSize: 13,
                  color: _textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${flightLegs.length}',
                  style: TextStyle(
                    fontSize: 14,
                    color: _secondaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          if (flightLegs.isEmpty)
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Icon(Icons.flight, size: 40, color: _textLight),
                  SizedBox(height: 8),
                  Text(
                    'No flight details available',
                    style: TextStyle(
                      color: _textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          else
            ...flightLegs.map((leg) => _buildFlightLeg(leg)),
        ],
      ),
    );
  }

  Widget _buildFlightLeg(ReportFlightLeg leg) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // Route Information
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FROM',
                      style: TextStyle(
                        fontSize: 10,
                        color: _textSecondary,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      leg.origin,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 12, color: _secondaryColor),
                        SizedBox(width: 6),
                        Text(
                          _formatDateTime(leg.departureTime),
                          style: TextStyle(
                            fontSize: 12,
                            color: _textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: _secondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                        border: Border.all(color: _secondaryColor.withOpacity(0.3), width: 2),
                      ),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: _secondaryColor,
                        size: 15,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 2,
                      height: 40,
                      color: _secondaryColor.withOpacity(0.3),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'TO',
                      style: TextStyle(
                        fontSize: 10,
                        color: _textSecondary,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      leg.destination,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.access_time, size: 12, color: _secondaryColor),
                        SizedBox(width: 6),
                        Text(
                          _formatDateTime(leg.arrivalTime),
                          style: TextStyle(
                            fontSize: 12,
                            color: _textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Divider(height: 1),
          SizedBox(height: 16),
          // Flight Information Grid
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFlightInfoItem('Airline', leg.airlineCode, Icons.airlines),
                _buildFlightInfoItem('Flight', leg.flightNo, Icons.flight),
                _buildFlightInfoItem('PNR', leg.airlinePNR, Icons.confirmation_number),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlightInfoItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 16, color: _secondaryColor),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            color: _textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildPassengerDetailsCard(ResponseData response) {
    final passengers = response.passengers;
    
    return Container(
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.people_rounded, color: _secondaryColor, size: 16),
              ),
              SizedBox(width: 12),
              Text(
                'PASSENGER INFORMATION',
                style: TextStyle(
                  fontSize: 13,
                  color: _textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${passengers.length}',
                  style: TextStyle(
                    fontSize: 14,
                    color: _secondaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ...passengers.asMap().entries.map((entry) {
            final index = entry.key;
            final passenger = entry.value;
            return Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _backgroundColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _secondaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: _secondaryColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '${passenger.title} ${passenger.firstName} ${passenger.lastName}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _secondaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          passenger.paxType,
                          style: TextStyle(
                            fontSize: 12,
                            color: _secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  _buildPassengerDetailRow('Ticket Number', passenger.ticketNo),
                  _buildPassengerDetailRow('Passport', passenger.passportNo),
                  _buildPassengerDetailRow('Email', passenger.email),
                  _buildPassengerDetailRow('Contact', passenger.contact),
                  _buildPassengerDetailRow('Date of Birth', _formatDate(passenger.dob)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPassengerDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: _textSecondary,
                fontSize: 13,
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

Widget _buildFareBreakdownCard(ResponseData response) {
  final flightFares = response.journey.flightOption.flightFares;
  
  if (flightFares.isEmpty) {
    return Container();
  }

  final firstFare = flightFares.first;
  
    // Calculate additional charges from passengers
  double totalAdditionalCharges = 0;
  final additionalChargesList = <AdditionalCharge>[];
  
  for (final passenger in response.passengers) {
    final ssr = passenger.ssrAvailability;
    if (ssr != null) {
      final passengerName = '${passenger.title} ${passenger.firstName} ${passenger.lastName}';
      
      // Baggage charges
      if (ssr.baggageInfo != null) {
        for (final baggageInfo in ssr.baggageInfo!) {
          if (baggageInfo.baggages != null) {
            for (final baggage in baggageInfo.baggages!) {
              if (baggage.amount != null && baggage.amount! > 0) {
                additionalChargesList.add(AdditionalCharge(
                  'Extra Baggage - $passengerName',
                  baggage.amount!,
                ));
                totalAdditionalCharges += baggage.amount!;
              }
            }
          }
        }
      }
      
      // Meal charges
      if (ssr.mealInfo != null) {
        for (final mealInfo in ssr.mealInfo!) {
          if (mealInfo.meals != null) {
            for (final meal in mealInfo.meals!) {
              if (meal.amount != null && meal.amount! > 0) {
                additionalChargesList.add(AdditionalCharge(
                  'Meal - ${meal.name} - $passengerName',
                  meal.amount!,
                ));
                totalAdditionalCharges += meal.amount!;
              }
            }
          }
        }
      }
      
      // Seat charges
      if (ssr.seatInfo != null) {
        for (final seatInfo in ssr.seatInfo!) {
          if (seatInfo.seats != null) {
            for (final seat in seatInfo.seats!) {
              if (seat.fare != null && seat.fare!.isNotEmpty) {
                final seatFare = double.tryParse(seat.fare!);
                if (seatFare != null && seatFare > 0) {
                  additionalChargesList.add(AdditionalCharge(
                    'Seat Selection - $passengerName',
                    seatFare,
                  ));
                  totalAdditionalCharges += seatFare;
                }
              }
            }
          }
        }
      }
    }
  }

  // Calculate totals
  double totalBaseFare = 0;
  double totalTax = 0;
  double totalDiscount = 0;

  for (final fare in firstFare.fares) {
    totalBaseFare += fare.baseFare;
    totalTax += fare.tax;
    totalDiscount += fare.discount;
  }

  return Container(
    decoration: BoxDecoration(
      color: _cardColor,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 20,
          offset: Offset(0, 8),
        ),
      ],
    ),
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _secondaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.currency_rupee_rounded, color: _secondaryColor, size: 16),
            ),
            SizedBox(width: 12),
            Text(
              'FARE BREAKDOWN',
              style: TextStyle(
                fontSize: 13,
                color: _textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        
        // Base Fare and Taxes
        ...firstFare.fares.expand((fare) => [
          _buildFareItem('${_getPassengerTypeName(fare.ptc)} Base Fare', '₹${fare.baseFare.toStringAsFixed(2)}'),
          _buildFareItem('${_getPassengerTypeName(fare.ptc)} Tax', '₹${fare.tax.toStringAsFixed(2)}'),
          // if (fare.discount > 0)
          //   _buildFareItem('${_getPassengerTypeName(fare.ptc)} Discount', '-₹${fare.discount.toStringAsFixed(2)}'),
        ]),
        
        // Additional Services Section
        if (additionalChargesList.isNotEmpty) ...[
          SizedBox(height: 16),
          Divider(height: 1),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              'Additional Services',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _primaryColor,
              ),
            ),
          ),
          ...additionalChargesList.asMap().entries.map((entry) {
            final index = entry.key;
            final charge = entry.value;
            return _buildAdditionalChargeRow(
              charge.label,
              charge.amount,
              index: index + 1,
            );
          }),
        ],
        
        SizedBox(height: 16),
        Divider(height: 1),
        SizedBox(height: 16),
        
        // Summary Section
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildSummaryRow('Total Base Fare', totalBaseFare),
              _buildSummaryRow('Total Taxes', totalTax),
              
              if (totalAdditionalCharges > 0)
                _buildSummaryRow('Additional Services', totalAdditionalCharges),
              
              if (totalDiscount > 0)
                _buildSummaryRow('Discount', -totalDiscount, isDiscount: true),
              
              Divider(height: 16, color: Colors.grey.shade400),
              
              _buildSummaryRow(
                'Total Amount',
                firstFare.totalAmount,
                isTotal: true,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
  Widget _buildFareItem(String label, String amount, {bool isTotal = false}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isTotal ? _textPrimary : _textSecondary,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 14,
              color: isTotal ? _secondaryColor : _textPrimary,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalChargeRow(String label, double amount, {required int index}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: _secondaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      index.toString(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: _secondaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 13,
                      color: _textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Text(
            '₹${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {
    bool isDiscount = false,
    bool isCommission = false,
    bool isTotal = false,
  }) {
    final isNegative = amount < 0;
    final displayAmount = isNegative ? -amount : amount;
    
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
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
            '${isNegative ? '-' : ''}₹${displayAmount.toStringAsFixed(2)}',
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

  String _formatDateTime(String dateTime) {
    try {
      final dt = DateTime.parse(dateTime);
      return DateFormat('dd MMM yyyy • HH:mm').format(dt);
    } catch (e) {
      return dateTime;
    }
  }

  String _formatDate(String date) {
    try {
      final dt = DateTime.parse(date);
      return DateFormat('dd MMM yyyy').format(dt);
    } catch (e) {
      return date;
    }
  }
}