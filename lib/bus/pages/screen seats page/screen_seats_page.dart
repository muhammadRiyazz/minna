import 'dart:convert';
import 'dart:developer';

import 'package:minna/bus/domain/trips%20list%20modal/trip_list_modal.dart';
import 'package:minna/bus/pages/Screen%20BdDP%20details/screen_boarding_droping_details.dart';
import 'package:minna/bus/pages/screen%20seats%20page/widgets/berthgrid.view.dart';
import 'package:minna/bus/presendation/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:minna/comman/const/const.dart';
import 'package:iconsax/iconsax.dart';
import '../../domain/BlockTicket/block_ticket_request_modal.dart';
import '../../domain/seatlayout/seatlayoutmodal.dart';
import '../../infrastructure/fetch seatlayout/seatlayout.dart';
import '../../infrastructure/seats/seatcalculation.dart';

class ScreenSeateLayout extends StatefulWidget {
  const ScreenSeateLayout({
    super.key,
    required this.alldata,
    required this.travelsname,
    required this.trpinfo,
    required this.dropingTimeList,
    required this.boardingTimeList,
  });

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

  // Color Theme - Black & Gold Premium
  // Theme standardizing: Use global constants directly from const.dart

  @override
  void initState() {
    super.initState();
    fetchseatlayoutdata(tripid: widget.alldata.availableTripID!);
  }

