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
      appBar: AppBar(
        backgroundColor: maincolor1,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Flight Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Iconsax.arrow_left, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPremiumHeader(report),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildSummaryCard(),
                  const SizedBox(height: 16),
                  _buildFlightDetailsCard(response),
                  const SizedBox(height: 16),
                  _buildPassengerDetailsCard(response),
                  const SizedBox(height: 16),
                  _buildFareBreakdownCard(response),
                  const SizedBox(height: 16),
                  if (report.cancel != null && report.cancel!.status != 'NONE')
                    _buildCancellationCard(),
                  if (report.refund != null &&
                      report.refund!.status != 'NOT_REFUNDED')
                    _buildRefundCard(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
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

  Widget _buildPremiumHeader(ReportData report) {
    final statusColor = _getStatusColor(report.bookingStatus);
    final statusIcon = _getStatusIcon(report.bookingStatus);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: maincolor1,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Iconsax.airplane, size: 40, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Text(
            report.pnr ?? 'ID: ${report.bookingId}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: statusColor.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  statusIcon,
                  size: 14,
                  color: statusColor == Colors.green
                      ? Colors.greenAccent
                      : statusColor,
                ),
                const SizedBox(width: 8),
                Text(
                  report.bookingStatus.toUpperCase(),
                  style: TextStyle(
                    color: statusColor == Colors.green
                        ? Colors.greenAccent
                        : statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderSoft),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'BOOKING SUMMARY',
            style: TextStyle(
              color: textLight,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 20),
          _buildSummaryItem(
            'Trip Type',
            (_currentReport.response?.tripMode ?? '') == 'O'
                ? 'One Way'
                : 'Round Trip',
            Iconsax.airplane5,
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
            Iconsax.calendar_1,
          ),
          _buildSummaryItem(
            'Currency',
            _currentReport.response?.currency ?? 'INR',
            Iconsax.money_send,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: maincolor1.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: maincolor1),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: maincolor1,
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
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        // border: Border.all(color: borderSoft),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
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
                  color: secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Iconsax.airplane, color: secondaryColor, size: 18),
              ),
              const SizedBox(width: 12),
              const Text(
                'FLIGHT DETAILS',
                style: TextStyle(
                  fontSize: 11,
                  color: textLight,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${flightLegs.length} Leg(s)',
                  style: TextStyle(
                    fontSize: 12,
                    color: maincolor1,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          if (flightLegs.isEmpty)
            _buildEmptyDetails('No flight details available')
          else
            ...flightLegs.map((leg) => _buildFlightLeg(leg)),
        ],
      ),
    );
  }

  Widget _buildEmptyDetails(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(
            Iconsax.info_circle,
            size: 40,
            color: textLight.withOpacity(0.5),
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: TextStyle(
              color: textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
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
                        fontSize: 15,
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
                        fontSize: 15,
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
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderSoft),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Iconsax.user, color: secondaryColor, size: 18),
              ),
              const SizedBox(width: 12),
              const Text(
                'PASSENGER INFORMATION',
                style: TextStyle(
                  fontSize: 11,
                  color: textLight,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              const Spacer(),
              Text(
                '${passengers.length} Total',
                style: TextStyle(
                  fontSize: 12,
                  color: maincolor1,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ...passengers.asMap().entries.map((entry) {
            final index = entry.key;
            final passenger = entry.value;
            return Container(
              margin: EdgeInsets.only(
                bottom: index == passengers.length - 1 ? 0 : 16,
              ),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(20),
                // border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: maincolor1.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          (index + 1).toString().padLeft(2, '0'),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: maincolor1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '${passenger.title} ${passenger.firstName} ${passenger.lastName}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: maincolor1,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
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
                            fontSize: 10,
                            color: secondaryColor,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
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
    if (value == null || value.isEmpty || value == 'null')
      return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: textSecondary.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFareBreakdownCard(ResponseData response) {
    final flightFares = response.journey.flightOption.flightFares;

    if (flightFares.isEmpty) return const SizedBox.shrink();

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
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderSoft),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Iconsax.receipt_2, color: secondaryColor, size: 18),
              ),
              const SizedBox(width: 12),
              const Text(
                'FARE BREAKDOWN',
                style: TextStyle(
                  fontSize: 11,
                  color: textLight,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

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
            ],
          ),

          // Additional Services Section
          if (additionalChargesList.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 16),
            const Text(
              'Additional Services',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: maincolor1,
              ),
            ),
            const SizedBox(height: 12),
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

          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade100),
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
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(height: 1),
                ),
                _buildSummaryRow(
                  'Amount',
                  double.tryParse(_currentReport.amount) ?? 0,
                ),
                _buildSummaryRow(
                  'Service Charge',
                  double.tryParse(_currentReport.commission) ?? 0,
                  isCommission: true,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(height: 1, thickness: 1),
                ),
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
        _currentReport.cancel?.status.toUpperCase() == 'PENDING' ||
        _currentReport.cancel?.status.toUpperCase() == 'REQUESTED') {
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

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 30,
                offset: const Offset(0, -12),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                // Drag Handle
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: textLight.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 12),

                // Premium Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: errorColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Iconsax.info_circle,
                          color: errorColor,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cancel Booking',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.5,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Provide a reason for cancellation',
                              style: TextStyle(
                                fontSize: 13,
                                color: textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.close_rounded,
                          color: textSecondary,
                          size: 20,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: backgroundColor,
                          padding: const EdgeInsets.all(8),
                        ),
                      ),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Divider(height: 1),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'CANCELLATION REASON',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: textLight,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: reasonController,
                          maxLines: 4,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter reason here...',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: textLight,
                              fontWeight: FontWeight.w400,
                            ),
                            filled: true,
                            fillColor: backgroundColor,
                            contentPadding: const EdgeInsets.all(20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: errorColor.withOpacity(0.5),
                                width: 1.5,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a valid reason';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: warningColor.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: warningColor.withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Iconsax.warning_2,
                                color: warningColor,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Text(
                                  'Warning: This action is irreversible. Refund is subject to airline policy.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF92400E),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                Navigator.pop(context);
                                _handleCancelRequest(
                                  reasonController.text.trim(),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: errorColor,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'Confirm Cancellation',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
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
          ),
        ),
      ),
    );
  }

  Widget _buildCancellationCard() {
    final cancel = _currentReport.cancel!;
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: errorColor.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
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
                child: const Icon(
                  Iconsax.info_circle,
                  color: errorColor,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'CANCELLATION INFORMATION',
                style: TextStyle(
                  fontSize: 11,
                  color: textLight,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildDetailRow(
            'Status',
            cancel.status,
            Iconsax.info_circle,
            color: errorColor,
          ),
          if (cancel.reason != null && cancel.reason!.isNotEmpty)
            _buildDetailRow(
              'Reason',
              cancel.reason!,
              Iconsax.note,
              color: textSecondary,
            ),
        ],
      ),
    );
  }

  Widget _buildRefundCard() {
    final refund = _currentReport.refund!;
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: successColor.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
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
                child: const Icon(
                  Iconsax.wallet_money,
                  color: successColor,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'REFUND INFORMATION',
                style: TextStyle(
                  fontSize: 11,
                  color: textLight,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildDetailRow(
            'Refund Status',
            refund.status,
            Iconsax.info_circle,
            color: successColor,
          ),
          _buildDetailRow(
            'Amount',
            '₹${refund.refundedAmount}',
            Iconsax.money_3,
            color: successColor,
          ),
          if (refund.reason != null && refund.reason!.isNotEmpty)
            _buildDetailRow(
              'Note',
              refund.reason!,
              Iconsax.note,
              color: textSecondary,
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

  Widget _buildDetailRow(
    String label,
    String value,
    IconData icon, {
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color ?? textSecondary),
          const SizedBox(width: 12),
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 12,
              color: textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: color ?? textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: errorColor),
    );
  }
}
