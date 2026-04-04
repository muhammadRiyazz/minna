import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minna/bus/infrastructure/time.dart';
import 'package:minna/bus/pages/screen%20passengers%20input/screen_passengers_input.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/bus/domain/seatlayout/seatlayoutmodal.dart';
import 'package:minna/bus/domain/trips%20list%20modal/trip_list_modal.dart';
import 'package:minna/bus/domain/BlockTicket/block_ticket_request_modal.dart';

class ScreenBdDpDetails extends StatefulWidget {
  const ScreenBdDpDetails({
    super.key,
    required this.selectedSeats,
    required this.alldata,
    required this.travelsname,
    required this.dropingTimeList,
    required this.boardingTimeList,
    required this.trpinfo,
  });

  final BlockTicketRequest alldata;
  final String trpinfo;
  final String travelsname;
  final List<Seat> selectedSeats;
  final List<BoardingPoint> boardingTimeList;
  final List<BoardingPoint> dropingTimeList;

  @override
  State<ScreenBdDpDetails> createState() => _ScreenBdDpDetailsState();
}

class _ScreenBdDpDetailsState extends State<ScreenBdDpDetails> {
  String? boardingpoint;
  String? droppingpoint;
  String? boardingpointname;
  String? droppingpointname;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: maincolor1,
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Iconsax.arrow_left_2, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Boarding & Dropping',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${widget.selectedSeats.length} ${widget.selectedSeats.length == 1 ? 'Seat' : 'Seats'} • ${widget.travelsname}',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            // Standard Premium Header
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: maincolor1,
                // borderRadius: const BorderRadius.only(
                //   bottomLeft: Radius.circular(24),
                //   bottomRight: Radius.circular(24),
                // ),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black.withOpacity(0.1),
                //     blurRadius: 10,
                //     offset: const Offset(0, 4),
                //   ),
                //  ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),

                  // Tab Selection Area - Simple and Clean
                  Container(
                    // margin: const EdgeInsets.symmetric(
                    //   horizontal: 16,
                    //   vertical: 8,
                    // ),
                    decoration: BoxDecoration(
                      // color: Colors.white.withOpacity(0.08),
                      // borderRadius: BorderRadius.circular(12),
                    ),
                    child: TabBar(
                      labelColor: secondaryColor,
                      unselectedLabelColor: Colors.white.withOpacity(0.5),
                      indicatorColor: secondaryColor,
                      indicatorWeight: 3,
                      dividerColor: Colors.transparent,
                      labelPadding: const EdgeInsets.symmetric(vertical: 0),
                      labelStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      tabs: const [
                        Tab(text: 'BOARDING'),
                        Tab(text: 'DROPPING'),
                      ],
                    ),
                  ),
                  // const SizedBox(height: 12),

                  // Current Selection Summaries - Horizontal Flow
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  //   child: Row(
                  //     children: [
                  //       _buildHeaderSelectionSummary(
                  //         'Boarding',
                  //         boardingpointname,
                  //         Iconsax.location,
                  //       ),
                  //       Container(
                  //         width: 1,
                  //         height: 24,
                  //         color: Colors.white.withOpacity(0.15),
                  //         margin: const EdgeInsets.symmetric(horizontal: 16),
                  //       ),
                  //       _buildHeaderSelectionSummary(
                  //         'Dropping',
                  //         droppingpointname,
                  //         Iconsax.gps,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),

            // Point Selection Lists
            Expanded(
              child: TabBarView(
                children: [
                  _buildPointList(widget.boardingTimeList, true),
                  _buildPointList(widget.dropingTimeList, false),
                ],
              ),
            ),

