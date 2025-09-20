import 'package:flutter/material.dart';

import 'package:minna/cab/domain/confirm%20model/confirm_model.dart';
import 'package:minna/comman/const/const.dart';

class CabSuccessPage extends StatelessWidget {
  final BookingConfirmData bookingResponse;

  const CabSuccessPage({super.key, required this.bookingResponse});

  @override
  Widget build(BuildContext context) {
    final data = bookingResponse;
    
    return WillPopScope(
      onWillPop: () async {
        // Navigate to home instead of going back
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
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
                        ...[
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
                        
                        // Trip Details
                        Text(
                          'Trip Details',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        
                        const SizedBox(height: 10),
                        
                        // Route information
                        if (data.routes.isNotEmpty) 
                          _buildRouteCard(data.routes.first),
                        
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
                      ],
                        
                        const SizedBox(height: 32),
                        
                        // Action buttons
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  // Share booking details
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  side: BorderSide(color: Colors.blue.shade700),
                                ),
                                child: Text(
                                  'SHARE',
                                  style: TextStyle(
                                    color: Colors.blue.shade700,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context, '/home', (route) => false);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade700,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: const Text(
                                  'GO TO HOME',
                                  style: TextStyle(
                                    color: Colors.white,
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
              color: highlight ? Colors.blue.shade700 : Colors.grey.shade600,
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
                      color: highlight ? Colors.blue.shade700 : Colors.grey.shade800,
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

  Widget _buildRouteCard(RouteInfo route) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Source
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'From',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        route.source.address,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade800,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Divider with line
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Container(
                    width: 2,
                    height: 20,
                    color: Colors.grey.shade300,
                    margin: const EdgeInsets.only(left: 10),
                  ),
                ],
              ),
            ),
            
            // Destination
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.green.shade600,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'To',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        route.destination.address,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade800,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Date and Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      route.startDate,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      route.startTime,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
      elevation: 2,
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
                    color: Colors.blue.shade700,
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

