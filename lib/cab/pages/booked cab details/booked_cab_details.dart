// lib/cab/presentation/booking_details_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:minna/cab/application/booked%20details/booked_details_bloc.dart';
import 'package:minna/cab/domain/cab%20list%20model/cab_booked_details.dart';
import 'package:minna/comman/const/const.dart';

class BookingDetailsPage extends StatelessWidget {
  final String bookingId;

  const BookingDetailsPage({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookedDetailsBloc()
        ..add(BookedDetailsEvent.fetchDetails(bookingId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Booking #$bookingId'),
          backgroundColor: maincolor1,
          foregroundColor: Colors.white,
        ),
        body: BlocBuilder<BookedDetailsBloc, BookedDetailsState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => _buildLoadingState(),
              success: (details) => _buildSuccessState(context, details),
              error: (message) => _buildErrorState(context, message),
              orElse: () => _buildInitialState(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessState(BuildContext context, BookingDetails details) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Booking Status Card
          _buildStatusCard(details),
          const SizedBox(height: 16),

          // Trip Information
          _buildTripInfoCard(details),
          const SizedBox(height: 16),

          // Routes Information
          _buildRoutesCard(details),
          const SizedBox(height: 16),

          // Traveller Information
          _buildTravellerCard(details.traveller),
          const SizedBox(height: 16),

          // Cab & Fare Information
          _buildCabFareCard(details.cabRate),
        ],
      ),
    );
  }

  Widget _buildStatusCard(BookingDetails details) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Booking Status',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(details.statusDesc),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    details.statusDesc,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Divider(color: Colors.grey.shade300),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoItem(
                  Icons.confirmation_number,
                  'Booking ID',
                  details.bookingId,
                ),
                _buildInfoItem(
                  Icons.directions_car,
                  'Trip Type',
                  details.tripTypeName,
                ),
                _buildInfoItem(
                  Icons.alt_route,
                  'Distance',
                  '${details.tripDistance} km',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripInfoCard(BookingDetails details) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trip Information',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 12),
            Divider(color: Colors.grey.shade300),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoItem(
                  Icons.calendar_today,
                  'Pickup Date',
                  _formatDate(details.pickupDate),
                ),
                _buildInfoItem(
                  Icons.access_time,
                  'Pickup Time',
                  _formatTimeTo12Hour(details.pickupTime),
                ),
                _buildInfoItem(
                  Icons.event,
                  'Booked On',
                  '${_formatDate(details.bookingDate)} ${_formatTimeTo12Hour(details.bookingTime)}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoutesCard(BookingDetails details) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              details.isMultiCity ? 'Routes' : 'Route',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 12),
            Divider(color: Colors.grey.shade300),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: details.routes.length,
              itemBuilder: (context, index) {
                final route = details.routes[index];
                return _buildRouteItem(route, index, details.routes.length);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRouteItem(BookedRoute route, int index, int totalRoutes) {
    return Column(
      children: [
        if (index > 0) const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Icon(Icons.location_on, color: maincolor1, size: 20),
                if (index < totalRoutes - 1)
                  Container(
                    width: 2,
                    height: 40,
                    color: Colors.grey.shade300,
                  ),
                if (index == totalRoutes - 1)
                  Icon(Icons.flag, color: Colors.green, size: 20),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'From: ${route.source.address}',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'To: ${route.destination.address}',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Date: ${_formatDate(route.startDate)} • Time: ${_formatTimeTo12Hour(route.startTime)}',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTravellerCard(BookedTraveller traveller) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Traveller Information',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 12),
            Divider(color: Colors.grey.shade300),
            const SizedBox(height: 12),
            _buildTravellerInfoItem('Name', traveller.fullName),
            _buildTravellerInfoItem('Email', traveller.email),
            _buildTravellerInfoItem(
                'Primary Contact', traveller.primaryContact.fullNumber),
            if (traveller.alternateContact.number.isNotEmpty)
              _buildTravellerInfoItem(
                  'Alternate Contact', traveller.alternateContact.fullNumber),
          ],
        ),
      ),
    );
  }

  Widget _buildTravellerInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCabFareCard(BookedCabRate cabRate) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cab & Fare Details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 12),
            Divider(color: Colors.grey.shade300),
            const SizedBox(height: 12),
            // Cab Details
            Text(
              cabRate.cab.type,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildCabSpecItem(
                  Icons.people,
                  '${cabRate.cab.seatingCapacity} Seats',
                ),
                const SizedBox(width: 16),
                _buildCabSpecItem(
                  Icons.luggage,
                  '${cabRate.cab.bagCapacity} Bags',
                ),
                if (cabRate.cab.isAssured) ...[
                  const SizedBox(width: 16),
                  _buildCabSpecItem(
                    Icons.verified,
                    'Assured',
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),
            // Fare Breakdown
            Text(
              'Fare Breakdown',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            _buildFareItem('Base Fare', '₹${cabRate.fare.baseFare}'),
            _buildFareItem('Driver Allowance', '₹${cabRate.fare.driverAllowance}'),
            _buildFareItem('GST', '₹${cabRate.fare.gst}'),
            if (cabRate.fare.tollTax > 0)
              _buildFareItem('Toll Tax', '₹${cabRate.fare.tollTax}'),
            if (cabRate.fare.stateTax > 0)
              _buildFareItem('State Tax', '₹${cabRate.fare.stateTax}'),
            if (cabRate.fare.airportFee > 0)
              _buildFareItem('Airport Fee', '₹${cabRate.fare.airportFee}'),
            if (cabRate.fare.additionalCharge > 0)
              _buildFareItem('Additional Charges', '₹${cabRate.fare.additionalCharge}'),
            const SizedBox(height: 8),
            Divider(color: Colors.grey.shade300),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Amount',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: maincolor1,
                  ),
                ),
                Text(
                  '₹${cabRate.fare.totalAmount}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: maincolor1,
                  ),
                ),
              ],
            ),
            if (cabRate.fare.dueAmount > 0) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Due Amount',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.orange.shade700,
                    ),
                  ),
                  Text(
                    '₹${cabRate.fare.dueAmount}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade700,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCabSpecItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildFareItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 20, color: maincolor1),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red.shade300),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(fontSize: 16, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<BookedDetailsBloc>().add(
                    BookedDetailsEvent.fetchDetails(bookingId),
                  );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: maincolor1,
              foregroundColor: Colors.white,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialState() {
    return const Center(
      child: Text('Loading booking details...'),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Colors.green.shade600;
      case 'hold':
        return Colors.orange.shade600;
      case 'cancelled':
        return Colors.red.shade600;
      case 'completed':
        return Colors.blue.shade600;
      default:
        return Colors.grey.shade600;
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

  String _formatTimeTo12Hour(String time24) {
    try {
      final timeParts = time24.split(':');
      if (timeParts.length >= 2) {
        int hour = int.parse(timeParts[0]);
        int minute = int.parse(timeParts[1]);
        
        String period = hour >= 12 ? 'PM' : 'AM';
        hour = hour % 12;
        hour = hour == 0 ? 12 : hour;
        
        return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
      }
      return time24;
    } catch (e) {
      return time24;
    }
  }
}