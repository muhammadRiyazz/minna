// screens/report_list_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:minna/flight/domain/report/report_model.dart';
import 'package:minna/flight/infrastracture/report/report.dart';
import 'package:minna/flight/presendation/report%20details/report_details.dart';
import 'package:minna/flight/presendation/report_list/view_more.dart';
import 'package:minna/comman/const/const.dart';

class ReportListScreen extends StatefulWidget {
  const ReportListScreen({super.key});

  @override
  State<ReportListScreen> createState() => _ReportListScreenState();
}

class _ReportListScreenState extends State<ReportListScreen> {
  late Future<ReportResponse> _reportsFuture;
  final ReportApiService _apiService = ReportApiService();

  // Theme Variables
  final Color _primaryColor = maincolor1;
  final Color _secondaryColor = secondaryColor;
  final Color _backgroundColor = backgroundColor;
  final Color _cardColor = cardColor;
  final Color _textPrimary = textPrimary;
  final Color _textSecondary = textSecondary;
  final Color _textLight = textLight;
  final Color _errorColor = errorColor;
  final Color _warningColor = const Color(0xFFD97706);
  final Color _borderColor = borderSoft;

  @override
  void initState() {
    super.initState();
    _reportsFuture = _apiService.fetchReports();
  }

  void _refreshReports() {
    setState(() {
      _reportsFuture = _apiService.fetchReports();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Main Content removed header
          SliverToBoxAdapter(child: const SizedBox(height: 10)),

          // Main Content
          SliverFillRemaining(
            child: FutureBuilder<ReportResponse>(
              future: _reportsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildShimmerLoading();
                } else if (snapshot.hasError) {
                  return _buildErrorState(snapshot.error.toString());
                } else if (snapshot.hasData) {
                  final response = snapshot.data!;
                  if (response.status) {
                    return _buildSuccessState(response);
                  } else {
                    return _buildFailureState(response.message);
                  }
                } else {
                  return _buildEmptyState();
                }
              },
            ),
          ),
        ],
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

  Widget _buildShimmerBox({required double width, required double height, double radius = 4}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: _errorColor.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(Iconsax.danger, color: _errorColor, size: 48),
          ),
          const SizedBox(height: 24),
          Text('Failed to Load Data', style: TextStyle(color: _textPrimary, fontSize: 18, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: _refreshReports,
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor, 
              foregroundColor: Colors.white, 
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
            ),
            icon: const Icon(Iconsax.refresh, size: 18),
            label: const Text('Try Again', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Widget _buildFailureState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: _warningColor.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(Iconsax.warning_2, color: _warningColor, size: 48),
          ),
          const SizedBox(height: 24),
          Text('Unable to Load Reports', style: TextStyle(color: _textPrimary, fontSize: 18, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          Text(message, style: TextStyle(color: _textSecondary, fontSize: 14), textAlign: TextAlign.center),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _refreshReports,
            style: ElevatedButton.styleFrom(
              backgroundColor: _secondaryColor, 
              foregroundColor: Colors.white, 
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
            ),
            icon: const Icon(Iconsax.refresh, size: 18),
            label: const Text('Retry', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
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
            decoration: BoxDecoration(color: _secondaryColor.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(Iconsax.airplane, color: _secondaryColor, size: 48),
          ),
          const SizedBox(height: 24),
          Text(
            'No Bookings Found',
            style: TextStyle(color: _textPrimary, fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(
            'You haven\'t made any flight bookings yet.',
            style: TextStyle(color: _textSecondary, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessState(ReportResponse response) {
    final reports = response.data?.bookings ?? [];
    final validReports = reports.where((report) => report.response != null).toList();
    final displayReports = validReports.isEmpty ? reports : validReports;

    if (displayReports.isEmpty) {
      return _buildEmptyState();
    }

    displayReports.sort((a, b) {
      int idA = int.tryParse(a.bookingId) ?? 0;
      int idB = int.tryParse(b.bookingId) ?? 0;
      return idB.compareTo(idA);
    });

    final displayBookings = displayReports.take(4).toList();
    final totalBookings = displayReports.length;

    return ListView(
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
                        builder: (context) => FlightAllReportsPage(allReports: validReports),
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
                        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
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
            children: displayBookings.map((report) => _buildReportCard(report)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildReportCard(ReportData report) {
    final response = report.response!;
    final flightLegs = response.journey.flightOption.flightLegs;
    final firstLeg = flightLegs.isNotEmpty ? flightLegs.first : null;
    final lastLeg = flightLegs.isNotEmpty ? flightLegs.last : null;

    final pnr = report.pnr ?? 'ID: ${report.bookingId}';
    final origin = firstLeg?.origin ?? 'N/A';
    final destination = lastLeg?.destination ?? 'N/A';

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
                  builder: (context) => ReportDetailScreen(report: report),
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
                        child: Icon(Iconsax.airplane, size: 20, color: _primaryColor),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$origin to $destination',
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
                              "PNR: $pnr",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: _textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildStatusBadge(report.bookingStatus),
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
                            label: "Departure",
                            value: firstLeg != null
                                ? _formatDate(firstLeg.departureTime)
                                : "N/A",
                            icon: Iconsax.calendar_1,
                          ),
                          Container(
                            height: 30,
                            width: 1,
                            color: _borderColor,
                          ),
                          _buildInfoItem(
                            label: "Travelers",
                            value: "${response.passengers.length} Pax",
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
                                "${flightLegs.length} Flight Segment(s)",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: _textPrimary,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "₹${report.totalAmount}",
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

  String _formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat('dd MMM yyyy').format(parsedDate);
    } catch (e) {
      return date;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'CONFIRMED':
        return Colors.green;
      case 'CANCELLED':
        return _errorColor;
      case 'PENDING':
        return _warningColor;
      default:
        return _secondaryColor;
    }
  }
}
