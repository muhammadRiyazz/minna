import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minna/hotel booking/application/report/hotel_report_bloc.dart';
import 'package:minna/hotel booking/domain/report/hotel_report_model.dart';
import 'package:minna/hotel booking/pages/report/screen_hotel_report_detail.dart';
import 'package:minna/hotel booking/pages/report/hotel_view_more.dart';
import 'package:minna/comman/const/const.dart';

class ScreenHotelReport extends StatefulWidget {
  const ScreenHotelReport({super.key});

  @override
  State<ScreenHotelReport> createState() => _ScreenHotelReportState();
}

class _ScreenHotelReportState extends State<ScreenHotelReport> {
  @override
  void initState() {
    super.initState();
    context.read<HotelReportBloc>().add(FetchHotelReports());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelReportBloc, HotelReportState>(
      builder: (context, state) {
        if (state is HotelReportLoading) {
          return _buildShimmerLoading();
        } else if (state is HotelReportLoaded) {
          if (state.reports.isEmpty) {
            return _buildEmptyState();
          }
          return _buildReportList(state.reports);
        } else if (state is HotelReportError) {
          return _buildErrorState(state.message);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: borderSoft),
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.white,
            child: Column(
              children: [
                // Header Shimmer
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: borderSoft)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildShimmerBox(width: 150, height: 16),
                            const SizedBox(height: 6),
                            _buildShimmerBox(width: 100, height: 10),
                          ],
                        ),
                      ),
                      _buildShimmerBox(width: 60, height: 24, radius: 100),
                    ],
                  ),
                ),
                // Content Shimmer
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildShimmerBox(width: 80, height: 10),
                              const SizedBox(height: 6),
                              _buildShimmerBox(width: 100, height: 14),
                            ],
                          ),
                          Container(height: 30, width: 1, color: borderSoft),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _buildShimmerBox(width: 80, height: 10),
                              const SizedBox(height: 6),
                              _buildShimmerBox(width: 100, height: 14),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: borderSoft,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildShimmerBox(width: 100, height: 14),
                          _buildShimmerBox(width: 80, height: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildShimmerBox({
    required double width,
    required double height,
    double radius = 4,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: secondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.house_2, size: 48, color: secondaryColor),
          ),
          const SizedBox(height: 24),
          Text(
            "No Hotel Bookings Found",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "We couldn't find any hotel bookings in your history.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () =>
                context.read<HotelReportBloc>().add(FetchHotelReports()),
            style: ElevatedButton.styleFrom(
              backgroundColor: maincolor1,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            icon: const Icon(Iconsax.refresh, size: 18),
            label: const Text(
              "Refresh",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return _buildEmptyState();
  }

  Widget _buildReportList(List<HotelBookingRecord> reports) {
    // Sort and take the latest 4 for the preview
    final displayReports = reports.take(4).toList();
    final totalBookings = reports.length;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<HotelReportBloc>().add(FetchHotelReports());
      },
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'MANAGE BOOKINGS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: textLight,
                    letterSpacing: 1.2,
                  ),
                ),
                if (totalBookings > 0)
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HotelAllReportsPage(allReports: reports),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: secondaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    child: Row(
                      children: [
                        const Text(
                          'View All',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_forward_rounded, size: 14),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: displayReports
                  .map((record) => _buildBookingCard(record))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(HotelBookingRecord record) {
    final booking = record.booking;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: borderSoft, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScreenHotelReportDetail(record: record),
                ),
              );
            },
            child: Column(
              children: [
                // Top Header Section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: maincolor1.withOpacity(0.03),
                    border: Border(bottom: BorderSide(color: borderSoft)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: maincolor1.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Iconsax.house, size: 20, color: maincolor1),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking.hotelName,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                color: maincolor1,
                                letterSpacing: -0.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "Order ID: ${booking.bookingId ?? booking.id}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildStatusBadge(record.booking.bookingStatus ?? ""),
                    ],
                  ),
                ),

                // Content Section
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfoItem(
                            label: "Check-In",
                            value: _formatDate(booking.checkIn),
                            icon: Iconsax.calendar_1,
                          ),
                          Container(
                            height: 30,
                            width: 1,
                            color: borderSoft,
                          ),
                          _buildInfoItem(
                            label: "Check-Out",
                            value: _formatDate(booking.checkOut),
                            icon: Iconsax.calendar_2,
                            crossAxisAlignment: CrossAxisAlignment.end,
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Divider(color: borderSoft, height: 1),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Iconsax.user,
                                size: 12,
                                color: secondaryColor,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "${booking.guests} Guest(s)",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: textPrimary,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${booking.currency} ${booking.netAmount}",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                              color: maincolor1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color = _getStatusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          fontSize: 8,
          color: color,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'CONFIRMED':
        return const Color(0xFF0D9488);
      case 'CANCELLED':
        return errorColor;
      case 'INITIATED':
      case 'PENDING':
        return const Color(0xFFD97706);
      default:
        return secondaryColor;
    }
  }

  Widget _buildInfoItem({
    required String label,
    required String value,
    required IconData icon,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
  }) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 10, color: textSecondary),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: maincolor1,
          ),
        ),
      ],
    );
  }

  String _formatDate(String dateStr) {
    try {
      if (dateStr.isEmpty) return "N/A";
      final date = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return dateStr;
    }
  }
}
