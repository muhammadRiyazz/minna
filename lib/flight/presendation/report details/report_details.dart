// screens/report_detail_screen.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:minna/flight/domain/report/report_model.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/flight/infrastracture/report/report.dart';
import 'package:url_launcher/url_launcher.dart';

// Add this class definition at the top of your file
class AdditionalCharge {
  final String label;
  final double amount;

  AdditionalCharge(this.label, this.amount);
}

class ReportDetailScreen extends StatefulWidget {
  final ReportData report;

  const ReportDetailScreen({super.key, required this.report});

  @override
  State<ReportDetailScreen> createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  bool _isCancelling = false;
  late ReportData _currentReport;
  final ReportApiService _apiService = ReportApiService();

  @override
  void initState() {
    super.initState();
    _currentReport = widget.report;
  }

  // Updated color scheme matching your cab booking details
  static final Color _accentColor = secondaryColor; // Gold

  @override
  Widget build(BuildContext context) {
    final report = _currentReport;
    final response = report.response;

    if (response == null) {
      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Text('Flight Details'),
          backgroundColor: maincolor1,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Iconsax.danger, color: errorColor, size: 64),
              SizedBox(height: 16),
              Text(
                'Invalid Report Data',
                style: TextStyle(
                  color: textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'This report contains invalid data and cannot be displayed.',
                style: TextStyle(color: textSecondary, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      // appBar: AppBar(
      //   title: Text(
      //     'Flight Details',
      //     style: TextStyle(
      //       color: Colors.white,
      //       fontSize: 18,
      //       fontWeight: FontWeight.w600,
      //     ),
      //   ),
      //   backgroundColor: maincolor1,
      //   iconTheme: IconThemeData(color: Colors.white),
      //   centerTitle: true,
      //   elevation: 0,
      // ),
      body: CustomScrollView(
        slivers: [
          // Header Section
          SliverAppBar(
            backgroundColor: maincolor1,
            expandedHeight: 160.0,
            pinned: false,
            floating: false,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [maincolor1, maincolor1.withOpacity(0.8)],
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
                                report.pnr ?? 'ID: ${report.bookingId}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(
                                report.bookingStatus,
                              ).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: _getStatusColor(report.bookingStatus),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _getStatusIcon(report.bookingStatus),
                                  size: 12,
                                  color: _getStatusColor(report.bookingStatus),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  report.bookingStatus.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _getStatusColor(
                                      report.bookingStatus,
                                    ),
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

              // Cancellation Info Card
              if (report.cancel != null && report.cancel!.status != 'NONE')
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: _buildCancellationCard(),
                ),

              // Refund Info Card
              if (report.refund != null &&
                  report.refund!.status != 'NOT_REFUNDED')
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: _buildRefundCard(),
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

              const SizedBox(height: 60),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: _shouldShowCancelButton(response)
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: errorColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: errorColor.withOpacity(0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _isCancelling
                          ? null
                          : () {
                              _showCancelReasonDialog(context);
                            },
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Iconsax.undo, color: errorColor, size: 20),
                            const SizedBox(width: 12),
                            Text(
                              _isCancelling
                                  ? 'Processing...'
                                  : 'Request Cancellation',
                              style: TextStyle(
                                color: _isCancelling
                                    ? errorColor.withOpacity(0.5)
                                    : errorColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (_isCancelling)
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      errorColor.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
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
                  color: textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.0,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _currentReport.bookingStatus,
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          _buildSummaryItem(
            'PNR Number',
            _currentReport.pnr ?? 'N/A',
            Iconsax.airplane,
          ),
          _buildSummaryItem(
            'Trip Type',
            (_currentReport.response?.tripMode ?? '') == 'O'
                ? 'One Way'
                : 'Round Trip',
            Icons.flight,
          ),
          _buildSummaryItem(
            'Booking Date',
            _currentReport
                        .response
                        ?.journey
                        .flightOption
                        .flightLegs
                        .isNotEmpty ??
                    false
                ? _formatDate(
                    _currentReport
                        .response!
                        .journey
                        .flightOption
                        .flightLegs
                        .first
                        .departureTime,
                  )
                : 'ID: ${_currentReport.bookingId}',
            Icons.calendar_today,
          ),
          _buildSummaryItem(
            'Currency',
            _currentReport.response?.currency ?? 'INR',
            Icons.currency_rupee,
          ),
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
              color: secondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 16, color: secondaryColor),
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
                    color: textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
        color: cardColor,
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
                  color: secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.flight_takeoff,
                  color: secondaryColor,
                  size: 16,
                ),
              ),
              SizedBox(width: 12),
              Text(
                'FLIGHT DETAILS',
                style: TextStyle(
                  fontSize: 13,
                  color: textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${flightLegs.length}',
                  style: TextStyle(
                    fontSize: 14,
                    color: secondaryColor,
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
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Icon(Icons.flight, size: 40, color: textLight),
                  SizedBox(height: 8),
                  Text(
                    'No flight details available',
                    style: TextStyle(
                      color: textSecondary,
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
        color: backgroundColor,
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
                        color: textSecondary,
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
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 12,
                          color: secondaryColor,
                        ),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            _formatDateTime(leg.departureTime),
                            style: TextStyle(
                              fontSize: 11,
                              color: textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
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
                        color: secondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: secondaryColor.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: secondaryColor,
                        size: 15,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 2,
                      height: 40,
                      color: secondaryColor.withOpacity(0.3),
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
                        color: textSecondary,
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
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 12,
                          color: secondaryColor,
                        ),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            _formatDateTime(leg.arrivalTime),
                            style: TextStyle(
                              fontSize: 11,
                              color: textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
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
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFlightInfoItem(
                  'Airline',
                  leg.airlineCode,
                  Icons.airlines,
                ),
                _buildFlightInfoItem('Flight', leg.flightNo, Icons.flight),
                _buildFlightInfoItem(
                  'PNR',
                  leg.airlinePNR,
                  Icons.confirmation_number,
                ),
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
        Icon(icon, size: 16, color: secondaryColor),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            color: textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _buildPassengerDetailsCard(ResponseData response) {
    final passengers = response.passengers;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
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
                  color: secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.people_rounded,
                  color: secondaryColor,
                  size: 16,
                ),
              ),
              SizedBox(width: 12),
              Text(
                'PASSENGER INFORMATION',
                style: TextStyle(
                  fontSize: 13,
                  color: textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${passengers.length}',
                  style: TextStyle(
                    fontSize: 14,
                    color: secondaryColor,
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
                color: backgroundColor,
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
                          color: secondaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: secondaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          passenger.paxType,
                          style: TextStyle(
                            fontSize: 12,
                            color: secondaryColor,
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
                  _buildPassengerDetailRow(
                    'Date of Birth',
                    _formatDate(passenger.dob),
                  ),
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
                color: textSecondary,
                fontSize: 13,
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
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
        final passengerName =
            '${passenger.title} ${passenger.firstName} ${passenger.lastName}';

        // Baggage charges
        if (ssr.baggageInfo != null) {
          for (final baggageInfo in ssr.baggageInfo!) {
            if (baggageInfo.baggages != null) {
              for (final baggage in baggageInfo.baggages!) {
                if (baggage.amount != null && baggage.amount! > 0) {
                  additionalChargesList.add(
                    AdditionalCharge(
                      'Extra Baggage - $passengerName',
                      baggage.amount!,
                    ),
                  );
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
                  additionalChargesList.add(
                    AdditionalCharge(
                      'Meal - ${meal.name} - $passengerName',
                      meal.amount!,
                    ),
                  );
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
                    additionalChargesList.add(
                      AdditionalCharge(
                        'Seat Selection - $passengerName',
                        seatFare,
                      ),
                    );
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
        color: cardColor,
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
                  color: secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.currency_rupee_rounded,
                  color: secondaryColor,
                  size: 16,
                ),
              ),
              SizedBox(width: 12),
              Text(
                'FARE BREAKDOWN',
                style: TextStyle(
                  fontSize: 13,
                  color: textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),

          // Base Fare and Taxes
          ...firstFare.fares.expand(
            (fare) => [
              _buildFareItem(
                '${_getPassengerTypeName(fare.ptc)} Base Fare',
                '₹${fare.baseFare.toStringAsFixed(2)}',
              ),
              _buildFareItem(
                '${_getPassengerTypeName(fare.ptc)} Tax',
                '₹${fare.tax.toStringAsFixed(2)}',
              ),
              // if (fare.discount > 0)
              //   _buildFareItem('${_getPassengerTypeName(fare.ptc)} Discount', '-₹${fare.discount.toStringAsFixed(2)}'),
            ],
          ),

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
                  color: maincolor1,
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
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildSummaryRow('Total Base Fare', totalBaseFare),
                _buildSummaryRow('Total Taxes', totalTax),

                if (totalAdditionalCharges > 0)
                  _buildSummaryRow(
                    'Additional Services',
                    totalAdditionalCharges,
                  ),

                if (totalDiscount > 0)
                  _buildSummaryRow(
                    'Discount',
                    -totalDiscount,
                    isDiscount: true,
                  ),

                Divider(height: 16, color: Colors.grey.shade400),

                _buildSummaryRow(
                  'Amount',
                  double.tryParse(_currentReport.amount) ?? 0,
                ),
                _buildSummaryRow(
                  'Service Charge',
                  double.tryParse(_currentReport.commission) ?? 0,
                  isCommission: true,
                ),

                Divider(height: 16, color: Colors.grey.shade400),

                _buildSummaryRow(
                  'Total Amount',
                  double.tryParse(_currentReport.totalAmount) ?? 0,
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
              color: isTotal ? textPrimary : textSecondary,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 14,
              color: isTotal ? secondaryColor : textPrimary,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalChargeRow(
    String label,
    double amount, {
    required int index,
  }) {
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
                    color: secondaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      index.toString(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: secondaryColor,
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
                      color: textPrimary,
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
              color: textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    double amount, {
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
              color: isDiscount
                  ? successColor
                  : (isCommission
                        ? secondaryColor
                        : (isTotal ? maincolor1 : textPrimary)),
            ),
          ),
          Text(
            '${isNegative ? '-' : ''}₹${displayAmount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600,
              color: isDiscount
                  ? successColor
                  : (isCommission
                        ? secondaryColor
                        : (isTotal ? secondaryColor : textPrimary)),
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

  bool _shouldShowCancelButton(ResponseData response) {
    log(_currentReport.bookingStatus.toUpperCase());
    log(_currentReport.cancel!.status.toString().toUpperCase());
    // Don't show if already cancelled or pending cancel
    if (_currentReport.bookingStatus.toUpperCase() == 'CANCELLED' ||
        _currentReport.cancel?.status.toUpperCase() == 'CANCELLED' ||
        _currentReport.cancel?.status.toUpperCase() == 'PENDING') {
      return false;
    }

    if (response.journey.flightOption.flightLegs.isEmpty) return false;
    try {
      log(response.journey.flightOption.flightLegs.first.departureTime);
      final firstLeg = response.journey.flightOption.flightLegs.first;
      final departureTime = DateTime.parse(firstLeg.departureTime);
      // Show button if travel is in the future
      return departureTime.isAfter(DateTime.now());
    } catch (e) {
      return false;
    }
  }

  void _showCancelReasonDialog(BuildContext context) {
    final TextEditingController reasonController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Iconsax.info_circle, color: errorColor),
            SizedBox(width: 10),
            Text('Cancel Booking'),
          ],
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Please provide a reason for cancelling this booking.',
                style: TextStyle(fontSize: 14, color: textSecondary),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: reasonController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter cancellation reason...',
                  hintStyle: TextStyle(fontSize: 13, color: textLight),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: secondaryColor, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a reason';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(color: textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(context);
                _handleCancelRequest(reasonController.text.trim());
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: errorColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Confirm Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancellationCard() {
    final cancel = _currentReport.cancel!;
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: errorColor.withOpacity(0.3)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: errorColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Iconsax.info_circle, color: errorColor, size: 16),
              ),
              const SizedBox(width: 12),
              const Text(
                'CANCELLATION INFORMATION',
                style: TextStyle(
                  color: textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSummaryItem(
            'Cancel Status',
            cancel.status,
            Iconsax.close_circle,
          ),
          if (cancel.reason != null && cancel.reason!.isNotEmpty)
            _buildSummaryItem('Reason', cancel.reason!, Iconsax.note),
        ],
      ),
    );
  }

  Widget _buildRefundCard() {
    final refund = _currentReport.refund!;
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: successColor.withOpacity(0.3)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: successColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Iconsax.money_tick, color: successColor, size: 16),
              ),
              const SizedBox(width: 12),
              const Text(
                'REFUND INFORMATION',
                style: TextStyle(
                  color: textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSummaryItem('Refund Status', refund.status, Iconsax.verify),
          _buildSummaryItem(
            'Refunded Amount',
            '₹${refund.refundedAmount.toStringAsFixed(2)}',
            Iconsax.wallet_2,
          ),
          if (refund.refundId != null)
            _buildSummaryItem('Refund ID', refund.refundId!, Iconsax.code),
          if (refund.refundedAt != null)
            _buildSummaryItem(
              'Refunded Date',
              _formatDate(refund.refundedAt!),
              Iconsax.calendar,
            ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'CONFIRMED':
        return successColor;
      case 'CANCELLED':
        return errorColor;
      case 'PENDING':
        return const Color(0xFFD97706);
      default:
        return secondaryColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toUpperCase()) {
      case 'CONFIRMED':
        return Iconsax.tick_circle;
      case 'CANCELLED':
        return Iconsax.close_circle;
      case 'PENDING':
        return Iconsax.timer_1;
      default:
        return Iconsax.info_circle;
    }
  }

  Future<void> _handleCancelRequest(String reason) async {
    setState(() {
      _isCancelling = true;
    });

    try {
      final result = await _apiService.cancelFlightBooking(
        bookingId: _currentReport.bookingId,
        cancelReason: reason,
      );

      if (mounted) {
        if (result['status'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message'] ?? 'Cancellation request sent'),
              backgroundColor: successColor,
            ),
          );
          // Optional: You might want to refresh the report data here or pop back
          // Navigator.pop(context, true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                result['message'] ?? 'Failed to send cancellation request',
              ),
              backgroundColor: errorColor,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred. Please try again later.'),
            backgroundColor: errorColor,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isCancelling = false;
        });
      }
    }
  }
}
