// lib/cab/presentation/cab_booking_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  // Color Theme
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37);
  final Color _accentColor = Color(0xFFC19B3C);
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);
  final Color _errorColor = Color(0xFFE53935);
  final Color _successColor = Color(0xFF00C853);

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch data when screen loads
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
     
      body: BlocConsumer<BookedInfoBloc, BookedInfoState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (message) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(content: Text(message)),
              // );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return Column(
            children: [
              _buildSearchAndFilter(context, state),
              Expanded(
                child: state.maybeWhen(
                  loading: () => buildLoadingState(),
                  success: (allBookings, filteredBookings, searchQuery, selectedDate, statusFilter) =>
                      filteredBookings.isEmpty
                          ? _buildEmptyState()
                          : _buildBookingList(filteredBookings),
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
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Search Bar
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                context.read<BookedInfoBloc>().add(
                      BookedInfoEvent.searchChanged(value),
                    );
              },
              decoration: InputDecoration(
                hintText: 'Search by Booking ID...',
                hintStyle: TextStyle(color: _textLight),
                prefixIcon: Icon(Icons.search, color: _secondaryColor),
                filled: true,
                fillColor: _backgroundColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              style: TextStyle(color: _textPrimary),
            ),
          ),
          const SizedBox(width: 12),
          // Date Filter Button
          Container(
            decoration: BoxDecoration(
              color: _secondaryColor,
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [_secondaryColor, _accentColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
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
              icon: Icon(Icons.calendar_today, size: 20, color: _cardColor),
              tooltip: "Filter by date",
            ),
          ),
          const SizedBox(width: 8),
          // Status Filter Button
          Container(
            decoration: BoxDecoration(
              color: _secondaryColor,
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [_secondaryColor, _accentColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: PopupMenuButton<String>(
              icon: Icon(Icons.filter_list, color: _cardColor),
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

  Widget _buildBookingList(List<CabBooking> bookings) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        return _buildCabTicket(bookings[index]);
      },
    );
  }

  Widget _buildCabTicket(CabBooking booking) {
    final bloc = context.read<BookedInfoBloc>();
    
    return InkWell(
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
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: _cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: _secondaryColor.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            // Top Section with Booking ID
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                gradient: LinearGradient(
                  colors: [_primaryColor, _primaryColor.withOpacity(0.9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Booking ID: ${booking.bookingId}",
                    style: TextStyle(
                      color: _cardColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Details Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(
                    Icons.person_outline,
                    "${booking.firstName} ${booking.lastName}",
                    booking.priContact,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.local_taxi, size: 20, color: _secondaryColor),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _secondaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _secondaryColor.withOpacity(0.3)),
                        ),
                        child: Text(
                          booking.cabType,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: _secondaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _accentColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _accentColor.withOpacity(0.3)),
                        ),
                        child: Text(
                          booking.tripType,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: _accentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    Icons.calendar_today_outlined,
                    booking.date,
                    bloc.formatTimeTo12Hour(booking.time),
                  ),
                  const Divider(height: 20, thickness: 1, color: Color(0xFFEEEEEE)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Amount",
                            style: TextStyle(
                              fontSize: 12,
                              color: _textLight,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "₹${booking.total}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _secondaryColor,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: _getStatusColor(booking.status),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: _getStatusColor(booking.status).withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          booking.status,
                          style: TextStyle(
                            color: _cardColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
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

  Widget _buildInfoRow(IconData icon, String text1, String text2) {
    return Row(
      children: [
        Icon(icon, size: 20, color: _textSecondary),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 14,
                color: _textPrimary,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(text: text1),
                TextSpan(
                  text: " • ",
                  style: TextStyle(color: _textLight),
                ),
                TextSpan(
                  text: text2,
                  style: TextStyle(color: _textSecondary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_taxi_outlined,
              size: 80,
              color: _textLight,
            ),
            const SizedBox(height: 16),
            Text(
              "No cab bookings found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: _textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Try adjusting your search or filter criteria",
              style: TextStyle(fontSize: 14, color: _textLight),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: _errorColor),
          const SizedBox(height: 16),
          Text(
            'Failed to Load Data',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'There was an issue fetching your reports.\n'
            'Please check your connection and try again.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: _textLight),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _secondaryColor,
              foregroundColor: _cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              elevation: 2,
            ),
            onPressed: () {
              context.read<BookedInfoBloc>().add(
                    BookedInfoEvent.fetchList(),
                  );
            },
            child: Text('Retry', style: TextStyle(color: _cardColor)),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.hourglass_empty, size: 64, color: _textLight),
          const SizedBox(height: 16),
          Text(
            'Ready to Load',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: _textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Press refresh to load your cab bookings',
            style: TextStyle(fontSize: 14, color: _textLight),
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
        return Color(0xFFFF9800); // Orange
      case "cancelled":
        return _errorColor;
      default:
        return _textLight;
    }
  }
}