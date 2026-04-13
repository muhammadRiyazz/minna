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
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        backgroundColor: Colors.transparent,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 160,
          left: 16,
          right: 16,
        ),
        duration: const Duration(milliseconds: 1500),
        content: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: maincolor1.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: maincolor1.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Iconsax.tick_circle, color: maincolor1, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Seat Added!',
                      style: TextStyle(
                        color: textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    // Text(
                    //   'Seat ${seat.name} successfully selected',
                    //   style: TextStyle(
                    //     color: textSecondary,
                    //     fontSize: 12,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Fare: ',
                            style: TextStyle(
                              color: textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: '₹${seat.baseFare}',
                            style: TextStyle(
                              color: successColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
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
          icon: Icon(Iconsax.arrow_left_2, color: Colors.white, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: maincolor1,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Select Seats',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        // actions: [
        //   TextButton.icon(
        //     onPressed: () => _showSeatLegend(context),
        //     icon: Icon(Iconsax.box, color: accentColor, size: 16),
        //     label: Text(
        //       'INFO',
        //       style: TextStyle(
        //         fontSize: 10,
        //         color: accentColor,
        //         fontWeight: FontWeight.w800,
        //       ),
        //     ),
        //   ),
        //   const SizedBox(width: 8),
        // ],
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
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            _buildInlineLegend(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Case: Only Lower Berth
                                if ((lowerBerth != null &&
                                        lowerBerth!.isNotEmpty) &&
                                    (upperBerth == null ||
                                        upperBerth!.isEmpty)) ...[
                                  const Spacer(flex: 1),
                                  Expanded(
                                    flex: 4,
                                    child: BerthGridView(
                                      title: 'Lower Berth',
                                      seatlist: lowerBerth!,
                                      selectedseats: newselectedseats,
                                      onSeatSelected: updateSelectedSeat,
                                      primaryColor: maincolor1,
                                      secondaryColor: secondaryColor,
                                      accentColor: maincolor1,
                                      backgroundColor: backgroundColor,
                                      cardColor: cardColor,
                                      textPrimary: textPrimary,
                                      textSecondary: textSecondary,
                                      textLight: textLight,
                                      showSteering: true,
                                    ),
                                  ),
                                  const Spacer(flex: 1),
                                ]
                                // Case: Only Upper Berth
                                else if ((upperBerth != null &&
                                        upperBerth!.isNotEmpty) &&
                                    (lowerBerth == null ||
                                        lowerBerth!.isEmpty)) ...[
                                  const Spacer(flex: 1),
                                  Expanded(
                                    flex: 4,
                                    child: BerthGridView(
                                      title: 'Upper Berth',
                                      seatlist: upperBerth!,
                                      selectedseats: newselectedseats,
                                      onSeatSelected: updateSelectedSeat,
                                      primaryColor: maincolor1,
                                      secondaryColor: secondaryColor,
                                      accentColor: maincolor1,
                                      backgroundColor: backgroundColor,
                                      cardColor: cardColor,
                                      textPrimary: textPrimary,
                                      textSecondary: textSecondary,
                                      textLight: textLight,
                                    ),
                                  ),
                                  const Spacer(flex: 1),
                                ]
                                // Case: Both Berths
                                else ...[
                                  if (lowerBerth != null &&
                                      lowerBerth!.isNotEmpty)
                                    Expanded(
                                      child: BerthGridView(
                                        title: 'Lower Berth',
                                        seatlist: lowerBerth!,
                                        selectedseats: newselectedseats,
                                        onSeatSelected: updateSelectedSeat,
                                        primaryColor: maincolor1,
                                        secondaryColor: secondaryColor,
                                        accentColor: maincolor1,
                                        backgroundColor: backgroundColor,
                                        cardColor: cardColor,
                                        textPrimary: textPrimary,
                                        textSecondary: textSecondary,
                                        textLight: textLight,
                                        showSteering: true,
                                      ),
                                    ),
                                  const SizedBox(width: 8),
                                  if (upperBerth != null &&
                                      upperBerth!.isNotEmpty)
                                    Expanded(
                                      child: BerthGridView(
                                        title: 'Upper Berth',
                                        seatlist: upperBerth!,
                                        selectedseats: newselectedseats,
                                        onSeatSelected: updateSelectedSeat,
                                        primaryColor: maincolor1,
                                        secondaryColor: secondaryColor,
                                        accentColor: maincolor1,
                                        backgroundColor: backgroundColor,
                                        cardColor: cardColor,
                                        textPrimary: textPrimary,
                                        textSecondary: textSecondary,
                                        textLight: textLight,
                                      ),
                                    ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (!isloading && !iserror) _buildBottomSummaryPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSelectionBanner() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: newselectedseats.isEmpty
          ? const SizedBox.shrink()
          : Container(
              key: const ValueKey('selection_banner'),
              // margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [maincolor1, maincolor1.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: maincolor1.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Iconsax.info_circle,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'You have selected:',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          newselectedseats.map((s) => s.name).join(', '),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${newselectedseats.length} ${newselectedseats.length == 1 ? 'Seat' : 'Seats'}',
                      style: TextStyle(
                        color: maincolor1,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildBottomSummaryPanel() {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: textLight.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Column(
              children: [
                // Operator Info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.travelsname,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                _buildTopSelectionBanner(),
                const SizedBox(height: 8),

                // Continue Button / Summary
                Row(
                  children: [
                    if (newselectedseats.isNotEmpty)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${newselectedseats.length} ${newselectedseats.length == 1 ? 'Seat' : 'Seats'}',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: textSecondary,
                              ),
                            ),
                            Text(
                              '₹${totalAmount.toStringAsFixed(0)}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Expanded(
                      flex: newselectedseats.isNotEmpty ? 1 : 2,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: newselectedseats.isEmpty
                              ? textLight.withOpacity(0.3)
                              : maincolor1,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (newselectedseats.isEmpty) {
                            _showNoSelectionDialog();
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScreenBdDpDetails(
                                  boardingTimeList: widget.boardingTimeList,
                                  dropingTimeList: widget.dropingTimeList,
                                  selectedSeats: newselectedseats,
                                  travelsname: widget.travelsname,
                                  trpinfo: widget.trpinfo,
                                  alldata: widget.alldata,
                                ),
                              ),
                            );
                          }
                        },
                        child: Text(
                          newselectedseats.isEmpty
                              ? 'SELECT SEATS'
                              : 'CONTINUE',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
              Iconsax.woman,
              borderColor: Colors.pink,
            ),
            _buildLegendItem(
              Colors.blue.withOpacity(0.2),
              'Gents Seat',
              'Reserved for male passengers',
              Iconsax.man,
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

  Widget _buildInlineLegend() {
    return GestureDetector(
      onTap: () => _showSeatLegend(context),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: textLight.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCompactLegendItem(
                  Colors.white,
                  'Available',
                  null,
                  borderColor: textLight.withOpacity(0.3),
                ),
                _buildCompactLegendItem(maincolor1, 'Selected', null),
                _buildCompactLegendItem(
                  textLight.withOpacity(0.15),
                  'Booked',
                  null,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCompactLegendItem(
                  Colors.pink.withOpacity(0.15),
                  'Ladies',
                  Iconsax.woman,
                  iconColor: Colors.pink,
                ),
                _buildCompactLegendItem(
                  Colors.blue.withOpacity(0.15),
                  'Gents',
                  Iconsax.man,
                  iconColor: Colors.blue,
                ),
                // Dummy item for alignment
                const SizedBox(width: 80),
              ],
            ),
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
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: borderColor ?? color.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Icon(
              icon,
              size: 16,
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
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 11,
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

  Widget _buildCompactLegendItem(
    Color color,
    String label,
    IconData? icon, {
    Color? borderColor,
    Color? iconColor,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: 1,
            ),
          ),
          child: icon != null
              ? Icon(icon, size: 12, color: iconColor ?? Colors.white)
              : null,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerLoading() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            // Dummy Legend Shimmer
            Container(
              height: 60,
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: textLight.withOpacity(0.05)),
              ),
              child: Shimmer.fromColors(
                baseColor: textSecondary.withOpacity(0.05),
                highlightColor: textSecondary.withOpacity(0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    3,
                    (i) => Container(
                      width: 80,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildShimmerSeatLayout()),
                const SizedBox(width: 8),
                Expanded(child: _buildShimmerSeatLayout()),
              ],
            ),
          ],
        ),
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
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
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
