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
    this.title,
    this.showSteering = false,
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
  final String? title;
  final bool showSteering;

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
    if (widget.seatlist.isEmpty) return const SizedBox.shrink();

    // Find normalized boundaries
    int minRow = 999;
    int maxRow = 0;
    int minCol = 999;
    int maxCol = 0;

    for (final seat in widget.seatlist) {
      final r = int.parse(seat.row);
      final c = int.parse(seat.column);
      if (r < minRow) minRow = r;
      if (r > maxRow) maxRow = r;
      if (c < minCol) minCol = c;
      if (c > maxCol) maxCol = c;
    }

    final rowCount = maxRow - minRow + 1;
    final colCount = maxCol - minCol + 1;

    return Column(
      children: [
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              '${widget.title!.toUpperCase()} (${widget.seatlist.length})',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: widget.textLight,
                letterSpacing: 1.1,
              ),
            ),
          ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: widget.textLight.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              const double spacing = 2.0; // Reduced spacing
              final double availableWidth = constraints.maxWidth;
              final double unitWidth =
                  (availableWidth - (rowCount - 1) * spacing) / rowCount;
              // Made units shorter to reduce vertical scrolling
              final double unitHeight = unitWidth / 0.60;

              // Calculate the actual required height by finding the maximum extent of any seat
              double maxComputedHeight = 0;
              for (final seat in widget.seatlist) {
                final int c = int.parse(seat.column) - minCol;
                final int sl = int.tryParse(seat.length) ?? 1;
                final double top = c * (unitHeight + spacing);
                final double h = sl * unitHeight + (sl - 1) * spacing;
                // seat height + spacing for label + padding
                final double totalSeatHeight = top + h + 25;
                if (totalSeatHeight > maxComputedHeight) {
                  maxComputedHeight = totalSeatHeight;
                }
              }

              return Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: availableWidth,
                        height: maxComputedHeight,
                        child: Stack(
                          children: widget.seatlist.map((seat) {
                            final int r = int.parse(seat.row) - minRow;
                            final int c = int.parse(seat.column) - minCol;
                            final int sw = int.tryParse(seat.width) ?? 1;
                            final int sl = int.tryParse(seat.length) ?? 1;

                            final double left = r * (unitWidth + spacing);
                            final double top = c * (unitHeight + spacing);
                            final double width =
                                sw * unitWidth + (sw - 1) * spacing;
                            final double height =
                                sl * unitHeight + (sl - 1) * spacing;

                            return Positioned(
                              left: left,
                              top: top,
                              width: width,
                              height:
                                  height +
                                  10, // Enough space for seat + price label
                              child: _buildSeatItem(seat),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSeatItem(Seat seat) {
    final isSelected = widget.selectedseats.any((s) => s.name == seat.name);
    final isAvailable = seat.available == 'true';
    final isSleeper =
        (int.tryParse(seat.width) ?? 1) > 1 ||
        (int.tryParse(seat.length) ?? 1) > 1;
    final isLadies = seat.ladiesSeat == 'true';
    final isMens = seat.malesSeat == 'true';

    Color seatColor = isSelected
        ? widget.accentColor
        : !isAvailable
        ? widget.textLight.withOpacity(0.1)
        : Colors.white;

    Color borderColor = isSelected
        ? widget.accentColor
        : !isAvailable
        ? widget.textLight.withOpacity(0.05)
        : widget.textLight.withOpacity(0.3);

    return GestureDetector(
      onTap: () {
        if (isAvailable) {
          widget.onSeatSelected(seat, !isSelected);
        }
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: seatColor,
                borderRadius: BorderRadius.circular(isSleeper ? 5 : 3),
                border: Border.all(color: borderColor, width: 0.8),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 1,
                    left: 2,
                    right: 2,
                    child: Container(
                      height: isSleeper ? 10 : 2.5,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white.withOpacity(0.25)
                            : borderColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),

                  if (!isAvailable || isSelected || isLadies || isMens)
                    Icon(
                      isLadies
                          ? Iconsax.woman
                          : (isMens ? Iconsax.man : Iconsax.user),
                      size: isSleeper ? 16 : 10,
                      color: isSelected
                          ? Colors.white
                          : isLadies
                          ? Colors.pink.withOpacity(0.4)
                          : isMens
                          ? Colors.blue.withOpacity(0.4)
                          : widget.textLight.withOpacity(0.4),
                    ),

                  Positioned(
                    bottom: 1.5,
                    left: 3,
                    right: 3,
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white.withOpacity(0.2)
                            : borderColor.withOpacity(0.1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 1),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Text(
              !isAvailable
                  ? 'SOLD'
                  : '₹${double.parse(seat.baseFare).toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 6,
                fontWeight: FontWeight.w600,
                color: !isAvailable
                    ? widget.textLight
                    : widget.textSecondary.withOpacity(0.8),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
