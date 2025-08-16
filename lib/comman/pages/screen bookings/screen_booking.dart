import 'package:minna/comman/const/const.dart';
import 'package:flutter/material.dart';
import 'package:minna/comman/pages/screen%20bookings/bus%20report/screen_reports.dart';

class ScreenBooking extends StatefulWidget {
  const ScreenBooking({super.key});

  @override
  State<ScreenBooking> createState() => _ScreenBookingState();
}

class _ScreenBookingState extends State<ScreenBooking> {
  int _selectedTab = 0; // 0 for Bus, 1 for Flight
  bool _isLoggedIn = false; // Track login state for demo purposes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'My Bookings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: maincolor1,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      body: Column(
        children: [
          // Tab selector
          _buildBookingTypeSelector(),
          // const SizedBox(height: 16),

          // Content based on selected tab
          Expanded(
            child: _selectedTab == 0 ? ScreenReport() : _buildFlightContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingTypeSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Column(
        children: [
          SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _bookingTypeButton("Bus", _selectedTab == 0, () {
                  setState(() {
                    _selectedTab = 0;
                  });
                }),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _bookingTypeButton("Flight", _selectedTab == 1, () {
                  setState(() {
                    _selectedTab = 1;
                  });
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bookingTypeButton(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? maincolor1 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFlightContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.flight, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const Text(
            'No trips yet',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            'You haven\'t booked any flight trips yet\nPlan Your Next Journey',
            style: TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          // ElevatedButton(
          //   onPressed: () {
          //     // Navigate to bus booking screen
          //   },
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.grey.shade200, // Button color
          //     foregroundColor: maincolor1, // Text color
          //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(8), // Border radius
          //     ),
          //     elevation: 0, // Remove shadow
          //   ),
          //   child: const Text(
          //     'Book Now',
          //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          //   ),
          // ),
        ],
      ),
    );
  }
}
