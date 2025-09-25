// lib/cab/presentation/booking_details_page.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:minna/cab/application/booked%20details/booked_details_bloc.dart';
import 'package:minna/cab/domain/cab%20list%20model/cab_booked_details.dart';
import 'package:minna/comman/const/const.dart';

class BookingDetailsPage extends StatefulWidget {
  final String bookingId;

  const BookingDetailsPage({super.key, required this.bookingId});

  @override
  State<BookingDetailsPage> createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  bool _isCancelling = false; // loading when initiating fetch reasons
  bool _isConfirmingCancellation = false; // loading when confirming cancel
  final String _baseUrl = 'http://gozotech2.ddns.net:5192/api/cpapi/booking';
  final String _authorization =
      'Basic ZjA2MjljNTIxZjE2MjU0NTA2YmIyMDQzNWI4MTJmMmE=';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BookedDetailsBloc()..add(BookedDetailsEvent.fetchDetails(widget.bookingId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Booking #${widget.bookingId}'),
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
          const SizedBox(height: 24),

          // Cancel button section
          _buildCancelSection(details),
        ],
      ),
    );
  }

  Widget _buildCancelSection(BookingDetails details) {
    // If already cancelled, don't show button
    final statusLower = details.statusDesc.toLowerCase();
    final alreadyCancelled = statusLower.contains('cancel') || statusLower.contains('cancelled');

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Actions',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: maincolor1,
              ),
            ),
            const SizedBox(height: 12),
            Divider(color: Colors.grey.shade300),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: alreadyCancelled || _isCancelling
                        ? null
                        : () => _onCancelPressed(details.bookingId),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    icon: _isCancelling
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.cancel),
                    label: Text(_isCancelling ? 'Loading...' : (alreadyCancelled ? 'Already Cancelled' : 'Cancel Booking')),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Triggered when Cancel button pressed
  Future<void> _onCancelPressed(String bookingId) async {
    setState(() {
      _isCancelling = true;
    });

    try {
      final uri = Uri.parse('$_baseUrl/getCancellationList');
      final response = await http.post(
        uri,
        headers: {
          'Authorization': _authorization,
          // server curl had no content-type / empty body; we'll send an empty body
        },
        body: '',
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded['success'] == true && decoded['data'] != null) {
          final List<dynamic> cancellationList = decoded['data']['cancellationList'] ?? [];
          // Build model list
          final reasons = cancellationList.map((e) {
            return _CancellationReason(
              id: e['id']?.toString() ?? '',
              text: e['text'] ?? '',
              placeholder: e['placeholder'] ?? '',
            );
          }).toList();

          setState(() {
            _isCancelling = false;
          });

          // Show bottom sheet to select reason and confirm
          await _showCancellationBottomSheet(bookingId, reasons);
        } else {
          setState(() {
            _isCancelling = false;
          });
          _showError('Failed to load cancellation reasons');
        }
      } else {
        setState(() {
          _isCancelling = false;
        });
        _showError('Error fetching reasons: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isCancelling = false;
      });
      _showError('Failed to fetch cancellation reasons. Please try again.');
    }
  }

  Future<void> _showCancellationBottomSheet(String bookingId, List<_CancellationReason> reasons) async {
    String selectedReasonId = reasons.isNotEmpty ? reasons.first.id : '';
    String additionalText = '';
    String placeholder = reasons.isNotEmpty ? reasons.first.placeholder : 'Additional details';
    // Use StatefulBuilder inside showModalBottomSheet for local state
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (context) {
        return StatefulBuilder(builder: (context, setModalState) {
          final selectedReason = reasons.firstWhere(
              (r) => r.id == selectedReasonId,
              orElse: () => reasons.isNotEmpty ? reasons[0] : _CancellationReason(id: '', text: '', placeholder: ''));

          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Cancel Booking',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(Icons.close, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        const Text(
                          'Select a reason',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        ...reasons.map((r) {
                          final isSelected = r.id == selectedReasonId;
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(r.text),
                            subtitle: r.placeholder.isNotEmpty ? Text(r.placeholder) : null,
                            leading: Radio<String>(
                              value: r.id,
                              groupValue: selectedReasonId,
                              onChanged: (val) {
                                setModalState(() {
                                  selectedReasonId = val ?? '';
                                  placeholder = r.placeholder;
                                });
                              },
                            ),
                            onTap: () {
                              setModalState(() {
                                selectedReasonId = r.id;
                                placeholder = r.placeholder;
                              });
                            },
                          );
                        }).toList(),
                        const SizedBox(height: 12),
                        TextField(
                          minLines: 1,
                          maxLines: 5,
                          onChanged: (val) => additionalText = val,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            hintText: placeholder.isNotEmpty ? placeholder : 'Additional details (optional)',
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _isConfirmingCancellation
                                    ? null
                                    : () {
                                        // Confirm cancellation
                                        Navigator.of(context).pop(); // close sheet
                                        _confirmCancellation(
                                          bookingId: bookingId,
                                          reasonText: additionalText.isNotEmpty ? additionalText : (selectedReason.text ?? ''),
                                          reasonId: selectedReasonId,
                                        );
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red.shade600,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                ),
                                child: _isConfirmingCancellation
                                    ? const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                      )
                                    : const Text('Confirm Cancellation'),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

Future<void> _confirmCancellation({
  required String bookingId,
  required String reasonText,
  required String reasonId,
}) async {
  setState(() {
    _isConfirmingCancellation = true;
  });

  try {
    final uri = Uri.parse('$_baseUrl/cancelBooking');
    final bodyMap = {
      "bookingId": bookingId,
      "reason": reasonText,
      "reasonId": reasonId
    };

    final response = await http.post(
      uri,
      headers: {
        'Authorization': _authorization,
        'Content-Type': 'application/json',
      },
      body: jsonEncode(bodyMap),
    ).timeout(const Duration(seconds: 20));

    setState(() {
      _isConfirmingCancellation = false;
    });

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded['success'] == true && decoded['data'] != null) {
        final data = decoded['data'];
        final refundedAmount = data['refundAmount'] ?? 0;
        final cancellationCharge = data['cancellationCharge'] ?? 0;
        final message = data['message'] ?? 'Booking cancelled successfully';
        final cancelledBookingId = data['bookingId'] ?? bookingId;

        // Show updated bottom sheet
        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 50,
                      height: 5,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Icon(Icons.check_circle, color: Colors.green, size: 60),
                    const SizedBox(height: 12),
                    Text(
                      'Cancellation Successful',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: maincolor1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      message,
                      style: const TextStyle(fontSize: 14, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    // Booking info
                    ListTile(
                      leading: const Icon(Icons.confirmation_number_outlined),
                      title: const Text('Booking ID'),
                      subtitle: Text(cancelledBookingId),
                    ),
                    ListTile(
                      leading: const Icon(Icons.currency_rupee),
                      title: const Text('Refund Amount'),
                      subtitle: Text('₹$refundedAmount'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.money_off_csred_outlined),
                      title: const Text('Cancellation Charge'),
                      subtitle: Text('₹$cancellationCharge'),
                    ),
                    const SizedBox(height: 10),

                    // Extra note
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.orange.shade200),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline, color: Colors.orange),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Refund will be credited within 5–7 working days.',
                              style: const TextStyle(fontSize: 13, color: Colors.black87),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: maincolor1,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.done_all),
                      label: const Text("OK, Got it"),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        _showError('Cancellation failed. Please try again.');
      }
    } else {
      _showError('Cancellation failed: ${response.statusCode}');
    }
  } catch (e) {
    setState(() {
      _isConfirmingCancellation = false;
    });
    _showError('Failed to cancel booking. Please check your connection and try again.');
  }
}


  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade600,
      ),
    );
  }

  Widget _buildStatusCard(BookingDetails details) {
    return Card(
      elevation: 0,
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
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: maincolor1,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: _getStatusColor(details.statusDesc),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    details.statusDesc,
                    style: const TextStyle(fontSize: 12,
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
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trip Information',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: maincolor1,
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
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              details.isMultiCity ? 'Routes' : 'Route',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: maincolor1,
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
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Icon(Icons.flag, color: Colors.green, size: 20),
                  ),
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
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Traveller Information',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: maincolor1,
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
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cab & Fare Details',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: maincolor1,
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
                    BookedDetailsEvent.fetchDetails(widget.bookingId),
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

// Small model for reasons
class _CancellationReason {
  final String id;
  final String text;
  final String placeholder;

  _CancellationReason({required this.id, required this.text, required this.placeholder});
}


