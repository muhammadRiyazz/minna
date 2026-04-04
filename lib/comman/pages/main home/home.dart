import 'package:flutter/material.dart';
import 'package:minna/Electyicity%20&%20Water/water%20bill/water%20bill%20home/water_input.dart';
import 'package:minna/hotel%20booking/pages/holel%20home%20page/home_page_hotel.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minna/DTH%20&%20Mobile/DTH/pages/dth%20home%20inputs/dht_input_page.dart';
import 'package:minna/DTH%20&%20Mobile/mobile%20%20recharge/application/oparator/operators_bloc.dart';
import 'package:minna/DTH%20&%20Mobile/mobile%20%20recharge/pages/home%20page/recharge_home.dart';
import 'package:minna/Electyicity%20&%20Water/kseb/kseb%20home/electricity_home.dart';

import 'package:minna/bus/application/location%20fetch/bus_location_fetch_bloc.dart';
import 'package:minna/bus/pages/screen%20bus%20home%20/bus_home.dart';
import 'package:minna/cab/pages/TripSelectionPage/TripSelectionPage.dart';
import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/application/home_data/destination_model.dart';
import 'package:minna/comman/application/home_data/home_data_bloc.dart';
import 'package:minna/comman/application/home_data/home_data_event.dart';
import 'package:minna/comman/application/home_data/home_data_state.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/pages/histoy/histoty.dart';
import 'package:minna/comman/pages/log%20in/login_page.dart';
import 'package:minna/comman/pages/screen%20bookings/screen_booking.dart';
import 'package:minna/comman/pages/screen%20my%20account/my_account_page.dart';
import 'package:minna/flight/presendation/screen%20flight/home_flight.dart';

