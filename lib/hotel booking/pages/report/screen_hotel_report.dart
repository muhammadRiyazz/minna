import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minna/hotel booking/application/report/hotel_report_bloc.dart';
import 'package:minna/hotel booking/domain/report/hotel_report_model.dart';
import 'package:minna/hotel booking/pages/report/screen_hotel_report_detail.dart';
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
        return Shimmer.fromColors(
          baseColor: Colors.grey[200]!,
          highlightColor: Colors.white,
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: borderSoft),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildShimmerBox(width: 120, height: 16),
                    _buildShimmerBox(width: 80, height: 32, radius: 20),
                  ],
                ),
                const SizedBox(height: 20),
                _buildShimmerBox(width: double.infinity, height: 100, radius: 16),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildShimmerBox(width: 100, height: 12),
                    _buildShimmerBox(width: 60, height: 24, radius: 8),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildShimmerBox({required double width, required double height, double radius = 4}) {
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
          Icon(Iconsax.house_2, size: 80, color: secondaryColor.withOpacity(0.3)),
          const SizedBox(height: 16),
          Text(
            "No Hotel Bookings Found",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: maincolor1.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Iconsax.danger, size: 60, color: Colors.redAccent),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.read<HotelReportBloc>().add(FetchHotelReports()),
              style: ElevatedButton.styleFrom(backgroundColor: maincolor1),
              child: const Text("Retry", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportList(List<HotelBookingRecord> reports) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HotelReportBloc>().add(FetchHotelReports());
      },
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        itemCount: reports.length,
        itemBuilder: (context, index) {
          final record = reports[index];
          return _buildBookingCard(record);
        },
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
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: maincolor1,
                                letterSpacing: -0.5,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "Order ID: ${booking.bookingId ?? booking.id}",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildStatusBadge(booking.bookingStatus),
                    ],
                  ),
                ),
                
                // Content Section
                Padding(
                  padding: const EdgeInsets.all(20),
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
                      const SizedBox(height: 20),
                      Divider(color: borderSoft, height: 1),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Iconsax.user, size: 14, color: secondaryColor),
                              const SizedBox(width: 6),
                              Text(
                                "${booking.guests} Guest(s)",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: textPrimary,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${booking.currency} ${booking.netAmount}",
                            style: TextStyle(
                              fontSize: 18,
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
    bool isConfirmed = status.toUpperCase() == "CONFIRMED";
    bool isPending = status.toUpperCase() == "INITIATED" || status.toUpperCase() == "PENDING";
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isConfirmed 
            ? Colors.green.withOpacity(0.1) 
            : isPending 
                ? Colors.orange.withOpacity(0.1) 
                : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: isConfirmed 
              ? Colors.green 
              : isPending 
                  ? Colors.orange[800] 
                  : Colors.red,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
    );
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
            Icon(icon, size: 12, color: textSecondary),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
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
            fontSize: 14,
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
