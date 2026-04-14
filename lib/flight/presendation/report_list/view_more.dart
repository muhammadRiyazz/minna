import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:minna/flight/domain/report/report_model.dart';
import 'package:minna/flight/presendation/report%20details/report_details.dart';
import 'package:minna/comman/const/const.dart';

class FlightAllReportsPage extends StatefulWidget {
  final List<ReportData> allReports;

  const FlightAllReportsPage({super.key, required this.allReports});

  @override
  State<FlightAllReportsPage> createState() => _FlightAllReportsPageState();
}

class _FlightAllReportsPageState extends State<FlightAllReportsPage> {
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
  final Color _borderColor = borderSoft;

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
    _startDate = DateFormat(
      'yyyy-MM-dd',
    ).format(now.subtract(const Duration(days: 30)));
    _endDate = DateFormat('yyyy-MM-dd').format(now);
    _originalReports = _getValidReports();
    _filteredReports = _originalReports;
  }

  List<ReportData> _getValidReports() {
    return widget.allReports
        .where((report) => report.response != null)
        .toList();
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
      ).format(now.subtract(const Duration(days: 30)));
      _endDate = DateFormat('yyyy-MM-dd').format(now);
      _isDateFilterActive = false;
      _originalReports = _getValidReports();
      _applySearchFilter();
    });
  }

  void _applySearchFilter() {
    List<ReportData> filteredList = List.from(_originalReports);

    if (_isSearchActive && _searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      filteredList = filteredList
          .where(
            (report) =>
                (report.pnr?.toLowerCase().contains(query) ?? false) ||
                (report.bookingId.toLowerCase().contains(query)) ||
                (report.response?.journey.flightOption.flightLegs.any(
                      (leg) =>
                          leg.origin.toLowerCase().contains(query) ||
                          leg.destination.toLowerCase().contains(query),
                    ) ??
                    false) ||
                (report.response?.passengers.any(
                      (passenger) =>
                          passenger.firstName.toLowerCase().contains(query) ||
                          passenger.lastName.toLowerCase().contains(query),
                    ) ??
                    false),
          )
          .toList();
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        elevation: 0,
        backgroundColor: _cardColor,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Date Range',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: _primaryColor,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 320,
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
                  selectionColor: _secondaryColor,
                  startRangeSelectionColor: _secondaryColor,
                  endRangeSelectionColor: _secondaryColor,
                  rangeSelectionColor: _secondaryColor.withOpacity(0.12),
                  todayHighlightColor: _secondaryColor,
                  headerStyle: DateRangePickerHeaderStyle(
                    textStyle: TextStyle(
                      color: _primaryColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: _textSecondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _secondaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        _filterByDateRange();
                      },
                      child: const Text(
                        'Apply',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
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
          String? dateStr = report
              .response
              ?.journey
              .flightOption
              .flightLegs
              .firstOrNull
              ?.departureTime;
          if (dateStr == null) return false;
          final reportDate = DateTime.parse(dateStr);
          return (reportDate.isAtSameMomentAs(startDateTime) ||
                  reportDate.isAfter(startDateTime)) &&
              (reportDate.isAtSameMomentAs(endDateTime) ||
                  reportDate.isBefore(endDateTime));
        } catch (e) {
          return false;
        }
      }).toList();
      _isDateFilterActive = true;
      _isFilterActive = _isDateFilterActive || _isSearchActive;
    });
  }

  void _clearAllFilters() {
    _clearSearch();
    _clearDateFilter();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: _backgroundColor,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Header-less Spacing
            const SliverToBoxAdapter(
              child: SizedBox(height: 10),
            ),

            // Search and Filter Section
            SliverToBoxAdapter(
              child: Padding(
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
                        border: Border.all(color: _borderColor),
                      ),
                      child: Column(
                        children: [
                          // Search Bar
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  onChanged: _onSearchChanged,
                                  decoration: InputDecoration(
                                    hintText: 'Search PNR, Route, Passenger...',
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
                                    suffixIcon:
                                        _searchController.text.isNotEmpty
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
                              Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: _secondaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IconButton(
                                  onPressed: _showDatePickerDialog,
                                  icon: Icon(
                                    Iconsax.calendar_tick,
                                    size: 20,
                                    color: _secondaryColor,
                                  ),
                                  constraints: const BoxConstraints(),
                                ),
                              ),
                            ],
                          ),

                          if (_isDateFilterActive)
                            Container(
                              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                              child: _buildDateRangeBadge(),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Results Count
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'SEARCH RESULTS',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: _textLight,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _secondaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            '${_filteredReports.length} ${_filteredReports.length == 1 ? 'REPORT' : 'REPORTS'}',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: _secondaryColor,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Reports List
            _filteredReports.isEmpty
                ? SliverFillRemaining(child: _buildEmptyState())
                : SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) =>
                            _buildReportCard(_filteredReports[index]),
                        childCount: _filteredReports.length,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRangeBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _secondaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _secondaryColor.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(Iconsax.calendar_1, size: 14, color: _secondaryColor),
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
            child: Icon(Iconsax.close_circle, size: 14, color: _errorColor),
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
          padding: const EdgeInsets.all(20),
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
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            color: _textLight,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          report.pnr ?? report.bookingId,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: _textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '₹${report.amount}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: _secondaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatDate(firstLeg?.departureTime ?? ''),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: _textLight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(height: 1),
              ),

              // Route Section
              Row(
                children: [
                  _buildCityInfo(firstLeg?.origin ?? '---', 'ORIGIN', true),
                  Expanded(
                    child: Column(
                      children: [
                        const Icon(
                          Iconsax.airplane,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 4),
                        Container(height: 1, width: 40, color: _borderColor),
                      ],
                    ),
                  ),
                  _buildCityInfo(
                    lastLeg?.destination ?? '---',
                    'DESTINATION',
                    false,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Footer Badges
              Row(
                children: [
                  _buildFooterBadge(
                    Iconsax.user,
                    '${response.passengers.length} PAX',
                  ),
                  const SizedBox(width: 8),
                  _buildFooterBadge(Iconsax.clock, '${flightLegs.length} LEGS'),
                  const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(report.bookingStatus).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              color: _getStatusColor(report.bookingStatus),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            report.bookingStatus.toUpperCase(),
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                              color: _getStatusColor(report.bookingStatus),
                              letterSpacing: 0.5,
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
    );
  }

  Widget _buildCityInfo(String city, String label, bool isStart) {
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: isStart
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w900,
              color: _textLight,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            city.length > 3
                ? city.substring(0, 3).toUpperCase()
                : city.toUpperCase(),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: _textPrimary,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            city,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: _textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildFooterBadge(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: _textSecondary),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: _textSecondary,
            ),
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
            decoration: BoxDecoration(
              color: _secondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.ticket, color: _secondaryColor, size: 48),
          ),
          const SizedBox(height: 24),
          Text(
            _isFilterActive ? 'No Matches Found' : 'No Reports Found',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _isFilterActive
                ? 'Try adjusting your filters'
                : 'You haven\'t made any bookings yet',
            style: TextStyle(
              color: _textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (_isFilterActive) ...[
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _clearAllFilters,
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              icon: const Icon(Iconsax.refresh, size: 18),
              label: const Text(
                'Clear Filters',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ],
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

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'CONFIRMED':
        return _successColor;
      case 'CANCELLED':
        return _errorColor;
      case 'PENDING':
        return const Color(0xFFD97706);
      default:
        return _secondaryColor;
    }
  }
}

class KeyboardDismisser extends StatelessWidget {
  final Widget child;
  const KeyboardDismisser({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}
