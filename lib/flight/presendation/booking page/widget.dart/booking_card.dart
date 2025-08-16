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

              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Text(
                'Flight Details',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              children: [
                // Airline header with price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 45,
                            height: 40,
                            decoration: BoxDecoration(),
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  fit: BoxFit.fill,
                                  flightOption.flightimg ?? "",
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(color: Colors.grey[200]),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Airline Name
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  flightOption.flightName ?? '---',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  flightOption.ticketingCarrier ?? '---',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black54,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: DottedLine(dashColor: Colors.grey.shade400),
                ),

                // Onward Journey Section (only if we have onward legs)
                if (onwardLegs.isNotEmpty &&
                    onwardDepartureTime != null &&
                    onwardArrivalTime != null)
                  buildFlightLegSection(
                    firstLeg: onwardLegs.first,
                    lastLeg: onwardLegs.last,
                    departureTime: onwardDepartureTime,
                    arrivalTime: onwardArrivalTime,
                    duration: onwardDuration!,
                    stops: onwardStops,
                  ),

                // Return Journey Section (if exists)
                if (returnLegs.isNotEmpty &&
                    returnDepartureTime != null &&
                    returnArrivalTime != null) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: DottedLine(
                      direction: Axis.horizontal,
                      lineLength: double.infinity,
                      lineThickness: 1.0,
                      dashLength: 4.0,
                      dashColor: Colors.grey,
                      dashGapLength: 4.0,
                    ),
                  ),
                  buildFlightLegSection(
                    firstLeg: returnLegs.first,
                    lastLeg: returnLegs.last,
                    departureTime: returnDepartureTime,
                    arrivalTime: returnArrivalTime,
                    duration: returnDuration!,
                    stops: returnStops,
                  ),
                ],
                SizedBox(height: 10),

                // Flight legs expansion tile
                if (onwardLegs.isNotEmpty || returnLegs.isNotEmpty)
                  ExpansionTile(
                    collapsedBackgroundColor: Colors.blue.shade50,
                    iconColor: maincolor1,
                    tilePadding: EdgeInsets.symmetric(horizontal: 10),
                    title: Text(
                      'Flight Legs',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: maincolor1,
                      ),
                    ),
                    children: [
                      // Onward legs
                      if (onwardLegs.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ' Onward Journey',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                              SizedBox(height: 8),
                              ..._buildLegsDetails(onwardLegs),
                            ],
                          ),
                        ),
                      ],

                      if (returnLegs.isNotEmpty) ...[
                        SizedBox(height: 16),
                        // Return legs
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Return Journey',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                              SizedBox(height: 8),
                              ..._buildLegsDetails(returnLegs),
                            ],
                          ),
                        ),
                      ],
                      SizedBox(height: 8),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildLegsDetails(List<FFlightLeg> legs) {
    List<Widget> widgets = [];

    for (int i = 0; i < legs.length; i++) {
      final leg = legs[i];
      widgets.add(_buildLegDetail(leg));

      // Add layover information if not the last leg
      if (i < legs.length - 1) {
        final currentArrival = DateTime.parse(legs[i].arrivalTime!);
        final nextDeparture = DateTime.parse(legs[i + 1].departureTime!);
        final layoverDuration = nextDeparture.difference(currentArrival);
        final hours = layoverDuration.inHours;
        final minutes = layoverDuration.inMinutes.remainder(60);

        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 238, 248, 255),
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    children: [
                      Text(
                        'Layover of ${hours}h ${minutes}m',
                        style: TextStyle(color: maincolor1, fontSize: 10),
                      ),
                      Text(
                        'At ${leg.destinationName}',
                        style: TextStyle(color: maincolor1, fontSize: 8),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }

    return widgets;
  }

  Widget _buildLegDetail(FFlightLeg leg) {
    final departureTime = leg.departureTime != null
        ? DateTime.parse(leg.departureTime!)
        : DateTime.now();
    final arrivalTime = leg.arrivalTime != null
        ? DateTime.parse(leg.arrivalTime!)
        : DateTime.now();
    final duration = arrivalTime.difference(departureTime);

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
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
          // Airline info
          Row(
            children: [
              Container(
                width: 45,
                height: 30,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 219, 245, 255),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(flightOption.flightimg ?? ""),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    leg.flightName ?? '--',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${leg.airlineCode} ${leg.flightNo}',
                    style: TextStyle(fontSize: 9, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Departure
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('HH:mm').format(departureTime),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    leg.origin ?? '',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // Flight duration and path
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '${duration.inHours}h ${duration.inMinutes.remainder(60)}m',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: maincolor1,
                          ),
                          padding: const EdgeInsets.all(6),
                          child: Icon(
                            Icons.flight,
                            size: 13,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Arrival
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    DateFormat('HH:mm').format(arrivalTime),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    leg.destination ?? '',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Terminal and date info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Terminal ${leg.departureTerminal ?? '-'}',
                    style: TextStyle(fontSize: 9, color: Colors.grey.shade600),
                  ),
                  Text(
                    leg.originName ?? '--',
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
                  ),
                  Text(
                    DateFormat('MMM dd, yyyy').format(departureTime),
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade900),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Terminal ${leg.arrivalTerminal ?? '-'}',
                    style: TextStyle(fontSize: 9, color: Colors.grey.shade600),
                  ),
                  Text(
                    leg.destinationName ?? '--',
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
                  ),
                  Text(
                    DateFormat('MMM dd, yyyy').format(arrivalTime),
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade900),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
