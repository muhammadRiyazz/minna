import 'package:flutter/material.dart';
import 'package:minna/cab/domain/confirm%20model/confirm_model.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/pages/main%20home/home.dart';

class CabSuccessPage extends StatelessWidget {
  final BookingConfirmData bookingResponse;

  const CabSuccessPage({super.key, required this.bookingResponse});

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
        body: Container(
          color: maincolor1,
          child: Column(
            children: [
              // Header section
              Container(
                padding: const EdgeInsets.only(top: 60, bottom: 20),
                child: Column(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 80,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Booking Confirmed!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Your cab booking is done ',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Content section
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        
                        const SizedBox(height: 10),
                        
                        _buildDateTimeCard(data.startDate,data.startTime),
                        
                        const SizedBox(height: 24),
                        
                        // Cab Information
                        Text(
                          'Cab Information',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
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
                            color: Colors.grey.shade800,
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        _buildFareCard(data.cabRate.fare),
                        
                        const SizedBox(height: 10),
                        
                        // Action buttons
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
  Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
          (route) => false,
        );},
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  side: BorderSide(color: maincolor1!),
                                ),
                                child: Text(
                                  'GO TO HOME',
                                  style: TextStyle(
                                    color: maincolor1,
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              color: highlight ? maincolor1 : Colors.grey.shade600,
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
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: highlight ? maincolor1: Colors.grey.shade800,
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
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Calendar icon section
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  date.day.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: maincolor1,
                  ),
                ),
                Text(
                  _getMonthAbbreviation(date.month),
                  style: TextStyle(
                    fontSize: 12,
                    color: maincolor1,
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
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      formattedTime,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Cab image placeholder
            Container(
              width: 80,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.directions_car,
                size: 40,
                color: Colors.grey.shade500,
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
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cab.category,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.people,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${cab.seatingCapacity} passengers',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.luggage,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${cab.bagCapacity} bags',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Base fare
            _buildFareRow('Base Fare', '₹${fare.baseFare}'),
            const SizedBox(height: 8),
            
            // Additional charges
            if (fare.driverAllowance > 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _buildFareRow('Driver Allowance', '₹${fare.driverAllowance}'),
              ),
            
            if (fare.gst > 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _buildFareRow('GST', '₹${fare.gst}'),
              ),
            
            if (fare.tollTax > 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _buildFareRow('Toll Tax', '₹${fare.tollTax}'),
              ),
            
            if (fare.stateTax > 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _buildFareRow('State Tax', '₹${fare.stateTax}'),
              ),
            
            if (fare.airportFee > 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _buildFareRow('Airport Fee', '₹${fare.airportFee}'),
              ),
            
            // Divider
            const Divider(height: 24),
            
            // Total amount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Amount',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                Text(
                  '₹${fare.totalAmount}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: maincolor1,
                  ),
                ),
              ],
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
            color: Colors.grey.shade600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    );
  }
}