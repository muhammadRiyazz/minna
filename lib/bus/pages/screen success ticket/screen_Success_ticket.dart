import 'package:flutter/material.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/pages/main%20home/home.dart';

class ScreenSuccessTicket extends StatefulWidget {
  final String tinid;
  final int passengercount;

  const ScreenSuccessTicket({
    super.key,
    required this.tinid,
    required this.passengercount,
  });

  @override
  State<ScreenSuccessTicket> createState() => _ScreenSuccessTicketState();
}

class _ScreenSuccessTicketState extends State<ScreenSuccessTicket> {
  // Color Theme - Black & Gold Premium
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37); // Gold
  final Color _accentColor = Color(0xFFC19B3C); // Darker Gold
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);
  final Color _successColor = Color(0xFF388E3C);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: _backgroundColor,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                // Background decoration
                Positioned(
                  top: -50,
                  right: -50,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: _secondaryColor.withOpacity(0.05),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -80,
                  left: -80,
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      color: _secondaryColor.withOpacity(0.03),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                
                // Main content
                Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Success Icon with Animation
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                           color: _secondaryColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                            
                            ),
                            child:  Icon(
                              Icons.check_rounded,
                              color: _secondaryColor,
                              size: 60,
                            ),
                          ),
                          const SizedBox(height: 32),
                          
                          // Success Title
                          Text(
                            'Booking Confirmed!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              color: _textPrimary,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 10),
                          
                          // Success Message
                          Text(
                            'Your bus tickets have been successfully booked',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              color: _textSecondary,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 32),
                          
                          // Ticket Details Card
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: _cardColor,
                              borderRadius: BorderRadius.circular(20),
                            
                             
                            ),
                            child: Column(
                              children: [
                                // Ticket ID
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.confirmation_number_rounded,
                                      color: _secondaryColor,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Ticket ID',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: _textSecondary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  widget.tinid,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: _primaryColor,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                
                             
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          
                          // Additional Information
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: _successColor.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: _successColor.withOpacity(0.2),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info_outline_rounded,
                                  color: _successColor,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Your tickets have been sent to your registered email and mobile number',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: _successColor,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          
                          // Action Buttons
                          Column(
                            children: [
                              // Primary Button - Go Home
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _primaryColor,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 18,
                                      horizontal: 24,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    elevation: 0,
                                  ),
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (_) => HomePage()),
                                      (route) => false,
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.home_rounded, size: 20),
                                      const SizedBox(width: 12),
                                      Text(
                                        'Go to Home',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              
                              // Secondary Button - View Ticket (Optional)
                              // SizedBox(
                              //   width: double.infinity,
                              //   child: OutlinedButton(
                              //     style: OutlinedButton.styleFrom(
                              //       foregroundColor: _primaryColor,
                              //       padding: const EdgeInsets.symmetric(
                              //         vertical: 16,
                              //         horizontal: 24,
                              //       ),
                              //       shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(16),
                              //       ),
                              //       side: BorderSide(
                              //         color: _primaryColor,
                              //         width: 1.5,
                              //       ),
                              //     ),
                              //     onPressed: () {
                              //       // Navigate to ticket view page
                              //       // Navigator.push(
                              //       //   context,
                              //       //   MaterialPageRoute(
                              //       //     builder: (_) => ScreenViewTicket(
                              //       //       tinid: widget.tinid,
                              //       //       passengercount: widget.passengercount,
                              //       //     ),
                              //       //   ),
                              //       // );
                              //     },
                              //     child: Row(
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: [
                              //         Icon(Icons.visibility_rounded, size: 20),
                              //         const SizedBox(width: 12),
                              //         Text(
                              //           'View Ticket',
                              //           style: TextStyle(
                              //             fontSize: 16,
                              //             fontWeight: FontWeight.w600,
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          
                          
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Optional: Enhanced Confirmation Dialog
  void _showEnhancedConfirmationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: _cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.confirmation_number_rounded,
                  color: _secondaryColor,
                  size: 32,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'View Your Ticket?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Would you like to see your bus ticket details now?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: _textSecondary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: _textPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(
                          color: _textLight.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => HomePage()),
                          (route) => false,
                        );
                      },
                      child: Text(
                        'Go Home',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primaryColor,
                        foregroundColor: _secondaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        // Navigate to ticket view
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) => ScreenViewTicket(
                        //       tinid: widget.tinid,
                        //       passengercount: widget.passengercount,
                        //     ),
                        //   ),
                        // );
                      },
                      child: Text(
                        'View Ticket',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}