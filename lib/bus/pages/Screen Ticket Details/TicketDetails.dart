import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:minna/bus/infrastructure/fareCalculation/fare_calculation.dart';
import 'package:minna/bus/infrastructure/time.dart';
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
  final String transactionId;

  const TicketDetails({
    super.key,
    required this.tin,
    required this.count,
    required this.blocid,
    required this.transactionId,
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

  // Colors are used directly from const.dart: maincolor1, secondaryColor, backgroundColor, cardColor, etc.

  @override
  void initState() {
    super.initState();
    _fetchTicketData(widget.tin);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return _buildShimmerLoading();
    if (isError) return Erroricon(ontap: () => _fetchTicketData(widget.tin));

    final ticket = ticketMoreData!;
    final status = responseJson!["status"];
    final isCancelled = status == "CANCELLED";

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: maincolor1,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Ticket Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Iconsax.arrow_left, color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _buildPremiumHeader(ticket, isCancelled),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildJourneyCard(ticket),
                      const SizedBox(height: 16),
                      _buildBusInfoCard(ticket),
                      const SizedBox(height: 16),
                      _buildPassengersCard(ticket),
                      const SizedBox(height: 16),
                      _buildFareCard(ticket, isCancelled),
                      const SizedBox(height: 120), // Space for pinned button
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!isCancelled)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildCancelButton(),
            ),
        ],
      ),
    );
  }

  Widget _buildPremiumHeader(TicketinfoMore ticket, bool isCancelled) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: maincolor1,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Iconsax.ticket, size: 40, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Text(
            ticket.pnr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: (isCancelled ? errorColor : successColor).withOpacity(0.2),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: (isCancelled ? errorColor : successColor).withOpacity(
                  0.3,
                ),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isCancelled ? Iconsax.close_circle : Iconsax.tick_circle,
                  size: 14,
                  color: isCancelled ? errorColor : Colors.greenAccent,
                ),
                const SizedBox(width: 8),
                Text(
                  isCancelled ? 'CANCELLED' : 'CONFIRMED',
                  style: TextStyle(
                    color: isCancelled ? errorColor : Colors.greenAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJourneyCard(TicketinfoMore ticket) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderSoft),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'FROM',
                      style: TextStyle(
                        fontSize: 10,
                        color: textLight,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      ticket.sourceCity,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: maincolor1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ticket.pickupLocation,
                      style: const TextStyle(
                        fontSize: 12,
                        color: textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Iconsax.clock,
                          size: 14,
                          color: secondaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          changetime(time: ticket.pickupTime),
                          style: const TextStyle(
                            fontSize: 12,
                            color: textSecondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: secondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: secondaryColor.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Iconsax.arrow_right,
                        color: secondaryColor,
                        size: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 2,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            secondaryColor.withOpacity(0.5),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'TO',
                      style: TextStyle(
                        fontSize: 10,
                        color: textLight,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      ticket.destinationCity,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: maincolor1,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ticket.dropLocation,
                      style: const TextStyle(
                        fontSize: 12,
                        color: textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Iconsax.clock,
                          size: 14,
                          color: secondaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          changetime(time: ticket.dropTime),
                          style: const TextStyle(
                            fontSize: 12,
                            color: textSecondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDateInfo('Date of Issue', ticket.dateOfIssue),
                Container(width: 1, height: 30, color: Colors.grey.shade300),
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
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 9,
            color: textLight,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          DateFormat('dd MMM yyyy').format(date),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w900,
            color: maincolor1,
          ),
        ),
      ],
    );
  }

  Widget _buildBusInfoCard(TicketinfoMore ticket) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderSoft),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: secondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Iconsax.bus, color: secondaryColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticket.travels.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: maincolor1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  ticket.busType,
                  style: const TextStyle(
                    fontSize: 12,
                    color: textSecondary,
                    fontWeight: FontWeight.w600,
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
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderSoft),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Iconsax.user,
                  color: secondaryColor,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'PASSENGERS',
                style: TextStyle(
                  fontSize: 11,
                  color: textLight,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              const Spacer(),
              Text(
                '${ticket.inventoryItems.length} Seats',
                style: const TextStyle(
                  fontSize: 12,
                  color: maincolor1,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...ticket.inventoryItems.map((item) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(20),
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
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: maincolor1.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Iconsax.user,
                                color: maincolor1,
                                size: 12,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                item.passenger.name.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                  color: maincolor1,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: secondaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Seat ${item.seatName}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: secondaryColor,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            if (item.cancellationReason != null &&
                                item.cancellationReason!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: errorColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'CANCELLED',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: errorColor,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        if (item.cancellationReason != null &&
                            item.cancellationReason!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              'Reason: ${item.cancellationReason}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: errorColor,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Text(
                    '₹${item.baseFare}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
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
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderSoft),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Iconsax.receipt_21,
                  color: secondaryColor,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'FARE BREAKUP',
                style: TextStyle(
                  fontSize: 11,
                  color: textLight,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildFareRow('Base Fare', baseFare),
          _buildFareRow('Taxes & Fees', gst),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1),
          ),
          _buildFareRow('Total Paid', totalFare, isTotal: true),
          if (isCancelled) ...[
            const SizedBox(height: 12),
            _buildFareRow('Refund Amount', refundAmount, isRefund: true),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal || isRefund ? 15 : 14,
              color: isTotal || isRefund ? maincolor1 : textSecondary,
              fontWeight: isTotal || isRefund
                  ? FontWeight.w900
                  : FontWeight.w600,
            ),
          ),
          Text(
            '₹${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: isTotal || isRefund ? 16 : 14,
              color: isRefund
                  ? successColor
                  : (isTotal ? secondaryColor : maincolor1),
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancelButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isButtonError ? errorColor : maincolor1,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            onPressed: callCancelDataApi,
            child: isButtonLoading
                ? const SizedBox(
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
                        isButtonError ? Iconsax.refresh : Iconsax.close_circle,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        isButtonError ? 'TRY AGAIN' : 'CANCEL TICKET',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
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
          errorColor,
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
              paymentId: widget.transactionId.isNotEmpty
                  ? widget.transactionId
                  : (responseJson?['transaction_id'] ?? ''),
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
        errorColor,
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Column(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            color: maincolor1,
            // borderRadius: const BorderRadius.vertical(
            //   bottom: Radius.circular(32),
            // ),
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.white.withOpacity(0.1),
            highlightColor: Colors.white.withOpacity(0.2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 150,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: 100,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 3,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildShimmerCard(
                  height: 120,
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              height: 16,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
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
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerCard({required Widget child, double height = 150}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade100,
      highlightColor: Colors.white,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.shade200),
        ),
        padding: const EdgeInsets.all(20),
        child: child,
      ),
    );
  }
}
