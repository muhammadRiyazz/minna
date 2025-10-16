import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:minna/bus/infrastructure/fareCalculation/fare_calculation.dart';
import 'package:minna/bus/infrastructure/time.dart';
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

  // New color scheme
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37); // Gold
  final Color _accentColor = Color(0xFFC19B3C); // Darker Gold
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);
  final Color _errorColor = Color(0xFFE53935);
  final Color _successColor = Color(0xFF4CAF50);

  @override
  void initState() {
    super.initState();
    _fetchTicketData(widget.tin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: isLoading
          ? _buildShimmerLoading()
          : isError
              ? Erroricon(ontap: () => _fetchTicketData(widget.tin))
              : _buildTicketDetailsWithSliver(),
    );
  }

  Widget _buildTicketDetailsWithSliver() {
    final ticket = ticketMoreData!;
    final status = responseJson!["status"];
    final isCancelled = status == "CANCELLED";

    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            // Sliver App Bar
            SliverAppBar(
              backgroundColor: _primaryColor,
              expandedHeight: 200.0,
              pinned: true,
              floating: true,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(
                'Ticket Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [_primaryColor, _primaryColor.withOpacity(0.8)],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // PNR and Status in header
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'PNR Number',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  ticket.pnr,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isCancelled
                                    ? _errorColor.withOpacity(0.2)
                                    : _successColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isCancelled ? _errorColor : _successColor,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isCancelled ? Icons.cancel : Icons.check_circle,
                                    size: 12,
                                    color: isCancelled ? _errorColor : _successColor,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    isCancelled ? 'Cancelled' : 'Confirmed',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: isCancelled ? _errorColor : _successColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Ticket Content
            SliverList(
              delegate: SliverChildListDelegate([
                // Journey Details Card
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildJourneyCard(ticket),
                ),

                // Bus Information Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _buildBusInfoCard(ticket),
                ),

                const SizedBox(height: 16),

                // Passengers List
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _buildPassengersCard(ticket),
                ),

                const SizedBox(height: 16),

                // Fare Details Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _buildFareCard(ticket, isCancelled),
                ),

                const SizedBox(height: 100), // Extra space for bottom button
              ]),
            ),
          ],
        ),

        // Cancel Button positioned at bottom
        if (!isCancelled)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildCancelButton(),
          ),
      ],
    );
  }

  Widget _buildJourneyCard(TicketinfoMore ticket) {
    return Container(
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
                        fontSize: 10,
                        color: _textSecondary,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      ticket.sourceCity,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      ticket.pickupLocation,
                      style: TextStyle(
                        fontSize: 13,
                        color: _textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 12, color: _secondaryColor),
                        const SizedBox(width: 6),
                        Text(
                          changetime(time: ticket.pickupTime),
                          style: TextStyle(
                            fontSize: 12,
                            color: _textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: _secondaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: _secondaryColor.withOpacity(0.3), width: 2),
                    ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: _secondaryColor,
                      size: 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 2,
                    height: 40,
                    color: _secondaryColor.withOpacity(0.3),
                  ),
                ],
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
                    const SizedBox(height: 5),
                    Text(
                      ticket.destinationCity,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ticket.dropLocation,
                      style: TextStyle(
                        fontSize: 13,
                        color: _textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.access_time, size: 12, color: _secondaryColor),
                        const SizedBox(width: 6),
                        Text(
                          changetime(time: ticket.dropTime),
                          style: TextStyle(
                            fontSize: 12,
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
          const SizedBox(height: 20),
          // Date Information
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDateInfo('Date of Issue', ticket.dateOfIssue),
                Container(
                  width: 1,
                  height: 30,
                  color: _textLight.withOpacity(0.3),
                ),
                _buildDateInfo('Date of Journey', ticket.doj),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateInfo(String title, DateTime date) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 10, color: _textSecondary),
        ),
        const SizedBox(height: 6),
        Text(
          DateFormat('dd MMM yyyy').format(date),
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildBusInfoCard(TicketinfoMore ticket) {
    return Container(
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
      padding: const EdgeInsets.all(16),
      child: Row(


        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _secondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: _secondaryColor.withOpacity(0.3), width: 2),
            ),
            child: Icon(Icons.directions_bus_rounded, color: _secondaryColor, size: 20),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticket.travels,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  ticket.busType,
                  style: TextStyle(
                    fontSize: 12,
                    color: _textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: _secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Bus Service',
                    style: TextStyle(
                      fontSize: 12,
                      color: _secondaryColor,
                      fontWeight: FontWeight.w600,
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

  Widget _buildPassengersCard(TicketinfoMore ticket) {
    return Container(
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
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.people_alt_rounded, color: _secondaryColor, size: 15),
              ),
              const SizedBox(width: 12),
              Text(
                'PASSENGERS',
                style: TextStyle(
                  fontSize: 13,
                  color: _textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${ticket.inventoryItems.length}',
                  style: TextStyle(
                    fontSize: 14,
                    color: _secondaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...ticket.inventoryItems.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                padding: const EdgeInsets.all(15),
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
                          Row(
                            children: [
 Padding(
                  padding: const EdgeInsets.only(right: 10,),
   child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _secondaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person, color: _secondaryColor, size: 12),
                ),
 ),


                              Text(
                                item.passenger.name,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'Seat ${item.seatName}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              if (item.cancellationReason != null && 
                                  item.cancellationReason!.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: _errorColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      'Cancelled',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _errorColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          if (item.cancellationReason != null && 
                              item.cancellationReason!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                'Reason: ${item.cancellationReason}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _errorColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Text(
                      '₹${item.baseFare}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: _secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFareCard(TicketinfoMore ticket, bool isCancelled) {
    final baseFare = totalbasefare(seats: ticket.inventoryItems);
    final totalFare = totalfare(seats: ticket.inventoryItems);
    final gst = totalFare - baseFare;

    num refundAmount = 0;
    if (isCancelled && responseJson!.containsKey("refundAmount")) {
      final refundString = responseJson!["refundAmount"].toString();
      refundAmount = double.tryParse(refundString) ?? 0;
    }

    return Container(
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
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.receipt_long_rounded, color: _secondaryColor, size: 12),
              ),
              const SizedBox(width: 12),
              Text(
                'FARE BREAKUP',
                style: TextStyle(
                  fontSize: 13,
                  color: _textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          _buildFareRow('Base Fare', baseFare),
          _buildFareRow('Taxes & Fees', gst),
          const Divider(height: 6),
          _buildFareRow('Total Paid', totalFare, isTotal: true),
          if (isCancelled) ...[
            const Divider(height: 6),
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

  Widget _buildFareRow(
    String label,
    num amount, {
    bool isTotal = false,
    bool isRefund = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: isTotal || isRefund ? _textPrimary : _textSecondary,
              fontWeight: isTotal || isRefund
                  ? FontWeight.w600
                  : FontWeight.normal,
            ),
          ),
          Text(
            '₹${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16,
              color: isRefund
                  ? _successColor
                  : isTotal
                      ? _secondaryColor
                      : _textPrimary,
              fontWeight: isTotal || isRefund
                  ? FontWeight.w700
                  : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancelButton() {
    return Container(
      padding: const EdgeInsets.only(bottom: 10,right: 12,left: 12),
      decoration: BoxDecoration( 
        
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      
        color: _cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),],
    ),
       
            child: SafeArea(
           child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isButtonError ? _errorColor : _primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              shadowColor: _primaryColor.withOpacity(0.3),
            ),
            onPressed: callCancelDataApi,
            child: isButtonLoading
                ? SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cancel_rounded,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        isButtonError ? 'TRY AGAIN' : 'CANCEL TICKET',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
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
        responseJson = json.decode(data.body);
        
        if (responseJson!["status"] == "CANCELLED") {
          if (responseJson!["inventoryItems"] is Map<String, dynamic>) {
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
          body.replaceAll('Error:', '').trim(),
          _errorColor,
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
        'Something went wrong. Please try again.',
        _errorColor,
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

  void _showCustomSnackBar(String message, Color bgColor, IconData icon) {
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
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: _primaryColor,
          expandedHeight: 200.0,
          pinned: true,
          floating: true,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            background: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                color: _primaryColor,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildShimmerCard(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildShimmerBox(width: 40, height: 14),
                              const SizedBox(height: 12),
                              _buildShimmerBox(width: double.infinity, height: 20),
                              const SizedBox(height: 8),
                              _buildShimmerBox(width: 200, height: 16),
                              const SizedBox(height: 6),
                              _buildShimmerBox(width: 100, height: 16),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            _buildShimmerBox(width: 40, height: 40, isCircle: true),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _buildShimmerBox(width: 40, height: 14),
                              const SizedBox(height: 12),
                              _buildShimmerBox(width: double.infinity, height: 20),
                              const SizedBox(height: 8),
                              _buildShimmerBox(width: 200, height: 16),
                              const SizedBox(height: 6),
                              _buildShimmerBox(width: 100, height: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }

  Widget _buildShimmerCard({required Widget child}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: _cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(24),
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
        color: _cardColor,
        borderRadius: isCircle
            ? BorderRadius.circular(height / 2)
            : BorderRadius.circular(4),
      ),
    );
  }
}