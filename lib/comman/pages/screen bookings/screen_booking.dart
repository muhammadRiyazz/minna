import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minna/cab/pages/booked%20list/booking_list.dart';
import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/bus/pages/bus%20report/screen_reports.dart';
import 'package:minna/comman/pages/log%20in/login_page.dart';
import 'package:minna/flight/presendation/report_list/report_list.dart';
import 'package:minna/hotel%20booking/pages/report/screen_hotel_report.dart';
import 'package:minna/comman/const/const.dart';

class ScreenBooking extends StatefulWidget {
  const ScreenBooking({super.key});

  @override
  State<ScreenBooking> createState() => _ScreenBookingState();
}

class _ScreenBookingState extends State<ScreenBooking> {
  int _selectedTab = 0;

  // Modern Premium Theme Variables
  final Color _primaryColor = maincolor1; // Deep Ocean Blue
  final Color _secondaryColor = secondaryColor; // Gold
  final Color _backgroundColor = backgroundColor;
  final Color _cardColor = cardColor;
  final Color _textPrimary = textPrimary;
  final Color _textSecondary = textSecondary;
  final Color _borderColor = borderSoft;

  final List<Map<String, dynamic>> bookingTypes = [
    {'name': 'Bus', 'icon': Iconsax.bus},
    {'name': 'Flight', 'icon': Iconsax.airplane},
    {'name': 'Cab', 'icon': Iconsax.car},
    {'name': 'Hotel', 'icon': Iconsax.house},
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
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final isLoggedIn = state.isLoggedIn ?? false;

          return Stack(
            children: [
              // Premium Header Background
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 250,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        _primaryColor,
                        _primaryColor.withOpacity(0.9),
                        _primaryColor.withOpacity(0.85),
                      ],
                    ),
                    // borderRadius: const BorderRadius.vertical(
                    //   bottom: Radius.circular(40),
                    // ),
                  ),
                  child: Stack(
                    children: [
                      // Decorative Element
                      Positioned(
                        right: -30,
                        top: -30,
                        child: Icon(
                          Iconsax.archive_book,
                          size: 180,
                          color: Colors.white.withOpacity(0.05),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SafeArea(
                child: Column(
                  children: [
                    // Custom Header Title
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'My Bookings',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Manage your travel records',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          // GestureDetector(
                          //   onTap: () => setState(() {}),
                          //   child: Container(
                          //     padding: const EdgeInsets.all(10),
                          //     decoration: BoxDecoration(
                          //       color: Colors.white.withOpacity(0.15),
                          //       shape: BoxShape.circle,
                          //       border: Border.all(
                          //         color: Colors.white.withOpacity(0.1),
                          //       ),
                          //     ),
                          //     child: const Icon(
                          //       Iconsax.refresh,
                          //       color: Colors.white,
                          //       size: 20,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    _buildTabSelector(),

                    // Tab Selector Section
                    const SizedBox(height: 20),

                    // Content Section
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: _backgroundColor,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(35),
                          ),
                        ),
                        child: !isLoggedIn
                            ? _buildNotLoggedInSection()
                            : _buildSelectedContent(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTabSelector() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: List.generate(bookingTypes.length, (index) {
          final isSelected = _selectedTab == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? _secondaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: _secondaryColor.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      bookingTypes[index]['icon'],
                      color: isSelected
                          ? Colors.white
                          : Colors.white.withOpacity(0.6),
                      size: 15,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      bookingTypes[index]['name'],
                      style: TextStyle(
                        fontSize: 10,
                        color: isSelected
                            ? Colors.white
                            : Colors.white.withOpacity(0.6),
                        fontWeight: isSelected
                            ? FontWeight.w800
                            : FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSelectedContent() {
    switch (_selectedTab) {
      case 0:
        return const ScreenReport(); // Bus
      case 1:
        return const ReportListScreen(); // Flight
      case 2:
        return const CabBookingList(); // Cab
      case 3:
        return const ScreenHotelReport(); // Hotel
      default:
        return const SizedBox();
    }
  }

  Widget _buildEmptyContent(String type, IconData icon) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(35),
              decoration: BoxDecoration(
                color: _secondaryColor.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 60,
                color: _secondaryColor.withOpacity(0.4),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'No $type Bookings',
              style: TextStyle(
                fontSize: 22,
                color: _textPrimary,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Your $type bookings will appear here\nonce you complete a reservation process.',
              style: TextStyle(
                fontSize: 15,
                color: _textSecondary,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                shadowColor: _primaryColor.withOpacity(0.4),
              ),
              child: Text(
                'Book Now',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotLoggedInSection() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: _secondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.lock_1, size: 50, color: _secondaryColor),
          ),
          const SizedBox(height: 32),
          Text(
            'Login Required',
            style: TextStyle(
              fontSize: 24,
              color: _textPrimary,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Please login to view your travel bookings\nand manage your itineraries.',
            style: TextStyle(
              fontSize: 15,
              color: _textSecondary,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
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
                backgroundColor: _primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                shadowColor: _primaryColor.withOpacity(0.4),
              ),
              child: const Text(
                'Login to Continue',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
