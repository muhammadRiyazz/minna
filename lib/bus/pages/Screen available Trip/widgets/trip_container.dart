import 'package:flutter/material.dart';
import 'package:minna/bus/domain/BlockTicket/block_ticket_request_modal.dart';
import 'package:minna/bus/domain/trips%20list%20modal/trip_list_modal.dart';
import 'package:minna/bus/pages/screen%20seats%20page/screen_seats_page.dart';
import 'package:minna/comman/const/const.dart';
import 'package:iconsax/iconsax.dart';

class TripCountainer extends StatelessWidget {
  const TripCountainer({
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

  @override
  Widget build(BuildContext context) {
    final trip = availableTriplist[index];

    final formattedPrice = startfare != null
        ? '₹${startfare!.round().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}'
        : '₹0';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.withOpacity(0.05), width: 1),
        boxShadow: [
          BoxShadow(
            color: maincolor1.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  // Top Row: Agency + Price
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBusIcon(),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              trip.travels.isNotEmpty
                                  ? trip.travels
                                  : 'Unknown Travels',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                color: maincolor1,
                                letterSpacing: -0.5,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: maincolor1.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                trip.busType.isNotEmpty
                                    ? trip.busType
                                    : 'Standard Bus',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: maincolor1.withOpacity(0.7),
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'STARTING AT',
                            style: TextStyle(
                              fontSize: 8,
                              color: textSecondary.withOpacity(0.6),
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            formattedPrice,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: secondaryColor,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Middle Section: Journey Path
                  _buildJourneyPath(trip),
                  const SizedBox(height: 20),

                  // Bottom Row: Seats + Action
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSeatsInfo(trip.availableSeats),
                      _buildViewSeatsButton(context, trip),
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

  Widget _buildBusIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            secondaryColor.withOpacity(0.1),
            secondaryColor.withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(Iconsax.bus, color: secondaryColor, size: 24),
    );
  }

  Widget _buildJourneyPath(AvailableTrip trip) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          _buildTimeNode("DEPART", departureTime, CrossAxisAlignment.start),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.timer_1,
                      size: 12,
                      color: maincolor1.withOpacity(0.5),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      trip.duration.isNotEmpty
                          ? convertTimeString(trip.duration)
                          : '0h 0m',
                      style: TextStyle(
                        fontSize: 11,
                        color: maincolor1.withOpacity(0.7),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 1.5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            maincolor1.withOpacity(0),
                            maincolor1.withOpacity(0.2),
                            maincolor1.withOpacity(0),
                          ],
                        ),
                      ),
                    ),
                    Icon(
                      Iconsax.record_circle,
                      size: 12,
                      color: secondaryColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildTimeNode("ARRIVE", arrivalTime, CrossAxisAlignment.end),
        ],
      ),
    );
  }

  Widget _buildTimeNode(
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
            fontSize: 9,
            color: textSecondary.withOpacity(0.5),
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: maincolor1,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSeatsInfo(String availableSeats) {
    final int seats = int.tryParse(availableSeats) ?? 0;
    Color statusColor;
    IconData statusIcon;
    if (seats > 10) {
      statusColor = const Color(0xFF2E7D32);
      statusIcon = Iconsax.status;
    } else if (seats > 0) {
      statusColor = const Color(0xFFEF6C00);
      statusIcon = Iconsax.info_circle;
    } else {
      statusColor = const Color(0xFFC62828);
      statusIcon = Iconsax.close_circle;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusIcon, color: statusColor, size: 14),
          const SizedBox(width: 6),
          Text(
            '$seats Seats Left',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewSeatsButton(BuildContext context, AvailableTrip trip) {
    return ElevatedButton(
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
        backgroundColor: maincolor1,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'VIEW SEATS',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Iconsax.arrow_right_3, size: 14, color: Colors.white),
        ],
      ),
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
