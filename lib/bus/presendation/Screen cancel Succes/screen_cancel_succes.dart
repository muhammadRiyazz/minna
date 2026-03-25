import 'package:flutter/material.dart';
import 'package:minna/comman/pages/main%20home/home.dart';

import '../../domain/cancel succes modal/cancel_succes_modal.dart';

class ScreenCancelSucces extends StatelessWidget {
   ScreenCancelSucces({
    super.key,
    required this.cancelSuccesdata,
    required this.refundSuccess,
    this.refundMessage,
  });

  final CancelSuccesModal cancelSuccesdata;
  final bool refundSuccess;
  final String? refundMessage;

  // Updated Theme Colors - Premium Black & Gold
  final Color _primaryColor = Colors.black;
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF94A3B8);
  final Color _errorColor = Color(0xFFEF4444);
  final Color _successColor = Color(0xFF10B981);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: _backgroundColor,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Success Icon - Premium Design
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: _successColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _successColor.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.check_circle_rounded,
                      color: _successColor,
                      size: 72,
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Title
                  Text(
                    'Cancellation Successful',
                    style: TextStyle(
                      color: _textPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Message
                  Text(
                    'Your trip for TIN: ${cancelSuccesdata.tin}\nhas been cancelled.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _textSecondary,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // Refund Status Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
                    decoration: BoxDecoration(
                      color: _cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                      border: Border.all(
                        color: refundSuccess ? _successColor.withOpacity(0.1) : _errorColor.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'REFUND AMOUNT',
                          style: TextStyle(
                            color: _textLight,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "₹${cancelSuccesdata.refundAmount}",
                          style: TextStyle(
                            color: _textPrimary,
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Divider(
                          color: _textLight.withOpacity(0.1),
                          height: 1,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              refundSuccess ? Icons.info_outline_rounded : Icons.warning_amber_rounded,
                              size: 18,
                              color: refundSuccess ? _successColor : _errorColor,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                refundSuccess 
                                  ? 'Refund initiated, credit shortly' 
                                  : 'Refund not initiated, some issue faced',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: refundSuccess ? _successColor : _errorColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (!refundSuccess) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Please connect with our support team',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: _textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 60),
                  
                  // Back to Home Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primaryColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        'Back to Home',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}