  void updateSelectedSeat(Seat seat, bool isSelected) {
    const maxSeats = 6;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();

    if (isSelected && newselectedseats.length >= maxSeats) {
      _showMaxSeatsBottomSheet();
      return;
    }

    setState(() {
      if (isSelected) {
        newselectedseats.add(seat);
        totalAmount += double.parse(seat.baseFare);
        _showSeatSelectedSnackbar(seat);
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 180,
          left: 16,
          right: 16,
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: cardColor,
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(Iconsax.ticket_2, color: Colors.white, size: 24),
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
                        color: textSecondary,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: seat.name,
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: maincolor1,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          TextSpan(
                            text: ' • ₹${seat.baseFare}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: successColor,
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
                    color: backgroundColor,
                  ),
                  child: Icon(
                    Iconsax.close_circle,
                    color: textSecondary,
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
          color: cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: errorColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Iconsax.danger, size: 48, color: errorColor),
            ),
            const SizedBox(height: 24),
            Text(
              'Maximum Seats Reached',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: textPrimary,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'You can select up to 6 seats per booking',
              style: TextStyle(fontSize: 15, color: textSecondary, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: maincolor1,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Okay',
                  style: TextStyle(
                    fontSize: 16,
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
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2, color: Colors.white, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: maincolor1,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Seats',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              widget.travelsname,
              style: TextStyle(
                fontSize: 11,
                color: Colors.white.withOpacity(0.6),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => _showSeatLegend(context),
            icon: const Icon(
              Iconsax.info_circle,
              color: Colors.white,
              size: 22,
            ),
            tooltip: 'Seat Information',
          ),
          const SizedBox(width: 8),
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
                        decoration: BoxDecoration(
                          color: cardColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TabBar(
                          labelColor: Colors.white,
                          unselectedLabelColor: textSecondary,
                          indicator: BoxDecoration(
                            color: maincolor1,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          indicatorPadding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 8,
                          ),
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                          ),
                          unselectedLabelStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                          tabs: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Tab(text: 'Lower Berth'),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Tab(text: 'Upper Berth'),
                            ),
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
                                primaryColor: maincolor1,
                                secondaryColor: secondaryColor,
                                accentColor: accentColor,
                                backgroundColor: backgroundColor,
                                cardColor: cardColor,
                                textPrimary: textPrimary,
                                textSecondary: textSecondary,
                                textLight: textLight,
                              )
                            else
                              _buildEmptyState('Lower Berth'),
                            if (upperBerth != null && upperBerth!.isNotEmpty)
                              BerthGridView(
                                seatlist: upperBerth!,
                                selectedseats: newselectedseats,
                                onSeatSelected: updateSelectedSeat,
                                primaryColor: maincolor1,
                                secondaryColor: secondaryColor,
                                accentColor: accentColor,
                                backgroundColor: backgroundColor,
                                cardColor: cardColor,
                                textPrimary: textPrimary,
                                textSecondary: textSecondary,
                                textLight: textLight,
                              )
                            else
                              _buildEmptyState('Upper Berth'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (!isloading && !iserror) _buildBottomSummaryPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String berthType) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_seat_outlined, size: 64, color: textLight),
          const SizedBox(height: 16),
          Text(
            'No $berthType seats available',
            style: TextStyle(
              fontSize: 16,
              color: textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please check other berth options',
            style: TextStyle(fontSize: 14, color: textLight),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSummaryPanel() {
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
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (newselectedseats.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${newselectedseats.length} ${newselectedseats.length == 1 ? 'SEAT' : 'SEATS'} SELECTED',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: textSecondary.withOpacity(0.6),
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 6,
                          children: newselectedseats.map((seat) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: secondaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                                // border: Border.all(
                                //   color: secondaryColor.withOpacity(0.3),
                                // ),
                              ),
                              child: Text(
                                seat.name,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: maincolor1,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'TOTAL AMOUNT',
                        style: TextStyle(
                          fontSize: 10,
                          color: textSecondary.withOpacity(0.6),
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹${totalAmount.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: secondaryColor,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: newselectedseats.isEmpty
                    ? textLight.withOpacity(0.2)
                    : maincolor1,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                if (newselectedseats.isEmpty) {
                  _showNoSelectionDialog();
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    newselectedseats.isEmpty
                        ? 'SELECT SEATS TO PROCEED'
                        : 'CONTINUE WITH ${newselectedseats.length} SEATS',
                    style: TextStyle(
                      color: newselectedseats.isEmpty
                          ? textSecondary.withOpacity(0.5)
                          : Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                  if (newselectedseats.isNotEmpty) ...[
                    const SizedBox(width: 12),
                    const Icon(
                      Iconsax.arrow_right_3,
                      size: 18,
                      color: Colors.white,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showNoSelectionDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: warningColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Iconsax.info_circle, size: 48, color: warningColor),
            ),
            const SizedBox(height: 24),
            Text(
              'Select Your Seats',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: textPrimary,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'Please select at least one seat to proceed with your booking',
              style: TextStyle(fontSize: 15, color: textSecondary, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: maincolor1,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Select Seats',
                  style: TextStyle(
                    fontSize: 16,
                    color: secondaryColor,
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

  void _showSeatLegend(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: textLight.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Row(
              children: [
                Icon(Icons.info_outline_rounded, color: maincolor1),
                const SizedBox(width: 8),
                Text(
                  'Seat Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildLegendItem(
              maincolor1,
              'Available Seat',
              'Regular seats available for booking',
              Iconsax.box,
            ),
            _buildLegendItem(
              secondaryColor,
              'Selected Seat',
              'Seats you have selected',
              Iconsax.tick_square,
            ),
            _buildLegendItem(
              Colors.grey[300]!,
              'Booked Seat',
              'Already booked by other passengers',
              Iconsax.slash,
            ),
            _buildLegendItem(
              Colors.pink.withOpacity(0.2),
              'Ladies Seat',
              'Reserved for female passengers',
              Iconsax.user,
              borderColor: Colors.pink,
            ),
            _buildLegendItem(
              Colors.blue.withOpacity(0.2),
              'Gents Seat',
              'Reserved for male passengers',
              Iconsax.user,
              borderColor: Colors.blue,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.hotel, color: maincolor1, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Sleeper seats are horizontal, Seater seats are vertical',
                      style: TextStyle(fontSize: 12, color: textSecondary),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(
    Color color,
    String title,
    String description,
    IconData icon, {
    Color? borderColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: borderColor ?? color.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Icon(
              icon,
              size: 20,
              color:
                  borderColor ??
                  (color == maincolor1 || color == secondaryColor
                      ? Colors.white
                      : textSecondary),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
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

  Widget _buildShimmerLoading() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: textSecondary,
              indicator: BoxDecoration(
                color: maincolor1,
                borderRadius: BorderRadius.circular(12),
              ),
              indicatorPadding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 8,
              ),
              tabs: const [
                Tab(text: 'Lower Berth'),
                Tab(text: 'Upper Berth'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [_buildShimmerSeatLayout(), _buildShimmerSeatLayout()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerSeatLayout() {
    const rows = 8;
    const cols = 5;

    return Shimmer.fromColors(
      baseColor: textSecondary.withOpacity(0.05),
      highlightColor: textSecondary.withOpacity(0.02),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            childAspectRatio: 0.85,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          itemCount: rows * cols,
          itemBuilder: (context, index) {
            final col = index % cols;
            if (col == 2) return const SizedBox.shrink();

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 1),
              ),
            );
          },
        ),
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
        backgroundColor: errorColor,
        textColor: Colors.white,
      );
    }
  }
}
