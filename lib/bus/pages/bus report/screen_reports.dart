import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minna/comman/const/const.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:minna/bus/domain/report%20modal/report_Modal.dart';
import 'package:minna/bus/infrastructure/fetch%20reports/fetch_reports.dart';
import 'package:minna/bus/pages/bus%20report/widget/DetailsPartContainer.dart';

class ScreenReport extends StatefulWidget {
  const ScreenReport({super.key});

  @override
  State<ScreenReport> createState() => _ScreenReportState();
}

class _ScreenReportState extends State<ScreenReport> {
  final TextEditingController _bookingIdController = TextEditingController();
  String _startDate = '';
  String _endDate = '';
  bool _isLoading = false;
  bool _isError = false;
  List<BusTicketReport> _reportData = [];
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _startDate = '2000-01-01';
    _endDate = DateFormat('yyyy-MM-dd').format(now);
    _fetchReports();
  }

  @override
  void dispose() {
    _bookingIdController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchReports() async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });

    try {
      final resp = await fetchReport(fromdate: _startDate, todate: _endDate);
      final data = busTicketReportFromJson(resp.body);

      setState(() {
        _reportData = data;
        _isLoading = false;
      });
    } catch (e) {
      log("Fetch error: $e");
      setState(() {
        _isError = true;
        _isLoading = false;
      });
    }
  }

  void _onDateRangeSelected(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      final start = args.value.startDate;
      final end = args.value.endDate ?? args.value.startDate;

      setState(() {
        _startDate = DateFormat('yyyy-MM-dd').format(start);
        _endDate = DateFormat('yyyy-MM-dd').format(end);
      });

      _fetchReports();
    }
  }

  List<BusTicketReport> get _filteredReports {
    final query = _bookingIdController.text.trim().toLowerCase();
    if (query.isEmpty) return _reportData;
    return _reportData
        .where((report) => report.blockKey.toLowerCase().contains(query))
        .toList();
  }

  void _showDatePickerDialog() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Date Range',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: maincolor1,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 350,
                child: SfDateRangePicker(
                  selectionMode: DateRangePickerSelectionMode.range,
                  onSelectionChanged: _onDateRangeSelected,
                  initialSelectedRange: PickerDateRange(
                    DateTime.now().subtract(const Duration(days: 7)),
                    DateTime.now(),
                  ),
                  selectionColor: maincolor1!.withOpacity(0.2),
                  startRangeSelectionColor: maincolor1,
                  endRangeSelectionColor: maincolor1,
                  rangeSelectionColor: maincolor1!.withOpacity(0.1),
                  todayHighlightColor: maincolor1,
                  monthViewSettings: const DateRangePickerMonthViewSettings(
                    showTrailingAndLeadingDates: true,
                  ),
                  headerStyle: DateRangePickerHeaderStyle(
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      color: maincolor1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: maincolor1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      _fetchReports();
                    },
                    child: const Text(
                      'Apply',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateRangeText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 8),
        Text(
          '${DateFormat('MMM dd, yyyy').format(DateTime.parse(_startDate))} - '
          '${DateFormat('MMM dd, yyyy').format(DateTime.parse(_endDate))}',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.flight, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No Trips Found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'We couldn\'t find any trips for the selected criteria.\n'
            'Try adjusting your search or date range.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: maincolor1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: _fetchReports,
            child: const Text('Refresh', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Failed to Load Data',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'There was an issue fetching your reports.\n'
            'Please check your connection and try again.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: maincolor1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: _fetchReports,
            child: const Text('Retry', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,

      child: Column(
        children: [
          // Header with filter controls
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              // color: Colors.white,
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.1),
              //     blurRadius: 8,
              //     offset: const Offset(0, 4),
              //   ),
              // ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _bookingIdController,
                        onChanged: (_) => setState(() {}),
                        decoration: InputDecoration(
                          hintText: 'Search by Booking ID...',
                          prefixIcon: Icon(Icons.search, color: maincolor1),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: [?maincolor1, Colors.blue.shade400],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: IconButton(
                        onPressed: _showDatePickerDialog,
                        icon: const Icon(Icons.date_range, color: Colors.white),
                        tooltip: 'Select Date Range',
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: 12),
                // _buildDateRangeText(),
              ],
            ),
          ),

          // Status indicator
          if (_isLoading)
            LinearProgressIndicator(color: maincolor1, minHeight: 2),

          // Content section
          Expanded(
            child: RefreshIndicator(
              color: maincolor1,
              onRefresh: _fetchReports,
              child: _isLoading && _reportData.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : _isError
                  ? _buildErrorState()
                  : _filteredReports.isEmpty
                  ? _buildEmptyState()
                  : CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate((
                              context,
                              index,
                            ) {
                              final item = _filteredReports[index];
                              if (item.status == 'Pending' ||
                                  item.status == 'Failure') {
                                return const SizedBox.shrink();
                              }
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: DetailsPart(
                                  reportData: _filteredReports,
                                  index: index,
                                ),
                              );
                            }, childCount: _filteredReports.length),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
