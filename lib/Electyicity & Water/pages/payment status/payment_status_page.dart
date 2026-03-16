import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minna/Electyicity%20&%20Water/report.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/pages/main%20home/home.dart';

class BillPaymentStatusPage extends StatefulWidget {
  final Map<String, dynamic> responseData;
  final String provider;
  final String consumerId;

  const BillPaymentStatusPage({
    super.key,
    required this.responseData,
    required this.provider,
    required this.consumerId,
  });

  @override
  State<BillPaymentStatusPage> createState() => _BillPaymentStatusPageState();
}

class _BillPaymentStatusPageState extends State<BillPaymentStatusPage> {
  @override
  Widget build(BuildContext context) {
    final billDetails = widget.responseData['data']?['billdetails'] ?? {};
    final responseReason = (billDetails['responseReason'] ?? 'Awaited')
        .toString()
        .toUpperCase();

    // Status Determination
    bool isSuccess =
        responseReason == 'SUCCESSFUL' || responseReason == 'SUCCESS';
    bool isAwaited = responseReason == 'AWAITED';
    bool isFailed = responseReason == 'FAILED';

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false,
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BillPaymentPage(
                      title: 'Bill Reports',
                      billerCategory: 'Electricity',
                    ),
                  ),
                );
              },
              child: Text(
                'Reports',
                style: TextStyle(
                  color: maincolor1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildStatusHeader(
                isSuccess,
                isAwaited,
                isFailed,
                responseReason,
              ),
              const SizedBox(height: 30),
              _buildPaymentDetailsCard(billDetails),
              const SizedBox(height: 20),
              if (isAwaited) _buildAwaitedInfoCard(),
              if (isFailed) _buildFailedInfoCard(),
              const SizedBox(height: 40),
              _buildActionButtons(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusHeader(
    bool isSuccess,
    bool isAwaited,
    bool isFailed,
    String responseReason,
  ) {
    Color statusColor = isSuccess
        ? Colors.green
        : (isAwaited ? Colors.orange : Colors.red);

    IconData statusIcon = isSuccess
        ? Icons.check_circle
        : (isAwaited ? Icons.timer_rounded : Icons.error_rounded);

    String statusTitle = isSuccess
        ? 'Payment Successful'
        : (isAwaited ? 'Payment Awaited' : 'Payment Failed');

    String statusSubtitle = isSuccess
        ? 'Your bill payment has been successfully processed.'
        : (isAwaited
              ? 'Your payment is under verification by the biller.'
              : 'We encountered an error while processing your bill.');

    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Center(child: Icon(statusIcon, color: statusColor, size: 60)),
        ),
        const SizedBox(height: 20),
        Text(
          statusTitle,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            statusSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ),
        if (isSuccess || isAwaited) ...[
          const SizedBox(height: 20),
          Text(
            '₹ ${widget.responseData['data']?['paymentdetails']?['amount'] ?? '0.00'}',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPaymentDetailsCard(Map<String, dynamic> billDetails) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Transaction Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          _buildDetailRow('Provider', widget.provider),
          _buildDetailRow('Consumer ID', widget.consumerId),
          _buildDetailRow('Bill Number', billDetails['txtBillNumber'] ?? 'N/A'),
          // _buildDetailRow('Transaction ID', billDetails['txnRefId'] ?? 'N/A'),
          _buildDetailRow(
            'Date & Time',
            billDetails['date_time'] ??
                DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
          ),
          const Divider(height: 30),
          _buildDetailRow(
            'Status',
            (billDetails['responseReason'] ?? 'Awaited'),
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAwaitedInfoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.orange, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Your payment is being verified. It will reflect in the operator records within 24-48 hours. Please check the reports section for updates.',
              style: TextStyle(color: Colors.orange[800], fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFailedInfoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.red, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'If any amount was deducted from your account, it will be automatically refunded within 3-7 working days.',
                  style: TextStyle(color: Colors.red[800], fontSize: 13),
                ),
                const SizedBox(height: 8),
                Text(
                  'Refund initiated, check reports for status',
                  style: TextStyle(
                    color: Colors.red[900],
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: maincolor1,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Go to Home',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BillPaymentPage(
                      title: 'Bill Reports',
                      billerCategory: 'Electricity',
                    ),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: maincolor1,
                side: BorderSide(color: maincolor1, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'View Reports',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
