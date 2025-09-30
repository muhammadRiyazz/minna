import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:minna/bus/infrastructure/fareCalculation/fare_calculation.dart';
import 'package:minna/bus/pages/Screen%20available%20Trip/screen_available_triplist.dart';
import 'package:minna/comman/const/const.dart';
import 'package:shimmer/shimmer.dart';

import '../../domain/CncelData/cancel_data.dart';
import '../../domain/Ticket details/ticket_details_more1.dart';
import '../../infrastructure/cancelTicket/cancel_Ticket_Details.dart';
import '../../infrastructure/fetch ticket details/fetch_ticket_details.dart';
import '../screen Cancel Info/screen_cancel_info.dart';
import '../../presendation/widgets/error_widget.dart';

class TicketDetails extends StatefulWidget {
  final String tin;
  final int count;
  final String blocid;

  const TicketDetails({
    super.key,
    required this.tin,
    required this.count,
    required this.blocid,
  });

  @override
  State<TicketDetails> createState() => _TicketDetailsState();
}

class _TicketDetailsState extends State<TicketDetails> {
  TicketinfoMore? ticketMoreData;
  CancelDataModal? cancelData;
  Map<String, dynamic>? responseJson;

  bool isLoading = true;
  bool isError = false;
  bool isButtonLoading = false;
  bool isButtonError = false;

  @override
  void initState() {
    super.initState();
    _fetchTicketData(widget.tin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Details'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: maincolor1,
        elevation: 0,
        centerTitle: true,
      ),
      body: isLoading
          ? _buildShimmerLoading()
          : isError
              ? Erroricon(ontap: () => _fetchTicketData(widget.tin))
              : _buildTicketDetails(),
    );
  }

  Widget _buildTicketDetails() {
    final ticket = ticketMoreData!;
    final status = responseJson!["status"];
    final isCancelled = status == "CANCELLED";

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                // Ticket Status Card
                _buildStatusCard(ticket, isCancelled),
                const SizedBox(height: 20),

                // Journey Details Card
                _buildJourneyCard(ticket),
                const SizedBox(height: 20),

                // Bus Information Card
                _buildBusInfoCard(ticket),
                const SizedBox(height: 20),

                // Passengers List
                _buildPassengersCard(ticket),
                const SizedBox(height: 20),

                // Fare Details Card
                _buildFareCard(ticket, isCancelled),
                
                // Cancellation Details (if cancelled)
                // if (isCancelled) ...[
                //   const SizedBox(height: 20),
                //   _buildCancellationDetailsCard(),
                // ],
              ],
            ),
          ),
        ),

        // Cancel Button (if not cancelled)
        if (!isCancelled) _buildCancelButton(),
      ],
    );
  }

  Widget _buildStatusCard(TicketinfoMore ticket, bool isCancelled) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PNR Number',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    ticket.pnr,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isCancelled
                      ? Colors.red.withOpacity(0.1)
                      : Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isCancelled ? Icons.cancel : Icons.check_circle,
                      size: 16,
                      color: isCancelled ? Colors.red : Colors.green,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      isCancelled ? 'Cancelled' : 'Confirmed',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isCancelled ? Colors.red : Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDateInfo('Date of Issue', ticket.dateOfIssue),
              _buildDateInfo('Date of Journey', ticket.doj),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateInfo(String title, DateTime date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 4),
        Text(
          DateFormat('dd MMM yyyy').format(date),
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildJourneyCard(TicketinfoMore ticket) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Route Information
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FROM',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ticket.sourceCity,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      ticket.pickupLocation,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      changetime(time: ticket.pickupTime),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: maincolor1!.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: maincolor1,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'TO',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ticket.destinationCity,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      ticket.dropLocation,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      changetime(time: ticket.dropTime),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBusInfoCard(TicketinfoMore ticket) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: maincolor1!.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.directions_bus, color: maincolor1, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticket.travels,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  ticket.busType,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPassengersCard(TicketinfoMore ticket) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PASSENGERS (${ticket.inventoryItems.length})',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          ...ticket.inventoryItems.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: maincolor1!.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person, color: maincolor1, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.passenger.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Seat ${item.seatName}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        if (item.cancellationReason != null && 
                            item.cancellationReason!.isNotEmpty)
                          Text(
                            'Cancelled: ${item.cancellationReason}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.red.shade600,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Text(
                    '₹${item.baseFare}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: maincolor1,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFareCard(TicketinfoMore ticket, bool isCancelled) {
  // Convert string values to numbers for calculations
  final baseFare = totalbasefare(seats: ticket.inventoryItems);
  final totalFare = totalfare(seats: ticket.inventoryItems);
  final gst = totalFare - baseFare;

  // Handle refund amount for cancelled tickets - convert to number
  num refundAmount = 0;
  if (isCancelled && responseJson!.containsKey("refundAmount")) {
    final refundString = responseJson!["refundAmount"].toString();
    refundAmount = double.tryParse(refundString) ?? 0;
  }

  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          blurRadius: 10,
          spreadRadius: 2,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        _buildFareRow('Base Fare', baseFare),
        const SizedBox(height: 8),
        _buildFareRow('Taxes & Fees', gst),
        const Divider(height: 24),
        _buildFareRow('Total Paid', totalFare, isTotal: true),
        if (isCancelled) ...[
          const Divider(height: 24),
          _buildFareRow(
            'Refund Amount',
            refundAmount,
            isRefund: true,
          ),
        ],
      ],
    ),
  );
}

  Widget _buildCancellationDetailsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CANCELLATION DETAILS',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          if (responseJson!.containsKey("dateOfCancellation"))
            _buildCancellationInfoRow(
              'Cancelled On',
              _formatDateTime(responseJson!["dateOfCancellation"]),
            ),
          if (responseJson!.containsKey("cancellationReason"))
            _buildCancellationInfoRow(
              'Reason',
              responseJson!["cancellationReason"],
            ),
          if (responseJson!.containsKey("cancellationCharges"))
            _buildCancellationInfoRow(
              'Cancellation Charges',
              '₹${responseJson!["cancellationCharges"]}',
            ),
        ],
      ),
    );
  }

  Widget _buildCancellationInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
    } catch (e) {
      return dateTimeString;
    }
  }
