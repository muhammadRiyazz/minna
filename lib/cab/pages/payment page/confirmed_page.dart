import 'package:flutter/material.dart';
import 'package:minna/cab/domain/confirm%20model/confirm_model.dart';
import 'package:minna/comman/pages/main%20home/home.dart';

class CabSuccessPage extends StatelessWidget {
  final BookingConfirmData bookingResponse;

  const CabSuccessPage({super.key, required this.bookingResponse});

  // Color Theme - Black & Gold Premium (matching booked_cab_details.dart)
  static const Color _primaryColor = Colors.black;
  static const Color _secondaryColor = Color(0xFFD4AF37); // Gold
  static const Color _backgroundColor = Color(0xFFF8F9FA);
  static const Color _cardColor = Colors.white;
  static const Color _textPrimary = Colors.black;
  static const Color _textSecondary = Color(0xFF666666);
  static const Color _textLight = Color(0xFF999999);

  @override
  Widget build(BuildContext context) {
    final data = bookingResponse;
    
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
        body: Container(
          color: Colors.green,
          child: Column(
            children: [
              // Header section
              Container(
                padding: const EdgeInsets.only(top: 60, bottom: 20),
                child: Column(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),

                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Booking Confirmed!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Your cab booking is confirmed',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Content section
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: _backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12,),
                        // Booking ID
                        _buildInfoCard(
                          icon: Icons.confirmation_number,
                          title: 'Booking ID',
                          value: data.bookingId,
                        ),
                        
                        const SizedBox(height: 10),
                        
                        // Verification Code
                        _buildInfoCard(
                          icon: Icons.vpn_key,
                          title: 'Verification Code',
                          value: data.verificationCode,
                          highlight: true,
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Date and Time Section - Redesigned
                        Text(
                          'Date & Time',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _textPrimary,
                          ),
                        ),
                        
                        const SizedBox(height: 10),
                        
                        _buildDateTimeCard(data.startDate,data.startTime),
                        
                        const SizedBox(height: 24),
                        
                        // Cab Information
                        Text(
                          'Cab Information',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _textPrimary,
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        _buildCabInfoCard(data.cabRate.cab),
                        
                        const SizedBox(height: 24),

                        // Fare Details
                        Text(
                          'Fare Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _textPrimary,
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        _buildFareCard(data.cabRate.fare),
                        
                        const SizedBox(height: 10),
                        
                        // Action buttons
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (_) => HomePage()),
                                    (route) => false,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _primaryColor,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'GO TO HOME',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    bool highlight = false,
  }) {
    return Card(
      elevation: 0,
      color: _cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: highlight ? _secondaryColor.withOpacity(0.1) : _backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: highlight ? _secondaryColor : _textSecondary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: _textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: highlight ? _secondaryColor : _textPrimary,
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

Widget _buildDateTimeCard(String dateString, String timeString) {
  // Parse the date and time
  final date = DateTime.parse(dateString);
  
  // Parse time string (assuming format like "14:30:00")
  final timeParts = timeString.split(':');
  final hour = int.parse(timeParts[0]);
  final minute = int.parse(timeParts[1]);
  
  // Create a DateTime object for time formatting
  final timeDateTime = DateTime(2023, 1, 1, hour, minute);

  // Format time in 12-hour format with AM/PM
  final formattedTime = _formatTime12Hour(timeDateTime);
  
  // Format date with month name and year
  final formattedDate = _formatDateWithMonthName(date);
  
  return Card(
    elevation: 0,
    color: _cardColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Calendar icon section
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: _secondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  date.day.toString(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _secondaryColor,
                  ),
                ),
                Text(
                  _getMonthAbbreviation(date.month),
                  style: TextStyle(
                    fontSize: 12,
                    color: _secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Date and time details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Scheduled Pickup',
                  style: TextStyle(
                    fontSize: 12,
                    color: _textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: _textSecondary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      formattedTime,
                      style: TextStyle(
                        fontSize: 14,
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
    ),
  );
}
  String _formatTime12Hour(DateTime dateTime) {
    final hour = dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour < 12 ? 'AM' : 'PM';
    return '${hour == 0 ? 12 : hour}:$minute $period';
  }

  String _formatDateWithMonthName(DateTime dateTime) {
    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    
    return '${dateTime.day} ${monthNames[dateTime.month - 1]}, ${dateTime.year}';
  }

  String _getMonthAbbreviation(int month) {
    const monthAbbreviations = [
      'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
      'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'
    ];
    
    return monthAbbreviations[month - 1];
  }

  Widget _buildCabInfoCard(Cab cab) {
    return Card(
      elevation: 0,
      color: _cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: _secondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.directions_car,
                size: 32,
                color: _secondaryColor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cab.type,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cab.category,
                    style: TextStyle(
                      fontSize: 14,
                      color: _textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _backgroundColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.people,
                              size: 16,
                              color: _textSecondary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${cab.seatingCapacity}',
                              style: TextStyle(
                                fontSize: 12,
                                color: _textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _backgroundColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.luggage,
                              size: 16,
                              color: _textSecondary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${cab.bagCapacity}',
                              style: TextStyle(
                                fontSize: 12,
                                color: _textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFareCard(Fare fare) {
    return Card(
      elevation: 0,
      color: _cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Base fare
            _buildFareRow('Base Fare', '₹${fare.baseFare}'),
            const SizedBox(height: 12),
            
            // Additional charges
            if (fare.driverAllowance > 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildFareRow('Driver Allowance', '₹${fare.driverAllowance}'),
              ),
            
            if (fare.gst > 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildFareRow('GST', '₹${fare.gst}'),
              ),
            
            if (fare.tollTax > 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildFareRow('Toll Tax', '₹${fare.tollTax}'),
              ),
            
            if (fare.stateTax > 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildFareRow('State Tax', '₹${fare.stateTax}'),
              ),
            
            if (fare.airportFee > 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildFareRow('Airport Fee', '₹${fare.airportFee}'),
              ),
            
            // Divider
            Divider(
              height: 32,
              thickness: 1,
              color: _textLight.withOpacity(0.3),
            ),
            
            // Total amount
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _secondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _textPrimary,
                    ),
                  ),
                  Text(
                    '₹${fare.totalAmount}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: _secondaryColor,
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

  Widget _buildFareRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: _textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: _textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}