import 'package:minna/visa/pages/visa_page.dart';
import 'package:url_launcher/url_launcher.dart';

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
          icon: Icon(Iconsax.home),
          activeIcon: Icon(Iconsax.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.book),
          activeIcon: Icon(Iconsax.book),
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.timer_1),
          activeIcon: Icon(Iconsax.timer),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.user),
          activeIcon: Icon(Iconsax.user),
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

  @override
  void initState() {
    super.initState();
    context.read<HomeDataBloc>().add(const FetchDestinations());
    context.read<HomeDataBloc>().add(const FetchVisaCountries());
  }

  // Travel Services Data with theme colors
  List<Map<String, dynamic>> get _travelServices => [
    {
      'label': 'Flights',
      'icon': Iconsax.airplane,
      'color': Color(0xFF003875), // Gold
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FlightBookingTab()),
        );
      },
    },
    {
      'label': 'Hotels',
      'icon': Iconsax.building,
      'color': Color(0xFF003875), // Gold
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HotelBookingHome()),
        );
      },
    },
    {
      'label': 'Bus',
      'icon': Iconsax.bus,
      'color': Color(0xFF003875), // Gold
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
      'icon': Iconsax.car,
      'color': Color(0xFF003875), // Gold
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TripSelectionPage()),
        );
      },
    },
    {
      'label': 'Visa',
      'icon': Iconsax.global,
      'color': Color(0xFF003875), // Gold
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VisaPage()),
        );
      },
    },
    {
      'label': 'Airport Cabs',
      'icon': Iconsax.car,
      'color': Color(0xFF003875), // Gold
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TripSelectionPage()),
        );
      },
    },
    {
      'label': 'Train',
      'icon': Iconsax.bus,
      'color': Color(0xFF003875), // Gold
      'onTap': (BuildContext context) {
        _showComingSoonBottomSheet(context, "Train");
      },
    },
    {
      'label': 'Cruise',
      'icon': Iconsax.ship,
      'color': Color(0xFF003875), // Gold
      'onTap': (BuildContext context) {
        _showComingSoonBottomSheet(context, "Cruise");
      },
    },
  ];

  // Quick Services Data with theme colors
  List<Map<String, dynamic>> get _quickServices => [
    {
      'icon': Iconsax.mobile,
      'label': 'Mobile',
      'color': Color(0xFF003875), // Gold
      'onTap': (BuildContext context) {
        context.read<OperatorsBloc>().add(const OperatorsEvent.getop());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MobileRechargeInputPage()),
        );
      },
    },
    {
      'icon': Iconsax.monitor,
      'label': 'DTH',
      'color': Color(0xFF003875), // Gold
      'onTap': (BuildContext context) {
        context.read<OperatorsBloc>().add(const OperatorsEvent.getDTHop());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DTHInputPage()),
        );
      },
    },
    {
      'icon': Iconsax.flash,
      'label': 'Electricity',
      'color': Color(0xFF003875), // Gold
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ElectricityBillInputPage()),
        );
      },
    },
    {
      'icon': Icons.water_drop_rounded,
      'label': 'Water',
      'color': maincolor1,
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WaterBillInputPage()),
        );
      },
    },
  ];

  // Combined Services for Search
  List<Map<String, dynamic>> get _allSearchableServices => [
    ..._travelServices,
    ..._quickServices,
  ];

  List<Map<String, dynamic>> get _filteredServices {
    if (_searchText.isEmpty) return [];
    return _allSearchableServices.where((service) {
      final label = service['label'].toString().toLowerCase();
      final query = _searchText.toLowerCase();
      return label.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 360;
    final bool isTablet = screenSize.width > 600;

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
        ? 16
        : 15;
    final double bodyFontSize = isSmallScreen
        ? 12
        : isTablet
        ? 16
        : 12;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      final bool isLoggedIn = state.isLoggedIn ?? false;
                      return Column(
                        children: [
                          _buildIntegratedHeader(
                            isSmallScreen,
                            isTablet,
                            titleFontSize,
                            state,
                          ),
                          Transform.translate(
                            offset: const Offset(0, -28),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: isSmallScreen ? 16 : 24,
                              ),
                              child: _buildPremiumSearchBar(isSmallScreen),
                            ),
                          ),
                          if (!isLoggedIn)
                            Transform.translate(
                              offset: const Offset(0, -14),
                              child: _buildLoginAlertBanner(isSmallScreen),
                            ),
                        ],
                      );
                    },
                  ),

                  // const SizedBox(height: 20),
                  // Popular Destinations
                  BlocBuilder<HomeDataBloc, HomeDataState>(
                    builder: (context, state) {
                      return _buildPopularDestinations(
                        isSmallScreen,
                        isTablet,
                        headingFontSize,
                        bodyFontSize,
                        state,
                      );
                    },
                  ),

                  // Offers Carousel Top
                  // _buildOffersCarousel(isSmallScreen, isTablet, bodyFontSize),

                  // Travel Services
                  _buildTravelServicesSection(
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
            if (_searchText.isNotEmpty)
              _buildSearchResultsOverlay(isSmallScreen),
          ],
        ),
      ),
    );
  }

  Widget _buildStaticBrandingHeader(bool isSmallScreen, LoginState state) {
    final isLoggedIn = state.isLoggedIn ?? false;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 16 : 24,
        vertical: 12,
      ),
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // App Brand Logo & Name
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: maincolor1,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(
                    'asset/mtlogo.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Iconsax.airplane, color: secondaryColor, size: 18),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'MT TRIP',
                style: TextStyle(
                  color: maincolor1,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          // Profile Actions
          Row(children: [_buildProfileAvatar(isLoggedIn)]),
        ],
      ),
    );
  }

  SliverAppBar _buildDynamicAppBar(
    bool isSmallScreen,
    bool isTablet,
    double titleFontSize,
    LoginState state,
  ) {
    final isLoggedIn = state.isLoggedIn ?? false;

    return SliverAppBar(
      backgroundColor: backgroundColor,
      expandedHeight: !isLoggedIn
          ? (isTablet
                ? 160
                : isSmallScreen
                ? 140
                : 175)
          : 85,
      floating: false,
      pinned: false, // Changed to false because branding is now fixed above
      elevation: 0,
      centerTitle: false,
      titleSpacing: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          margin: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 16 : 24,
            vertical: 12,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 16 : 24,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Login Alert Banner (only when not logged in)
                if (!isLoggedIn) ...[
                  _buildLoginAlertBanner(isSmallScreen),
                  const SizedBox(height: 12),
                ],
                // Sleek Search Bar
                _buildPremiumSearchBar(isSmallScreen),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIntegratedHeader(
    bool isSmallScreen,
    bool isTablet,
    double titleFontSize,
    LoginState state,
  ) {
    final isLoggedIn = state.isLoggedIn ?? false;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: maincolor1,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(36)),
        boxShadow: [
          BoxShadow(
            color: maincolor1.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            isSmallScreen ? 16 : 24,
            isSmallScreen ? 16 : 24,
            isSmallScreen ? 16 : 24,
            24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isLoggedIn ? 'Welcome back,' : 'Hello, Traveler!',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Where to next?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: titleFontSize + 4,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildProfileAvatar(isLoggedIn),
                ],
              ),
              const SizedBox(
                height: 40,
              ), // Padding to account for the overlapping search bar
            ],
          ),
        ),
      ),
    );
  }

  PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentOfferPage = 0;

  Widget _buildOffersCarousel(
    bool isSmallScreen,
    bool isTablet,
    double bodyFontSize,
  ) {
    if (_travelOffers.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: isSmallScreen ? 160 : 200,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentOfferPage = page;
              });
            },
            itemCount: _travelOffers.length,
            itemBuilder: (context, index) {
              final offer = _travelOffers[index];
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value = _pageController.page! - index;
                    value = (1 - (value.abs() * 0.2)).clamp(0.0, 1.0);
                  }
                  return Center(
                    child: Transform.scale(scale: value, child: child),
                  );
                },
                child: _buildPremiumOfferCard(offer, isSmallScreen, true),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_travelOffers.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: _currentOfferPage == index ? 24 : 8,
              decoration: BoxDecoration(
                color: _currentOfferPage == index
                    ? secondaryColor
                    : textLight.withOpacity(0.4),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildProfileAvatar(bool isLoggedIn) {
    return GestureDetector(
      onTap: () {
        if (!isLoggedIn) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => LoginBottomSheet(login: 2),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyAccountPage()),
          );
        }
      },
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
        ),
        child: Icon(
          isLoggedIn ? Iconsax.user : Iconsax.login,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildPremiumSearchBar(bool isSmallScreen) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
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
          hintText: 'Search for recharge, bill, travel...',
          hintStyle: TextStyle(
            color: textLight,
            fontSize: isSmallScreen ? 14 : 16,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(
            Iconsax.search_normal,
            color: secondaryColor,
            size: 22,
          ),
          suffixIcon: _searchText.isNotEmpty
              ? IconButton(
                  icon: Icon(Iconsax.close_circle, color: textLight, size: 20),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _searchText = '');
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResultsOverlay(bool isSmallScreen) {
    final results = _filteredServices;

    return Positioned.fill(
      child: GestureDetector(
        onTap: () => setState(() {
          _searchController.clear();
          _searchText = '';
        }),
        child: Container(
          color: Colors.black.withOpacity(0.3),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: results.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            Icon(
                              Iconsax.search_status,
                              color: textLight,
                              size: 40,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'No services found for "$_searchText"',
                              style: TextStyle(
                                color: textSecondary,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: results.map((service) {
                          return ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: (service['color'] as Color).withOpacity(
                                  0.1,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                service['icon'] as IconData,
                                color: service['color'] as Color,
                                size: 20,
                              ),
                            ),
                            title: Text(
                              service['label'] as String,
                              style: TextStyle(
                                color: textPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              _getServiceCategory(service['label'] as String),
                              style: TextStyle(color: textLight, fontSize: 12),
                            ),
                            trailing: Icon(
                              Iconsax.arrow_right_3,
                              color: textLight,
                              size: 16,
                            ),
                            onTap: () {
                              setState(() {
                                _searchController.clear();
                                _searchText = '';
                              });
                              (service['onTap'] as Function(BuildContext))(
                                context,
                              );
                            },
                          );
                        }).toList(),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getServiceCategory(String label) {
    if (['Mobile', 'DTH'].contains(label)) return 'Manage Service';
    if (['Electricity', 'Water'].contains(label)) return 'Utility Service';
    return 'Travel Service';
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
        );
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 24),
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 16 : 20,
          vertical: isSmallScreen ? 12 : 16,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              secondaryColor.withOpacity(0.1),
              secondaryColor.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: secondaryColor.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            // // Alert Icon
            // Container(
            //   padding: EdgeInsets.all(8),
            //   decoration: BoxDecoration(
            //     color: secondaryColor.withOpacity(0.1),
            //     shape: BoxShape.circle,
            //   ),
            //   child: Icon(
            //     Icons.info_outline,
            //     color: secondaryColor,
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
                      color: maincolor1,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'login to manage trips, explore offers & more',
                    style: TextStyle(color: textSecondary, fontSize: 10),
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
                color: maincolor1,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => LoginBottomSheet(login: 2),
                  );
                },
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
            color: maincolor1,
            fontSize: isSmallScreen ? 12 : 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: textSecondary,
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
      color: cardColor,
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
                hintStyle: TextStyle(color: textLight, fontSize: bodyFontSize),
                prefixIcon: Icon(Iconsax.search_normal, color: maincolor1),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: isSmallScreen ? 16 : 20,
                  horizontal: 20,
                ),
                suffixIcon: _searchText.isNotEmpty
                    ? IconButton(
                        icon: Icon(Iconsax.close_circle, color: textLight),
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
        color: cardColor,
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
              color: textPrimary,
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
          color: backgroundColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: secondaryColor.withOpacity(0.3)),
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
                color: textPrimary,
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
    HomeDataState state,
  ) {
    if (state.isDestinationsLoading) {
      return _buildPopularDestinationsLoading(
        isSmallScreen,
        isTablet,
        headingFontSize,
      );
    }

    final destinations = state.popularDestinations ?? [];
    if (destinations.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: isSmallScreen ? 16 : 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TRENDING NOW',
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Popular Destinations',
                    style: TextStyle(
                      fontSize: headingFontSize + 4,
                      fontWeight: FontWeight.w900,
                      color: maincolor1,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              itemCount: destinations.length,
              itemBuilder: (context, index) {
                final destination = destinations[index];
                return _buildPremiumDestinationCard(
                  destination,
                  isSmallScreen,
                  isTablet,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumDestinationCard(
    DestinationModel destination,
    bool isSmallScreen,
    bool isTablet,
  ) {
    return GestureDetector(
      onTap: () => _showDestinationDetailsBottomSheet(context, destination),
      child: Container(
        width: isSmallScreen ? 180 : 220,
        margin: const EdgeInsets.only(right: 17),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: maincolor1.withOpacity(0.12),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                destination.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[200],
                  child: Icon(Iconsax.image, color: Colors.grey[400]),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.0),
                      Colors.black.withOpacity(0.85),
                    ],
                    stops: const [0.3, 0.5, 1.0],
                  ),
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      destination.location.isNotEmpty
                          ? destination.location
                          : destination.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          "INR ${destination.priceToShow}",
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(width: 4),
                        // Expanded(
                        //   child: Text(
                        //     'onwards',
                        //     style: TextStyle(
                        //        color: Colors.white.withOpacity(0.7),
                        //        fontSize: 10,
                        //        fontWeight: FontWeight.w500,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDestinationDetailsBottomSheet(
    BuildContext context,
    DestinationModel destination,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildDestinationDetailsSheet(context, destination),
    );
  }

  Widget _buildDestinationDetailsSheet(
    BuildContext context,
    DestinationModel destination,
  ) {
    // Parse duration from title if possible
    String duration = "Flexible";
    if (destination.title.contains('Nights') ||
        destination.title.contains('Days')) {
      final parts = destination.title.split('\u2013')[0].trim();
      duration = parts.replaceAll(' Nights', 'N').replaceAll(' Days', 'D');
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: textLight.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Immersive Hero
                        ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: Stack(
                            children: [
                              Image.network(
                                destination.image,
                                height: 280,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      height: 280,
                                      color: Colors.grey[200],
                                      child: Icon(
                                        Iconsax.image,
                                        color: Colors.grey[400],
                                        size: 48,
                                      ),
                                    ),
                              ),
                              // Category Badge
                              Positioned(
                                top: 16,
                                left: 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: maincolor1,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Text(
                                    'HOLIDAY PACKAGE',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ),
                              // Action Buttons
                              Positioned(
                                top: 16,
                                right: 16,
                                child: Row(
                                  children: [
                                    // _buildHeroFloatingButton(
                                    //   Iconsax.export,
                                    //   () {},
                                    // ),
                                    const SizedBox(width: 8),
                                    _buildHeroFloatingButton(
                                      Icons.close,
                                      () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    destination.title,
                                    style: TextStyle(
                                      color: maincolor1,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: -0.5,
                                      height: 1.2,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Iconsax.star1,
                                        color: secondaryColor,
                                        size: 14,
                                      ),
                                      const SizedBox(width: 4),
                                      const Text(
                                        '4.8 (120+ Reviews)',
                                        style: TextStyle(
                                          color: textSecondary,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Quick Info Summary Grid
                        _buildQuickSummaryRow(duration),

                        const SizedBox(height: 24),
                        // Price Banner
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                maincolor1.withOpacity(0.05),
                                maincolor1.withOpacity(0.02),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(15),
                            // border: Border.all(
                            //   color: maincolor1.withOpacity(0.08),
                            // ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Price',
                                      style: TextStyle(
                                        color: textSecondary,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "₹ ${destination.price}",
                                      style: TextStyle(
                                        color: maincolor1,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // Hotel Section
                      if (destination.hotelDetails.isNotEmpty) ...[
                        _buildSectionCard(
                          Iconsax.building_3,
                          'Preferred Hotel',
                          Text(
                            destination.hotelDetails,
                            style: TextStyle(
                              color: textPrimary,
                              fontSize: 14,
                              height: 1.6,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],

                      // Itinerary Section
                      if (destination.days.isNotEmpty) ...[
                        _buildSectionHeader(Iconsax.calendar_tick, 'Itinerary'),
                        const SizedBox(height: 12),
                        ...List.generate(destination.days.length, (index) {
                          return _buildTimelineDayTile(
                            destination.days[index],
                            isLast: index == destination.days.length - 1,
                          );
                        }),
                        const SizedBox(height: 24),
                      ],
                      // Inclusions Section
                      if (destination.inclusions.isNotEmpty) ...[
                        _buildSectionCard(
                          Iconsax.tick_circle,
                          'What\'s Included',
                          _buildRichTextSection(destination.inclusions),
                        ),
                        const SizedBox(height: 20),
                      ],
                      // Exclusions Section
                      if (destination.exclusions.isNotEmpty) ...[
                        _buildSectionCard(
                          Iconsax.close_circle,
                          'What\'s Excluded',
                          _buildRichTextSection(
                            destination.exclusions,
                            isExclusion: true,
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],

                      // Final CTA
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 40),
                        child: ElevatedButton(
                          onPressed: () {
                            const String supportNumber = "+919656666556";
                            final Uri callUri = Uri.parse("tel:$supportNumber");
                            launchUrl(callUri);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: maincolor1,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 8,
                            shadowColor: maincolor1.withOpacity(0.4),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Book Holiday Now',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Talk to our Travel Experts',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.8),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroFloatingButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          // blurStyle: BlurStyle.outer,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildQuickSummaryRow(String duration) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildInfoItem(Iconsax.clock, duration, 'Duration'),
        _buildInfoItem(Iconsax.coffee, 'Included', 'Meals'),
        _buildInfoItem(Iconsax.building_3, '3-4 Star', 'Hotel'),
        _buildInfoItem(Iconsax.truck_fast, 'Included', 'Transfers'),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: maincolor1.withOpacity(0.04),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: secondaryColor, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: maincolor1,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: textLight,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard(IconData icon, String title, Widget content) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderSoft),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: secondaryColor, size: 20),
              const SizedBox(width: 12),
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  color: maincolor1,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }

  Widget _buildTimelineDayTile(DayPlan day, {required bool isLast}) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          // SizedBox(
          //   width: 40,
          //   child: Column(
          //     children: [
          //       Container(
          //         width: 12,
          //         height: 12,
          //         decoration: BoxDecoration(
          //           color: secondaryColor,
          //           shape: BoxShape.circle,
          //           border: Border.all(
          //             color: secondaryColor.withOpacity(0.3),
          //             width: 3,
          //           ),
          //         ),
          //       ),
          //       if (!isLast)
          //         Expanded(child: Container(width: 2, color: borderSoft)),
          //     ],
          //   ),
          // ),
          // const SizedBox(width: 8),
          // Content
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: borderSoft),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.01),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Theme(
                data: Theme.of(
                  context,
                ).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: maincolor1,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'DAY ${day.dayNumber}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          day.title,
                          style: TextStyle(
                            color: maincolor1,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(height: 1, thickness: 0.5),
                          const SizedBox(height: 12),
                          Text(
                            day.description,
                            style: TextStyle(
                              color: textSecondary,
                              fontSize: 13,
                              height: 1.6,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (day.meals.isNotEmpty) ...[
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: secondaryColor.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Iconsax.coffee,
                                    color: secondaryColor,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      'Meals: ${day.meals}',
                                      style: TextStyle(
                                        color: maincolor1,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: secondaryColor, size: 18),
          const SizedBox(width: 10),
          Text(
            title.toUpperCase(),
            style: TextStyle(
              color: maincolor1,
              fontSize: 13,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRichTextSection(String text, {bool isExclusion = false}) {
    final lines = text.split('\n').where((l) => l.trim().isNotEmpty).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: isExclusion ? errorColor : secondaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  line.trim(),
                  style: TextStyle(
                    color: textPrimary.withOpacity(0.9),
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDayTile(DayPlan day) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderSoft),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          leading: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: secondaryColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Day ${day.dayNumber}',
              style: TextStyle(
                color: secondaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          title: Text(
            day.title,
            style: TextStyle(
              color: maincolor1,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(height: 1, thickness: 0.5),
                  const SizedBox(height: 16),
                  Text(
                    day.description,
                    style: TextStyle(
                      color: textSecondary,
                      fontSize: 13,
                      height: 1.6,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (day.meals.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Iconsax.coffee, color: secondaryColor, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          'Meals: ${day.meals}',
                          style: TextStyle(
                            color: maincolor1,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularDestinationsLoading(
    bool isSmallScreen,
    bool isTablet,
    double headingFontSize,
  ) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.trend_up, color: maincolor1, size: headingFontSize),
              SizedBox(width: 8),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: headingFontSize,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
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
              itemCount: 3,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: isSmallScreen
                        ? 170
                        : isTablet
                        ? 210
                        : 190,
                    margin: EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumOfferCard(
    Map<String, dynamic> offer,
    bool isSmallScreen, [
    bool isCarousel = false,
  ]) {
    return Container(
      width: double.infinity,
      margin: isCarousel
          ? const EdgeInsets.symmetric(horizontal: 4)
          : const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: maincolor1.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Image.network(
              offer['image'],
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: Colors.grey[200]),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.1),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: successColor.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'SAVE 20%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    offer['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    offer['subtitle'],
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: maincolor1,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Book Now',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
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

  Widget _buildTravelServicesSection(
    BuildContext context,
    bool isSmallScreen,
    bool isTablet,
    double iconSize,
    double headingFontSize,
    double bodyFontSize,
  ) {
    // Combine all services for display
    final List<Map<String, dynamic>> allServices = [
      ..._travelServices,
      ..._quickServices,
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            'OUR SERVICES',
            style: TextStyle(
              color: secondaryColor.withOpacity(0.8),
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Travel & Essentials',
            style: TextStyle(
              fontSize: headingFontSize + 2,
              fontWeight: FontWeight.w900,
              color: maincolor1,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 24,
              childAspectRatio: 0.72,
            ),
            itemCount: allServices.length,
            itemBuilder: (context, index) {
              final service = allServices[index];
              return _buildPremiumServiceCard(
                service,
                isSmallScreen,
                iconSize,
                bodyFontSize,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumServiceCard(
    Map<String, dynamic> service,
    bool isSmallScreen,
    double iconSize,
    double bodyFontSize,
  ) {
    return GestureDetector(
      onTap: () => service['onTap'](context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(isSmallScreen ? 14 : 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: maincolor1.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              service['icon'],
              color: service['color'],
              size: isSmallScreen ? 20 : 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            service['label'],
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: maincolor1,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
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
      padding: EdgeInsets.all(isSmallScreen ? 24 : 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [maincolor1, Color(0xFF001F45)],
        ),
        boxShadow: [
          BoxShadow(
            color: maincolor1.withOpacity(0.2),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            bottom: -10,
            child: Opacity(
              opacity: 0.05,
              child: Icon(
                Iconsax.discover,
                size: isSmallScreen ? 120 : 160,
                color: Colors.white,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GO BEYOND',
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Travel The World\nWith Confidence',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Unlock exclusive deals on curated flights and premium hotel stays.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                  height: 1.5,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              // Container(
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 16,
              //     vertical: 8,
              //   ),
              //   decoration: BoxDecoration(
              //     color: secondaryColor,
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: const Text(
              //     'Explore Collections',
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 12,
              //     ),
              //   ),
              // ),
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
              Icon(Iconsax.discover, size: 120, color: Colors.white),
              SizedBox(height: 20),
              Text(
                '$service Coming Soon!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'We\'re working hard to bring you the best $service booking experience. Stay tuned!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: textSecondary),
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: maincolor1,
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