Widget _buildFareRow(
  String label,
  num amount, {
  bool isTotal = false,
  bool isRefund = false,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 16,
          color: isTotal || isRefund ? Colors.black : Colors.grey.shade600,
          fontWeight: isTotal || isRefund
              ? FontWeight.w600
              : FontWeight.normal,
        ),
      ),
      Text(
        '₹${amount.toStringAsFixed(2)}', // Format to 2 decimal places
        style: TextStyle(
          fontSize: 16,
          color: isRefund
              ? Colors.green
              : isTotal
                  ? maincolor1
                  : Colors.black,
          fontWeight: isTotal || isRefund
              ? FontWeight.w600
              : FontWeight.normal,
        ),
      ),
    ],
  );
}

  Widget _buildCancelButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
          
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isButtonError ? Colors.orange : maincolor1,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: callCancelDataApi,
            child: isButtonLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    isButtonError ? 'TRY AGAIN' : 'CANCEL TICKET',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> _fetchTicketData(String tinid) async {
    setState(() {
      isLoading = true;
      isError = false;
    });

    try {
      final data = await getTicketData(tIn: tinid);
      if (data?.statusCode == 200 &&
          !data!.body.contains("Authorization failed")) {
        // Parse the response
        responseJson = json.decode(data.body);
        
        // Check if the ticket is cancelled and handle the different structure
        if (responseJson!["status"] == "CANCELLED") {
          // For cancelled tickets, we need to handle the different structure
          // The inventoryItems might be a single object instead of a list
          if (responseJson!["inventoryItems"] is Map<String, dynamic>) {
            // Convert single object to list
            responseJson!["inventoryItems"] = [responseJson!["inventoryItems"]];
          }
        }
        
        ticketMoreData = ticketinfoMoreFromJson(data.body);
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception("Unauthorized");
      }
    } catch (e) {
      log("Error fetching ticket data: $e");
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  }

  Future<void> callCancelDataApi() async {
    setState(() {
      isButtonLoading = true;
      isButtonError = false;
    });

    try {
      final Response? resp = await cancelDetails(tin: ticketMoreData!.tin);
      final body = resp!.body;

      if (body.contains('Error') && !body.contains("Authorization failed")) {
        _showCustomSnackBar(
          context,
          body.replaceAll('Error:', '').trim(),
          Colors.red,
          Icons.error,
        );
        setState(() {
          isButtonLoading = false;
          isButtonError = true;
        });
        return;
      }

      final jsonResponse = jsonDecode(body);
      if (jsonResponse['cancellable'] == 'true') {
        cancelData = cancelDataModalFromJson(body);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScreenCancelInfo(
              cancelData: cancelData!,
              seats: ticketMoreData!.inventoryItems,
              tin: ticketMoreData!.tin,
              blocid: widget.blocid,
            ),
          ),
        );
      } else {
        _showCustomSnackBar(
          context,
          'Sorry, cancellation not possible.',
          Colors.orange,
          Icons.warning,
        );
        setState(() {
          isButtonError = true;
        });
      }
    } catch (e) {
      log("Cancel Error: $e");
      _showCustomSnackBar(
        context,
        'Something went wrong. Please try again.',
        Colors.red,
        Icons.error_outline,
      );
      setState(() {
        isButtonError = true;
      });
    } finally {
      setState(() {
        isButtonLoading = false;
      });
    }
  }

  /// Custom Snackbar widget
  void _showCustomSnackBar(
      BuildContext context, String message, Color bgColor, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: bgColor,
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          // Status Card Shimmer
          _buildShimmerCard(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildShimmerBox(width: 100, height: 16),
                        const SizedBox(height: 8),
                        _buildShimmerBox(width: 150, height: 20),
                      ],
                    ),
                    _buildShimmerBox(width: 80, height: 30, isCircle: true),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildShimmerBox(width: 80, height: 14),
                        const SizedBox(height: 4),
                        _buildShimmerBox(width: 120, height: 16),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildShimmerBox(width: 80, height: 14),
                        const SizedBox(height: 4),
                        _buildShimmerBox(width: 120, height: 16),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Journey Card Shimmer
          _buildShimmerCard(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildShimmerBox(width: 40, height: 14),
                          const SizedBox(height: 8),
                          _buildShimmerBox(width: double.infinity, height: 20),
                          const SizedBox(height: 4),
                          _buildShimmerBox(width: 200, height: 16),
                          const SizedBox(height: 4),
                          _buildShimmerBox(width: 100, height: 16),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        _buildShimmerBox(width: 40, height: 40, isCircle: true),
                        const SizedBox(height: 8),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildShimmerBox(width: 40, height: 14),
                          const SizedBox(height: 8),
                          _buildShimmerBox(width: double.infinity, height: 20),
                          const SizedBox(height: 4),
                          _buildShimmerBox(width: 200, height: 16),
                          const SizedBox(height: 4),
                          _buildShimmerBox(width: 100, height: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Bus Info Card Shimmer
          _buildShimmerCard(
            child: Row(
              children: [
                _buildShimmerBox(width: 48, height: 48, isCircle: true),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildShimmerBox(width: 150, height: 20),
                      const SizedBox(height: 8),
                      _buildShimmerBox(width: 100, height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Passengers Card Shimmer
          _buildShimmerCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildShimmerBox(width: 150, height: 18),
                const SizedBox(height: 16),
                ...List.generate(
                  3,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        _buildShimmerBox(width: 40, height: 40, isCircle: true),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildShimmerBox(width: 120, height: 18),
                              const SizedBox(height: 4),
                              _buildShimmerBox(width: 80, height: 14),
                            ],
                          ),
                        ),
                        _buildShimmerBox(width: 60, height: 18),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Fare Card Shimmer
          _buildShimmerCard(
            child: Column(
              children: [
                _buildShimmerFareRow(),
                const SizedBox(height: 8),
                _buildShimmerFareRow(),
                const Divider(height: 24),
                _buildShimmerFareRow(isTotal: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerCard({required Widget child}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }

  Widget _buildShimmerBox({
    required double width,
    required double height,
    bool isCircle = false,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: isCircle
            ? BorderRadius.circular(height / 2)
            : BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildShimmerFareRow({bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildShimmerBox(width: isTotal ? 150 : 120, height: isTotal ? 18 : 16),
        _buildShimmerBox(width: isTotal ? 80 : 70, height: isTotal ? 18 : 16),
      ],
    );
  }
}