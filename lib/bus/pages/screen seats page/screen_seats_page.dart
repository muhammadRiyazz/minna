import 'dart:convert';
import 'dart:developer';

import 'package:minna/bus/domain/trips%20list%20modal/trip_list_modal.dart';
import 'package:minna/bus/pages/Screen%20BdDP%20details/screen_boarding_droping_details.dart';
import 'package:minna/bus/pages/screen%20seats%20page/widgets/berthgrid.view.dart';
import 'package:minna/bus/presendation/widgets/error_widget.dart';
import 'package:minna/bus/presendation/widgets/loading_widget.dart';
import 'package:minna/comman/const/const.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import '../../domain/BlockTicket/block_ticket_request_modal.dart';
import '../../domain/seatlayout/seatlayoutmodal.dart';
import '../../infrastructure/fetch seatlayout/seatlayout.dart';
import '../../infrastructure/seats/seatcalculation.dart';

class ScreenSeateLayout extends StatefulWidget {
  const ScreenSeateLayout({
    Key? key,
    required this.alldata,
    required this.travelsname,
    required this.trpinfo,
    required this.dropingTimeList,
    required this.boardingTimeList,
  }) : super(key: key);

  final BlockTicketRequest alldata;
  final String trpinfo;
  final String travelsname;
  final List<BoardingPoint> boardingTimeList;
  final List<BoardingPoint> dropingTimeList;
  @override
  State<ScreenSeateLayout> createState() => _ScreenSeateLayoutState();
}

