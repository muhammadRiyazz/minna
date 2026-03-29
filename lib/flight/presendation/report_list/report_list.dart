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
                totalBookings > 4 ? 'RECENT TRIPS' : 'YOUR TRIPS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: _textLight,
                  letterSpacing: 1.2,
                ),
              ),
              if (totalBookings > 4)
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

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: _borderColor),
      ),
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
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PNR / BOOKING ID',
                            style: TextStyle(
                              fontSize: 10,
                              color: _textLight,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            report.pnr ?? 'ID: ${report.bookingId}',
                            style: TextStyle(
                              color: _textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _secondaryColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: _secondaryColor.withOpacity(0.2)),
                      ),
                      child: Text(
                        '₹${report.totalAmount}',
                        style: TextStyle(
                          fontSize: 12,
                          color: _secondaryColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Route Section
                if (firstLeg != null && lastLeg != null)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _backgroundColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade100),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    firstLeg.origin,
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: _textPrimary),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text('Origin', style: TextStyle(fontSize: 10, color: _textSecondary, fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(color: _secondaryColor.withOpacity(0.1), shape: BoxShape.circle),
                                child: Icon(Iconsax.airplane, color: _secondaryColor, size: 14),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    lastLeg.destination,
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: _textPrimary),
                                    textAlign: TextAlign.end,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text('Destination', style: TextStyle(fontSize: 10, color: _textSecondary, fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(height: 1)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Iconsax.calendar_1, size: 14, color: _secondaryColor),
                                const SizedBox(width: 8),
                                Text(
                                  _formatDate(firstLeg.departureTime),
                                  style: TextStyle(fontSize: 11, color: _textSecondary, fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Iconsax.user, size: 14, color: _secondaryColor),
                                const SizedBox(width: 8),
                                Text(
                                  '${response.passengers.length} Pax',
                                  style: TextStyle(fontSize: 11, color: _textSecondary, fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                else
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: _backgroundColor, borderRadius: BorderRadius.circular(16)),
                    child: Center(child: Text('Route details unavailable', style: TextStyle(color: _textSecondary, fontSize: 12))),
                  ),
                const SizedBox(height: 20),

                // Footer Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: _secondaryColor.withOpacity(0.1), shape: BoxShape.circle),
                          child: Icon(Iconsax.info_circle, color: _secondaryColor, size: 14),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${flightLegs.length} Flight${flightLegs.length > 1 ? 's' : ''}',
                          style: TextStyle(fontSize: 12, color: _textPrimary, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    Text(
                      'DETAILS',
                      style: TextStyle(
                        fontSize: 11,
                        color: _secondaryColor,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
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
}
