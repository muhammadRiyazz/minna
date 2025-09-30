import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:minna/bus/domain/CncelData/cancel_data.dart';
import 'package:minna/bus/domain/Ticket%20details/ticket_details_more1.dart';
import 'package:minna/bus/domain/cancel%20succes%20modal/cancel_succes_modal.dart';
import 'package:minna/bus/infrastructure/cancelTicket/conform_cancel_seat.dart';
import 'package:minna/bus/presendation/Screen%20cancel%20Succes/screen_cancel_succes.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/core/api.dart';


class ScreenCancelInfo extends StatefulWidget {
  const ScreenCancelInfo({
    super.key,
    required this.cancelData,
    required this.seats,
    required this.blocid,
    required this.tin,
  });

  final CancelDataModal cancelData;
  final List<InventoryItem> seats;
  final String tin;
  final String blocid;

  @override
  State<ScreenCancelInfo> createState() => _ScreenCancelInfoState();
}

class _ScreenCancelInfoState extends State<ScreenCancelInfo> {
  bool isLoading = false;
  bool isError = false;
  CancelSuccesModal? cancelSuccesData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cancellation Info'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: maincolor1,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Cancellable Status Card
              _buildStatusCard(),
              const SizedBox(height: 16),

              // Charges Details Card
              _buildChargesCard(),
              const Spacer(),

              // Action Button
              _buildActionButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Cancellation Status',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: widget.cancelData.cancellable == 'true'
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.cancelData.cancellable == 'true'
                        ? Icons.check_circle
                        : Icons.cancel,
                    size: 16,
                    color: widget.cancelData.cancellable == 'true'
                        ? Colors.green
                        : Colors.red,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    widget.cancelData.cancellable == 'true'
                        ? 'CANCELLABLE'
                        : 'NOT CANCELLABLE',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: widget.cancelData.cancellable == 'true'
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChargesCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CANCELLATION DETAILS',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 12),
            const Divider(height: 1),

            // Seat-wise charges
            ...List.generate(
              widget.cancelData.cancellationCharges.entry.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Seat ${widget.cancelData.cancellationCharges.entry[index].key}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      widget.cancelData.cancellationCharges.entry[index].value,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 24),

            // Service Charge
            _buildChargeRow('Service Charge', widget.cancelData.serviceCharge),
            const Divider(height: 24),

            // Total Charges
            _buildChargeRow(
              'Total Cancellation Charges',
              widget.cancelData.totalCancellationCharge,
              isHighlighted: true,
            ),
            const SizedBox(height: 8),
            _buildChargeRow(
              'Service Tax',
              widget.cancelData.serviceTaxOnCancellationCharge,
              isHighlighted: true,
            ),
            const Divider(height: 24),

            // Refund Amount
            _buildChargeRow(
              'Total Refund Amount',
              widget.cancelData.totalRefundAmount,
              isRefund: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChargeRow(
    String label,
    String value, {
    bool isHighlighted = false,
    bool isRefund = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isHighlighted ? 14 : 13,
            fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.normal,
            color: isHighlighted ? Colors.black : Colors.grey.shade600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isHighlighted ? 16 : 14,
            fontWeight: FontWeight.w600,
            color: isRefund
                ? Colors.green
                : isHighlighted
                ? maincolor1
                : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        // color: Colors.white,
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isError ? Colors.orange : maincolor1,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            onPressed: callApi,
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    isError ? 'TRY AGAIN' : 'CONFIRM CANCELLATION',
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

  Future<void> callApi() async {
  if (widget.cancelData.cancellable != 'true') return;

  setState(() {
    isLoading = true;
    isError = false;
  });

  try {
    // Step 1: Cancel Seat API
    final data = await cancelSeats(tin: widget.tin, seats: widget.seats);
    final respo = data!.body;

    if (respo.contains('Error')) {
      if (respo !=
          'Error: Authorization failed please send valid consumer key and secret in the api request.') {
        final msg = respo.replaceAll('Error:', '').trim();
        showAppSnackBar(context, msg,
            bgColor: Colors.orange, icon: Icons.warning_amber_rounded);

        setState(() {
          isLoading = false;
          isError = true;
        });
        return;
      } else {
        // Retry if authorization failed
        await callApi();
        return;
      }
    }

    cancelSuccesData = cancelSuccesModalFromJson(data.body);

    // Step 2: Call Refund API
    final refundRes = await cancelRefundupdate(
     responsee: data.body
     ,blockID: widget.blocid
    );

    final refundJson = jsonDecode(refundRes.body);

    if (refundJson["status"] == "success") {
      // ✅ Refund success
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ScreenCancelSucces(cancelSuccesdata: cancelSuccesData!),
        ),
      );
    } else {
      // ❌ Refund failed
      showAppSnackBar(context,
          refundJson["message"] ?? "Refund not possible. Please contact support.",
          bgColor: Colors.red,
          icon: Icons.support_agent);

      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  } catch (e) {
    log('Cancellation error: $e');
    setState(() {
      isLoading = false;
      isError = true;
    });
    showAppSnackBar(context, "An error occurred. Please try again.",
        bgColor: Colors.red, icon: Icons.error_outline);
  }
}

}
void showAppSnackBar(BuildContext context, String message,
    {Color bgColor = Colors.red, IconData icon = Icons.error}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}

Future<http.Response> cancelRefundupdate({
  required String blockID,
  required String responsee,
 
}) async {
  log("cancelRefundupdate---");
  final url = Uri.parse("${baseUrl}CancelTicket");

  final response = await http.post(
    url,
    body: {
      "blockID":blockID,
      "response": responsee,
     
    },
  );
log(response.body);
  return response;
}
