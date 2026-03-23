import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:minna/bus/domain/bus%20seat%20model/bus_seat_model.dart';
import 'package:minna/bus/infrastructure/bus%20searvice/bus_services.dart';
import 'package:minna/bus/pages/screen%20boarding%20dropping/screen_boarding_dropping.dart';
import 'package:minna/bus/pages/screen%20seats%20page/widgets/berthgrid.view.dart';
import 'package:minna/comman/functions/snack_bar.dart';
import 'package:shimmer/shimmer.dart';

class ScreenSeateLayout extends StatefulWidget {
  final Map<String, dynamic> alldata;
  final String tripid;
  final String travelsname;
  final String trpinfo;
  final List<dynamic> boardingTimeList;
  final List<dynamic> dropingTimeList;
  final dynamic availableTrip;

  const ScreenSeateLayout({
    super.key,
    required this.alldata,
    required this.tripid,
    required this.travelsname,
    required this.trpinfo,
    required this.boardingTimeList,
    required this.dropingTimeList,
    this.availableTrip,
  });

  @override
  State<ScreenSeateLayout> createState() => _ScreenSeateLayoutState();
}

class _ScreenSeateLayoutState extends State<ScreenSeateLayout> {
  bool isloading = true;
  bool iserror = false;
  BusSeatModel? fetchseatdata;
  List<Seat>? lowerBerth;
  List<Seat>? upperBerth;
  List<Seat> newselectedseats = [];

  int totallowerBerthRowno = 0;
  int totallowerBerthcolumn = 0;
  int totalupperBerthRowno = 0;
  int totalupperBerthcolumn = 0;

  final Color _primaryColor = const Color(0xFFFFC107); // Gold
  final Color _secondaryColor = const Color(0xFF000000); // Black
  final Color _backgroundColor = const Color(0xFFF5F5F7);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = const Color(0xFF1D1B20);
  final Color _textSecondary = const Color(0xFF49454F);
  final Color _textLight = const Color(0xFF79747E);
  final Color _errorColor = const Color(0xFFB3261E);

  @override
  void initState() {
    super.initState();
    fetchseatlayoutdata(tripid: widget.tripid);
  }

  void updateSelectedSeat(Seat seat, bool isSelected) {
    setState(() {
      if (isSelected) {
        if (newselectedseats.length < 6) {
          newselectedseats.add(seat);
          _showSeatSelectedSnackbar(seat);
        } else {
          _showMaxSeatsBottomSheet();
        }
      } else {
        newselectedseats.removeWhere((s) => s.name == seat.name);
      }
    });
  }