            // Bottom Continue Bar
            _buildBottomActionBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSelectionSummary(
    String label,
    String? value,
    IconData icon,
  ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 12, color: Colors.white.withOpacity(0.5)),
              const SizedBox(width: 6),
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value ?? 'Select Point',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
              fontWeight: value != null ? FontWeight.w700 : FontWeight.w400,
            ),
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildPointList(List<BoardingPoint> points, bool isBoarding) {
    if (points.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_off_outlined, size: 64, color: textLight),
            const SizedBox(height: 16),
            Text(
              'No points available',
              style: TextStyle(fontSize: 16, color: textSecondary),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
      itemCount: points.length,
      itemBuilder: (context, index) {
        final point = points[index];
        final isSelected =
            (isBoarding ? boardingpoint : droppingpoint) == point.bpId;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(20),
            // boxShadow: [
            //   BoxShadow(
            //     color: isSelected
            //         ? secondaryColor.withOpacity(0.2)
            //         : Colors.black.withOpacity(0.04),
            //     blurRadius: isSelected ? 12 : 8,
            //     offset: const Offset(0, 4),
            //   ),
            // ],
            // border: Border.all(
            //   color: isSelected ? null : Colors.transparent,
            //   width: 1.5,
            // ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                setState(() {
                  if (isBoarding) {
                    boardingpoint = point.bpId;
                    boardingpointname = point.bpName;
                  } else {
                    droppingpoint = point.bpId;
                    droppingpointname = point.bpName;
                  }
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Icon/Time Area
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: isSelected ? secondaryColor : backgroundColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Icon(
                          //   Icons.access_time_filled_rounded,
                          //   size: 16,
                          //   color: isSelected ? Colors.white : textSecondary,
                          // ),
                          // const SizedBox(height: 4),
                          Text(
                            changetime(
                              time: point.time,
                            ).split(' ')[0], // Get time part
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: isSelected ? Colors.white : textPrimary,
                            ),
                          ),
                          Text(
                            changetime(
                              time: point.time,
                            ).split(' ').last, // Get AM/PM part
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? Colors.white.withOpacity(0.8)
                                  : textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Content Area
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            point.bpName,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (point.landmark.isNotEmpty)
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  size: 12,
                                  color: textSecondary,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    point.landmark,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: textSecondary,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          if (point.address.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              point.address,
                              style: TextStyle(
                                fontSize: 11,
                                color: textLight,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Selection Indicator
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected ? secondaryColor : Colors.transparent,
                        border: Border.all(
                          color: isSelected
                              ? secondaryColor
                              : textLight.withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomActionBar() {
    final bool readyToContinue = boardingpoint != null && droppingpoint != null;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        20,
        16,
        20,
        MediaQuery.of(context).padding.bottom + 16,
      ),
      child: Row(
        children: [
          // Status Info
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  readyToContinue ? 'Selection Complete' : 'Next Step',
                  style: TextStyle(
                    fontSize: 12,
                    color: textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  readyToContinue
                      ? 'Ready to proceed'
                      : (boardingpoint == null
                            ? 'Select Boarding Point'
                            : 'Select Dropping Point'),
                  style: TextStyle(
                    fontSize: 14,
                    color: readyToContinue ? successColor : textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Continue Button
          SizedBox(
            height: 56,
            width: 140,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: maincolor1,
                foregroundColor: secondaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                if (!readyToContinue) {
                  _showErrorBottomSheet(
                    boardingpoint == null
                        ? 'Boarding Point Required'
                        : 'Dropping Point Required',
                    boardingpoint == null
                        ? 'Please select a location to board the bus.'
                        : 'Please select a location to drop off.',
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScreenPassengerInput(
                        selctseat: widget.selectedSeats,
                        alldata: widget.alldata,
                        boardingpoint: boardingpoint!,
                        droppingPoint: droppingpoint!,
                        travelsname: widget.travelsname,
                        trpinfo: widget.trpinfo,
                      ),
                    ),
                  );
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showErrorBottomSheet(String title, String message) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: textLight.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: errorColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                color: errorColor,
                size: 40,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: textSecondary, height: 1.5),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: maincolor1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'OK, Got it',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
