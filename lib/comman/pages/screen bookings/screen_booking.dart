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
  int _selectedTab = 0;

  // White, Black, Gold theme
  final Color _blackColor = Colors.black;
  final Color _whiteColor = Colors.white;
  final Color _goldColor = Color(0xFFD4AF37);
  final Color _backgroundColor = Color(0xFFFAFAFA);
  final Color _borderColor = Color(0xFFEEEEEE);
  final Color _textSecondary = Color(0xFF666666);

  final List<Map<String, dynamic>> bookingTypes = [
    {
      'name': 'Bus',
      'icon': Icons.directions_bus,
    },
    {
      'name': 'Flight',
      'icon': Icons.flight,
    },
    {
      'name': 'Cab',
      'icon': Icons.local_taxi,
    },
    {
      'name': 'Hotel',
      'icon': Icons.hotel,
    },
  ];

  @override
  void initState() {
    super.initState();
    context.read<LoginBloc>().add(const LoginEvent.loginInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: Text(
          'My Bookings',
          style: TextStyle(
            color: _blackColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: _whiteColor,
        elevation: 0,
        foregroundColor: _blackColor,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: _blackColor),
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
              SizedBox(height: 10),
              _buildTabSelector(),
              SizedBox(height: 10),
              Expanded(child: _buildSelectedContent()),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTabSelector() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: _whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        children: List.generate(bookingTypes.length, (index) {
          final isSelected = _selectedTab == index;
          
          return Expanded(
            child: _tabButton(index, isSelected, () {
              setState(() {
                _selectedTab = index;
              });
            }),
          );
        }),
      ),
    );
  }

  Widget _tabButton(int index, bool isSelected, VoidCallback onTap) {
    final type = bookingTypes[index];
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
        decoration: BoxDecoration(
          color: isSelected ? _goldColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          // border: isSelected ? Border.all(color: _goldColor) : null,
        ),
        child: Column(
          children: [
            Icon(
              type['icon'],
              color: isSelected ? _goldColor : _textSecondary,
              size: 15,
            ),
            SizedBox(height: 6),
            Text(
              type['name'],
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? _goldColor : _textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedContent() {
    switch (_selectedTab) {
      case 0:
        return ScreenReport(); // Bus
      case 1:
        return _buildEmptyContent('Flight', Icons.flight);
      case 2:
        return CabBookingList(); // Cab
      case 3:
        return _buildEmptyContent('Hotel', Icons.hotel);
      default:
        return SizedBox();
    }
  }

  Widget _buildEmptyContent(String type, IconData icon) {
    return Padding(
      padding: EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: _whiteColor,
              shape: BoxShape.circle,
              border: Border.all(color: _borderColor),
            ),
            child: Icon(
              icon,
              size: 32,
              color: _textSecondary,
            ),
          ),
          SizedBox(height: 24),
          Text(
            'No $type Bookings',
            style: TextStyle(
              fontSize: 18,
              color: _blackColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Your $type bookings will appear here\nwhen you make a reservation',
            style: TextStyle(
              fontSize: 14,
              color: _textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNotLoggedInSection() {
    return Padding(
      padding: EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: _whiteColor,
              shape: BoxShape.circle,
              border: Border.all(color: _borderColor),
            ),
            child: Icon(
              Icons.lock_outline,
              size: 40,
              color: _textSecondary,
            ),
          ),
          SizedBox(height: 32),
          Text(
            'Login Required',
            style: TextStyle(
              fontSize: 22,
              color: _blackColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Please login to view your bookings\nand manage your trips',
            style: TextStyle(
              fontSize: 16,
              color: _textSecondary,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => LoginBottomSheet(login: 1),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _blackColor,
                foregroundColor: _whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Login to Continue',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
        
        ],
      ),
    );
  }
}