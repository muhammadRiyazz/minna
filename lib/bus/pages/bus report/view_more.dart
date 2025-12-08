import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:minna/bus/domain/report%20modal/report_Modal.dart';
import 'package:minna/bus/pages/Screen%20Ticket%20Details/TicketDetails.dart';

// Add these imports for your API calls
// import 'package:minna/bus/domain/api_services.dart'; // Your API service file
// import 'package:minna/bus/domain/report%20modal/report_Modal.dart'; // Your model

class BusAllBookingsPage extends StatefulWidget {
  final List<BusTicketReport> allBookings;

  const BusAllBookingsPage({
    super.key,
    required this.allBookings,
  });

  @override
  State<BusAllBookingsPage> createState() => _BusAllBookingsPageState();
}

class _BusAllBookingsPageState extends State<BusAllBookingsPage> {
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
  List<BusTicketReport> _filteredBookings = [];
  List<BusTicketReport> _originalBookings = [];
  bool _isFilterActive = false;
  bool _isDateFilterActive = false;
  bool _isSearchActive = false;
  bool _isLoading = false;
  bool _isInitialLoading = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _startDate = DateFormat('yyyy-MM-dd').format(now.subtract(Duration(days: 30)));
    _endDate = DateFormat('yyyy-MM-dd').format(now);
    _originalBookings = _getValidBookings();
    _filteredBookings = _originalBookings;
    _isInitialLoading = false;
  }

  List<BusTicketReport> _getValidBookings() {
    return widget.allBookings.where((report) => 
        report.status != 'Pending' && report.status != 'Failure').toList();
  }

  Future<void> _fetchReportsByDate(String fromDate, String toDate) async {
    if (!mounted) return;
    
    setState(() {
      log(
        'loading.  --- true'
      );
      _isLoading = true;
    });

    try {
      // Uncomment and use your actual API call
      // final resp = await fetchReport(fromdate: fromDate, todate: toDate);
      // final data = busTicketReportFromJson(resp.body);
      
      // For demo, simulate API delay and use filtered data from existing bookings
      await Future.delayed(Duration(milliseconds: 800));
      
      // Filter existing bookings by date range for demo
      // In real app, replace this with actual API response
      final startDateTime = DateTime.parse(fromDate);
      final endDateTime = DateTime.parse(toDate);
      
      final filteredData = widget.allBookings.where((report) {
        try {
          final reportDate = DateTime.parse(report.date);
          return (reportDate.isAtSameMomentAs(startDateTime) || reportDate.isAfter(startDateTime)) &&
                 (reportDate.isAtSameMomentAs(endDateTime) || reportDate.isBefore(endDateTime)) &&
                 report.status != 'Pending' && report.status != 'Failure';
        } catch (e) {
          return false;
        }
      }).toList();

      if (mounted) {
        setState(() {
          _originalBookings = filteredData;
          _filteredBookings = filteredData;
          _isLoading = false;
          _isDateFilterActive = true;
          _isFilterActive = _isDateFilterActive || _isSearchActive;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      // Handle error - show snackbar or dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch bookings: $e'),
          backgroundColor: _errorColor,
        ),
      );
    }
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
      _originalBookings = _getValidBookings();
      _applySearchFilter();
    });
  }

  void _applySearchFilter() {
    List<BusTicketReport> filteredList = List.from(_originalBookings);

    // Apply search filter if active
    if (_isSearchActive && _searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      filteredList = filteredList.where((report) => 
          (report.blockKey.toLowerCase().contains(query) ?? false) ||
          (report.ticketNo.toLowerCase().contains(query) ?? false) ||
          (report.source.toLowerCase().contains(query) ?? false) ||
          (report.destination.toLowerCase().contains(query) ?? false) ||
          (report.status.toLowerCase().contains(query) ?? false)
      ).toList();
    }

    setState(() {
      _filteredBookings = filteredList;
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
                  // Clear Button
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.pop(context);
                  //     _clearDateFilter();
                  //   },
                  //   style: TextButton.styleFrom(
                  //     foregroundColor: _errorColor,
                  //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  //   ),
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       Icon(Icons.clear, size: 16),
                  //       SizedBox(width: 4),
                  //       Text('Clear'),
                  //     ],
                  //   ),
                  // ),
                  
                  // Action Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Cancel Button
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          foregroundColor: _textSecondary,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        child: Text('Cancel'),
                      ),
                      
                      // Apply Button
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [_secondaryColor, _accentColor],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            _fetchReportsByDate(_startDate, _endDate);
                          },
                          child: _isLoading 
                              ? SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : Text(
                                  'Apply Dates',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600,fontSize: 10),
                                ),
                        ),
                      ),
                    ],
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
      body: RefreshIndicator(
           color: _secondaryColor,
        backgroundColor: _cardColor,
        onRefresh:() async{
   await _fetchReportsByDate(_startDate, _endDate);

        },
        child: SafeArea(
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
                                hintText: 'Search by Ticket, Route, or Status...',
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
                            onPressed: _isLoading ? null : _showDatePickerDialog,
                            icon: _isLoading 
                                ? SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(_cardColor),
                                    ),
                                  )
                                : Icon(Icons.calendar_today_rounded, size: 20, color: _cardColor),
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
                      'All Bookings',
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
                            '${_filteredBookings.length} ${_filteredBookings.length == 1 ? 'booking' : 'bookings'}',
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
        
              // Bookings List
              Expanded(
                child: _isLoading
                    ? ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: 6, // Show 6 shimmer cards
                        itemBuilder: (context, index) => _buildShimmerCard(),
                      )
                    : _filteredBookings.isEmpty
                        ? _buildEmptyState()
                        : KeyboardDismisser(
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              itemCount: _filteredBookings.length,
                              itemBuilder: (context, index) {
                                final item = _filteredBookings[index];
                                return _buildBusTripCard(item);
                              },
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBusTripCard(BusTicketReport item) {
    final statusColor = _getStatusColor(item.status);
    String formattedDate = 'N/A';
    String formattedTime = 'N/A';

    try {
      final dateTime = DateTime.parse(item.date);
      formattedDate = DateFormat('MMM dd, yyyy').format(dateTime);
      formattedTime = DateFormat('hh:mm a').format(dateTime);
    } catch (e) {
      print('Error parsing date: ${item.date}');
    }

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
                builder: (context) => TicketDetails(
                  count: item.seatDetails.length,
                  tin: item.ticketNo,
                  blocid: item.slNo,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row with Ticket ID and Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TICKET REFERENCE',
                            style: TextStyle(
                              fontSize: 8,
                              color: _textSecondary,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.0,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            item.ticketNo ?? 'N/A',
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
                            formattedDate,
                            style: TextStyle(
                              color: _secondaryColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
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
                              item.source ?? 'N/A',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
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
                              item.destination ?? 'N/A',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.end,
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
                    // Seats Info
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: _secondaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.event_seat_rounded,
                            color: _secondaryColor,
                            size: 12,
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          '${item.seatDetails.length} seat${item.seatDetails.length > 1 ? 's' : ''}',
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
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: statusColor.withOpacity(0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: statusColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            (item.status ?? 'Unknown').toUpperCase(),
                            style: TextStyle(
                              fontSize: 8,
                              color: statusColor,
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
      padding: EdgeInsets.all(20),
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
              Icons.directions_bus_rounded,
              color: _secondaryColor,
              size: 64,
            ),
          ),
          SizedBox(height: 20),
          Text(
            _isFilterActive ? 'No Matching Bookings' : 'No Bookings Found',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            _isFilterActive 
                ? 'No bookings match your current filters.\nTry adjusting your search criteria.'
                : 'You don\'t have any bus bookings yet.\nStart by booking your first trip!',
            style: TextStyle(
              color: _textSecondary,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          if (_isFilterActive)
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
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: _clearAllFilters,
                child: Text(
                  'Clear All Filters',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
        ],
      ),
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