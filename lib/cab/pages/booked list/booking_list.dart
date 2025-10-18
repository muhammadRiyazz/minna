// lib/cab/presentation/cab_booking_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:minna/cab/application/booked%20info%20list/booked_info_bloc.dart';
import 'package:minna/cab/domain/cab%20report/cab_booked_list.dart';
import 'package:minna/cab/pages/booked%20cab%20details/booked_cab_details.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/pages/widget/loading.dart';

class CabBookingList extends StatefulWidget {
  const CabBookingList({super.key});

  @override
  State<CabBookingList> createState() => _CabBookingListState();
}

class _CabBookingListState extends State<CabBookingList> {
  // Updated Color Theme matching flight report
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

  @override
  void initState() {
    super.initState();
    context.read<BookedInfoBloc>().add(
          BookedInfoEvent.fetchList(),
        );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: Text(
          'Cab Bookings',
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
            onPressed: () {
              context.read<BookedInfoBloc>().add(BookedInfoEvent.fetchList());
            },
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: BlocConsumer<BookedInfoBloc, BookedInfoState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (message) {
              // Handle error if needed
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return Column(
            children: [
              _buildSearchAndFilter(context, state),
              SizedBox(height: 8),
              Expanded(
                child: state.maybeWhen(
                  loading: () => _buildShimmerLoading(),
                  success: (allBookings, filteredBookings, searchQuery, selectedDate, statusFilter) =>
                      filteredBookings.isEmpty
                          ? _buildEmptyState()
                          : _buildSuccessState(filteredBookings),
                  error: (message) => _buildErrorState(),
                  orElse: () => _buildInitialState(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchAndFilter(BuildContext context, BookedInfoState state) {
    DateTime? selectedDate;
    String? statusFilter;

    state.maybeWhen(
      success: (allBookings, filteredBookings, searchQuery, date, filter) {
        selectedDate = date;
        statusFilter = filter;
      },
      orElse: () {},
    );

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          // Search Bar
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: _backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  context.read<BookedInfoBloc>().add(
                        BookedInfoEvent.searchChanged(value),
                      );
                },
                decoration: InputDecoration(
                  hintText: 'Search by Booking ID or Name...',
                  hintStyle: TextStyle(color: _textLight, fontSize: 14),
                  prefixIcon: Icon(Icons.search_rounded, color: _secondaryColor, size: 20),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                style: TextStyle(color: _textPrimary, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Date Filter Button
          Container(
            decoration: BoxDecoration(
              color: _secondaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate ?? DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (pickedDate != null) {
                  context.read<BookedInfoBloc>().add(
                        BookedInfoEvent.dateFilterChanged(pickedDate),
                      );
                }
              },
              icon: Icon(Icons.calendar_today_rounded, size: 20, color: _cardColor),
              tooltip: "Filter by date",
            ),
          ),
          const SizedBox(width: 8),
          // Status Filter Button
          Container(
            decoration: BoxDecoration(
              color: _secondaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: PopupMenuButton<String>(
              icon: Icon(Icons.filter_list_rounded, color: _cardColor, size: 20),
              onSelected: (String? newValue) {
                context.read<BookedInfoBloc>().add(
                      BookedInfoEvent.statusFilterChanged(newValue),
                    );
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: "All",
                  child: Text("All Statuses", style: TextStyle(color: _textPrimary)),
                ),
                PopupMenuItem<String>(
                  value: "Confirmed",
                  child: Text("Confirmed", style: TextStyle(color: _textPrimary)),
                ),
                PopupMenuItem<String>(
                  value: "Hold",
                  child: Text("Hold", style: TextStyle(color: _textPrimary)),
                ),
                PopupMenuItem<String>(
                  value: "Cancelled",
                  child: Text("Cancelled", style: TextStyle(color: _textPrimary)),
                ),
              ],
              tooltip: "Filter by status",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemCount: 6,
      itemBuilder: (context, index) {
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
            padding: EdgeInsets.all(20),
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
                SizedBox(height: 16),
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
                // Shimmer for details
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

  Widget _buildSuccessState(List<CabBooking> bookings) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cab Bookings',
                  style: TextStyle(
                    color: _textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '${bookings.length} booking${bookings.length > 1 ? 's' : ''} found',
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
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                return _buildCabBookingCard(bookings[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCabBookingCard(CabBooking booking) {
    final bloc = context.read<BookedInfoBloc>();
    
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
                builder: (context) => BookingDetailsPage(
                  tableID: booking.id,
                  bookingId: booking.bookingId,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row with Booking ID and Amount
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
                            booking.bookingId,
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
                        '₹${booking.total}',
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
                      // Passenger Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PASSENGER',
                              style: TextStyle(
                                fontSize: 10,
                                color: _textSecondary,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.0,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "${booking.firstName} ${booking.lastName}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.phone_rounded, size: 12, color: _secondaryColor),
                                SizedBox(width: 4),
                                Text(
                                  booking.priContact,
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
                                Icons.person_rounded,
                                color: _secondaryColor,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Trip Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'TRIP DETAILS',
                              style: TextStyle(
                                fontSize: 10,
                                color: _textSecondary,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.0,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              booking.tripType,
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
                                Icon(Icons.calendar_today_rounded, size: 12, color: _secondaryColor),
                                SizedBox(width: 4),
                                Text(
                                  _formatDate(booking.date),
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
                    // Cab Type
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: _secondaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.local_taxi_rounded,
                            color: _secondaryColor,
                            size: 14,
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          booking.cabType,
                          style: TextStyle(
                            fontSize: 12,
                            color: _textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 16),
                    // Time
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: _secondaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.access_time_rounded,
                            color: _secondaryColor,
                            size: 14,
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          bloc.formatTimeTo12Hour(booking.time),
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
                        color: _getStatusColor(booking.status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _getStatusColor(booking.status).withOpacity(0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: _getStatusColor(booking.status),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            booking.status.toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              color: _getStatusColor(booking.status),
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
                Icons.local_taxi_rounded,
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
              'Try adjusting your search or filter criteria',
              style: TextStyle(
                color: _textSecondary,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<BookedInfoBloc>().add(BookedInfoEvent.fetchList());
              },
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

  Widget _buildErrorState() {
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
              'Failed to Load Data',
              style: TextStyle(
                color: _textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'There was an issue fetching your bookings.\n'
              'Please check your connection and try again.',
              style: TextStyle(
                color: _textSecondary,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<BookedInfoBloc>().add(BookedInfoEvent.fetchList());
              },
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

  Widget _buildInitialState() {
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
                Icons.hourglass_empty_rounded,
                color: _secondaryColor,
                size: 64,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Ready to Load',
              style: TextStyle(
                color: _textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Press refresh to load your cab bookings',
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