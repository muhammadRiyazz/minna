import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/cab/pages/booked%20list/booking_list.dart';
import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/bus/pages/bus%20report/screen_reports.dart';
import 'package:minna/comman/pages/log%20in/login_page.dart';

class ScreenBooking extends StatefulWidget {
  const ScreenBooking({super.key});

  @override
  State<ScreenBooking> createState() => _ScreenBookingState();
}

class _ScreenBookingState extends State<ScreenBooking> {
  int _selectedTab = 0; // 0 = Bus, 1 = Flight, 2 = Cab, 3 = Hotel

  final List<Map<String, dynamic>> bookingTypes = [
    {
      'name': 'Bus',
      'icon': Icons.directions_bus,
      'color': maincolor1,
      'gradient': [maincolor1!, maincolor1!.withOpacity(0.8)]
    },
    {
      'name': 'Flight',
      'icon': Icons.flight,
      'color': maincolor1,
      'gradient': [maincolor1!, maincolor1!.withOpacity(0.8)]
    },
    {
      'name': 'Cab',
      'icon': Icons.local_taxi,
      'color': maincolor1,
      'gradient': [maincolor1!, maincolor1!.withOpacity(0.8)]
    },
    {
      'name': 'Hotel',
      'icon': Icons.hotel,
      'color': maincolor1,
      'gradient': [maincolor1!, maincolor1!.withOpacity(0.8)]
    },
  ];

  @override
  void initState() {
    super.initState();
    // Load login info from bloc
    context.read<LoginBloc>().add(const LoginEvent.loginInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
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
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final isLoggedIn = state.isLoggedIn ?? false;

          if (!isLoggedIn) {
            return _buildNotLoggedInSection();
          }

          return Column(
            children: [
              // Booking Type Selector
              _buildBookingTypeSelector(),
              
              // Content Area
              Expanded(child: _buildSelectedContent()),
            ],
          );
        },
      ),
    );
  }

  /// Enhanced Tab Selector
  Widget _buildBookingTypeSelector() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: List.generate(bookingTypes.length, (index) {
          final type = bookingTypes[index];
          final isSelected = _selectedTab == index;
          
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: _bookingTypeButton(
                type,
                isSelected,
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

  /// Enhanced Booking Type Button
  Widget _bookingTypeButton(Map<String, dynamic> type, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        decoration: BoxDecoration(
          gradient: isSelected 
              ? LinearGradient(
                  colors: type['gradient'],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: maincolor1!.withOpacity(0.3),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              type['icon'],
              color: isSelected ? Colors.white : maincolor1,
              size: 20,
            ),
            SizedBox(height: 6),
            Text(
              type['name'],
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
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

  /// Enhanced Flight Section
  Widget _buildFlightContent() {
    return _emptySection(
      icon: Icons.flight,
      title: "No Flight Trips Yet",
      subtitle: "You haven't booked any flight trips yet\nPlan your next journey and explore new destinations",
      buttonText: "Book Flight",
      onButtonPressed: () {
        // Navigate to flight booking
      },
    );
  }

  /// Enhanced Hotel Section
  Widget _buildHotelContent() {
    return _emptySection(
      icon: Icons.hotel,
      title: "No Hotel Bookings Yet",
      subtitle: "You haven't booked any hotels yet\nFind the perfect stay for your next trip",
      buttonText: "Book Hotel",
      onButtonPressed: () {
        // Navigate to hotel booking
      },
    );
  }

  /// Enhanced Reusable Empty Section Widget
  Widget _emptySection({
    required IconData icon,
    required String title,
    required String subtitle,
    String? buttonText,
    VoidCallback? onButtonPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: maincolor1!.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 50, color: maincolor1),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[800],
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          if (buttonText != null && onButtonPressed != null) ...[
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onButtonPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: maincolor1,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Enhanced Not Logged In Section
  Widget _buildNotLoggedInSection() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: maincolor1!.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.lock_outline, size: 50, color: maincolor1),
            ),
            const SizedBox(height: 24),
            Text(
              "Login to View Bookings",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Please log in to view and manage your bookings,\ncheck upcoming trips, and access your travel history",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => LoginBottomSheet(login: 1),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: maincolor1,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: Text(
                "Login Now",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}