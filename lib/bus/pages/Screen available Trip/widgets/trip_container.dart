import 'package:flutter/material.dart';
import 'package:minna/bus/domain/BlockTicket/block_ticket_request_modal.dart';
import 'package:minna/bus/domain/trips list modal/trip_list_modal.dart';
import 'package:minna/bus/pages/screen seats page/screen_seats_page.dart';

class TripCountainer extends StatelessWidget {
   TripCountainer({
    super.key,
    required this.availableTriplist,
    required this.startfare,
    required this.index,
    required this.departureTime,
    required this.arrivalTime,
  });

  final List<AvailableTrip> availableTriplist;
  final double? startfare;
  final String departureTime;
  final String arrivalTime;
  final int index;

  // Color Theme
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37); // Gold
  final Color _accentColor = Color(0xFFC19B3C); // Darker Gold
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);

  @override
  Widget build(BuildContext context) {
    final trip = availableTriplist[index];
    final size = MediaQuery.of(context).size;

    final formattedPrice = startfare != null
        ? '₹${startfare!.round().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}'
        : '₹0';

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// Top Section: Logo + Bus Info + Price
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.directions_bus_rounded,
                    color: _secondaryColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trip.travels.isNotEmpty ? trip.travels : 'Travels Name',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: _textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        trip.busType.isNotEmpty ? trip.busType : 'A/C Sleeper',
                        style: TextStyle(
                          fontSize: 12,
                          color: _textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4),
                      // if (trip.rating.isNotEmpty)
                      //   Row(
                      //     children: [
                      //       Icon(
                      //         Icons.star_rounded,
                      //         color: _secondaryColor,
                      //         size: 14,
                      //       ),
                      //       SizedBox(width: 4),
                      //       Text(
                      //         trip.rating,
                      //         style: TextStyle(
                      //           fontSize: 12,
                      //           color: _textSecondary,
                      //           fontWeight: FontWeight.w500,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Starts from',
                      style: TextStyle(
                        fontSize: 10,
                        color: _textLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      formattedPrice,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _secondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// Middle Section: Departure - Duration - Arrival
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTimeBlock(
                    "Departure",
                    departureTime.isNotEmpty ? departureTime : '10:00 AM',
                    CrossAxisAlignment.start,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _secondaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            trip.duration.isNotEmpty
                                ? convertTimeString(trip.duration)
                                : '0h 0m',
                            style: TextStyle(
                              fontSize: 11,
                              color: _secondaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 1,
                              color: _textLight.withOpacity(0.3),
                              width: double.infinity,
                            ),
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: _cardColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _textLight.withOpacity(0.3),
                                ),
                              ),
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                size: 12,
                                color: _textLight,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  _buildTimeBlock(
                    "Arrival",
                    arrivalTime.isNotEmpty ? arrivalTime : '5:00 PM',
                    CrossAxisAlignment.end,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            /// Bottom Section: Seats Left + View Seats Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color:int.parse( trip.availableSeats) > 10
                        ? Color(0xFFE8F5E8)
                        :int.parse( trip.availableSeats)> 0
                            ? Color(0xFFFFF4E5)
                            : Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                       int.parse( trip.availableSeats) > 10
                            ? Icons.event_seat_rounded
                            : int.parse( trip.availableSeats) > 0
                                ? Icons.warning_amber_rounded
                                : Icons.error_outline_rounded,
                        color:int.parse( trip.availableSeats) > 10
                            ? Color(0xFF4CAF50)
                            : int.parse( trip.availableSeats) > 0
                                ? Color(0xFFFF9800)
                                : Color(0xFFF44336),
                        size: 14,
                      ),
                      SizedBox(width: 6),
                      Text(
                        '${trip.availableSeats} SEATS LEFT',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color:int.parse( trip.availableSeats) > 10
                              ? Color(0xFF4CAF50)
                              :int.parse( trip.availableSeats) > 0
                                  ? Color(0xFFFF9800)
                                  : Color(0xFFF44336),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View Seats',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward_rounded, size: 14),
                    ],
                  ),
                ),
              ],
            ),
          ],
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
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: _textLight,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          time,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _textPrimary,
          ),
        ),
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