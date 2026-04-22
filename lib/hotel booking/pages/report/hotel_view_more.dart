import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:minna/hotel%20booking/domain/report/hotel_report_model.dart';
import 'package:minna/hotel%20booking/pages/report/screen_hotel_report_detail.dart';
import 'package:minna/comman/const/const.dart';

class HotelAllReportsPage extends StatefulWidget {
  final List<HotelBookingRecord> allReports;

  const HotelAllReportsPage({super.key, required this.allReports});

  @override
  State<HotelAllReportsPage> createState() => _HotelAllReportsPageState();
}

class _HotelAllReportsPageState extends State<HotelAllReportsPage> {
  // Theme Variables
  final Color _primaryColor = maincolor1;
  final Color _secondaryColor = secondaryColor;
  final Color _backgroundColor = backgroundColor;
  final Color _cardColor = cardColor;
  final Color _textPrimary = textPrimary;
  final Color _textSecondary = textSecondary;
  final Color _textLight = textLight;
  final Color _errorColor = errorColor;
  final Color _successColor = successColor;
  final Color _borderColor = borderSoft;

  final TextEditingController _searchController = TextEditingController();
  String _startDate = '';
  String _endDate = '';
  List<HotelBookingRecord> _filteredReports = [];
  List<HotelBookingRecord> _originalReports = [];
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
    _originalReports = widget.allReports;
    _filteredReports = _originalReports;
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
      _isDateFilterActive = false;
      _filteredReports = _originalReports;
      _applySearchFilter();
    });
  }

  void _applySearchFilter() {
    List<HotelBookingRecord> filteredList = List.from(_originalReports);

    if (_isDateFilterActive) {
      final start = DateTime.parse(_startDate);
      final end = DateTime.parse(_endDate);
      filteredList = filteredList.where((record) {
        try {
          final checkIn = DateTime.parse(record.booking.checkIn);
          return (checkIn.isAtSameMomentAs(start) || checkIn.isAfter(start)) &&
              (checkIn.isAtSameMomentAs(end) || checkIn.isBefore(end));
        } catch (e) {
          return false;
        }
      }).toList();
    }

    if (_isSearchActive && _searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      filteredList = filteredList.where((record) {
        final booking = record.booking;
        return booking.hotelName.toLowerCase().contains(query) ||
            (booking.bookingId?.toLowerCase().contains(query) ?? false) ||
            booking.id.toString().toLowerCase().contains(query);
      }).toList();
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
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
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
                        setState(() => _isDateFilterActive = true);
                        _applySearchFilter();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(child: _buildSearchAndFilter()),
                  _filteredReports.isEmpty
                      ? SliverFillRemaining(child: _buildEmptyState())
                      : SliverPadding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) =>
                                  _buildBookingCard(_filteredReports[index]),
                              childCount: _filteredReports.length,
                            ),
                          ),
                        ),
                ],
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
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            onPressed: () => Navigator.pop(context),
            color: _primaryColor,
          ),
          const SizedBox(width: 8),
          Text(
            'Hotel History',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: _primaryColor,
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
              '${_filteredReports.length} ${_filteredReports.length == 1 ? 'BOOKING' : 'BOOKINGS'}',
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
              border: Border.all(color: _borderColor),
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
                          hintText: 'Search Hotel or Order ID...',
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
                            Iconsax.calendar_1,
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

  Widget _buildBookingCard(HotelBookingRecord record) {
    final booking = record.booking;
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
              builder: (context) => ScreenHotelReportDetail(record: record),
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
                    child: Icon(Iconsax.house, size: 20, color: _primaryColor),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking.hotelName,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                            color: _primaryColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "ID: ${booking.bookingId ?? booking.id}",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusBadge(record.booking.bookingStatus),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoItem(
                        "Check-In",
                        _formatDate(booking.checkIn),
                        Iconsax.calendar_1,
                      ),
                      Container(height: 30, width: 1, color: _borderColor),
                      _buildInfoItem(
                        "Check-Out",
                        _formatDate(booking.checkOut),
                        Iconsax.calendar_2,
                        crossAxisAlignment: CrossAxisAlignment.end,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(height: 1),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${booking.guests} Guest(s) • ${booking.rooms} Room(s)",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: _textPrimary,
                        ),
                      ),
                      Text(
                        "${booking.currency} ${booking.netAmount}",
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

  Widget _buildStatusBadge(String status) {
    bool isConfirmed = status.toUpperCase() == "CONFIRMED";
    bool isPending =
        status.toUpperCase() == "INITIATED" ||
        status.toUpperCase() == "PENDING";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isConfirmed
            ? Colors.green.withOpacity(0.12)
            : isPending
            ? Colors.orange.withOpacity(0.12)
            : Colors.red.withOpacity(0.12),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: isConfirmed
              ? Colors.green
              : isPending
              ? Colors.orange[800]
              : Colors.red,
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
            child: Icon(Iconsax.house, color: _secondaryColor, size: 48),
          ),
          const SizedBox(height: 24),
          Text(
            _isFilterActive ? 'No Matches Found' : 'No Bookings Found',
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

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return dateStr;
    }
  }
}
