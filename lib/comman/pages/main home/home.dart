import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:minna/DTH%20&%20Mobile/DTH/pages/dth%20home%20inputs/dht_input_page.dart';
import 'package:minna/DTH%20&%20Mobile/mobile%20%20recharge/application/oparator/operators_bloc.dart';
import 'package:minna/DTH%20&%20Mobile/mobile%20%20recharge/pages/home%20page/recharge_home.dart';
import 'package:minna/Electyicity%20&%20Water/kseb/kseb%20home/electricity_home.dart';
import 'package:minna/Electyicity%20&%20Water/water%20bill/water%20bill%20home/water_input.dart';
import 'package:minna/bus/pages/screen%20bus%20home%20/bus_home.dart';
import 'package:minna/cab/pages/TripSelectionPage/TripSelectionPage.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/pages/histoy/histoty.dart';
import 'package:minna/comman/pages/screen%20bookings/screen_booking.dart';
import 'package:minna/comman/pages/screen%20my%20account/my_account_page.dart';
import 'package:minna/flight/presendation/screen%20flight/home_flight.dart';
import 'package:minna/hotel%20booking/pages/hotel%20details/hotel_details_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeContentPage(),
    ScreenBooking(),
    HistoryPage(),
    MyAccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: _pages[_currentIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: maincolor1,
      unselectedItemColor: Colors.grey[600],
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
      elevation: 8,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmarks_outlined),
          activeIcon: Icon(Icons.bookmarks),
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history_outlined),
          activeIcon: Icon(Icons.history),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Account',
        ),
      ],
    );
  }
}

class HomeContentPage extends StatefulWidget {
  @override
  State<HomeContentPage> createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  final List<Map<String, dynamic>> _allServices = [
    {
      'label': 'Mobile',
      'icon': Icons.phone_android,
      'color': Colors.blue,
      'onTap': (BuildContext context) {
        context.read<OperatorsBloc>().add(const OperatorsEvent.getop());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MobileRechargeInputPage()),
        );
      },
    },
    {
      'label': 'DTH',
      'icon': Icons.tv,
      'color': Colors.orange,
      'onTap': (BuildContext context) {
        context.read<OperatorsBloc>().add(const OperatorsEvent.getDTHop());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DTHInputPage()),
        );
      },
    },
    {
      'label': 'Electricity',
      'icon': Icons.lightbulb_outline,
      'color': Colors.green,
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ElectricityBillInputPage()),
        );
      },
    },
    {
      'label': 'Water',
      'icon': Icons.water_drop,
      'color': Colors.teal,
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WaterBillInputPage()),
        );
      },
    },
    {
      'label': 'Bus ',
      'icon': Icons.directions_bus,
      'color': Colors.red,
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BusHomeTab()),
        );
      },
    },
    {
      'label': 'Flights',
      'icon': Icons.flight,
      'color': Colors.blueAccent,
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FlightBookingTab()),
        );
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _filteredServices = _searchText.isEmpty
        ? []
        : _allServices
              .where(
                (service) => service['label'].toLowerCase().contains(
                  _searchText.toLowerCase(),
                ),
              )
              .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: maincolor1,
        elevation: 0,
        title: Text(
          'Minna Travels',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            if (_filteredServices.isNotEmpty)
              _buildSearchResults(_filteredServices),
            _buildTravelServices(context),
            _buildPromoBanner(),
            _buildQuickActions(context),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 10, 16, 25),
      decoration: BoxDecoration(
        color: maincolor1,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Explore our services!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search for services...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(List<Map<String, dynamic>> results) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          Text(
            'Search Results',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemCount: results.length,
            itemBuilder: (context, index) {
              final item = results[index];
              return GestureDetector(
                onTap: () => item['onTap'](context),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: item['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(item['icon'], color: item['color'], size: 28),
                    ),
                    SizedBox(height: 8),
                    Text(item['label'], style: TextStyle(fontSize: 12)),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTravelServices(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Travel Services',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTravelServiceButton(
                FontAwesomeIcons.bus,
                ' Bus ',
                Colors.red[400]!,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BusHomeTab()),
                  );
                },
              ),
              _buildTravelServiceButton(
                FontAwesomeIcons.plane,
                'Flights',
                Colors.blue[400]!,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FlightBookingTab()),
                  );
                },
              ),
              _buildTravelServiceButton(
                FontAwesomeIcons.hotel,
                'Hotels',
                Colors.green[400]!,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HotelDetailsPage();
                      },
                    ),
                  );
                  //  _showComingSoonBottomSheet(context, 'Hotels'),
                },
              ),
              _buildTravelServiceButton(
                FontAwesomeIcons.carSide,
                'Cabs',
                Colors.orange[400]!,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return TripSelectionPage();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showComingSoonBottomSheet(BuildContext context, String service) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(25),
          // height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                service == 'Hotels'
                    ? FontAwesomeIcons.hotel
                    : FontAwesomeIcons.train,
                size: 60,
                color: service == 'Hotels' ? Colors.green : Colors.orange,
              ),
              SizedBox(height: 20),
              Text(
                '$service Coming Soon!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 15),
              Text(
                'We are working hard to bring you the best $service booking experience.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: maincolor1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text(
                  'Got It!',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTravelServiceButton(
    IconData icon,
    String label,
    Color color,
    VoidCallback onpress,
  ) {
    return InkWell(
      onTap: onpress,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: FaIcon(icon, color: color, size: 24),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Recharge',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildQuickActionButton(
                Icons.phone_android,
                'Mobile',
                Colors.blue,
                () {
                  context.read<OperatorsBloc>().add(
                    const OperatorsEvent.getop(),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MobileRechargeInputPage(),
                    ),
                  );
                },
              ),
              _buildQuickActionButton(Icons.tv, 'DTH', Colors.orange, () {
                context.read<OperatorsBloc>().add(
                  const OperatorsEvent.getDTHop(),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DTHInputPage()),
                );
              }),
              _buildQuickActionButton(
                Icons.lightbulb_outline,
                'Electricity',
                Colors.green,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ElectricityBillInputPage(),
                    ),
                  );
                },
              ),
              _buildQuickActionButton(
                Icons.water_drop,
                'Water',
                Colors.teal,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WaterBillInputPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(
    IconData icon,
    String label,
    Color color,
    VoidCallback onpress,
  ) {
    return GestureDetector(
      onTap: onpress,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      width: double.infinity,
      // height: 240,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A2980),
            // Color(0xFF26D0CE),
            maincolor1!,
          ], // Ocean blue gradient
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative travel icons
          Positioned(
            right: 15,
            top: 15,
            child: Opacity(
              opacity: 0.1,
              child: Icon(
                FontAwesomeIcons.globeAsia,
                size: 100,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            left: 10,
            bottom: -15,
            child: Opacity(
              opacity: 0.1,
              child: Icon(
                FontAwesomeIcons.planeDeparture,
                size: 110,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 18),
                // Minna Special tag
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.rocket_launch, size: 16, color: Colors.white),
                      SizedBox(width: 6),
                      Text(
                        'Minna Special',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                // Main promotion text
                Text(
                  'Travel Smarter\nWith Minna',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 8),
                // Value proposition
                Text(
                  'Book buses, flights, and more\nwith exclusive Minna benefits',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.95),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFF1A2980),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),

                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      'Explore Now',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),

                // Action button
              ],
            ),
          ),
        ],
      ),
    );
  }
}
