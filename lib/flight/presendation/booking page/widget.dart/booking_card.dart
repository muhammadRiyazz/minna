import 'package:minna/comman/const/const.dart';
import 'package:minna/flight/domain/fare%20request%20and%20respo/fare_respo.dart';
import 'package:minna/flight/presendation/booking%20page/widget.dart/flightLeg.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FlightbookingCard extends StatelessWidget {
  final FFlightOption flightOption;

  const FlightbookingCard({super.key, required this.flightOption});

  @override
  Widget build(BuildContext context) {
    // Theme colors
    final Color _primaryColor = Colors.black;
    final Color _secondaryColor = Color(0xFFD4AF37);
    final Color _backgroundColor = Color(0xFFF8F9FA);
    final Color _cardColor = Colors.white;
    final Color _textPrimary = Colors.black;
    final Color _textSecondary = Color(0xFF666666);
    final Color _textLight = Color(0xFF999999);

    // Safely get onward and return legs with null checks
    final onwardLegs = flightOption.flightOnwardLegs ?? [];
    final returnLegs = flightOption.flightRetunLegs ?? [];

    // Helper function to parse date safely
    DateTime safeParseDate(String? dateString, {DateTime? fallback}) {
      try {
        return dateString != null
            ? DateTime.parse(dateString)
            : (fallback ?? DateTime.now());
      } catch (e) {
        return fallback ?? DateTime.now();
      }
    }

    // Calculate times and durations for onward journey
    DateTime? onwardDepartureTime;
    DateTime? onwardArrivalTime;
    Duration? onwardDuration;
    int onwardStops = 0;

    if (onwardLegs.isNotEmpty) {
      final firstOnwardLeg = onwardLegs.first;
      final lastOnwardLeg = onwardLegs.last;

      onwardDepartureTime = safeParseDate(firstOnwardLeg.departureTime);
      onwardArrivalTime = safeParseDate(lastOnwardLeg.arrivalTime);
      onwardDuration = onwardArrivalTime.difference(onwardDepartureTime);
      onwardStops = onwardLegs.length - 1;
    }

    // Calculate times and durations for return journey
    DateTime? returnDepartureTime;
    DateTime? returnArrivalTime;
    Duration? returnDuration;
    int returnStops = 0;

    if (returnLegs.isNotEmpty) {
      final firstReturnLeg = returnLegs.first;
      final lastReturnLeg = returnLegs.last;

      returnDepartureTime = safeParseDate(firstReturnLeg.departureTime);
      returnArrivalTime = safeParseDate(lastReturnLeg.arrivalTime);
      returnDuration = returnArrivalTime.difference(returnDepartureTime);
      returnStops = returnLegs.length - 1;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
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
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              // color: _secondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
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
                    Icons.flight_takeoff_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  'Flight Details',
                  style: TextStyle(
                    
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // Airline header
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _secondaryColor.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      // Airline Logo
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                      
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            flightOption.flightimg ?? "",
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              color: _backgroundColor,
                              child: Icon(
                                Icons.airlines_rounded,
                                color: _secondaryColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      // Airline Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              flightOption.flightName ?? 'Airline',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: _primaryColor,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              flightOption.ticketingCarrier ?? 'Flight Carrier',
                              style: TextStyle(
                                fontSize: 12,
                                color: _textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Flight Type Badge
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _secondaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _secondaryColor.withOpacity(0.3)),
                        ),
                        child: Text(
                          returnLegs.isNotEmpty ? 'Round Trip' : 'One Way',
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            color: _secondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // Onward Journey Section
                if (onwardLegs.isNotEmpty &&
                    onwardDepartureTime != null &&
                    onwardArrivalTime != null)
                  _buildJourneySection(
                    title: 'Onward Journey',
                    firstLeg: onwardLegs.first,
                    lastLeg: onwardLegs.last,
                    departureTime: onwardDepartureTime,
                    arrivalTime: onwardArrivalTime,
                    duration: onwardDuration!,
                    stops: onwardStops,
                    primaryColor: _primaryColor,
                    secondaryColor: _secondaryColor,
                    textSecondary: _textSecondary,
                  ),

                // Return Journey Section
                if (returnLegs.isNotEmpty &&
                    returnDepartureTime != null &&
                    returnArrivalTime != null) ...[
                  SizedBox(height: 16),
                  _buildJourneySection(
                    title: 'Return Journey',
                    firstLeg: returnLegs.first,
                    lastLeg: returnLegs.last,
                    departureTime: returnDepartureTime,
                    arrivalTime: returnArrivalTime,
                    duration: returnDuration!,
                    stops: returnStops,
                    primaryColor: _primaryColor,
                    secondaryColor: _secondaryColor,
                    textSecondary: _textSecondary,
                  ),
                ],

                SizedBox(height: 16),

                // Flight Legs Expansion
                if (onwardLegs.isNotEmpty || returnLegs.isNotEmpty)
                  Container(
                    decoration: BoxDecoration(
                      color: _backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: ExpansionTile(
                      collapsedIconColor: _secondaryColor,
                      iconColor: _secondaryColor,
                      tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      title: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: _secondaryColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.list_alt_rounded,
                              size: 16,
                              color: _secondaryColor,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Detailed Flight Legs',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: _primaryColor,
                            ),
                          ),
                        ],
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            children: [
                              // Onward Legs
                              if (onwardLegs.isNotEmpty) ...[
                                _buildLegsSection(
                                  title: 'Onward Journey Legs',
                                  legs: onwardLegs,
                                  primaryColor: _primaryColor,
                                  secondaryColor: _secondaryColor,
                                  textSecondary: _textSecondary,
                                ),
                                if (returnLegs.isNotEmpty) SizedBox(height: 20),
                              ],
                              // Return Legs
                              if (returnLegs.isNotEmpty)
                                _buildLegsSection(
                                  title: 'Return Journey Legs',
                                  legs: returnLegs,
                                  primaryColor: _primaryColor,
                                  secondaryColor: _secondaryColor,
                                  textSecondary: _textSecondary,
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
        ],
      ),
    );
  }

  Widget _buildJourneySection({
    required String title,
    required FFlightLeg firstLeg,
    required FFlightLeg lastLeg,
    required DateTime departureTime,
    required DateTime arrivalTime,
    required Duration duration,
    required int stops,
    required Color primaryColor,
    required Color secondaryColor,
    required Color textSecondary,
  }) {
    return Container(
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.flight_rounded,
                  size: 14,
                  color: secondaryColor,
                ),
              ),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              if (stops > 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$stops ${stops == 1 ? 'stop' : 'stops'}',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: secondaryColor,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16),
          
          // Flight route and timing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Departure
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('HH:mm').format(departureTime),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      firstLeg.origin ?? '--',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      firstLeg.originName ?? '--',
                      style: TextStyle(
                        fontSize: 12,
                        color: textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              // Duration and stops
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '${duration.inHours}h ${duration.inMinutes.remainder(60)}m',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: secondaryColor,
                      ),
                    ),
                    SizedBox(height: 8),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        DottedLine(
                          dashLength: 4,
                          dashGapLength: 4,
                          lineThickness: 2,
                          dashColor: secondaryColor.withOpacity(0.5),
                        ),
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.flight_rounded,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    if (stops > 0)
                      Text(
                        '$stops ${stops == 1 ? 'stop' : 'stops'}',
                        style: TextStyle(
                          fontSize: 10,
                          color: textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
              
              // Arrival
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat('HH:mm').format(arrivalTime),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      lastLeg.destination ?? '--',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      lastLeg.destinationName ?? '--',
                      style: TextStyle(
                        fontSize: 12,
                        color: textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: 8),
          
          // Date
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: secondaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  size: 12,
                  color: secondaryColor,
                ),
                SizedBox(width: 6),
                Text(
                  DateFormat('MMM dd, yyyy').format(departureTime),
                  style: TextStyle(
                    fontSize: 12,
                    color: textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegsSection({
    required String title,
    required List<FFlightLeg> legs,
    required Color primaryColor,
    required Color secondaryColor,
    required Color textSecondary,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        SizedBox(height: 12),
        ...legs.asMap().entries.map((entry) {
          final index = entry.key;
          final leg = entry.value;
          final isLast = index == legs.length - 1;
          
          return Column(
            children: [
              _buildLegDetailCard(
                leg: leg,
                primaryColor: primaryColor,
                secondaryColor: secondaryColor,
                textSecondary: textSecondary,
              ),
              if (!isLast) _buildLayoverInfo(leg, legs[index + 1], secondaryColor, textSecondary),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget _buildLegDetailCard({
    required FFlightLeg leg,
    required Color primaryColor,
    required Color secondaryColor,
    required Color textSecondary,
  }) {
    final departureTime = leg.departureTime != null
        ? DateTime.parse(leg.departureTime!)
        : DateTime.now();
    final arrivalTime = leg.arrivalTime != null
        ? DateTime.parse(leg.arrivalTime!)
        : DateTime.now();
    final duration = arrivalTime.difference(departureTime);

    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
       
      ),
      child: Column(
        children: [
          // Flight header
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color:Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    
                    flightOption.flightimg ?? "",
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.airlines_rounded, size: 16, color: secondaryColor),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    leg.flightName ?? '--',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    '${leg.airlineCode} ${leg.flightNo}',
                    style: TextStyle(
                      fontSize: 12,
                      color: textSecondary,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${duration.inHours}h ${duration.inMinutes.remainder(60)}m',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: secondaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          
          // Flight route
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Departure
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('HH:mm').format(departureTime),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      leg.origin ?? '--',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Terminal ${leg.departureTerminal ?? '-'}',
                      style: TextStyle(
                        fontSize: 11,
                        color: textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Flight icon
              Expanded(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.flight_rounded,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              
              // Arrival
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat('HH:mm').format(arrivalTime),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      leg.destination ?? '--',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Terminal ${leg.arrivalTerminal ?? '-'}',
                      style: TextStyle(
                        fontSize: 11,
                        color: textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: 8),
          
          // Airport names
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  leg.originName ?? '--',
                  style: TextStyle(
                    fontSize: 12,
                    color: textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                child: Text(
                  leg.destinationName ?? '--',
                  style: TextStyle(
                    fontSize: 12,
                    color: textSecondary,
                  ),
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLayoverInfo(FFlightLeg currentLeg, FFlightLeg nextLeg, Color secondaryColor, Color textSecondary) {
    final currentArrival = DateTime.parse(currentLeg.arrivalTime!);
    final nextDeparture = DateTime.parse(nextLeg.departureTime!);
    final layoverDuration = nextDeparture.difference(currentArrival);
    final hours = layoverDuration.inHours;
    final minutes = layoverDuration.inMinutes.remainder(60);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: secondaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: secondaryColor.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.schedule_rounded,
            size: 14,
            color: secondaryColor,
          ),
          SizedBox(width: 8),
          Text(
            'Layover: ${hours}h ${minutes}m at ${currentLeg.destinationName}',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}