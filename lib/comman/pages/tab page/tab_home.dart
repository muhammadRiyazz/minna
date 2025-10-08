import 'package:minna/bus/pages/screen%20bus%20home%20/bus_home.dart';
import 'package:minna/comman/const/const.dart';
import 'package:flutter/material.dart';
import 'package:minna/flight/presendation/screen%20flight/home_flight.dart';

class CommonTabPage extends StatefulWidget {
  const CommonTabPage({super.key});

  @override
  State<CommonTabPage> createState() => _CommonTabPageState();
}

class _CommonTabPageState extends State<CommonTabPage> {
  int _selectedTab = 0; // 0 for Bus, 1 for Flight

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80, // Increased height for more content
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '  Welcome back,',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '  MINNA Tours & Travels',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 2.0,
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(1.0, 1.0),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: maincolor1,
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.travel_explore, size: 30),
            onPressed: () {},
            // tooltip: 'Notifications',
          ),
          // IconButton(
          //   icon: const Icon(Icons.person_outline),
          //   onPressed: () {},
          //   tooltip: 'Profile',
          // ),
          const SizedBox(width: 13),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Button-style tab selector
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 5.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _bookingTypeButton(
                      "Bus",
                      _selectedTab == 0,
                      Icons.directions_bus_outlined,
                      () {
                        setState(() {
                          _selectedTab = 0;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _bookingTypeButton(
                      "Flight",
                      _selectedTab == 1,
                      Icons.flight_takeoff,
                      () {
                        setState(() {
                          _selectedTab = 1;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Content based on selected tab
            Expanded(
              child: _selectedTab == 0
                  ?  BusHomeTab()
                  :  FlightBookingTab(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bookingTypeButton(
    String label,
    bool isSelected,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? maincolor1 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: isSelected ? Colors.white : maincolor1),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.white : maincolor1,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