  void _showSeatSelectedSnackbar(Seat seat) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Seat ${seat.name} selected - ₹${seat.fare}'),
        backgroundColor: _secondaryColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showMaxSeatsBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: _cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 48),
            const SizedBox(height: 16),
            Text(
              'Maximum Limit Reached',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You can select up to 6 seats per ticket.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: _textSecondary),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  foregroundColor: _secondaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Understand', style: TextStyle(fontWeight: FontWeight.bold)),
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
        titleSpacing: 0,
        backgroundColor: _backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 20),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.travelsname,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.trpinfo,
              style: TextStyle(
                color: _textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => _showSeatLegend(context),
            icon: const Icon(Icons.info_outline_rounded, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: isloading
                ? _buildShimmerLoading(10, 3)
                : iserror
                    ? Center(child: Text('Error loading layout', style: TextStyle(color: _errorColor)))
                    : DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            if (upperBerth != null && upperBerth!.isNotEmpty)
                              TabBar(
                                indicatorColor: _primaryColor,
                                labelColor: _secondaryColor,
                                unselectedLabelColor: _textLight,
                                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                                tabs: const [
                                  Tab(text: 'Lower Berth'),
                                  Tab(text: 'Upper Berth'),
                                ],
                              ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  if (lowerBerth != null && lowerBerth!.isNotEmpty)
                                    InteractiveViewer(
                                      minScale: 0.5,
                                      maxScale: 2.0,
                                      child: BerthGridView(
                                        totalRowno: totallowerBerthRowno,
                                        totalColumnno: totallowerBerthcolumn,
                                        seatlist: lowerBerth!,
                                        onSeatSelected: updateSelectedSeat,
                                        secondaryColor: _secondaryColor,
                                        primaryColor: _primaryColor,
                                        cardColor: _cardColor,
                                        textPrimary: _textPrimary,
                                        textSecondary: _textSecondary,
                                        textLight: _textLight,
                                      ),
                                    )
                                  else
                                    _buildEmptyState('Lower Berth'),
                                  if (upperBerth != null && upperBerth!.isNotEmpty)
                                    InteractiveViewer(
                                      minScale: 0.5,
                                      maxScale: 2.0,
                                      child: BerthGridView(
                                        totalRowno: totalupperBerthRowno,
                                        totalColumnno: totalupperBerthcolumn,
                                        seatlist: upperBerth!,
                                        onSeatSelected: updateSelectedSeat,
                                        secondaryColor: _secondaryColor,
                                        primaryColor: _primaryColor,
                                        cardColor: _cardColor,
                                        textPrimary: _textPrimary,
                                        textSecondary: _textSecondary,
                                        textLight: _textLight,
                                      ),
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
    );
  }

  Widget _buildEmptyState(String berthType) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_seat_outlined, size: 64, color: _textLight),
          const SizedBox(height: 16),
          Text(
            'No $berthType seats available',
            style: TextStyle(fontSize: 16, color: _textSecondary, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Text('Please check other berth options', style: TextStyle(fontSize: 14, color: _textLight)),
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
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -6),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (newselectedseats.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                child: SizedBox(
                  height: 32,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: newselectedseats.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final seat = newselectedseats[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: _secondaryColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: _secondaryColor.withOpacity(0.2)),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Seat ${seat.name}',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _secondaryColor),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Amount',
                            style: TextStyle(fontSize: 13, color: _textSecondary, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '₹${_calculateTotalFare().toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF2E7D32), letterSpacing: -0.5),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _proceedToBoardingSelection,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _secondaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                      child: const Row(
                        children: [
                          Text('Select Boarding', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_rounded, size: 18),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ] else
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Text(
                  'Please select a seat to continue',
                  style: TextStyle(fontSize: 15, color: _textLight, fontStyle: FontStyle.italic),
                ),
              ),
          ],
        ),
      ),
    );
  }

  double _calculateTotalFare() {
    double total = 0;
    for (var seat in newselectedseats) {
      total += double.tryParse(seat.fare) ?? 0;
    }
    return total;
  }

  void _proceedToBoardingSelection() {
    if (newselectedseats.isEmpty) {
      _showNoSelectionDialog();
      return;
    }

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

  void _showNoSelectionDialog() {
    Fluttertoast.showToast(
      msg: 'Please select at least one seat',
      backgroundColor: Colors.orange,
      textColor: Colors.white,
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
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: _textLight.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Seat Legend',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: _textPrimary),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: _textSecondary),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildLegendItem(Icons.event_seat, 'Available', _secondaryColor.withOpacity(0.1), _secondaryColor),
            _buildLegendItem(Icons.event_seat, 'Selected', _secondaryColor, Colors.white),
            _buildLegendItem(Icons.event_seat, 'Booked', _textLight.withOpacity(0.2), _textLight),
            _buildLegendItem(Icons.event_seat, 'Ladies', const Color(0xFFFCE4EC), const Color(0xFFE91E63)),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor.withOpacity(0.1),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text('Got it', style: TextStyle(fontSize: 16, color: _secondaryColor, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(IconData icon, String label, Color bgColor, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Text(
            label,
            style: TextStyle(fontSize: 16, color: _textPrimary, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading(int rows, int cols) {
    return Shimmer.fromColors(
      baseColor: _textLight.withOpacity(0.1),
      highlightColor: _textLight.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            childAspectRatio: 0.8,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemCount: rows * cols,
          itemBuilder: (context, index) {
            final col = index % cols;
            if (cols > 2 && col == 1) return const SizedBox.shrink();

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
      final data = await fetchBusSeatLayout(tripID: tripid);
      if (data.statusCode == 200) {
        final responseData = jsonDecode(data.body);

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