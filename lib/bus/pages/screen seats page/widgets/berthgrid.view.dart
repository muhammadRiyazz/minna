import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:iconsax/iconsax.dart';
import '../../../domain/seatlayout/seatlayoutmodal.dart';
import '../../../infrastructure/seats/seatcalculation.dart';

class BerthGridView extends StatefulWidget {
  const BerthGridView({
    super.key,
    required this.seatlist,
    required this.selectedseats,
    required this.onSeatSelected,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
    required this.backgroundColor,
    required this.cardColor,
    required this.textPrimary,
    required this.textSecondary,
    required this.textLight,
  });

  final List<Seat> seatlist;
  final List<Seat> selectedseats;
  final Function(Seat, bool) onSeatSelected;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;
  final Color backgroundColor;
  final Color cardColor;
  final Color textPrimary;
  final Color textSecondary;
  final Color textLight;

  @override
  State<BerthGridView> createState() => _BerthGridViewState();
}

class _BerthGridViewState extends State<BerthGridView> {
  late int totalRowno;
  late int totalcolumn;
  bool showSeatInfo = true;

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
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration: BoxDecoration(
              color: widget.cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 20,
                  spreadRadius: 0,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: widget.seatlist.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100),
                        Lottie.asset(
                          'asset/90333-error.json',
                          width: 120,
                          height: 120,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No Seats Available',
                          style: TextStyle(
                            fontSize: 16,
                            color: widget.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Please try another berth type',
                          style: TextStyle(
                            fontSize: 14,
                            color: widget.textSecondary.withOpacity(0.7),
                          ),
                        ),
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
                        crossAxisCount: totalRowno,
                      ),
                    ),
                  ),
          ),
          _buildSeatInfoSection(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  EdgeInsets _getPaddingBasedOnRows(int rows) {
    switch (rows) {
      case 1:
        return const EdgeInsets.symmetric(horizontal: 100, vertical: 32);
      case 2:
        return const EdgeInsets.symmetric(horizontal: 80, vertical: 32);
      case 3:
        return const EdgeInsets.symmetric(horizontal: 60, vertical: 32);
      case 4:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 32);
      default:
        return const EdgeInsets.all(24);
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
        borderColor: Colors.pink,
        fillColor: Colors.transparent,
        seatColor: Colors.pink,
        isSelected: isSelected,
      );
    }

    if (seat.malesSeat == 'true') {
      return _buildSeatContainer(
        width: seat.width,
        length: seat.length,
        borderColor: Colors.blue,
        fillColor: Colors.transparent,
        seatColor: Colors.blue,
        isSelected: isSelected,
      );
    }

    return _buildSeatContainer(
      width: seat.width,
      length: seat.length,
      borderColor: widget.primaryColor.withOpacity(0.5),
      fillColor: Colors.transparent,
      seatColor: widget.primaryColor,
      isSelected: isSelected,
    );
  }

  Widget _getUnavailableSeatImage(Seat seat) {
    return _buildSeatContainer(
      width: seat.width,
      length: seat.length,
      borderColor: Colors.grey.withOpacity(0.3),
      fillColor: Colors.grey.withOpacity(0.1),
      seatColor: Colors.grey,
      isSelected: false,
    );
  }

  Widget _getSelectedSeatImage(Seat seat) {
    return _buildSeatContainer(
      width: seat.width,
      length: seat.length,
      borderColor: widget.secondaryColor,
      fillColor: widget.secondaryColor,
      seatColor: Colors.white,
      isSelected: true,
    );
  }

  Widget _buildSeatContainer({
    required String width,
    required String length,
    required Color borderColor,
    required Color fillColor,
    required Color seatColor,
    required bool isSelected,
  }) {
    bool sleeper = width == '2' || length == '2';
    double containerHeight = sleeper ? 100 : 52;
    double containerWidth = 44;

    return Padding(
      padding: EdgeInsets.only(top: sleeper ? 0 : 8),
      child: Container(
        margin: const EdgeInsets.all(4),
        width: containerWidth,
        height: containerHeight,
        decoration: BoxDecoration(
          color: isSelected ? fillColor : fillColor,
          borderRadius: BorderRadius.circular(sleeper ? 8 : 12),
          border: Border.all(
            color: isSelected ? borderColor : borderColor.withOpacity(0.5),
            width: 1.5,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: borderColor.withOpacity(0.2),
              offset: const Offset(0, 4),
              blurRadius: 8,
            ),
          ] : [],
        ),
        child: Column(
          children: [
            if (sleeper) ...[
              Container(
                margin: const EdgeInsets.all(6),
                height: 12,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withOpacity(0.4)
                      : borderColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(bottom: 6, left: 10, right: 10),
                height: 3,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withOpacity(0.3)
                      : borderColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ] else ...[
              Container(
                margin: const EdgeInsets.only(top: 6, left: 8, right: 8),
                height: 8,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withOpacity(0.4)
                      : borderColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(bottom: 6, left: 10, right: 10),
                height: 4,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withOpacity(0.3)
                      : borderColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSeatInfoSection() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: widget.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                showSeatInfo = !showSeatInfo;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: widget.secondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Iconsax.info_circle,
                        color: widget.secondaryColor,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Seat Information',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: widget.textPrimary,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
                Icon(
                  showSeatInfo ? Iconsax.arrow_up_1 : Iconsax.arrow_down_1,
                  color: widget.textSecondary.withOpacity(0.6),
                  size: 20,
                ),
              ],
            ),
          ),

          if (showSeatInfo) ...[
            const SizedBox(height: 10),
            const Divider(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SEAT TYPES',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: widget.textSecondary.withOpacity(0.6),
                    letterSpacing: 1.2,
                  ),
                ),
                Row(
                  children: [
                    _buildSmallIndicator('Seater'),
                    const SizedBox(width: 16),
                    _buildSmallIndicator('Sleeper'),
                  ],
                ),
              ],
            ),
            const Divider(height: 25),

            _buildBerthTypeInfo(),
          ],
        ],
      ),
    );
  }

  Widget _buildBerthTypeInfo() {
    return Column(
      children: [
        _buildSeatInfoRow(txt: 'Available for all', color: widget.primaryColor),
        _buildSeatInfoRow(txt: 'Men only', color: Colors.blue),
        _buildSeatInfoRow(txt: 'Women only', color: Colors.pink),
        _buildSeatInfoRow(txt: 'Already booked', color: Colors.grey[300]!),
        _buildSeatInfoRow(txt: 'Your selection', color: widget.secondaryColor),
      ],
    );
  }

  Widget _buildSmallIndicator(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w800,
        color: widget.textPrimary,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildSeatInfoRow({required String txt, required Color color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              txt,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: widget.textPrimary.withOpacity(0.8),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Row(
            children: [
              _buildMinSeat(color, isSleeper: false),
              const SizedBox(width: 12),
              _buildMinSeat(color, isSleeper: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMinSeat(Color color, {required bool isSleeper}) {
    return Container(
      width: 24,
      height: isSleeper ? 32 : 24,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(isSleeper ? 4 : 6),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Center(
        child: Container(
          width: 12,
          height: 3,
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ),
    );
  }
}
