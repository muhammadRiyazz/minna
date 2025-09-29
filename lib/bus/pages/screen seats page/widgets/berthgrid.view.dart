import 'package:minna/comman/const/const.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../domain/seatlayout/seatlayoutmodal.dart';
import '../../../infrastructure/seats/seatcalculation.dart';

class BerthGridView extends StatefulWidget {
  const BerthGridView({
    super.key,
    required this.seatlist,
    required this.selectedseats,
    required this.onSeatSelected,
  });

  final List<Seat> seatlist;
  final List<Seat> selectedseats;
  final Function(Seat, bool) onSeatSelected;

  @override
  State<BerthGridView> createState() => _BerthGridViewState();
}

class _BerthGridViewState extends State<BerthGridView> {
  late int totalRowno;
  late int totalcolumn;

  @override
  void initState() {
    super.initState();
    totalRowno = totalRow(seatsList: widget.seatlist) + 1;
    totalcolumn = totalColumn(seatsList: widget.seatlist) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: ExpansionTile(
              collapsedIconColor: Colors.white,
              iconColor: Colors.white,
              initiallyExpanded: false,
              textColor: Colors.white,
              tilePadding: const EdgeInsets.symmetric(horizontal: 16),
              collapsedBackgroundColor: maincolor1!,
              collapsedTextColor: Colors.white,
              backgroundColor: maincolor1!,
              collapsedShape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: const Row(
                children: [
                  Icon(Icons.event_seat_rounded, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Know your seat types',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              children: [
                // Shadow Container (now works!)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(color: Colors.grey, width: .6),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                          0.08,
                        ), // Lower opacity (0.1–0.3 works best)
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: const Offset(0, 4), // Shadow position (x, y)
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        _buildLegendItem(
                          _buildSeatContainer(
                            width: '1',
                            boxhight: 50,

                            length: '1',
                            borderColor: maincolor1!, // Selected seat border
                            fillColor: maincolor1!, // Semi-transparent fill
                            borderWidth: 2.5,
                            lBoxColor: Colors.white,
                          ),
                          'Selected by you',
                        ),
                        _buildLegendItem(
                          _buildSeatContainer(
                            width: '1',
                            length: '1',
                            lBoxColor: Colors.grey,
                            boxhight: 50,

                            borderColor: Colors.grey.withOpacity(
                              0.3,
                            ), // Unavailable seat border
                            fillColor: Colors.grey.withOpacity(
                              0.3,
                            ), // Light fill to show unavailable
                          ),
                          'Selected by others',
                        ),
                        _buildLegendItem(
                          _buildSeatContainer(
                            width: '1',
                            length: '1',
                            lBoxColor: maincolor1!,
                            boxhight: 50,

                            borderColor:
                                maincolor1!, // Default seat border color
                            fillColor: Colors.transparent,
                          ),
                          'Available for anyone',
                        ),
                        _buildLegendItem(
                          _buildSeatContainer(
                            width: '1',
                            length: '1',
                            lBoxColor: Colors.pink,
                            boxhight: 50,

                            borderColor:
                                Colors.pink, // Ladies seat border color
                            fillColor: Colors.transparent,
                          ),
                          'Ladies only',
                        ),
                        _buildLegendItem(
                          _buildSeatContainer(
                            width: '1',
                            length: '1',
                            lBoxColor: Colors.blue,
                            boxhight: 50,

                            borderColor: Colors.blue, // Males seat border color
                            fillColor: Colors.transparent,
                          ),
                          'Male only',
                        ),
                        _buildLegendItem(
                          _buildSeatContainer(
                            width: '1',
                            boxhight: 60,

                            length: '2',
                            borderColor: maincolor1!, // Selected seat border
                            fillColor: Colors.white, // Semi-transparent fill
                            borderWidth: .8,
                            lBoxColor: maincolor1!,
                          ),
                          'Sleeper seat',
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 7,
              horizontal: 15,
            ), // Add margin so shadow isn't clipped
            decoration: BoxDecoration(
              color:
                  Colors.white, // Background color (must contrast with shadow)
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(
                    0.08,
                  ), // Lower opacity (0.1–0.3 works best)
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 4), // Shadow position (x, y)
                ),
              ],
            ),
            child: widget.seatlist.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100),
                        Lottie.asset('asset/90333-error.json'),
                        const SizedBox(height: 10),
                        const Text('No Seats Available'),
                      ],
                    ),
                  )
                : Padding(
                    padding: _getPaddingBasedOnRows(totalRowno),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: totalRowno * totalcolumn,
                      itemBuilder: (context, index) {
                        final seat = _getSeatForIndex(index);
                        if (seat == null) return Container();
                        return _buildSeatWidget(seat);
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: .9,
                        crossAxisCount:
                            totalRowno, // Changed from totalRowno to totalcolumn
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  EdgeInsets _getPaddingBasedOnRows(int rows) {
    switch (rows) {
      case 1:
        return const EdgeInsets.symmetric(horizontal: 130, vertical: 15);
      case 2:
        return const EdgeInsets.symmetric(horizontal: 100, vertical: 15);
      case 3:
        return const EdgeInsets.symmetric(horizontal: 70, vertical: 15);
      case 4:
        return const EdgeInsets.symmetric(horizontal: 40, vertical: 15);
      case 5:
      case 6:
        return const EdgeInsets.only(top: 15, bottom: 0, right: 0, left: 0);
      default:
        return const EdgeInsets.symmetric(horizontal: 0, vertical: 15);
    }
  }

  Seat? _getSeatForIndex(int index) {
    final row = index % totalRowno;
    final column = index ~/ totalRowno;

    for (final seat in widget.seatlist) {
      final seatRow = int.parse(seat.row);
      final seatColumn = int.parse(seat.column);
      if (row == seatRow && column == seatColumn) {
        return seat;
      }
    }
    return null;
  }

  Widget _buildSeatWidget(Seat seat) {
    final isSelected = widget.selectedseats.any((s) => s.name == seat.name);
    final isAvailable = seat.available == 'true';

    return InkWell(
      onTap: () {
        if (isAvailable) {
          widget.onSeatSelected(seat, !isSelected);
          if (!isSelected) {
            // _showSeatSelectedSnackbar(context, seat);
          }
        }
      },
      child: _getSeatImage(seat, isSelected, isAvailable),
    );
  }

  Widget _getSeatImage(Seat seat, bool isSelected, bool isAvailable) {
    if (!isAvailable) {
      return _getUnavailableSeatImage(seat);
    }

    if (isSelected) {
      return _getSelectedSeatImage(seat);
    }

    if (seat.ladiesSeat == 'true') {
      return _buildSeatContainer(
        width: seat.width,
        length: seat.length,
        lBoxColor: Colors.pink,
        boxhight: 50,

        borderColor: Colors.pink, // Ladies seat border color
        fillColor: Colors.transparent,
      );
    }

    if (seat.malesSeat == 'true') {
      return _buildSeatContainer(
        width: seat.width,
        length: seat.length,
        lBoxColor: Colors.blue,
        boxhight: 50,

        borderColor: Colors.blue, // Males seat border color
        fillColor: Colors.transparent,
      );
    }

    return _buildSeatContainer(
      width: seat.width,
      length: seat.length,
      lBoxColor: maincolor1!,
      boxhight: 50,

      borderColor: maincolor1!, // Default seat border color
      fillColor: Colors.transparent,
    );
  }

  Widget _getUnavailableSeatImage(Seat seat) {
    return _buildSeatContainer(
      width: seat.width,
      boxhight: 50,
      length: seat.length,
      lBoxColor: Colors.grey,

      borderColor: Colors.grey.withOpacity(0.3), // Unavailable seat border
      fillColor: Colors.grey.withOpacity(0.3), // Light fill to show unavailable
    );
  }

  Widget _getSelectedSeatImage(Seat seat) {
    return _buildSeatContainer(
      width: seat.width,
      boxhight: 60,

      length: seat.length,
      borderColor: seat.malesSeat == 'true'
          ? Colors.blueAccent
          : seat.ladiesSeat == 'true'
          ? Colors.pink
          : maincolor1!, // Selected seat border
      fillColor: maincolor1!, // Semi-transparent fill
      borderWidth: 2.5,
      lBoxColor: seat.malesSeat == 'true'
          ? Colors.blueAccent
          : seat.ladiesSeat == 'true'
          ? Colors.pink
          : Colors.white,
    );
  }

  Widget _buildSeatContainer({
    required String width,
    required String length,
    required Color borderColor,
    required Color fillColor,
    required Color lBoxColor,

    required double boxhight,
    double borderWidth = 1.0,
  }) {
    bool sleeper = false;
    if (width == '2' || length == '2') {
      sleeper = true;
    }
    // Convert seat dimensions to numbers
    // double w = double.tryParse(width) ?? 1.0;
    // double l = double.tryParse(length) ?? 1.0;

    // // Base size constants
    // const double baseSize = 30.0;
    // const double marginSize = 5.0;

    // // Calculate dimensions based on seat proportions
    // double containerWidth = w * baseSize;
    // double containerHeight = l * baseSize;

    return
    //  width == '1' && length == '1'
    // ? Icon(Icons.event_seat_outlined, size: 50, weight: 0.5)
    // :
    Padding(
      padding: EdgeInsets.only(top: sleeper ? 0 : 7),
      child: Container(
        margin: EdgeInsets.all(4),

        width: 45,
        height: boxhight,
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        child: Column(
          children: [
            sleeper
                ? Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: lBoxColor,
                        border: Border.all(color: borderColor),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2),
                          topRight: Radius.circular(2),
                        ),
                      ),
                      height: 17, // 15% of container height
                      width: double.infinity,
                    ),
                  )
                : SizedBox(),
            Spacer(),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 8, // 10% of width
                vertical: 6, // 5% of height
              ),
              decoration: BoxDecoration(
                color: lBoxColor,
                borderRadius: BorderRadius.circular(2),
              ),
              height: 7, // 15% of container height
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildLegendItem(Widget box, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        box,

        const SizedBox(width: 16),
        Text(text, style: const TextStyle(fontSize: 14)),
      ],
    ),
  );
}
