import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:minna/bus/pages/Screen%20Ticket%20Details/TicketDetails.dart';
import 'package:minna/bus/pages/bus%20report/view_more.dart';
import 'package:minna/bus/domain/report%20modal/report_Modal.dart';
import 'package:minna/bus/infrastructure/fetch%20reports/fetch_reports.dart';
import 'package:minna/comman/const/const.dart';

class ScreenReport extends StatefulWidget {
  const ScreenReport({super.key});

  @override
  State<ScreenReport> createState() => _ScreenReportState();
}

class _ScreenReportState extends State<ScreenReport> {
  // Theme Variables
  final Color _primaryColor = maincolor1;
  final Color _secondaryColor = secondaryColor;
  final Color _backgroundColor = backgroundColor;
  final Color _cardColor = cardColor;
  final Color _textPrimary = textPrimary;
  final Color _textSecondary = textSecondary;
  final Color _textLight = textLight;
  final Color _errorColor = errorColor;
  final Color _successColor = const Color(0xFF0D9488);
  final Color _warningColor = const Color(0xFFD97706);
  final Color _borderColor = borderSoft;

  bool _isLoading = false;
  bool _isError = false;
  List<BusTicketReport> _reportData = [];

  @override
  void initState() {
    super.initState();
    _fetchReports();
  }

  Future<void> _fetchReports() async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });

    try {
      final now = DateTime.now();
      final startDate = '2000-01-01';
      final endDate = DateFormat('yyyy-MM-dd').format(now);

      final resp = await fetchReport(fromdate: startDate, todate: endDate);
      final data = busTicketReportFromJson(resp.body);

      if (!mounted) return;
      setState(() {
        _reportData = data.reversed.toList();
        _isLoading = false;
      });
    } catch (e) {
      log("Fetch error: $e");
      if (!mounted) return;
      setState(() {
        _isError = true;
        _isLoading = false;
      });
    }
  }

  List<BusTicketReport> get _lastFiveBookings {
    final validReports = _reportData
        .where(
          (report) => report.status != 'Pending' && report.status != 'Failure',
        )
        .toList();
    validReports.sort((a, b) => b.date.compareTo(a.date));
    return validReports.take(5).toList();
  }

  int get _totalValidBookings {
    return _reportData
        .where(
          (report) => report.status != 'Pending' && report.status != 'Failure',
        )
        .length;
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: _cardColor,
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: _secondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.bus, color: _secondaryColor, size: 48),
          ),
          const SizedBox(height: 24),
          Text(
            'No Trips Found',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'We couldn\'t find any trips in your booking history.',
            style: TextStyle(
              color: _textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: _fetchReports,
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            icon: const Icon(Iconsax.refresh, size: 18),
            label: const Text(
              'Refresh',
              style: TextStyle(fontWeight: FontWeight.w700),
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
              color: _errorColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.danger, color: _errorColor, size: 48),
          ),
          const SizedBox(height: 24),
          Text(
            'Failed to Load Data',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: _fetchReports,
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Main Content
          SliverToBoxAdapter(child: const SizedBox(height: 10)),

          // Main Content
          SliverFillRemaining(
            child: RefreshIndicator(
              color: _secondaryColor,
              backgroundColor: _cardColor,
              onRefresh: _fetchReports,
              child: _isLoading && _reportData.isEmpty
                  ? _buildShimmerLoading()
                  : _isError
                  ? _buildErrorState()
                  : _reportData.isEmpty
                  ? _buildEmptyState()
                  : _buildSuccessState(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessState() {
    final lastFiveBookings = _lastFiveBookings;
    final totalBookings = _totalValidBookings;

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 24),
      physics: const AlwaysScrollableScrollPhysics(),
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
                  color: _textLight,
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
                            BusAllBookingsPage(allBookings: _reportData),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: _secondaryColor,
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
            children: lastFiveBookings
                .map((item) => _buildBusTripCard(item))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildBusTripCard(BusTicketReport item) {
    final statusColor = _getStatusColor(item.status);
    final formattedDate = DateFormat(
      'EEE, d MMM yyyy',
    ).format(DateTime.parse(item.date));

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: _cardColor,
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
                  builder: (context) => TicketDetails(
                    count: item.seatDetails.length,
                    tin: item.ticketNo,
                    blocid: item.slNo,
                    transactionId: item.transactionId,
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
                    color: _primaryColor.withOpacity(0.03),
                    border: Border(bottom: BorderSide(color: _borderColor)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: _primaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Iconsax.bus,
                          size: 20,
                          color: _primaryColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${item.source} to ${item.destination}",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                color: _primaryColor,
                                letterSpacing: -0.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "Ticket: ${item.ticketNo}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: _textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildStatusBadge(item.status),
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
                            label: "Travel Date",
                            value: formattedDate,
                            icon: Iconsax.calendar_1,
                          ),
                          Container(
                            height: 30,
                            width: 1,
                            color: _borderColor,
                          ),
                          _buildInfoItem(
                            label: "Booking",
                            value: "${item.seatDetails.length} Seat(s)",
                            icon: Iconsax.user,
                            crossAxisAlignment: CrossAxisAlignment.end,
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Divider(color: _borderColor, height: 1),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Iconsax.info_circle,
                                size: 12,
                                color: _secondaryColor,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "Trip Document",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: _textPrimary,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "₹${item.totalFare}",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                              color: _primaryColor,
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
            Icon(icon, size: 10, color: _textSecondary),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: _textSecondary,
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
            color: _primaryColor,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return _successColor;
      case 'cancelled':
        return _errorColor;
      case 'pending':
        return _warningColor;
      default:
        return _secondaryColor;
    }
  }
}
