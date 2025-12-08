// screens/flight_all_reports_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:minna/flight/domain/report/report_model.dart';
import 'package:minna/flight/presendation/report%20details/report_details.dart';

class FlightAllReportsPage extends StatefulWidget {
  final List<ReportData> allReports;

  const FlightAllReportsPage({
    super.key,
    required this.allReports,
  });

  @override
  State<FlightAllReportsPage> createState() => _FlightAllReportsPageState();
}

class _FlightAllReportsPageState extends State<FlightAllReportsPage> {
  // Theme Colors
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37);
  final Color _accentColor = Color(0xFFC19B3C);
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);
  final Color _errorColor = Color(0xFFE53935);
  final Color _successColor = Color(0xFF4CAF50);
  final Color _warningColor = Color(0xFFFF9800);

  final TextEditingController _searchController = TextEditingController();
  String _startDate = '';
  String _endDate = '';
  List<ReportData> _filteredReports = [];
  List<ReportData> _originalReports = [];
  bool _isFilterActive = false;
  bool _isDateFilterActive = false;
  bool _isSearchActive = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _startDate = DateFormat('yyyy-MM-dd').format(now.subtract(Duration(days: 30)));
    _endDate = DateFormat('yyyy-MM-dd').format(now);
    _originalReports = _getValidReports();
    _filteredReports = _originalReports;
  }

  List<ReportData> _getValidReports() {
    return widget.allReports.where((report) => report.response != null).toList();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _isSearchActive = query.isNotEmpty;
      _applySearchFilter();
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _isSearchActive = false;
      _applySearchFilter();
    });
  }

  void _clearDateFilter() {
    setState(() {
      final now = DateTime.now();
      _startDate = DateFormat('yyyy-MM-dd').format(now.subtract(Duration(days: 30)));
      _endDate = DateFormat('yyyy-MM-dd').format(now);
      _isDateFilterActive = false;
      _originalReports = _getValidReports();
      _applySearchFilter();
    });
  }

  void _applySearchFilter() {
    List<ReportData> filteredList = List.from(_originalReports);

    // Apply search filter if active
    if (_isSearchActive && _searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      filteredList = filteredList.where((report) => 
          (report.alhindPnr?.toLowerCase().contains(query) ?? false) ||
          (report.response?.journey.flightOption.flightLegs.any((leg) => 
            leg.origin.toLowerCase().contains(query) || 
            leg.destination.toLowerCase().contains(query)) ?? false) ||
          (report.response?.passengers.any((passenger) => 
            passenger.firstName.toLowerCase().contains(query) || 
            passenger.lastName.toLowerCase().contains(query)) ?? false)
      ).toList();
    }

    setState(() {
      _filteredReports = filteredList;
      _isFilterActive = _isDateFilterActive || _isSearchActive;
    });
  }

  void _showDatePickerDialog() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 8,
        backgroundColor: _cardColor,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: _backgroundColor, width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_month_rounded, color: _secondaryColor, size: 24),
                    const SizedBox(width: 12),
                    Text(
                      'Select Date Range',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: _primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // Date Picker
              SizedBox(
                height: 350,
                child: SfDateRangePicker(
                  selectionMode: DateRangePickerSelectionMode.range,
                  onSelectionChanged: (args) {
                    if (args.value is PickerDateRange) {
                      final start = args.value.startDate;
                      final end = args.value.endDate ?? args.value.startDate;
                      if (start != null && end != null) {
                        setState(() {
                          _startDate = DateFormat('yyyy-MM-dd').format(start);
                          _endDate = DateFormat('yyyy-MM-dd').format(end);
                        });
                      }
                    }
                  },
                  initialSelectedRange: PickerDateRange(
                    DateTime.parse(_startDate),
                    DateTime.parse(_endDate),
                  ),
                  selectionColor: _secondaryColor.withOpacity(0.3),
                  startRangeSelectionColor: _secondaryColor,
                  endRangeSelectionColor: _secondaryColor,
                  rangeSelectionColor: _secondaryColor.withOpacity(0.1),
                  todayHighlightColor: _secondaryColor,
                  monthViewSettings: const DateRangePickerMonthViewSettings(
                    showTrailingAndLeadingDates: true,
                  ),
                  headerStyle: DateRangePickerHeaderStyle(
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      color: _primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Action Buttons Row
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      foregroundColor: _textSecondary,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    child: Text('Cancel'),
                  ),
                  SizedBox(width: 8),
                  
                  // Apply Button
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [_secondaryColor, _accentColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: _secondaryColor.withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        _filterByDateRange();
                      },
                      child: Text(
                        'Apply Dates',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
                      ),
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

  void _filterByDateRange() {
    setState(() {
      final startDateTime = DateTime.parse(_startDate);
      final endDateTime = DateTime.parse(_endDate);
      
      _filteredReports = _originalReports.where((report) {
        try {
          final reportDate = DateTime.parse(report.createdDate);
          return (reportDate.isAtSameMomentAs(startDateTime) || reportDate.isAfter(startDateTime)) &&
                 (reportDate.isAtSameMomentAs(endDateTime) || reportDate.isBefore(endDateTime));
        } catch (e) {
          return false;
        }
      }).toList();
      _isDateFilterActive = true;
      _isFilterActive = _isDateFilterActive || _isSearchActive;
    });
  }

  Widget _buildDateRangeText() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: _secondaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(6)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.calendar_today_rounded, size: 12, color: _secondaryColor),
            const SizedBox(width: 8),
            Text(
              '${DateFormat('MMM dd, yyyy').format(DateTime.parse(_startDate))}  -  '
              '${DateFormat('MMM dd, yyyy').format(DateTime.parse(_endDate))}',
              style: TextStyle(fontSize: 12, color: _textPrimary, fontWeight: FontWeight.w500),
            ),
            if (_isDateFilterActive) ...[
              SizedBox(width: 8),
              GestureDetector(
                onTap: _clearDateFilter,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: _errorColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, size: 12, color: _errorColor),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip({required String label, required VoidCallback onClear, bool isClearAll = false}) {
    return Container(
      decoration: BoxDecoration(
        color: isClearAll ? _errorColor.withOpacity(0.1) : _secondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isClearAll ? _errorColor.withOpacity(0.3) : _secondaryColor.withOpacity(0.3),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isClearAll ? _errorColor : _textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 4),
            GestureDetector(
              onTap: onClear,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: isClearAll ? _errorColor : _secondaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isClearAll ? Icons.clear_all : Icons.close,
                  size: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _clearAllFilters() {
    _clearSearch();
    _clearDateFilter();
  }

  Widget _buildShimmerCard() {
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
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Shimmer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      height: 10,
                      decoration: BoxDecoration(
                        color: _backgroundColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 120,
                      height: 16,
                      decoration: BoxDecoration(
                        color: _backgroundColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 80,
                  height: 30,
                  decoration: BoxDecoration(
                    color: _backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Route Card Shimmer
            Container(
              padding: EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: _backgroundColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          height: 10,
                          decoration: BoxDecoration(
                            color: _cardColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          width: 80,
                          height: 14,
                          decoration: BoxDecoration(
                            color: _cardColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: _cardColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 30,
                          height: 10,
                          decoration: BoxDecoration(
                            color: _cardColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          width: 80,
                          height: 14,
                          decoration: BoxDecoration(
                            color: _cardColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Footer Shimmer
            Row(
              children: [
                Container(
                  width: 60,
                  height: 20,
                  decoration: BoxDecoration(
                    color: _backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Spacer(),
                Container(
                  width: 70,
                  height: 25,
                  decoration: BoxDecoration(
                    color: _backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
        actions: [
          if (_isFilterActive)
            IconButton(
              onPressed: _clearAllFilters,
              icon: Icon(Icons.filter_alt_off_rounded, color: Colors.white),
              tooltip: 'Clear all filters',
            ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Search and Filter Section
            Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(12),
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
              child: Column(
                children: [
                  // Search Bar with Clear Button
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: _backgroundColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: _searchController,
                            onChanged: _onSearchChanged,
                            decoration: InputDecoration(
                              hintText: 'Search by PNR, Route, or Passenger...',
                              hintStyle: TextStyle(color: _textLight, fontSize: 14),
                              prefixIcon: Icon(Icons.search_rounded, color: _secondaryColor, size: 20),
                              suffixIcon: _searchController.text.isNotEmpty
                                  ? IconButton(
                                      icon: Icon(Icons.clear_rounded, color: _textLight, size: 18),
                                      onPressed: _clearSearch,
                                    )
                                  : null,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            ),
                            style: TextStyle(color: _textPrimary, fontSize: 14),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        decoration: BoxDecoration(
                         color: _secondaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: _showDatePickerDialog,
                          icon: Icon(Icons.calendar_today_rounded, size: 20, color: _cardColor),
                          tooltip: 'Select Date Range',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  _buildDateRangeText()
                ],
              ),
            ),

            // Results Count
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All Flight Reports',
                    style: TextStyle(
                      color: _textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.confirmation_number_rounded, size: 12, color: _secondaryColor),
                        SizedBox(width: 6),
                        Text(
                          '${_filteredReports.length} ${_filteredReports.length == 1 ? 'report' : 'reports'}',
                          style: TextStyle(
                            color: _secondaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            // Reports List
            Expanded(
              child: _filteredReports.isEmpty
                  ? _buildEmptyState()
                  : KeyboardDismisser(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _filteredReports.length,
                        itemBuilder: (context, index) {
                          final item = _filteredReports[index];
                          return _buildReportCard(item);
                        },
                      ),
                    ),
            ),
          ],
        ),
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
            padding: EdgeInsets.all(15.0),
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
                              fontSize: 8,
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
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                            color: _secondaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '₹${report.amount}',
                            style: TextStyle(
                              color: _secondaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          _formatDate(report.createdDate),
                          style: TextStyle(
                            color: _textLight,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Route Information Card
                Container(
                  padding: EdgeInsets.all(13),
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
                              firstLeg?.origin ?? 'N/A',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, size: 12, color: _secondaryColor),
                                SizedBox(width: 4),
                                Text(
                                  firstLeg != null ? _formatDate(firstLeg.departureTime) : 'N/A',
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
                              lastLeg?.destination ?? 'N/A',
                              style: TextStyle(
                                fontSize: 12,
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
                                  lastLeg != null ? _formatDate(lastLeg.arrivalTime) : 'N/A',
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
                            size: 12,
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          '${flightLegs.length} flight${flightLegs.length > 1 ? 's' : ''}',
                          style: TextStyle(
                            fontSize: 10,
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
                            size: 12,
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          '${response.passengers.length} passenger${response.passengers.length > 1 ? 's' : ''}',
                          style: TextStyle(
                            fontSize: 10,
                            color: _textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    // Status Badge
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _successColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _successColor.withOpacity(0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: _successColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            'CONFIRMED',
                            style: TextStyle(
                              fontSize: 8,
                              color: _successColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
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

  Widget _buildEmptyState() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_secondaryColor.withOpacity(0.1), _accentColor.withOpacity(0.1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
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
              _isFilterActive ? 'No Matching Reports' : 'No Reports Found',
              style: TextStyle(
                color: _textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                _isFilterActive 
                    ? 'No reports match your current filters.\nTry adjusting your search criteria.'
                    : 'You don\'t have any flight reports yet.\nStart by booking your first flight!',
                style: TextStyle(
                  color: _textSecondary,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            if (_isFilterActive)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_secondaryColor, _accentColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: _secondaryColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    onPressed: _clearAllFilters,
                    child: Text(
                      'Clear All Filters',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
          ],
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

// Helper widget to dismiss keyboard when scrolling
class KeyboardDismisser extends StatelessWidget {
  final Widget child;

  const KeyboardDismisser({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: child,
    );
  }
}