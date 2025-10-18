// screens/report_list_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minna/flight/domain/report/report_model.dart';
import 'package:minna/flight/infrastracture/report/report.dart';
import 'package:minna/flight/presendation/report%20details/report_details.dart';

class ReportListScreen extends StatefulWidget {
  const ReportListScreen({Key? key}) : super(key: key);

  @override
  State<ReportListScreen> createState() => _ReportListScreenState();
}

class _ReportListScreenState extends State<ReportListScreen> {
  late Future<ReportResponse> _reportsFuture;
  final ReportApiService _apiService = ReportApiService();

  // Updated color scheme matching your cab booking details
  static final Color _primaryColor = Colors.black;
  static final Color _secondaryColor = Color(0xFFD4AF37); // Gold
  static final Color _accentColor = Color(0xFFC19B3C); // Darker Gold
  static final Color _backgroundColor = Color(0xFFF8F9FA);
  static final Color _cardColor = Colors.white;
  static final Color _textPrimary = Colors.black;
  static final Color _textSecondary = Color(0xFF666666);
  static final Color _textLight = Color(0xFF999999);
  static final Color _errorColor = Color(0xFFE53935);
  static final Color _successColor = Color(0xFF4CAF50);
  static final Color _warningColor = Color(0xFFFF9800);

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
      appBar: AppBar(
        title: Text(
          'Flight Reports',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: _primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh_rounded, size: 22),
            onPressed: _refreshReports,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: FutureBuilder<ReportResponse>(
        future: _reportsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildShimmerLoading();
          } else if (snapshot.hasError) {
            return _buildErrorState(snapshot.error.toString());
          } else if (snapshot.hasData) {
            final response = snapshot.data!;
            if (response.status == 'SUCCESS') {
              return _buildSuccessState(response);
            } else {
              return _buildFailureState(response.statusDesc);
            }
          } else {
            return _buildEmptyState();
          }
        },
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: _cardColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // Shimmer for header row
                Row(
                  children: [
                    Container(
                      width: 120,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 80,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                // Shimmer for route
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 60,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                // Shimmer for date and passengers
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 80,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _errorColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                color: _errorColor,
                size: 64,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Something went wrong',
              style: TextStyle(
                color: _textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12),
            Text(
              error,
              style: TextStyle(
                color: _textSecondary,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _refreshReports,
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              icon: Icon(Icons.refresh_rounded, size: 20),
              label: Text(
                'Try Again',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFailureState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _warningColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.warning_amber_rounded,
                color: _warningColor,
                size: 64,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Unable to Load Reports',
              style: TextStyle(
                color: _textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12),
            Text(
              message,
              style: TextStyle(
                color: _textSecondary,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _refreshReports,
              style: ElevatedButton.styleFrom(
                backgroundColor: _secondaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              icon: Icon(Icons.refresh_rounded, size: 20),
              label: Text(
                'Retry',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: _secondaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.airplane_ticket_rounded,
                color: _secondaryColor,
                size: 64,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'No Reports Found',
              style: TextStyle(
                color: _textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'There are no flight reports available at the moment.',
              style: TextStyle(
                color: _textSecondary,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _refreshReports,
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              icon: Icon(Icons.refresh_rounded, size: 20),
              label: Text(
                'Refresh',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessState(ReportResponse response) {
    final reports = response.data ?? [];
    
    // Filter out reports with invalid response data
    final validReports = reports.where((report) => report.response != null).toList();
    
    if (validReports.isEmpty) {
      return _buildEmptyState();
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Flight Reports',
                  style: TextStyle(
                    color: _textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '${validReports.length} booking${validReports.length > 1 ? 's' : ''} found',
                  style: TextStyle(
                    color: _textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: validReports.length,
              itemBuilder: (context, index) {
                final report = validReports[index];
                return _buildReportCard(report);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(ReportData report) {
    final response = report.response!;
    final flightLegs = response.journey.flightOption.flightLegs;
    final firstLeg = flightLegs.isNotEmpty ? flightLegs.first : null;
    final lastLeg = flightLegs.isNotEmpty ? flightLegs.last : null;

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
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
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row with PNR and Amount
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BOOKING REFERENCE',
                            style: TextStyle(
                              fontSize: 10,
                              color: _textSecondary,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.0,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            report.alhindPnr ?? 'N/A',
                            style: TextStyle(
                              color: _textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: _secondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '₹${report.amount}',
                        style: TextStyle(
                          color: _secondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // From → To Route
                if (firstLeg != null && lastLeg != null)
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _backgroundColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'FROM',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _textSecondary,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                firstLeg.origin,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today, size: 12, color: _secondaryColor),
                                  SizedBox(width: 4),
                                  Text(
                                    _formatDate(firstLeg.departureTime),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: _textSecondary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: _secondaryColor.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: _secondaryColor.withOpacity(0.3), width: 2),
                                ),
                                child: Icon(
                                  Icons.arrow_forward_rounded,
                                  color: _secondaryColor,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'TO',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _textSecondary,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                lastLeg.destination,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.end,
                              ),
                              SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.calendar_today, size: 12, color: _secondaryColor),
                                  SizedBox(width: 4),
                                  Text(
                                    _formatDate(lastLeg.arrivalTime),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: _textSecondary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _backgroundColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Center(
                      child: Text(
                        'No flight route available',
                        style: TextStyle(
                          color: _textSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 16),

                // Footer Information
                Row(
                  children: [
                    // Flight count
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: _secondaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.flight_takeoff_rounded,
                            color: _secondaryColor,
                            size: 14,
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          '${flightLegs.length} flight${flightLegs.length > 1 ? 's' : ''}',
                          style: TextStyle(
                            fontSize: 12,
                            color: _textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 16),
                    // Passenger count
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: _secondaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.people_rounded,
                            color: _secondaryColor,
                            size: 14,
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          '${response.passengers.length} passenger${response.passengers.length > 1 ? 's' : ''}',
                          style: TextStyle(
                            fontSize: 12,
                            color: _textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    // Booking date
                    Text(
                      _formatDate(report.createdDate),
                      style: TextStyle(
                        fontSize: 12,
                        color: _textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: _textLight,
                      size: 20,
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

  String _formatDateTime(String dateTime) {
    try {
      final dt = DateTime.parse(dateTime);
      return DateFormat('dd MMM yyyy').format(dt);
    } catch (e) {
      return dateTime;
    }
  }
}