class _ScreenSeateLayoutState extends State<ScreenSeateLayout> {
  bool iserror = false;
  bool isloading = true;
  BusSeatModel? fetchseatdata;
  List<Seat>? lowerBerth;
  List<Seat>? upperBerth;
  final List<Seat> newselectedseats = [];
  int? totallowerBerthRowno;
  int? totallowerBerthcolumn;
  int? totalupperBerthRowno;
  int? totalupperBerthcolumn;
  double totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    fetchseatlayoutdata(tripid: widget.alldata.availableTripID!);
  }

  // In your State class (like _ScreenSeateLayoutState)
  void updateSelectedSeat(Seat seat, bool isSelected) {
    const maxSeats = 6;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    // Clear any existing snackbars before showing new ones
    scaffoldMessenger.clearSnackBars();

    if (isSelected && newselectedseats.length >= maxSeats) {
      _showMaxSeatsBottomSheet();
      return;
    }

    setState(() {
      if (isSelected) {
        newselectedseats.add(seat);
        totalAmount += double.parse(seat.baseFare);
        _showSeatSelectedSnackbar(
          seat,
        ); // Now this will show only one at a time
      } else {
        newselectedseats.removeWhere((s) => s.name == seat.name);
        totalAmount -= double.parse(seat.baseFare);
      }
    });
  }

  void _showSeatSelectedSnackbar(Seat seat) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: theme.primaryColor.withOpacity(0.2),
            width: 1,
          ),
        ),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 180,
          left: 16,
          right: 16,
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        elevation: 8,
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.primaryColor.withOpacity(0.8),
                      theme.primaryColor.withOpacity(0.4),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: theme.primaryColor.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.airline_seat_recline_normal_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Seat Selected',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: isDark ? Colors.grey[300] : Colors.grey[700],
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: seat.name,
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          TextSpan(
                            text: ' • ₹${seat.baseFare}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.green[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark ? Colors.grey[800] : Colors.grey[100],
                  ),
                  child: Icon(
                    Icons.close,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                    size: 18,
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMaxSeatsBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: const BorderRadius.vertical(
          //   top: Radius.circular(25),
          // ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red[50],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.event_seat, size: 48, color: Colors.red[600]),
            ),
            const SizedBox(height: 24),
            Text(
              'Maximum Seats Reached',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 3),

            Text(
              'You\'ve reached the limit of',

              style: TextStyle(fontSize: 13, color: Colors.black, height: 1.5),
              textAlign: TextAlign.center,
            ),
            Text(
              '6 seats',

              style: TextStyle(
                fontSize: 18,
                color: Colors.red,
                fontWeight: FontWeight.w700,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity, // Full width
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: maincolor1, // Use your theme color
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ), // Comfortable tap target
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  elevation: 0, // Flat design
                  minimumSize: const Size.fromHeight(
                    35,
                  ), // Ensure proper touch target height
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Okay',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: maincolor1,
        // title: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       widget.travelsname,
        //       style: const TextStyle(
        //         fontSize: 16,
        //         color: Colors.white,
        //         fontWeight: FontWeight.w500,
        //       ),
        //     ),
        //     Text(
        //       widget.trpinfo,
        //       style: const TextStyle(
        //         fontSize: 12,
        //         color: Colors.white,
        //         fontWeight: FontWeight.w300,
        //       ),
        //     ),
        //   ],
        // ),
        actions: [
          // IconButton(
          //   onPressed: () {
          //     // _showSeatLegend(context);
          //   },
          //   icon: const Icon(Icons.info_outline),
          //   tooltip: 'Seat Legend',
          // ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (isloading)
              Expanded(child: _buildShimmerLoading())
            else if (iserror)
              Expanded(
                child: Erroricon(
                  ontap: () {
                    fetchseatlayoutdata(
                      tripid: widget.alldata.availableTripID!,
                    );
                  },
                ),
              )
            else
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: TabBar(
                          labelColor: maincolor1,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: maincolor1,
                          indicatorWeight: 3,
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          unselectedLabelStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                          tabs: const [
                            Tab(text: 'Lower Berth'),
                            Tab(text: 'Upper Berth'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            if (lowerBerth != null && lowerBerth!.isNotEmpty)
                              BerthGridView(
                                seatlist: lowerBerth!,
                                selectedseats: newselectedseats,
                                onSeatSelected: updateSelectedSeat,
                              )
                            else
                              const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.event_seat,
                                      size: 48,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'No lower berth seats available',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (upperBerth != null && upperBerth!.isNotEmpty)
                              BerthGridView(
                                seatlist: upperBerth!,
                                selectedseats: newselectedseats,
                                onSeatSelected: updateSelectedSeat,
                              )
                            else
                              const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.event_seat,
                                      size: 48,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'No upper berth seats available',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
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
            // Bottom summary panel
            if (!isloading && !iserror) _buildBottomSummaryPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSummaryPanel() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ListTile(
          //   contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          //   title: Text(
          //     widget.travelsname,
          //     style: const TextStyle(
          //       fontSize: 15,
          //       color: maincolor1,
          //       fontWeight: FontWeight.w500,
          //     ),
          //   ),
          //   subtitle: Text(
          //     widget.trpinfo,
          //     style: const TextStyle(
          //       fontSize: 11,
          //       color: maincolor1,
          //       fontWeight: FontWeight.w300,
          //     ),
          //   ),

          //   trailing: Icon(Icons.directions_bus_outlined, color: maincolor1),
          // ),
          // newselectedseats.isEmpty
          //     ? SizedBox()
          //     : Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 16),
          //       child: Divider(height: 1),
          //     ),
          SizedBox(height: 12),
          newselectedseats.isEmpty
              ? SizedBox()
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 5,
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${newselectedseats.length} ${newselectedseats.length == 1 ? 'Seat' : 'Seats'} Selected',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // if (newselectedseats.isNotEmpty)
                          //   SizedBox(
                          //     width: MediaQuery.of(context).size.width * 0.7,
                          //     child: Wrap(
                          //       spacing: 4,
                          //       children:
                          //           newselectedseats
                          //               .map(
                          //                 (seat) => Chip(
                          //                   label: Text(
                          //                     seat.name,
                          //                     style: const TextStyle(
                          //                       fontSize: 12,
                          //                     ),
                          //                   ),
                          //                   backgroundColor: maincolor1
                          //                       .withOpacity(0.1),
                          //                   shape: RoundedRectangleBorder(
                          //                     borderRadius: BorderRadius.circular(
                          //                       4,
                          //                     ),
                          //                   ),
                          //                 ),
                          //               )
                          //               .toList(),
                          //     ),
                          //   ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        '₹${totalAmount.toStringAsFixed(1)}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

          Container(
            height: 55,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: newselectedseats.isEmpty
                    ? Colors.grey
                    : maincolor1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              onPressed: () {
                if (newselectedseats.isEmpty) {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (context) => Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            size: 48,
                            color: Colors.redAccent,
                          ),
                          SizedBox(height: 13),
                          Text(
                            'Selection Required',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Please select at least one seat to proceed.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: maincolor1,
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                              ),
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'OK',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).viewInsets.bottom,
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ScreenBdDpDetails(
                          boardingTimeList: widget.boardingTimeList,
                          dropingTimeList: widget.dropingTimeList,
                          selectedSeats: newselectedseats,
                          travelsname: widget.travelsname,
                          trpinfo: widget.trpinfo,
                          alldata: widget.alldata,
                        );
                      },
                    ),
                  );
                }
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Select boarding & dropping points',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // SizedBox(width: 8),
                  // Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  // void _showSeatLegend(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //     ),
  //     builder: (context) {
  //       return Padding(
  //         padding: const EdgeInsets.all(16),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             const Center(
  //               child: Text(
  //                 'Seat Legend',
  //                 style: TextStyle(fontSize: 1, fontWeight: FontWeight.bold),
  //               ),
  //             ),
  //             const SizedBox(height: 16),
  //             _buildLegendItem('asset/seatyt.png', 'Selected by others'),
  //             _buildLegendItem('asset/seatb.png', 'Available only for female'),
  //             _buildLegendItem('asset/seatc.png', 'Available for anyone'),
  //             _buildLegendItem('asset/seatmale.png', 'Available for male only'),
  //             _buildLegendItem('asset/seatyy.png', 'Selected by you'),
  //             _buildLegendItem('asset/seatsbkppp.png', 'Sleeper seat'),
  //             const SizedBox(height: 16),
  //             SizedBox(
  //               width: double.infinity,
  //               child: ElevatedButton(
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: maincolor1,
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                 ),
  //                 onPressed: () => Navigator.pop(context),
  //                 child: const Text(
  //                   'GOT IT',
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _buildLegendItem(String iconPath, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Image.asset(iconPath, width: 32, height: 32),
          const SizedBox(width: 16),
          Text(text, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Future<void> fetchseatlayoutdata({required String tripid}) async {
    setState(() {
      isloading = true;
      iserror = false;
    });

    try {
      final data = await fetchseats(tripid: tripid);
      log(data.body);
      if (data.statusCode == 200) {
        final dynamic responseData = jsonDecode(data.body);

        if (responseData is String && responseData.contains('Error:')) {
          throw Exception(responseData);
        }

        if (responseData is List) {
          throw Exception('Unexpected list response from server');
        }

        setState(() {
          fetchseatdata = BusSeatModel.fromJson(
            responseData as Map<String, dynamic>,
          );
          lowerBerth = getLowerBerth(seatsList: fetchseatdata!.seats);
          upperBerth = getUpperBerth(seatsList: fetchseatdata!.seats);

          if (lowerBerth != null && lowerBerth!.isNotEmpty) {
            totallowerBerthRowno = totalRow(seatsList: lowerBerth!) + 1;
            totallowerBerthcolumn = totalColumn(seatsList: lowerBerth!) + 1;
          }

          if (upperBerth != null && upperBerth!.isNotEmpty) {
            totalupperBerthRowno = totalRow(seatsList: upperBerth!) + 1;
            totalupperBerthcolumn = totalColumn(seatsList: upperBerth!) + 1;
          }

          isloading = false;
          iserror = false;
        });
      } else {
        throw Exception('Failed to load seat layout: ${data.statusCode}');
      }
    } catch (e, stackTrace) {
      log('Error fetching seat layout: $e');
      log('Stack trace: $stackTrace');
      setState(() {
        isloading = false;
        iserror = true;
      });
      Fluttertoast.showToast(
        msg: 'Failed to load seat layout. Please try again.',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}

Widget _buildShimmerLoading() {
  return DefaultTabController(
    length: 2,
    child: Column(
      children: [
        Container(
          color: Colors.white,
          child: const TabBar(
            tabs: [
              Tab(text: 'Lower Berth'),
              Tab(text: 'Upper Berth'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            children: [
              // Lower berth loading
              _buildShimmerSeatLayout(isLower: true),
              // Upper berth loading
              _buildShimmerSeatLayout(isLower: false),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildShimmerSeatLayout({required bool isLower}) {
  // Typical bus has 10-12 rows with 4 columns (2 seats each side + aisle)
  const rows = 8;
  const cols = 4;

  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: cols,
          childAspectRatio: 0.8,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: rows * cols,
        itemBuilder: (context, index) {
          final col = index % cols;

          // Skip aisle columns (cols 1 and 2 in 4-column layout)
          if (col == 1) return const SizedBox.shrink();

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey.shade200),
              ),
            ),
          );
        },
      ),
    ),
  );
}
