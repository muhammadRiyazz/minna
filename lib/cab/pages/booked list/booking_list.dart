// lib/cab/presentation/cab_booking_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/cab/application/booked%20info%20list/booked_info_bloc.dart';
import 'package:minna/cab/domain/cab%20report/cab_booked_list.dart';
import 'package:minna/cab/pages/booked%20cab%20details/booked_cab_details.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/pages/widget/loading.dart';

class CabBookingList extends StatefulWidget {

  const CabBookingList({super.key, });

  @override
  State<CabBookingList> createState() => _CabBookingListState();
}

class _CabBookingListState extends State<CabBookingList> {
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
      backgroundColor: Colors.white,
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
                  error: (message) => _buildEmptyState(),
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
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
                prefixIcon: Icon(Icons.search, color: maincolor1),
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Date Filter Button
          Container(
            decoration: BoxDecoration(
              color: maincolor1,
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
              icon: Icon(Icons.calendar_today, size: 20, color: Colors.white),
              tooltip: "Filter by date",
            ),
          ),
          const SizedBox(width: 8),
          // Status Filter Button
          Container(
            decoration: BoxDecoration(
              color: maincolor1,
              borderRadius: BorderRadius.circular(12),
            ),
            child: PopupMenuButton<String>(
              icon: Icon(Icons.filter_list, color: Colors.white),
              onSelected: (String? newValue) {
                context.read<BookedInfoBloc>().add(
                      BookedInfoEvent.statusFilterChanged(newValue),
                    );
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: "All",
                  child: Text("All Statuses"),
                ),
                const PopupMenuItem<String>(
                  value: "Confirmed",
                  child: Text("Confirmed"),
                ),
                const PopupMenuItem<String>(
                  value: "Hold",
                  child: Text("Hold"),
                ),
                const PopupMenuItem<String>(
                  value: "Cancelled",
                  child: Text("Cancelled"),
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
      padding: const EdgeInsets.all(16),
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => BookingDetailsPage(
          tableID:booking.id,
          bookingId: booking.bookingId,),));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            // Top Section with Booking ID
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: maincolor1,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Booking ID: ${booking.bookingId}",
                    style: const TextStyle(
                      color: Colors.white,
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
                      Icon(Icons.local_taxi, size: 20, color: maincolor1),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: maincolor1!.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          booking.cabType,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: maincolor1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          booking.tripType,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
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
                  const Divider(height: 20, thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Total Amount",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "₹${booking.total}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: maincolor1,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _getStatusColor(booking.status),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          booking.status,
                          style: const TextStyle(
                            color: Colors.white,
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
        Icon(icon, size: 20, color: Colors.grey.shade600),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(text: text1),
                const TextSpan(text: " • "),
                TextSpan(
                  text: text2,
                  style: TextStyle(color: Colors.grey.shade600),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.local_taxi,
            size: 80,
            color: maincolor1!.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            "No cab bookings found",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            "Try adjusting your search or filter criteria",
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
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
            onPressed: (){  context.read<BookedInfoBloc>().add(
                    BookedInfoEvent.fetchList(),
                  );},
            child: const Text('Retry', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
 

  Widget _buildInitialState() {
    return const Center(
      child: Text('Press refresh to load data'),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "confirmed":
        return Colors.green.shade600;
      case "hold":
        return Colors.orange.shade600;
      case "cancelled":
        return Colors.red.shade600;
      default:
        return Colors.grey.shade600;
    }
  }
}