import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:minna/DTH%20&%20Mobile/DTH/pages/dth%20home%20inputs/dht_input_page.dart';
import 'package:minna/DTH%20&%20Mobile/mobile%20%20recharge/application/oparator/operators_bloc.dart';
import 'package:minna/DTH%20&%20Mobile/mobile%20%20recharge/pages/home%20page/recharge_home.dart';
import 'package:minna/Electyicity%20&%20Water/kseb/kseb%20home/electricity_home.dart';
import 'package:minna/Electyicity%20&%20Water/water%20bill/water%20bill%20home/water_input.dart' hide ElectricityBillInputPage;
import 'package:minna/bus/application/location%20fetch/bus_location_fetch_bloc.dart';
import 'package:minna/bus/pages/screen%20bus%20home%20/bus_home.dart';
import 'package:minna/cab/pages/TripSelectionPage/TripSelectionPage.dart';
import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/pages/histoy/histoty.dart';
import 'package:minna/comman/pages/log%20in/login_page.dart';
import 'package:minna/comman/pages/screen%20bookings/screen_booking.dart';
import 'package:minna/comman/pages/screen%20my%20account/my_account_page.dart';
import 'package:minna/flight/presendation/screen%20flight/home_flight.dart';
import 'package:minna/hotel%20booking/pages/holel%20home%20page/home_page_hotel.dart' hide FlightBookingTab;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
  void initState() {
    super.initState();
    // Load login info from bloc
    context.read<LoginBloc>().add(const LoginEvent.loginInfo());
  }

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
  const HomeContentPage({super.key});

  @override
  State<HomeContentPage> createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  // Color Theme - Consistent throughout
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37); // Gold
  final Color _accentColor = Color(0xFFC19B3C); // Darker Gold
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);

  // Travel Offers Data with working image URLs
  final List<Map<String, dynamic>> _travelOffers = [
    {
      'title': 'Summer Getaway',
      'subtitle': 'Up to 40% OFF',
      'image':
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
    },
    {
      'title': 'Mountain Trek',
      'subtitle': 'Adventure Packages',
      'image':
          'https://res.cloudinary.com/enchanting/q_70,f_auto,w_1600,h_1001,c_fit/exodus-web/2021/12/trekking-poles-himalaya-1.jpg',
    },
    {
      'title': 'Beach Paradise',
      'subtitle': 'All Inclusive',
      'image':
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
    },
  ];

  // Popular Destinations with working image URLs
  final List<Map<String, dynamic>> _popularDestinations = [
    {
      'name': 'Bali',
      'country': 'Indonesia',
      'image':
          'https://images.unsplash.com/photo-1537953773345-d172ccf13cf1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      'price': '\$899',
    },
    {
      'name': 'New York',
      'country': 'USA',
      'image':
          'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      'price': '\$1,199',
    },
    {
      'name': 'Paris',
      'country': 'France',
      'image':
          'https://media.istockphoto.com/id/1345426734/photo/eiffel-tower-paris-river-seine-sunset-twilight-france.jpg?s=612x612&w=0&k=20&c=I5rAH5d_-Yyag8F0CKzk9vzMr_1rgkAASGTE11YMh9A=',
      'price': '\$1,299',
    },
    {
      'name': 'Tokyo',
      'country': 'Japan',
      'image':
          'https://i.natgeofe.com/n/eb9f0faa-75bc-47e2-8b14-253031b74125/bigtripjapantokyocrossing.jpg',
      'price': '\$1,599',
    },
  ];

  // Travel Services Data with theme colors
  List<Map<String, dynamic>> get _travelServices => [
    {
      'label': 'Flights',
      'icon': FontAwesomeIcons.plane,
      'color': Color(0xFFD4AF37), // Gold
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FlightBookingTab()),
        );
      },
    },
    {
      'label': 'Hotels',
      'icon': FontAwesomeIcons.hotel,
      'color': Color(0xFFD4AF37), // Gold
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HotelBookingHome()),
        );
      },
    },
    {
      'label': 'Bus',
      'icon': FontAwesomeIcons.bus,
      'color': Color(0xFFD4AF37), // Gold
      'onTap': (BuildContext context) {
            context.read<BusLocationFetchBloc>().add(const GetData());

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BusHomeTab()),
        );
      },
    },
    {
      'label': 'Cabs',
      'icon': FontAwesomeIcons.carSide,
      'color': Color(0xFFD4AF37), // Gold
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TripSelectionPage()),
        );
      },
    },
    {
      'label': 'Visa',
      'icon': FontAwesomeIcons.passport,
      'color': Color(0xFFD4AF37), // Gold
      'onTap': (BuildContext context) {
        _showComingSoonBottomSheet(context, "Visa Services");
      },
    },
    {
      'label': 'Airport Cabs',
      'icon': FontAwesomeIcons.taxi,
      'color': Color(0xFFD4AF37), // Gold
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TripSelectionPage()),
        );
      },
    },
    {
      'label': 'Train',
      'icon': FontAwesomeIcons.train,
      'color': Color(0xFFD4AF37), // Gold
      'onTap': (BuildContext context) {
        _showComingSoonBottomSheet(context, "Train");
      },
    },
    {
      'label': 'Cruise',
      'icon': FontAwesomeIcons.ship,
      'color': Color(0xFFD4AF37), // Gold
      'onTap': (BuildContext context) {
        _showComingSoonBottomSheet(context, "Cruise");
      },
    },
  ];

  // Quick Services Data with theme colors
  List<Map<String, dynamic>> get _quickServices => [
    {
      'icon': Icons.phone_android,
      'label': 'Mobile',
      'color': Color(0xFFD4AF37), // Gold
      'onTap': () {
        context.read<OperatorsBloc>().add(const OperatorsEvent.getop());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MobileRechargeInputPage()),
        );
      },
    },
    {
      'icon': Icons.tv,
      'label': 'DTH',
      'color': Color(0xFFD4AF37), // Gold
      'onTap': () {
        context.read<OperatorsBloc>().add(const OperatorsEvent.getDTHop());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DTHInputPage()),
        );
      },
    },
    {
      'icon': Icons.lightbulb_outline,
      'label': 'Electricity',
      'color': Color(0xFFD4AF37), // Gold
      'onTap': () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ElectricityBillInputPage()),
        );
      },
    },
    {
      'icon': Icons.water_drop,
      'label': 'Water',
      'color': Color(0xFFD4AF37), // Gold
      'onTap': () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WaterBillInputPage()),
        );
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 360;
    final bool isTablet = screenSize.width > 600;

    // Responsive sizing
    final double iconSize = isSmallScreen
        ? 18
        : isTablet
        ? 28
        : 24;
    final double titleFontSize = isSmallScreen
        ? 16
        : isTablet
        ? 24
        : 20;
    final double headingFontSize = isSmallScreen
        ? 14
        : isTablet
        ? 20
        : 18;
    final double bodyFontSize = isSmallScreen
        ? 12
        : isTablet
        ? 16
        : 12;

    return Scaffold(
      backgroundColor: _backgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return _buildAppBar(isSmallScreen, isTablet, titleFontSize ,state);
              },
            ),
          ];
        },
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              // Search Section
              // _buildSearchSection(isSmallScreen, isTablet, bodyFontSize),

              // Popular Destinations - MOVED TO TOP
              _buildPopularDestinations(
                isSmallScreen,
                isTablet,
                headingFontSize,
                bodyFontSize,
              ),

              // Travel Offers Banner

              // Travel Services Grid
              _buildTravelServicesSection(
                context,
                isSmallScreen,
                isTablet,
                iconSize,
                headingFontSize,
                bodyFontSize,
              ),
              _buildOffersBanner(isSmallScreen, isTablet, bodyFontSize),

              // Quick Services
              _buildQuickServicesSection(
                context,
                isSmallScreen,
                isTablet,
                iconSize,
                headingFontSize,
                bodyFontSize,
              ),

              // Promo Banner
              _buildPromoBanner(isSmallScreen, isTablet, bodyFontSize),

              SizedBox(
                height: isSmallScreen
                    ? 20
                    : isTablet
                    ? 40
                    : 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar(
  bool isSmallScreen,
  bool isTablet,
  double titleFontSize,
  LoginState state
) {
  final isLoggedIn = state.isLoggedIn ?? false;

  return SliverAppBar(
    backgroundColor: Colors.white,
    expandedHeight: ! isLoggedIn?
    
    
    
    ( isTablet ? 170 : isSmallScreen ? 150 : 280):  150,
     floating: false,
    pinned: true,
    elevation: 0,
    shadowColor: Colors.black.withOpacity(0.1),
    surfaceTintColor: Colors.white,
    stretch: true,
    collapsedHeight: 60,
    flexibleSpace: FlexibleSpaceBar(
      background: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 16 : 24,
              vertical: isSmallScreen ? 8 : 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Main header row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Logo and App Name
                    Row(
                      children: [
                        // App Logo Container
                        Container(
                          width: isSmallScreen ? 40 : isTablet ? 50 : 44,
                          height: isSmallScreen ? 40 : isTablet ? 50 : 44,
                          decoration: BoxDecoration(
                            color: _primaryColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'asset/mtlogo.jpg',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: _secondaryColor,
                                    child: Icon(
                                      Icons.airplanemode_active,
                                      color: _primaryColor,
                                      size: isSmallScreen ? 20 : 24,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: isSmallScreen ? 12 : 16),
                        // App Name and Tagline
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'MT TRIP',
                              style: TextStyle(
                                color: _primaryColor,
                                fontSize: isSmallScreen ? 20 : isTablet ? 28 : 24,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.2,
                                height: 1.0,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Travel • Explore • Experience',
                              style: TextStyle(
                                color: _textSecondary,
                                fontSize: isSmallScreen ? 10 : isTablet ? 13 : 11,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    
                    // Profile/Login Section
                    Row(
                      children: [
                        if (isLoggedIn) ...[
                          // Profile Icon with Badge
                          GestureDetector(
                            onTap: () {
                              // Navigate to profile
                            },
                            child: Container(
                              padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _secondaryColor.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Icon(
                                    Icons.person_outline_sharp,
                                    color: _primaryColor,
                                    size: isSmallScreen ? 16 : 20,
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      width: isSmallScreen ? 8 : 10,
                                      height: isSmallScreen ? 8 : 10,
                                      decoration: BoxDecoration(
                                        color: Colors.red[500],
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ] else ...[
                          // Login Button with Alert Functionality
                  //         GestureDetector(
                  //           onTap: () {
                  // showModalBottomSheet(
                  // context: context,
                  // isScrollControlled: true,
                  // backgroundColor: Colors.transparent,
                  // builder: (context) => LoginBottomSheet(login: 2),
                  // );
                  // },
                  //           child: Container(
                  //             height: isSmallScreen ? 36 : 40,
                  //             padding: EdgeInsets.symmetric(horizontal: 16),
                  //             decoration: BoxDecoration(
                  //             color: _primaryColor,
                  //               borderRadius: BorderRadius.circular(20),
                  //               boxShadow: [
                                 
                  //               ],
                  //             ),
                  //             child: Row(
                  //               mainAxisSize: MainAxisSize.min,
                  //               children: [
                  //                 Icon(
                  //                   Icons.login,
                  //                   color: Colors.white,
                  //                   size: 13,
                  //                 ),
                  //                 SizedBox(width: 6),
                  //                 Text(
                  //                   'Login',
                  //                   style: TextStyle(
                  //                     color: Colors.white,
                  //                     fontSize: isSmallScreen ? 12 : 12,
                  //                     fontWeight: FontWeight.w600,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                        ],
                      ],
                    ),
                  ],
                ),

                // Login Alert Banner (only when not logged in)
                if (!isLoggedIn) ...[
                  SizedBox(height: isSmallScreen ? 12 : 16),
                  _buildLoginAlertBanner(isSmallScreen),
                ],

                // Search Bar Section
                SizedBox(height: isSmallScreen ? 12 : 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey[200]!, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 6,
                        offset: Offset(0, 2),
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
                      hintText: 'Search for buses, flights, hotels...',
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: isSmallScreen ? 14 : 16,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: _primaryColor,
                        size: isSmallScreen ? 20 : 22,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: isSmallScreen ? 14 : 16,
                        horizontal: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

// Login Alert Banner Widget
Widget _buildLoginAlertBanner(bool isSmallScreen) {
  return GestureDetector(
    onTap: () {
  showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => LoginBottomSheet(login: 2),
                  );    },
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 16 : 20,
        vertical: isSmallScreen ? 12 : 16,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _secondaryColor.withOpacity(0.1),
            _secondaryColor.withOpacity(0.05)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _secondaryColor.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          // // Alert Icon
          // Container(
          //   padding: EdgeInsets.all(8),
          //   decoration: BoxDecoration(
          //     color: _secondaryColor.withOpacity(0.1),
          //     shape: BoxShape.circle,
          //   ),
          //   child: Icon(
          //     Icons.info_outline,
          //     color: _secondaryColor,
          //     size: isSmallScreen ? 18 : 20,
          //   ),
          // ),
          // SizedBox(width: isSmallScreen ? 12 : 16),
          
          // Alert Message
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login Required!',
                  style: TextStyle(
                    color: _primaryColor,
                    fontSize:14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'login to manage trips, explore offers & more',
                  style: TextStyle(
                    color: _textSecondary,
                    fontSize: 10,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          
          // // Quick Login Button
          Container(
            height: isSmallScreen ? 32 : 36,
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: _primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextButton(
              onPressed: () {
  showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => LoginBottomSheet(login: 2),
                  );              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Login Now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isSmallScreen ? 11 : 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// Show Login Alert Dialog


  // Helper method for stat items
  Widget _buildStatItem(String value, String label, bool isSmallScreen) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: _primaryColor,
            fontSize: isSmallScreen ? 12 : 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: _textSecondary,
            fontSize: isSmallScreen ? 10 : 12,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchSection(
    bool isSmallScreen,
    bool isTablet,
    double bodyFontSize,
  ) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
      color: _cardColor,
      margin: EdgeInsets.only(top: 0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 15,
                  offset: Offset(0, 4),
                ),
              ],
              border: Border.all(color: Colors.grey.withOpacity(0.1)),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search destinations, flights, hotels...',
                hintStyle: TextStyle(color: _textLight, fontSize: bodyFontSize),
                prefixIcon: Icon(Icons.search, color: _primaryColor),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: isSmallScreen ? 16 : 20,
                  horizontal: 20,
                ),
                suffixIcon: _searchText.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: _textLight),
                        onPressed: () {
                          setState(() {
                            _searchText = '';
                            _searchController.clear();
                          });
                        },
                      )
                    : null,
              ),
            ),
          ),
          if (_searchText.isNotEmpty)
            _buildSearchResults(isSmallScreen, isTablet, bodyFontSize),
        ],
      ),
    );
  }

  Widget _buildSearchResults(
    bool isSmallScreen,
    bool isTablet,
    double bodyFontSize,
  ) {
    final filteredServices = _travelServices
        .where(
          (service) => service['label'].toLowerCase().contains(
            _searchText.toLowerCase(),
          ),
        )
        .toList();

    if (filteredServices.isEmpty) return SizedBox();

    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search Results',
            style: TextStyle(
              fontSize: bodyFontSize,
              fontWeight: FontWeight.w600,
              color: _textPrimary,
            ),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: filteredServices.map((service) {
              return _buildSearchResultItem(
                service,
                isSmallScreen,
                bodyFontSize,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResultItem(
    Map<String, dynamic> service,
    bool isSmallScreen,
    double bodyFontSize,
  ) {
    return GestureDetector(
      onTap: () => service['onTap'](context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: _secondaryColor.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              service['icon'],
              color: service['color'],
              size: isSmallScreen ? 14 : 16,
            ),
            SizedBox(width: 8),
            Text(
              service['label'],
              style: TextStyle(
                fontSize: bodyFontSize,
                fontWeight: FontWeight.w500,
                color: _textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularDestinations(
    bool isSmallScreen,
    bool isTablet,
    double headingFontSize,
    double bodyFontSize,
  ) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: _primaryColor,
                size: headingFontSize,
              ),
              SizedBox(width: 8),
              Text(
                'Popular Destinations',
                style: TextStyle(
                  fontSize: headingFontSize,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
              ),
              Spacer(),
              // GestureDetector(
              //   onTap: () {
              //     // Handle see all action
              //   },
              //   child: Text(
              //     'See All',
              //     style: TextStyle(
              //       fontSize: bodyFontSize,
              //       color: _secondaryColor,
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              // ),
            ],
          ),
          SizedBox(height: 16),
          SizedBox(
            height: isSmallScreen
                ? 130
                : isTablet
                ? 150
                : 130,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _popularDestinations.length,
              itemBuilder: (context, index) {
                final destination = _popularDestinations[index];
                return Container(
                  width: isSmallScreen
                      ? 170
                      : isTablet
                      ? 210
                      : 190,
                  margin: EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(destination['image']),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 12,
                        bottom: 12,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              destination['name'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isSmallScreen ? 14 : 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              destination['country'],
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: bodyFontSize,
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _secondaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'From ${destination['price']}',
                                style: TextStyle(
                                  color: _primaryColor,
                                  fontSize: isSmallScreen ? 10 : 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOffersBanner(
    bool isSmallScreen,
    bool isTablet,
    double bodyFontSize,
  ) {
    return Container(
      height: isSmallScreen
          ? 140
          : isTablet
          ? 200
          : 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 16 : 24,
          vertical: 16,
        ),
        itemCount: _travelOffers.length,
        itemBuilder: (context, index) {
          final offer = _travelOffers[index];
          return Container(
            width: isSmallScreen
                ? 280
                : isTablet
                ? 350
                : 320,
            margin: EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(offer['image']),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3),
                  BlendMode.darken,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 20,
                  bottom: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _secondaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          'SPECIAL OFFER',
                          style: TextStyle(
                            color: _primaryColor,
                            fontSize: isSmallScreen ? 10 : 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        offer['title'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isSmallScreen ? 18 : 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        offer['subtitle'],
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: bodyFontSize,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTravelServicesSection(
    BuildContext context,
    bool isSmallScreen,
    bool isTablet,
    double iconSize,
    double headingFontSize,
    double bodyFontSize,
  ) {
    final crossAxisCount = isTablet
        ? 4
        : isSmallScreen
        ? 4
        : 4;

    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.travel_explore,
                color: _primaryColor,
                size: headingFontSize,
              ),
              SizedBox(width: 8),
              Text(
                'Travel Services',
                style: TextStyle(
                  fontSize: headingFontSize,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
              ),
              Spacer(),
              // GestureDetector(
              //   onTap: () {
              //     // Handle view all action
              //   },
              //   child: Text(
              //     'View All',
              //     style: TextStyle(
              //       fontSize: bodyFontSize,
              //       color: _secondaryColor,
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              // ),
            ],
          ),
          // SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: isSmallScreen ? 12 : 16,
              mainAxisSpacing: isSmallScreen ? 12 : 16,
              childAspectRatio: isSmallScreen ? 0.7 : 0.7,
            ),
            itemCount: _travelServices.length,
            itemBuilder: (context, index) {
              final service = _travelServices[index];
              return _buildServiceCard(
                service,
                isSmallScreen,
                isTablet,
                iconSize,
                bodyFontSize,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
    Map<String, dynamic> service,
    bool isSmallScreen,
    bool isTablet,
    double iconSize,
    double bodyFontSize,
  ) {
    return GestureDetector(
      onTap: () => service['onTap'](context),
      child: Container(
        decoration: BoxDecoration(
          color: _cardColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            // BoxShadow(
            //   color: Colors.black.withOpacity(0.05),
            //   blurRadius: 8,
            //   offset: Offset(0, 2),
            // ),
          ],
          // border: Border.all(color: service['color'].withOpacity(0.1)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(
                isSmallScreen
                    ? 12
                    : isTablet
                    ? 16
                    : 14,
              ),
              decoration: BoxDecoration(
                color: service['color'].withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: FaIcon(
                service['icon'],
                color: service['color'],
                size:
                
                 isSmallScreen ? iconSize - 2 : iconSize-5,
              ),
            ),
            SizedBox(height: isSmallScreen ? 6 : 8),
            Text(
              service['label'],
              style: TextStyle(
                fontSize: bodyFontSize-2,
                fontWeight: FontWeight.w600,

                color: _textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickServicesSection(
    BuildContext context,
    bool isSmallScreen,
    bool isTablet,
    double iconSize,
    double headingFontSize,
    double bodyFontSize,
  ) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
      color: _cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.bolt, color: _primaryColor, size: headingFontSize),
              SizedBox(width: 8),
              Text(
                'Quick Services',
                style: TextStyle(
                  fontSize: headingFontSize,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
              ),
            ],
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isTablet
                  ? 4
                  : isSmallScreen
                  ? 4
                  : 4,
              crossAxisSpacing: isSmallScreen ? 10 : 13,
              mainAxisSpacing: isSmallScreen ? 10 : 13,
              childAspectRatio: 0.76,
            ),
            itemCount: _quickServices.length,
            itemBuilder: (context, index) {
              final service = _quickServices[index];
              return _buildQuickServiceCard(
                service,
                isSmallScreen,
                isTablet,
                iconSize-2,
                bodyFontSize-2,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickServiceCard(
    Map<String, dynamic> service,
    bool isSmallScreen,
    bool isTablet,
    double iconSize,
    double bodyFontSize,
  ) {
    return GestureDetector(
      onTap: service['onTap'],
      child: Container(
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(
                isSmallScreen
                    ? 10
                    : isTablet
                    ? 14
                    : 12,
              ),
              decoration: BoxDecoration(
                color: service['color'].withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                service['icon'],
                color: service['color'],
                size: isSmallScreen ? iconSize - 2 : iconSize,
              ),
            ),
            SizedBox(height: isSmallScreen ? 6 : 8),
            Text(
              service['label'],
              style: TextStyle(
                fontSize: bodyFontSize,
                fontWeight: FontWeight.w600,
                color: _textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoBanner(
    bool isSmallScreen,
    bool isTablet,
    double bodyFontSize,
  ) {
    return Container(
      margin: EdgeInsets.all(isSmallScreen ? 16 : 24),
      padding: EdgeInsets.all(isSmallScreen ? 20 : 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_primaryColor, Color(0xFF2D2D2D)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Opacity(
              opacity: 0.1,
              child: Icon(
                Icons.airplanemode_active,
                size: isSmallScreen
                    ? 100
                    : isTablet
                    ? 150
                    : 120,
                color: Colors.white,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: 12,
                    //     vertical: 6,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: _secondaryColor.withOpacity(0.2),
                    //     borderRadius: BorderRadius.circular(20),
                    //     border: Border.all(
                    //       color: _secondaryColor.withOpacity(0.4),
                    //     ),
                    //   ),
                    //   child: Row(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       Icon(Icons.star, size: 14, color: _secondaryColor),
                    //       SizedBox(width: 6),
                    //       Text(
                    //         'Premium Member',
                    //         style: TextStyle(
                    //           color: _secondaryColor,
                    //           fontSize: isSmallScreen ? 10 : 12,
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: 12),
                    Text(
                      'Travel The World\nWith Confidence',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 
                            18,
                            
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Exclusive deals on flights, hotels and packages. for our premium members',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: bodyFontSize,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Container(
                    //   width: 130,
                    //   height: 40,
                    //   child: ElevatedButton(
                    //     onPressed: () {},
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: _secondaryColor,
                    //       foregroundColor: _primaryColor,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(20),
                    //       ),
                    //       elevation: 2,
                    //     ),
                    //     child: Text(
                    //       'Explore',
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: bodyFontSize,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.construction, size: 60, color: _secondaryColor),
              SizedBox(height: 20),
              Text(
                '$service Coming Soon!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'We\'re working hard to bring you the best $service booking experience. Stay tuned!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: _textSecondary),
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text(
                  'Got It!',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
