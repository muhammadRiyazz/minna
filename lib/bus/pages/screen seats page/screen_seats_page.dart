import 'dart:convert';
import 'dart:developer';

import 'package:minna/bus/domain/trips%20list%20modal/trip_list_modal.dart';
import 'package:minna/bus/pages/Screen%20BdDP%20details/screen_boarding_droping_details.dart';
import 'package:minna/bus/pages/screen%20seats%20page/widgets/berthgrid.view.dart';
import 'package:minna/bus/presendation/widgets/error_widget.dart';
import 'package:minna/comman/const/const.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
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
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37); // Gold
  final Color _accentColor = Color(0xFFC19B3C); // Darker Gold
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);
  final Color _errorColor = Color(0xFFE53935);
  final Color _successColor = Color(0xFF388E3C);
  final Color _warningColor = Color(0xFFF57C00);

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: _secondaryColor.withOpacity(0.3),
            width: 1,
          ),
        ),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 180,
          left: 16,
          right: 16,
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: _cardColor,
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
                      _primaryColor.withOpacity(0.9),
                      _primaryColor.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: _primaryColor.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.airline_seat_recline_normal_rounded,
                  color: _secondaryColor,
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
                        color: _textSecondary,
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
                              color: _primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          TextSpan(
                            text: ' • ₹${seat.baseFare}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: _successColor,
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
                    color: _backgroundColor,
                  ),
                  child: Icon(
                    Icons.close,
                    color: _textSecondary,
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
          color: _cardColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(25),
          ),
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
                color: _errorColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.event_seat, size: 48, color: _errorColor),
            ),
            const SizedBox(height: 24),
            Text(
              'Maximum Seats Reached',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: _textPrimary,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'You can select up to 6 seats per booking',
              style: TextStyle(
                fontSize: 15,
                color: _textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
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
                    color: _secondaryColor,
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
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: _primaryColor,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
            'Select Seats',
              style: TextStyle(
                fontSize: 16,
                color: _cardColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            // Text(
            //   widget.trpinfo,
            //   style: TextStyle(
            //     fontSize: 12,
            //     color: _secondaryColor.withOpacity(0.8),
            //     fontWeight: FontWeight.w400,
            //   ),
            // ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showSeatLegend(context);
            },
            icon: Icon(Icons.info_outline_rounded, color: Colors.white),
            tooltip: 'Seat Information',
          ),
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
                          color: _cardColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TabBar(
                          labelColor: _primaryColor,
                          unselectedLabelColor: _textSecondary,
                          indicatorColor: _secondaryColor,
                          indicatorWeight: 3,
                          indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: _primaryColor,
                          ),
                          unselectedLabelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: _textSecondary,
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
                                primaryColor: _primaryColor,
                                secondaryColor: _secondaryColor,
                                accentColor: _accentColor,
                                backgroundColor: _backgroundColor,
                                cardColor: _cardColor,
                                textPrimary: _textPrimary,
                                textSecondary: _textSecondary,
                                textLight: _textLight,
                              )
                            else
                              _buildEmptyState('Lower Berth'),
                            if (upperBerth != null && upperBerth!.isNotEmpty)
                              BerthGridView(
                                seatlist: upperBerth!,
                                selectedseats: newselectedseats,
                                onSeatSelected: updateSelectedSeat,
                                primaryColor: _primaryColor,
                                secondaryColor: _secondaryColor,
                                accentColor: _accentColor,
                                backgroundColor: _backgroundColor,
                                cardColor: _cardColor,
                                textPrimary: _textPrimary,
                                textSecondary: _textSecondary,
                                textLight: _textLight,
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
          Icon(
            Icons.event_seat_outlined,
            size: 64,
            color: _textLight,
          ),
          const SizedBox(height: 16),
          Text(
            'No $berthType seats available',
            style: TextStyle(
              fontSize: 16,
              color: _textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please check other berth options',
            style: TextStyle(
              fontSize: 14,
              color: _textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSummaryPanel() {
    return Container(
      decoration: BoxDecoration(
        color: _cardColor,
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
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${newselectedseats.length} ${newselectedseats.length == 1 ? 'Seat' : 'Seats'} Selected',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: newselectedseats.map((seat) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _secondaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: _secondaryColor.withOpacity(0.3),
                                ),
                              ),
                              child: Text(
                                seat.name,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: _primaryColor,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Total Amount',
                        style: TextStyle(
                          fontSize: 12,
                          color: _textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹${totalAmount.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: _secondaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
          
          // Continue button
          Container(
            margin: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: newselectedseats.isEmpty ? _textLight.withOpacity(0.6) : _primaryColor,
                foregroundColor: newselectedseats.isEmpty ? _textSecondary : _secondaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size.fromHeight(56),
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
                      ? 'Select Seats to Continue'
                      : 'Continue with ${newselectedseats.length} ${newselectedseats.length == 1 ? 'Seat' : 'Seats'}',
                    style: TextStyle(
                      color: newselectedseats.isEmpty ? _textSecondary : _cardColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (newselectedseats.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    Icon(Icons.arrow_forward_rounded, size: 20, color: _cardColor),
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
          color: _cardColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(25),
          ),
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
                color: _warningColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.event_seat_outlined, size: 48, color: _warningColor),
            ),
            const SizedBox(height: 24),
            Text(
              'Select Your Seats',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: _textPrimary,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'Please select at least one seat to proceed with your booking',
              style: TextStyle(
                fontSize: 15,
                color: _textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
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
                    color: _secondaryColor,
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
          color: _cardColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(25),
          ),
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
                color: _textLight.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Row(
              children: [
                Icon(Icons.info_outline_rounded, color: _primaryColor),
                const SizedBox(width: 8),
                Text(
                  'Seat Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: _textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildLegendItem(_primaryColor, 'Available Seat', 'Regular seats available for booking'),
            _buildLegendItem(_secondaryColor, 'Selected Seat', 'Seats you have selected'),
            _buildLegendItem(Colors.grey, 'Booked Seat', 'Already booked by other passengers'),
            _buildLegendItem(Colors.pink, 'Ladies Seat', 'Reserved for female passengers'),
            _buildLegendItem(Colors.blue, 'Gents Seat', 'Reserved for male passengers'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.hotel, color: _primaryColor, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Sleeper seats are horizontal, Seater seats are vertical',
                      style: TextStyle(
                        fontSize: 12,
                        color: _textSecondary,
                      ),
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

  Widget _buildLegendItem(Color color, String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: _textSecondary,
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
            color: _cardColor,
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
                _buildShimmerSeatLayout(),
                _buildShimmerSeatLayout(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerSeatLayout() {
    const rows = 8;
    const cols = 4;

    return Shimmer.fromColors(
      baseColor: _textLight.withOpacity(0.1),
      highlightColor: _textLight.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            childAspectRatio: 0.8,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemCount: rows * cols,
          itemBuilder: (context, index) {
            final col = index % cols;
            if (col == 1) return const SizedBox.shrink();

            return Container(
              decoration: BoxDecoration(
                color: _cardColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _textLight.withOpacity(0.1)),
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
        backgroundColor: _errorColor,
        textColor: Colors.white,
      );
    }
  }
}