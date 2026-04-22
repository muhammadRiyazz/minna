import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:minna/bus/domain/report%20modal/report_Modal.dart';
import 'package:minna/bus/pages/Screen%20Ticket%20Details/TicketDetails.dart';
import 'package:minna/comman/const/const.dart';

// Add these imports for your API calls
// import 'package:minna/bus/domain/api_services.dart'; // Your API service file
// import 'package:minna/bus/domain/report%20modal/report_Modal.dart'; // Your model

class BusAllBookingsPage extends StatefulWidget {
  final List<BusTicketReport> allBookings;

  const BusAllBookingsPage({super.key, required this.allBookings});

  @override
  State<BusAllBookingsPage> createState() => _BusAllBookingsPageState();
}

class _BusAllBookingsPageState extends State<BusAllBookingsPage> {
  // Theme Constants
  final Color _primaryColor = maincolor1;
  final Color _secondaryColor = secondaryColor;
  final Color _accentColor = accentColor;
  final Color _backgroundColor = backgroundColor;
  final Color _cardColor = cardColor;
  final Color _textPrimary = textPrimary;
  final Color _textSecondary = textSecondary;
  final Color _textLight = textLight;
  final Color _errorColor = errorColor;
  final Color _successColor = successColor;
  final Color _warningColor = warningColor;
  final Color _borderColor = borderSoft;

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
    _startDate = DateFormat(
      'yyyy-MM-dd',
    ).format(now.subtract(Duration(days: 30)));
    _endDate = DateFormat('yyyy-MM-dd').format(now);
    _originalBookings = _getValidBookings();
    _filteredBookings = _originalBookings;
    _isInitialLoading = false;
  }

  List<BusTicketReport> _getValidBookings() {
    return widget.allBookings
        .where(
          (report) => report.status != 'Pending' && report.status != 'Failure',
        )
        .toList();
  }

  Future<void> _fetchReportsByDate(String fromDate, String toDate) async {
    if (!mounted) return;

    setState(() {
      log('loading.  --- true');
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
          return (reportDate.isAtSameMomentAs(startDateTime) ||
                  reportDate.isAfter(startDateTime)) &&
              (reportDate.isAtSameMomentAs(endDateTime) ||
                  reportDate.isBefore(endDateTime)) &&
              report.status != 'Pending' &&
              report.status != 'Failure';
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
      _startDate = DateFormat(
        'yyyy-MM-dd',
      ).format(now.subtract(Duration(days: 30)));
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
      filteredList = filteredList
          .where(
            (report) =>
                (report.blockKey.toLowerCase().contains(query) ?? false) ||
                (report.ticketNo.toLowerCase().contains(query) ?? false) ||
                (report.source.toLowerCase().contains(query) ?? false) ||
                (report.destination.toLowerCase().contains(query) ?? false) ||
                (report.status.toLowerCase().contains(query) ?? false),
          )
          .toList();
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
                    Icon(
                      Iconsax.calendar_tick,
                      color: _secondaryColor,
                      size: 24,
                    ),
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
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
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : Text(
                                  'Apply Dates',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                  ),
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
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Iconsax.calendar_1, size: 12, color: _secondaryColor),
            const SizedBox(width: 8),
            Text(
              '${DateFormat('MMM dd, yyyy').format(DateTime.parse(_startDate))}  -  '
              '${DateFormat('MMM dd, yyyy').format(DateTime.parse(_endDate))}',
              style: TextStyle(
                fontSize: 12,
                color: _textPrimary,
                fontWeight: FontWeight.w500,
              ),
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
                  child: Icon(
                    Iconsax.close_circle,
                    size: 12,
                    color: _errorColor,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required VoidCallback onClear,
    bool isClearAll = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isClearAll
            ? _errorColor.withOpacity(0.1)
            : _secondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isClearAll
              ? _errorColor.withOpacity(0.3)
              : _secondaryColor.withOpacity(0.3),
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
                  isClearAll ? Iconsax.refresh : Iconsax.close_circle,
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
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: RefreshIndicator(
                color: _secondaryColor,
                backgroundColor: _cardColor,
                onRefresh: () async {
                  await _fetchReportsByDate(_startDate, _endDate);
                },
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(child: _buildSearchAndFilter()),
                    _filteredBookings.isEmpty
                        ? SliverFillRemaining(child: _buildEmptyState())
                        : SliverPadding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) =>
                                    _buildBusTripCard(_filteredBookings[index]),
                                childCount: _filteredBookings.length,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Iconsax.arrow_left_2, size: 20),
            onPressed: () => Navigator.pop(context),
            color: _primaryColor,
          ),
          const SizedBox(width: 8),
          Text(
            'Bus Bookings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: _textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _secondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              '${_filteredBookings.length} TOTAL',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: _secondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: _cardColor,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: _onSearchChanged,
                        decoration: InputDecoration(
                          hintText: 'Search Ticket, Route, Status...',
                          hintStyle: TextStyle(
                            color: _textLight,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          prefixIcon: Icon(
                            Iconsax.search_normal_1,
                            color: _secondaryColor,
                            size: 18,
                          ),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: Icon(
                                    Iconsax.close_circle,
                                    color: _textLight,
                                    size: 16,
                                  ),
                                  onPressed: _clearSearch,
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 15,
                          ),
                        ),
                        style: TextStyle(
                          color: _textPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _showDatePickerDialog,
                      icon: Icon(
                        Iconsax.calendar_tick,
                        size: 20,
                        color: _secondaryColor,
                      ),
                    ),
                  ],
                ),
                if (_isDateFilterActive)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: _secondaryColor.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _secondaryColor.withOpacity(0.1),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Iconsax.calendar,
                            size: 14,
                            color: _secondaryColor,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${DateFormat('dd MMM').format(DateTime.parse(_startDate))} - ${DateFormat('dd MMM').format(DateTime.parse(_endDate))}',
                              style: TextStyle(
                                fontSize: 11,
                                color: _textPrimary,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: _clearDateFilter,
                            child: Icon(
                              Iconsax.close_circle,
                              size: 14,
                              color: _errorColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusTripCard(BusTicketReport item) {
    Color statusColor = _getStatusColor(item.status);
    String formattedDate = 'N/A';
    try {
      final dateTime = DateTime.parse(item.date);
      formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
    } catch (e) {}

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
        border: Border.all(color: Colors.grey.shade100),
      ),
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
        borderRadius: BorderRadius.circular(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _primaryColor.withOpacity(0.03),
                border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Iconsax.bus, size: 20, color: _primaryColor),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item.source} → ${item.destination}',
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
                          "PNR: ${item.ticketNo}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusBadge(item.status, _getStatusColor(item.status)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoItem(
                        "Trip Date",
                        formattedDate,
                        Iconsax.calendar_1,
                      ),
                      Container(height: 30, width: 1, color: _borderColor),
                      _buildInfoItem(
                        "Passenger",
                        '${item.seatDetails.length} Seat(s)',
                        Iconsax.user,
                        crossAxisAlignment: CrossAxisAlignment.end,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Divider(height: 1),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Iconsax.ticket,
                            size: 12,
                            color: _secondaryColor,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            item.ticketNo ?? '---',
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
    );
  }

  Widget _buildStatusBadge(String status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildInfoItem(
    String label,
    String value,
    IconData icon, {
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
            _isSearchActive ? 'No Matches Found' : 'No Bookings Found',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "confirmed":
        return _successColor;
      case "cancelled":
        return _errorColor;
      default:
        return _warningColor;
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
