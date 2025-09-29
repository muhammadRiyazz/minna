import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/cab/pages/booked%20list/booking_list.dart';
import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/bus/pages/bus%20report/screen_reports.dart';

class ScreenBooking extends StatefulWidget {
  const ScreenBooking({super.key});

  @override
  State<ScreenBooking> createState() => _ScreenBookingState();
}

class _ScreenBookingState extends State<ScreenBooking> {
  int _selectedTab = 0; // 0 = Bus, 1 = Flight, 2 = Cab, 3 = Hotel

  @override
  void initState() {
    super.initState();
    // Load login info from bloc
    context.read<LoginBloc>().add(const LoginEvent.loginInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final isLoggedIn = state.isLoggedIn ?? false;

          if (!isLoggedIn) {
            return _notLoggedInSection();
          }

          return Column(
            children: [
              _buildBookingTypeSelector(),
              Expanded(child: _buildSelectedContent()),
            ],
          );
        },
      ),
    );
  }

  /// Tab Selector
  Widget _buildBookingTypeSelector() {
    final tabs = ["Bus", "Flight", "Cab", "Hotel"];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 18.0),
      child: Row(
        children: List.generate(tabs.length, (index) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: _bookingTypeButton(
                tabs[index],
                _selectedTab == index,
                () {
                  setState(() {
                    _selectedTab = index;
                  });
                },
              ),
            ),
          );
        }),
      ),
    );
  }

  /// Booking Type Button
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

  /// Content Based on Selected Tab
  Widget _buildSelectedContent() {
    switch (_selectedTab) {
      case 0:
        return const ScreenReport(); // Bus
      case 1:
        return _buildFlightContent(); // Flight
      case 2:
        return CabBookingList(); // Cab
      case 3:
        return _buildHotelContent(); // Hotel
      default:
        return const SizedBox();
    }
  }

  /// Flight Section
  Widget _buildFlightContent() {
    return _emptySection(
      icon: Icons.flight,
      title: "No trips yet",
      subtitle: "You haven’t booked any flight trips yet\nPlan Your Next Journey",
    );
  }

  /// Hotel Section
  Widget _buildHotelContent() {
    return _emptySection(
      icon: Icons.hotel,
      title: "No bookings yet",
      subtitle: "You haven’t booked any hotels yet\nPlan your next stay",
    );
  }

  /// Reusable Empty Section Widget
  Widget _emptySection({required IconData icon, required String title, required String subtitle}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Not Logged In Section
  Widget _notLoggedInSection() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_outline, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            const Text(
              "You are not logged in",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              "Please log in to view and manage your bookings.",
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
         
          ],
        ),
      ),
    );
  }
}
