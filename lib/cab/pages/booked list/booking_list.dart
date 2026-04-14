// lib/cab/presentation/cab_booking_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:minna/cab/application/booked%20info%20list/booked_info_bloc.dart';
import 'package:minna/cab/domain/cab%20report/cab_booked_list.dart';
import 'package:minna/cab/pages/booked%20cab%20details/booked_cab_details.dart';
import 'package:minna/cab/pages/booked%20list/cab_view_more.dart';
import 'package:minna/comman/const/const.dart';

class CabBookingList extends StatefulWidget {
  const CabBookingList({super.key});

  @override
  State<CabBookingList> createState() => _CabBookingListState();
}

class _CabBookingListState extends State<CabBookingList> {
  // Theme standardizing: Use global constants directly from const.dart
  final Color _borderColor = Colors.grey.shade200;

  @override
  void initState() {
    super.initState();
    context.read<BookedInfoBloc>().add(BookedInfoEvent.fetchList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Main Content removed header
          SliverToBoxAdapter(child: const SizedBox(height: 10)),

          // Main Content
          BlocBuilder<BookedInfoBloc, BookedInfoState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () =>
                    SliverFillRemaining(child: _buildShimmerLoading()),
                success:
                    (
                      allBookings,
                      filteredBookings,
                      searchQuery,
                      selectedDate,
                      statusFilter,
                    ) =>
                        _buildSuccessStateSliver(allBookings, filteredBookings),
                error: (message) =>
                    SliverFillRemaining(child: _buildErrorState()),
                orElse: () => SliverFillRemaining(child: _buildInitialState()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessStateSliver(
    List<CabBooking> allBookings,
    List<CabBooking> filteredBookings,
  ) {
    if (allBookings.isEmpty) {
      return SliverFillRemaining(child: _buildEmptyState());
    }

    final displayBookings = allBookings.take(4).toList();
    final totalBookings = allBookings.length;

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          // Header with count and View More
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "RECENT TRIPS",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: textLight,
                  letterSpacing: 1.2,
                ),
              ),
              if (totalBookings > 4)
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CabAllBookingsPage(allBookings: allBookings),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: secondaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "View All",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward_rounded, size: 14),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          ...displayBookings
              .map((booking) => _buildCabBookingCard(booking))
              .toList(),
        ]),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: _borderColor),
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
              _buildShimmerBox(width: double.infinity, height: 80, radius: 16),
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
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  Widget _buildCabBookingCard(CabBooking booking) {
    final statusColor = _getStatusColor(booking.status);

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
        border: Border.all(color: _borderColor, width: 1),
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
                  builder: (context) => BookingDetailsPage(
                    tableID: booking.id,
                    bookingId: booking.bookingId,
                  ),
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
                    border: Border(bottom: BorderSide(color: _borderColor)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: maincolor1.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Iconsax.car, size: 20, color: maincolor1),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking.cabType,
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
                              "Booking ID: ${booking.bookingId}",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildStatusBadge(booking.status),
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
                            label: "Pickup Date",
                            value: _formatDate(booking.date),
                            icon: Iconsax.calendar_1,
                          ),
                          Container(height: 30, width: 1, color: _borderColor),
                          _buildInfoItem(
                            label: "Passenger",
                            value: "${booking.firstName} ${booking.lastName}",
                            icon: Iconsax.user,
                            crossAxisAlignment: CrossAxisAlignment.end,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Divider(color: _borderColor, height: 1),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Iconsax.routing,
                                size: 14,
                                color: secondaryColor,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                booking.tripType,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: textPrimary,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "₹${booking.total}",
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
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w900,
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
            child: Icon(Iconsax.car, color: secondaryColor, size: 48),
          ),
          const SizedBox(height: 24),
          Text(
            'No Bookings Found',
            style: TextStyle(
              color: textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You haven\'t made any cab bookings yet.',
            style: TextStyle(
              color: textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: errorColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.danger, color: errorColor, size: 48),
          ),
          const SizedBox(height: 24),
          Text(
            'Failed to Load Data',
            style: TextStyle(
              color: textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () =>
                context.read<BookedInfoBloc>().add(BookedInfoEvent.fetchList()),
            style: ElevatedButton.styleFrom(
              backgroundColor: maincolor1,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            icon: const Icon(Iconsax.refresh, size: 18),
            label: const Text(
              'Try Again',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialState() =>
      const Center(child: CircularProgressIndicator());

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "confirmed":
        return successColor;
      case "hold":
        return warningColor;
      case "cancelled":
        return errorColor;
      default:
        return textLight;
    }
  }

  String _formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat('dd MMM yyyy').format(parsedDate);
    } catch (e) {
      return date;
    }
  }
}
