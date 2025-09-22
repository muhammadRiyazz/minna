import 'package:flutter/material.dart';
import 'package:minna/comman/const/const.dart';

class ConfirmPlanPage extends StatelessWidget {
  final String mobileNumber;
  final String operator;
  final Map<String, String> selectedPlan;

  const ConfirmPlanPage({super.key, 
    required this.mobileNumber,
    required this.operator,
    required this.selectedPlan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: maincolor1,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white, size: 16),
        title: const Text(
          'Confirm Recharge',
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          // Plan details section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Operator Info Row
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.red.shade100,
                                Colors.orange.shade100,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            operator.substring(0, 2),
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              operator,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              mobileNumber,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Icon(Icons.verified, color: maincolor1, size: 20),
                      ],
                    ),

                    // Divider with custom styling
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.grey.withOpacity(0.1),
                      ),
                    ),

                    // Plan Details
                    _buildDetailRow(
                      title: 'Plan Amount',
                      value: selectedPlan['price']!,
                      isHighlighted: true,
                    ),
                    _buildDetailRow(
                      title: 'Validity',
                      value: selectedPlan['validity']!,
                    ),
                    _buildDetailRow(
                      title: 'Benefits',
                      value: selectedPlan['desc']!,
                      isMultiLine: true,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Helper Widget for Detail Rows

          // const Spacer(),

          // Pay Now button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {


                
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: maincolor1,
              ),
              child: const Text(
                'Pay Now',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildDetailRow({
  required String title,
  required String value,
  bool isHighlighted = false,
  bool isMultiLine = false,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      crossAxisAlignment: isMultiLine
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
        const Spacer(),
        if (!isMultiLine)
          Text(
            value,
            style: TextStyle(
              fontSize: isHighlighted ? 16 : 14,
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w500,
              color: isHighlighted ? maincolor1 : Colors.black,
            ),
          ),
        if (isMultiLine)
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ),
      ],
    ),
  );
}
