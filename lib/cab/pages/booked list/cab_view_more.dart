import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:minna/cab/domain/cab%20report/cab_booked_list.dart';
import 'package:minna/cab/pages/booked%20cab%20details/booked_cab_details.dart';
import 'package:minna/comman/const/const.dart';

class CabAllBookingsPage extends StatefulWidget {
  final List<CabBooking> allBookings;

  const CabAllBookingsPage({super.key, required this.allBookings});

  @override
  State<CabAllBookingsPage> createState() => _CabAllBookingsPageState();
}

class _CabAllBookingsPageState extends State<CabAllBookingsPage> {
  // Color Theme
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

  final TextEditingController _searchController = TextEditingController();
  String _startDate = '';
  String _endDate = '';
  List<CabBooking> _filteredBookings = [];
  List<CabBooking> _originalBookings = [];
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
    _originalBookings = _getValidBookings();
    _filteredBookings = _originalBookings;
  }

  List<CabBooking> _getValidBookings() {
    return widget.allBookings
        .where(
          (booking) =>
              booking.status != 'Pending' && booking.status != 'Failure',
        )
        .toList();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _isSearchActive = query.isNotEmpty;
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
      _originalBookings = _getValidBookings();
      _applySearchFilter();
    });
  }

  void _applySearchFilter() {
    List<CabBooking> filteredList = List.from(_originalBookings);

    if (_isSearchActive && _searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      filteredList = filteredList
          .where(
            (booking) =>
                (booking.bookingId.toLowerCase().contains(query)) ||
                (booking.firstName.toLowerCase().contains(query)) ||
                (booking.lastName.toLowerCase().contains(query)) ||
                (booking.priContact.toLowerCase().contains(query)) ||
                (booking.cabType.toLowerCase().contains(query)) ||
                (booking.tripType.toLowerCase().contains(query)) ||
                (booking.status.toLowerCase().contains(query)),
          )
          .toList();
    }

    setState(() {
      _filteredBookings = filteredList;
    });
  }

  void _showDatePickerDialog() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 8,
        backgroundColor: _cardColor,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_month_rounded,
                    color: _secondaryColor,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Select Date Range',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: _textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 300,
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
                  rangeSelectionColor: _secondaryColor.withOpacity(0.1),
                  todayHighlightColor: _secondaryColor,
                  headerStyle: DateRangePickerHeaderStyle(
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      color: _textPrimary,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'CANCEL',
                      style: TextStyle(
                        color: _textSecondary,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _filterByDateRange();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      'APPLY',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
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

      _filteredBookings = _originalBookings.where((booking) {
        try {
          final bookingDate = DateTime.parse(booking.date);
          return (bookingDate.isAtSameMomentAs(startDateTime) ||
                  bookingDate.isAfter(startDateTime)) &&
              (bookingDate.isAtSameMomentAs(endDateTime) ||
                  bookingDate.isBefore(endDateTime));
        } catch (e) {
          return false;
        }
      }).toList();
      _isDateFilterActive = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header-less Spacing
          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Search and Filter Bar
                  Container(
                    decoration: BoxDecoration(
                      color: _cardColor,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(color: Colors.grey.shade100),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _backgroundColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: TextField(
                                  controller: _searchController,
                                  onChanged: _onSearchChanged,
                                  decoration: InputDecoration(
                                    hintText: 'Search bookings...',
                                    hintStyle: TextStyle(
                                      color: _textLight,
                                      fontSize: 14,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.search_rounded,
                                      color: _secondaryColor,
                                      size: 20,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                  ),
                                  style: TextStyle(
                                    color: _textPrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: _showDatePickerDialog,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: _secondaryColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(
                                  Icons.calendar_today_rounded,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (_isDateFilterActive) ...[
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(
                                Icons.date_range_rounded,
                                size: 14,
                                color: _secondaryColor,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${DateFormat('MMM dd').format(DateTime.parse(_startDate))} - ${DateFormat('MMM dd').format(DateTime.parse(_endDate))}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _textPrimary,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: _clearDateFilter,
                                child: Text(
                                  'CLEAR',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _errorColor,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: _filteredBookings.isEmpty
                ? SliverFillRemaining(child: _buildEmptyState())
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                          _buildCabBookingCard(_filteredBookings[index]),
                      childCount: _filteredBookings.length,
                    ),
                  ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _buildCabBookingCard(CabBooking booking) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookingDetailsPage(
                  tableID: booking.id,
                  bookingId: booking.bookingId,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BOOKING ID',
                            style: TextStyle(
                              fontSize: 10,
                              color: _textLight,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            booking.bookingId,
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _secondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '₹${booking.total}',
                        style: TextStyle(
                          color: _secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 14,
                      color: _secondaryColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formatDate(booking.date),
                      style: TextStyle(
                        fontSize: 12,
                        color: _textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(booking.status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        booking.status.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          color: _getStatusColor(booking.status),
                          fontWeight: FontWeight.w900,
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
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 64, color: _textLight),
          const SizedBox(height: 16),
          Text(
            'No bookings found',
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
      case "hold":
        return _warningColor;
      case "cancelled":
        return _errorColor;
      default:
        return _textLight;
    }
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
