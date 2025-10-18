import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:minna/bus/domain/report%20modal/report_Modal.dart';
import 'package:minna/bus/pages/Screen%20Ticket%20Details/TicketDetails.dart';

class BusAllBookingsPage extends StatefulWidget {
  final List<BusTicketReport> allBookings;

  const BusAllBookingsPage({
    Key? key,
    required this.allBookings,
  }) : super(key: key);

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

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _startDate = DateFormat('yyyy-MM-dd').format(now.subtract(Duration(days: 30)));
    _endDate = DateFormat('yyyy-MM-dd').format(now);
    _filteredBookings = _getValidBookings();
  }

  List<BusTicketReport> _getValidBookings() {
    return widget.allBookings.where((report) => 
        report.status != 'Pending' && report.status != 'Failure').toList();
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredBookings = _getValidBookings();
      } else {
        _filteredBookings = _getValidBookings().where((report) => 
            report.blockKey.toLowerCase().contains(query.toLowerCase()) ||
            report.ticketNo.toLowerCase().contains(query.toLowerCase()) ||
            report.source.toLowerCase().contains(query.toLowerCase()) ||
            report.destination.toLowerCase().contains(query.toLowerCase()) ||
            report.status.toLowerCase().contains(query.toLowerCase())
        ).toList();
      }
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
              
              SizedBox(
                height: 350,
                child: SfDateRangePicker(
                  selectionMode: DateRangePickerSelectionMode.range,
                  onSelectionChanged: (args) {
                    if (args.value is PickerDateRange) {
                      final start = args.value.startDate;
                      final end = args.value.endDate ?? args.value.startDate;
                      setState(() {
                        _startDate = DateFormat('yyyy-MM-dd').format(start);
                        _endDate = DateFormat('yyyy-MM-dd').format(end);
                      });
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
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      foregroundColor: _textSecondary,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Cancel'),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: _secondaryColor,
                      borderRadius: BorderRadius.circular(12),
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
                      onPressed: () {
                        Navigator.pop(context);
                        _filterByDateRange();
                      },
                      child: const Text(
                        'Apply Dates',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
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
      
      _filteredBookings = _getValidBookings().where((report) {
        final reportDate = DateTime.parse(report.date);
        return reportDate.isAfter(startDateTime.subtract(Duration(days: 1))) &&
               reportDate.isBefore(endDateTime.add(Duration(days: 1)));
      }).toList();
    });
  }

  Widget _buildDateRangeText() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _secondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _secondaryColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.calendar_today_rounded, size: 16, color: _secondaryColor),
          const SizedBox(width: 8),
          Text(
            '${DateFormat('MMM dd, yyyy').format(DateTime.parse(_startDate))} - '
            '${DateFormat('MMM dd, yyyy').format(DateTime.parse(_endDate))}',
            style: TextStyle(fontSize: 14, color: _textPrimary, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: Text(
          'All Bus Bookings',
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
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
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
                // Search Bar
                Container(
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
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    style: TextStyle(color: _textPrimary, fontSize: 14),
                  ),
                ),
                SizedBox(height: 12),
                
                // Date Filter Row
                Row(
                  children: [
                    Expanded(child: _buildDateRangeText()),
                    SizedBox(width: 12),
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
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${_filteredBookings.length} bookings',
                    style: TextStyle(
                      color: _secondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),

          // Bookings List
          Expanded(
            child: _filteredBookings.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredBookings.length,
                    itemBuilder: (context, index) {
                      final item = _filteredBookings[index];
                      return _buildBusTripCard(item);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusTripCard(BusTicketReport item) {
    final statusColor = _getStatusColor(item.status);
    final formattedDate = DateFormat('MMM dd, yyyy').format(DateTime.parse(item.date));

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
            padding: EdgeInsets.all(20.0),
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
                              fontSize: 10,
                              color: _textSecondary,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.0,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            item.ticketNo,
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
                        formattedDate,
                        style: TextStyle(
                          color: _secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Route Information Card
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
                              item.source,
                              style: TextStyle(
                                fontSize: 14,
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
                              item.destination,
                              style: TextStyle(
                                fontSize: 14,
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
                            size: 14,
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          '${item.seatDetails.length} seat${item.seatDetails.length > 1 ? 's' : ''}',
                          style: TextStyle(
                            fontSize: 12,
                            color: _textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 16),
                    // Block Key
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: _secondaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.confirmation_number_rounded,
                            color: _secondaryColor,
                            size: 14,
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          item.blockKey,
                          style: TextStyle(
                            fontSize: 12,
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
                            item.status.toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              color: statusColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
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
                Icons.directions_bus_rounded,
                color: _secondaryColor,
                size: 64,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'No Bookings Found',
              style: TextStyle(
                color: _textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'No bookings match your search criteria.\n'
              'Try adjusting your search terms or date range.',
              style: TextStyle(
                color: _textSecondary,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
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