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
  // Use standardized theme colors from const.dart


  @override
  Widget build(BuildContext context) {
    final billDetails = widget.responseData['data']?['billdetails'] ?? {};
    final responseReason = (billDetails['responseReason'] ?? 'Awaited')
        .toString()
        .toUpperCase();

    // Status Determination
    bool isSuccess = responseReason == 'SUCCESSFUL' || responseReason == 'SUCCESS';
    bool isAwaited = responseReason == 'AWAITED';
    bool isFailed = responseReason == 'FAILED';

    Color statusColor = isSuccess ? successColor : (isAwaited ? warningColor : errorColor);
    IconData statusIcon = isSuccess ? Icons.check_circle_rounded : (isAwaited ? Icons.hourglass_empty_rounded : Icons.error_outline_rounded);
    String statusTitle = isSuccess ? 'Payment Successful' : (isAwaited ? 'Payment Awaited' : 'Payment Failed');

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
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            // Immersive Top Background
            Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(color: maincolor1),
              child: Stack(
                children: [
                   Positioned(
                    top: -50,
                    right: -50,
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: -20,
                    child: Icon(statusIcon, size: 180, color: Colors.white.withOpacity(0.04)),
                  ),
                ],
              ),
            ),
            
            // Content
            Column(
              children: [
                const SizedBox(height: 80),
                // Status Icon & Title
                Center(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: statusColor.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
                          ],
                        ),
                        child: Icon(statusIcon, color: statusColor, size: 60),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        statusTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          isSuccess 
                            ? 'Your bill payment was successful.' 
                            : (isAwaited ? 'Payment is in process.' : 'Transaction could not be completed.'),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                      if (isSuccess || isAwaited) ...[
                        const SizedBox(height: 24),
                        Text(
                          '₹ ${widget.responseData['data']?['paymentdetails']?['amount'] ?? '0.00'}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                
                const SizedBox(height: 48),
                
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        // Details Card
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 20, offset: const Offset(0, 10)),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.receipt_long_rounded, color: maincolor1, size: 20),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Transaction Details',
                                    style: TextStyle(color: maincolor1, fontWeight: FontWeight.w900, fontSize: 16),
                                  ),
                                ],
                              ),
                              const Divider(height: 40),
                              _buildDetailRow('Provider', widget.provider),
                              _buildDetailRow('Consumer ID', widget.consumerId),
                              _buildDetailRow('Bill Number', billDetails['txtBillNumber'] ?? 'N/A'),
                              _buildDetailRow(
                                'Date & Time',
                                billDetails['date_time'] ?? DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.now()),
                              ),
                              const Divider(height: 40),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Status', style: TextStyle(color: textSecondary, fontSize: 13, fontWeight: FontWeight.w600)),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: statusColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      responseReason,
                                      style: TextStyle(color: statusColor, fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 0.5),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        if (isAwaited) _buildInfoCard(warningColor, 'Verification Pending', 'Your payment is under verification and will reflect in operator records within 24-48 hours.'),
                        if (isFailed) _buildInfoCard(errorColor, 'Refund Policy', 'If amount was deducted, it will be automatically refunded within 3-7 working days.'),
                        
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
                
                // Bottom Buttons
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: maincolor1,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            elevation: 0,
                          ),
                          child: const Text('GO TO HOME', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 15, letterSpacing: 1)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const BillPaymentPage(title: 'Bill Reports', billerCategory: 'Electricity')));
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: maincolor1, width: 2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          child: Text('VIEW REPORTS', style: TextStyle(color: maincolor1, fontWeight: FontWeight.w900, fontSize: 15, letterSpacing: 1)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Close Button
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
                    child: const Icon(Icons.close_rounded, color: Colors.white, size: 24),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: textSecondary, fontSize: 13, fontWeight: FontWeight.w600)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(color: maincolor1, fontSize: 14, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(Color color, String title, String message) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, color: color, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 14)),
                const SizedBox(height: 4),
                Text(message, style: TextStyle(color: color.withOpacity(0.8), fontSize: 12, height: 1.4, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
