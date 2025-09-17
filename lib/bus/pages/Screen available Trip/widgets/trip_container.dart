import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:minna/bus/domain/BlockTicket/block_ticket_request_modal.dart';
import 'package:minna/bus/domain/trips list modal/trip_list_modal.dart';
import 'package:minna/bus/pages/screen seats page/screen_seats_page.dart';
import 'package:minna/comman/const/const.dart';

class TripCountainer extends StatelessWidget {
  const TripCountainer({
    Key? key,
    required this.availableTriplist,
    required this.startfare,
    required this.index,
    required this.departureTime,
    required this.arrivalTime,
  }) : super(key: key);

  final List<AvailableTrip> availableTriplist;
  final double? startfare;
  final String departureTime;
  final String arrivalTime;
  final int index;

  @override
  Widget build(BuildContext context) {
    final trip = availableTriplist[index];
    final size = MediaQuery.of(context).size;

    final formattedPrice = startfare != null
        ? '₹${startfare!.round().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}'
        : '₹0';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),

          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              /// Top Section: Logo + Bus Info + Price
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: maincolor1,
                    child: Icon(
                      Icons.directions_bus_outlined,
                      size: 17,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trip.travels.isNotEmpty
                              ? trip.travels
                              : 'Travels Name',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          trip.busType.isNotEmpty
                              ? trip.busType
                              : 'A/C Sleeper',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Start From',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      Text(
                        formattedPrice,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: maincolor1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Divider(thickness: 0.5),

              /// Middle Section: Departure - Duration - Arrival
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTimeBlock(
                      "Pickup",
                      departureTime.isNotEmpty ? departureTime : '10:00 AM',
                      CrossAxisAlignment.start,
                    ),
                    Column(
                      children: [
                        Text(
                          trip.duration.isNotEmpty
                              ? convertTimeString(trip.duration)
                              : '0h 0m',
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 1,
                              color: const Color.fromARGB(255, 187, 187, 187),
                              width: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              child: Icon(
                                Icons.directions_bus_outlined,
                                size: 12,
                                color: const Color.fromARGB(255, 187, 187, 187),
                              ),
                            ),
                            Container(
                              height: 1,
                              color: const Color.fromARGB(255, 187, 187, 187),
                              width: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                    _buildTimeBlock(
                      "Drop",
                      arrivalTime.isNotEmpty ? arrivalTime : '5:00 PM',
                      CrossAxisAlignment.end,
                    ),
                  ],
                ),
              ),

              Divider(thickness: 0.5),

              /// Bottom Section: Seats Left + View Seats Button
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${trip.availableSeats} SEATS LEFT',
                      style: TextStyle(
                        color: maincolor1,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScreenSeateLayout(
                              boardingTimeList: trip.boardingTimes,
                              dropingTimeList: trip.droppingTimes,
                              alldata: BlockTicketRequest(
                                callFareBreakUpAPI: trip.callFareBreakUpApi,
                                availableTripID: trip.id,
                              ),
                              travelsname: trip.travels,
                              trpinfo: trip.busType,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: maincolor1,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: Text(
                          'View Seats',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeBlock(
    String label,
    String time,
    CrossAxisAlignment alignment,
  ) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
        const SizedBox(height: 4),
        Text(time, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      ],
    );
  }

  String convertTimeString(String timeString) {
    try {
      timeString = timeString.replaceAll(" hrs", "");
      List<String> parts = timeString.split(":");
      if (parts.length != 2) return timeString;

      int hours = int.tryParse(parts[0]) ?? 0;
      int minutes = int.tryParse(parts[1]) ?? 0;

      return "${hours}h ${minutes}m";
    } catch (e) {
      return timeString;
    }
  }
}
