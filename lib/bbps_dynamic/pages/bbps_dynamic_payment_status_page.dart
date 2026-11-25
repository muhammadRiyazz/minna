import 'package:flutter/material.dart';
import 'package:minna/comman/const/const.dart';
import 'package:iconsax/iconsax.dart';

class BbpsDynamicPaymentStatusPage extends StatelessWidget {
  final String status;
  final String message;

  const BbpsDynamicPaymentStatusPage({
    super.key,
    required this.status,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    String title = "Payment Status";
    IconData icon = Icons.info_outline;
    Color color = Colors.blue;
    Color bgColor = Colors.blue.withOpacity(0.1);

    String displayMessage = message;

    if (status == 'SUCCESS') {
      title = "Payment Successful";
      icon = Icons.check_circle_rounded;
      color = Colors.green;
      bgColor = Colors.green.withOpacity(0.1);
    } else if (status == 'FAILED') {
      title = "Verification Failed";
      icon = Icons.error_rounded;
      color = Colors.red;
      bgColor = Colors.red.withOpacity(0.1);
    } else if (status == 'REFUNDED') {
      title = "Refunded";
      icon = Icons.assignment_return_rounded;
      color = Colors.orange;
      bgColor = Colors.orange.withOpacity(0.1);
    } else if (status == 'PENDING') {
      title = "Verification Pending";
      icon = Icons.hourglass_empty_rounded;
      color = Colors.orange;
      bgColor = Colors.orange.withOpacity(0.1);
    } else if (status == 'REFUND_FAILED') {
      title = "Refund Failed";
      icon = Icons.warning_amber_rounded;
      color = Colors.red;
      bgColor = Colors.red.withOpacity(0.1);
      displayMessage = "$message\n\nPlease contact support for assistance.";
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // Hide back button for forced action
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated-like Circle Icon
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: bgColor,
                      ),
                      child: Center(
                        child: Icon(
                          icon,
                          color: color,
                          size: 64,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      displayMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              // Action Button
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color, // Match button with status color
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    if (status == 'SUCCESS' ||
                        status == 'PENDING' ||
                        status == 'REFUNDED') {
                      // Pop back to home (assuming 3 pops: Status -> Bill Details -> Input Page -> Home)
                      Navigator.pop(context); // Close status page
                      Navigator.pop(context); // Close Bill Details
                      Navigator.pop(context); // Close Input Page
                    } else {
                      // Just pop back to bill details to let them try again
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'DONE',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
