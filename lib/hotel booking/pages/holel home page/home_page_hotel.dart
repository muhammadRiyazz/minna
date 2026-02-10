import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minna/hotel%20booking/domain/Nation%20and%20city/city.dart';
import 'package:minna/hotel%20booking/domain/Nation%20and%20city/nation';
import 'package:minna/hotel%20booking/functions/hotel_api.dart';
import 'package:minna/hotel%20booking/pages/hotel%20list/hotel_list.dart';

List<CountryModel> countries = [];

class HotelBookingHome extends StatefulWidget {
  const HotelBookingHome({super.key});

  @override
  State<HotelBookingHome> createState() => _HotelBookingHomeState();
}

class _HotelBookingHomeState extends State<HotelBookingHome> {
  CountryModel? selectedCountry;
  String? selectedCity;
  String? selectedCityCode;
  DateTime checkInDate = DateTime.now();
  DateTime checkOutDate = DateTime.now().add(const Duration(days: 1));
  
  // Updated to support multiple rooms
  List<Map<String, dynamic>> rooms = [
    {'adults': 2, 'children': 0, 'childrenAges': <int>[]}
  ];

  List<HotelCityHotel> cities = [];
  bool _countriesLoaded = false;

  bool isLoadingCountries = false;
  bool isLoadingCities = false;

  final HotelApiService apiService = HotelApiService();

  // Format date getters
  String get formattedCheckIn => DateFormat('MMM dd, yyyy').format(checkInDate);
  String get formattedCheckOut => DateFormat('MMM dd, yyyy').format(checkOutDate);
  
  // Calculate totals from rooms
  int get totalAdults => rooms.fold(0, (sum, room) => sum + (room['adults'] as int));
  int get totalChildren => rooms.fold(0, (sum, room) => sum + (room['children'] as int));
  List<int> get allChildrenAges {
    final ages = <int>[];
    for (final room in rooms) {
      if (room['children'] > 0) {
        ages.addAll((room['childrenAges'] as List<int>).cast<int>());
      }
    }
    return ages;
  }

  // Updated guest string
  String get formattedGuests {
    final totalPeople = totalAdults + totalChildren;
    return '$totalPeople Guest${totalPeople > 1 ? 's' : ''}, ${rooms.length} Room${rooms.length > 1 ? 's' : ''}';
  }

  // Gold, Black & White Color Theme
  final Color _primaryColor = Color(0xFF000000); // Black
  final Color _secondaryColor = Color(0xFFD4AF37); // Gold
  final Color _accentColor = Color(0xFFB8860B); // Dark Gold
  final Color _backgroundColor = Color(0xFFFAFAFA); // Off-white
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Color(0xFF000000);
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);
  final Color _borderColor = Color(0xFFE0E0E0);

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    if (_countriesLoaded && countries.isNotEmpty) return;
    
    setState(() => isLoadingCountries = true);
    try {
      countries = await apiService.getCountries();
      _countriesLoaded = true;
    } catch (e) {
      debugPrint('Error fetching countries: $e');
    } finally {
      setState(() => isLoadingCountries = false);
    }
  }

  Future<void> fetchCities(String countryName) async {
    setState(() => isLoadingCities = true);
    try {
      // Find the CountryModel by name
      final country = countries.firstWhere((c) => c.name == countryName);
      cities = await apiService.getCities(country.code);
      
      if (cities.isNotEmpty) {
        selectedCity = cities.first.name;
        selectedCityCode = cities.first.code;
      } else {
        selectedCity = null;
        selectedCityCode = null;
      }
    } catch (e) {
      log('Error fetching cities: $e');
      selectedCity = null;
      selectedCityCode = null;
      cities = [];
    } finally {
      setState(() => isLoadingCities = false);
    }
  }

  void _showCountryBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (context) => CountryBottomSheet(
        isLoading: isLoadingCountries,
        selectedCountry: selectedCountry?.name,
        onCountrySelected: (countryName) async {
          Navigator.pop(context);
          if (countryName != selectedCountry?.name) {
            final country = countries.firstWhere((c) => c.name == countryName);
            setState(() {
              selectedCountry = country;
              selectedCity = null;
              selectedCityCode = null;
              cities = [];
            });
            await fetchCities(countryName);
          }
        },
        primaryColor: _primaryColor,
        secondaryColor: _secondaryColor,
        accentColor: _accentColor,
      ),
    );
  }

  void _showCityBottomSheet() {
    if (selectedCountry == null || isLoadingCities) return;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (context) => CityBottomSheet(
        isLoading: isLoadingCities,
        selectedCity: selectedCity,
        cities: cities,
        onCitySelected: (city, cityCode) {
          setState(() {
            selectedCity = city;
            selectedCityCode = cityCode;
          });
          Navigator.pop(context);
        },
        primaryColor: _primaryColor,
        secondaryColor: _secondaryColor,
        accentColor: _accentColor,
      ),
    );
  }

  Future<void> _selectCheckInDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: checkInDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2026, 12, 31),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: _secondaryColor,
              onPrimary: Colors.white,
              surface: _cardColor,
            ),
            dialogBackgroundColor: _cardColor,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != checkInDate) {
      setState(() {
        checkInDate = picked;
        if (checkOutDate.isBefore(picked) || checkOutDate == picked) {
          checkOutDate = picked.add(const Duration(days: 1));
        }
      });
    }
  }

  Future<void> _selectCheckOutDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: checkOutDate,
      firstDate: checkInDate.add(const Duration(days: 1)),
      lastDate: DateTime(2026, 12, 31),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: _secondaryColor,
              onPrimary: Colors.white,
              surface: _cardColor,
            ),
            dialogBackgroundColor: _cardColor,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != checkOutDate) {
      setState(() => checkOutDate = picked);
    }
  }

  void _showGuestSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (context) => GuestSelectorBottomSheet(
        totalAdults: totalAdults,
        totalChildren: totalChildren,
        childrenAges: allChildrenAges,
        rooms: rooms,
        onGuestsChanged: (newAdults, newChildren, newChildrenAges, newRooms) {
          setState(() {
            rooms = newRooms;
          });
        },
        primaryColor: _primaryColor,
        secondaryColor: _secondaryColor,
        accentColor: _accentColor,
        borderColor: _borderColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: _primaryColor,
            expandedHeight: 130,
            floating: false,
            pinned: true,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Iconsax.arrow_left_2, color: Colors.white, size: 24),
              onPressed: () => Navigator.pop(context),
            ),
            shadowColor: Colors.black.withOpacity(0.3),
            surfaceTintColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              expandedTitleScale: 1.2,
              titlePadding: EdgeInsets.only(bottom: 16),
              title: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  // color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                  // border: Border.all(color: _secondaryColor.withOpacity(0.3), width: 1),
                ),
                child: Text(
                  'Hotel Booking',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _primaryColor,
                      Color(0xFF1A1A1A),
                    ],
                    stops: [0.0, 1.0],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -50,
                      top: -50,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: _secondaryColor.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      left: -30,
                      bottom: -30,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: _secondaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderSection(),
                  const SizedBox(height: 15),
                  _buildSearchCardsSection(),
                  const SizedBox(height: 20),
                  _buildSearchButton(),
                  const SizedBox(height: 20),
                
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _primaryColor,
            Color(0xFF1A1A1A),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _secondaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
              // border: Border.all(color: _secondaryColor.withOpacity(0.4), width: 1),
            ),
            child: Icon(
              Iconsax.building_3,
              color: _secondaryColor,
              size: 22,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Find Your Perfect Stay",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Discover luxury hotels with best price guarantee",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchCardsSection() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 30,
            offset: const Offset(0, 8),
          ),
        ],
        // border: Border.all(color: _borderColor, width: 1),
      ),
      child: Column(
        children: [
          // Country Card
          _buildLocationCard(
            title: "Country",
            value: selectedCountry?.name ?? "Select Country",
            icon: Iconsax.flag,
            isLoading: isLoadingCountries,
            onTap: _showCountryBottomSheet,
          ),
          const SizedBox(height: 16),
          
          // City Card
          _buildLocationCard(
            title: "City",
            value: selectedCity ?? (isLoadingCities ? "Loading cities..." : "Select City"),
            icon: Iconsax.buildings,
            isLoading: isLoadingCities,
            onTap: _showCityBottomSheet,
            isDisabled: selectedCountry == null || isLoadingCities,
          ),
          const SizedBox(height: 16),
          
          // Dates and Guests Row
          Row(
            children: [
              Expanded(
                child: _buildDateCard(
                  title: "Check-in",
                  value: formattedCheckIn,
                  icon: Iconsax.calendar_1,
                  onTap: _selectCheckInDate,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildDateCard(
                  title: "Check-out",
                  value: formattedCheckOut,
                  icon: Iconsax.calendar_2,
                  onTap: _selectCheckOutDate,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Guests Card
          _buildLocationCard(
            title: "Guests & Rooms",
            value: formattedGuests,
            icon: Iconsax.profile_2user,
            isLoading: false,
            onTap: _showGuestSelector,
            isDisabled: false,
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard({
    required String title,
    required String value,
    required IconData icon,
    required bool isLoading,
    required VoidCallback onTap,
    bool isDisabled = false,
  }) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDisabled ? Colors.grey[50] : _cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isDisabled ? _borderColor : _secondaryColor.withOpacity(0.3),
            width: isDisabled ? 0: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDisabled ? _borderColor : _secondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
                // border: Border.all(color: _secondaryColor.withOpacity(0.2), width: 1),
              ),
              child: Icon(
                icon,
                color: isDisabled ? Colors.grey[400] : _secondaryColor,
                size: 18,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDisabled ? Colors.grey[400] : _textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 3),
                  if (isLoading)
                    Container(
                      height: 20,
                      width: 120,
                      decoration: BoxDecoration(
                        color: _borderColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    )
                  else
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDisabled ? Colors.grey[400] : _textPrimary,
                        height: 1.3,
                      ),
                    ),
                ],
              ),
            ),
            Icon(
              Iconsax.arrow_right_3,
              color: isDisabled ? Colors.grey[300] : _secondaryColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateCard({
    required String title,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _secondaryColor.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: _secondaryColor,
                  size: 16,
                ),
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: _textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _textPrimary,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchButton() {
    final isEnabled = selectedCountry != null && 
                     selectedCity != null && 
                     selectedCityCode != null && 
                     !isLoadingCities;
    
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled
            ? () {
                log(rooms.toList().toString());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HotelListPage(
                      cityId: selectedCityCode!,
                      cityName: selectedCity!,
                      checkInDate: checkInDate,
                      checkOutDate: checkOutDate,
                      rooms: rooms,
                    ),
                  ),
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? _secondaryColor : _borderColor,
          foregroundColor: isEnabled ? Colors.black : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          padding: EdgeInsets.symmetric(vertical: 20),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.search_normal_1,
              size: 22,
              color:  Colors.white,
            ),
            const SizedBox(width: 12),
            Text(
              "Search Hotels",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
                color:  Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

 
}

// City Bottom Sheet
class CityBottomSheet extends StatefulWidget {
  final bool isLoading;
  final String? selectedCity;
  final List<HotelCityHotel> cities;
  final Function(String, String) onCitySelected;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;

  const CityBottomSheet({
    super.key,
    required this.isLoading,
    required this.selectedCity,
    required this.cities,
    required this.onCitySelected,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
  });

  @override
  State<CityBottomSheet> createState() => _CityBottomSheetState();
}

class _CityBottomSheetState extends State<CityBottomSheet> {
  late List<HotelCityHotel> filteredCities;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCities = List.from(widget.cities);
    _searchController.addListener(_filterCities);
  }

  void _filterCities() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredCities = query.isEmpty
          ? List.from(widget.cities)
          : widget.cities.where((c) => c.name.toLowerCase().contains(query)).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    
    return Container(
      height: screenHeight * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        border: Border.all(color: widget.secondaryColor.withOpacity(0.1), width: 1),
      ),
      child: Column(
        children: [
          // Header with drag handle
          Container(
            padding: EdgeInsets.only(top: 16, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
              border: Border(
                bottom: BorderSide(color: Color(0xFFF0F0F0), width: 1),
              ),
            ),
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: widget.secondaryColor,
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Select City",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: widget.primaryColor,
                          ),
                        ),
                      ),
                      if (widget.selectedCity != null)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: widget.secondaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            // border: Border.all(color: widget.secondaryColor.withOpacity(0.3), width: 1),
                          ),
                          child: Text(
                            "Selected",
                            style: TextStyle(
                              color: widget.secondaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Search field
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search cities...",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  prefixIcon: Icon(Iconsax.search_normal, color: widget.secondaryColor),
                  filled: true,
                  fillColor: Colors.white,
                
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                ),
              ),
            ),
          ),
          
          // Cities list
          Expanded(
            child: widget.isLoading
                ? _buildShimmerList()
                : filteredCities.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: EdgeInsets.only(bottom: 24, left: 24, right: 24),
                        itemCount: filteredCities.length,
                        itemBuilder: (context, index) {
                          final city = filteredCities[index];
                          final isSelected = city.name == widget.selectedCity;
                          
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => widget.onCitySelected(city.name, city.code),
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  padding: EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                    color: isSelected ? widget.secondaryColor.withOpacity(0.1) : Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: isSelected ? widget.secondaryColor.withOpacity(0.0) : Color(0xFFF0F0F0),
                                      width:  1,
                                    ),
                                  
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: isSelected ? widget.secondaryColor.withOpacity(0.15) : Color(0xFFFAFAFA),
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: isSelected ? widget.secondaryColor.withOpacity(0.3) : Color(0xFFF0F0F0),
                                            width: 1,
                                          ),
                                        ),
                                        child: Icon(
                                          Iconsax.buildings,
                                          color: isSelected ? widget.secondaryColor : Color(0xFF999999),
                                          size: 20,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: Text(
                                          city.name,
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: isSelected ? widget.primaryColor : Color(0xFF333333),
                                          ),
                                        ),
                                      ),
                                      if (isSelected)
                                        Icon(
                                          Iconsax.tick_circle,
                                          color: widget.secondaryColor,
                                          size: 24,
                                        ),
                                    ],
                                  ),
                                ),
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

  Widget _buildShimmerList() {
    return ListView.builder(
      padding: EdgeInsets.all(24),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Color(0xFFF0F0F0), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 16,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      height: 12,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Color(0xFFFAFAFA),
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFFF0F0F0), width: 2),
              ),
              child: Icon(
                Iconsax.location_slash,
                size: 50,
                color: Color(0xFF999999),
              ),
            ),
            SizedBox(height: 24),
            Text(
              "No cities found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: widget.primaryColor,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Try selecting a different country or search again",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Guest Selector Bottom Sheet
class GuestSelectorBottomSheet extends StatefulWidget {
  final int totalAdults;
  final int totalChildren;
  final List<int> childrenAges;
  final List<Map<String, dynamic>> rooms;
  final Function(int, int, List<int>, List<Map<String, dynamic>>) onGuestsChanged;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;
  final Color borderColor;

  const GuestSelectorBottomSheet({
    super.key,
    required this.totalAdults,
    required this.totalChildren,
    required this.childrenAges,
    required this.rooms,
    required this.onGuestsChanged,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
    required this.borderColor,
  });

  @override
  State<GuestSelectorBottomSheet> createState() => _GuestSelectorBottomSheetState();
}

class _GuestSelectorBottomSheetState extends State<GuestSelectorBottomSheet> {
  late List<Map<String, dynamic>> rooms;
  late int totalAdults;
  late int totalChildren;
  late List<int> childrenAges;

  @override
  void initState() {
    super.initState();
    rooms = widget.rooms.isNotEmpty ? 
        List.from(widget.rooms) : 
        [
          {'adults': 2, 'children': 0, 'childrenAges': <int>[]}
        ];
    _calculateTotals();
  }

  void _calculateTotals() {
    totalAdults = rooms.fold(0, (sum, room) => sum + (room['adults'] as int));
    totalChildren = rooms.fold(0, (sum, room) => sum + (room['children'] as int));
    
    childrenAges = [];
    for (final room in rooms) {
      if (room['children'] > 0) {
        childrenAges.addAll((room['childrenAges'] as List<int>).cast<int>());
      }
    }
  }

  void updateGuests() {
    _calculateTotals();
    widget.onGuestsChanged(totalAdults, totalChildren, childrenAges, rooms);
  }

  void _addRoom() {
    if (rooms.length >= 4) return; // Max 4 rooms
    setState(() {
      rooms.add({
        'adults': 2,
        'children': 0,
        'childrenAges': <int>[],
      });
    });
    updateGuests();
  }

  void _removeRoom(int index) {
    if (rooms.length > 1) {
      setState(() {
        rooms.removeAt(index);
      });
      updateGuests();
    }
  }

  void _updateRoom(int index, String key, dynamic value) {
    setState(() {
      rooms[index][key] = value;
      
      if (key == 'children') {
        final int newChildrenCount = value;
        final List<int> currentAges = List<int>.from(rooms[index]['childrenAges']);
        
        if (newChildrenCount > currentAges.length) {
          while (currentAges.length < newChildrenCount) {
            currentAges.add(1);
          }
        } else if (newChildrenCount < currentAges.length) {
          currentAges.removeRange(newChildrenCount, currentAges.length);
        }
        rooms[index]['childrenAges'] = currentAges;
      }
    });
    updateGuests();
  }

  void _updateChildAge(int roomIndex, int childIndex, int age) {
    setState(() {
      final List<int> ages = List<int>.from(rooms[roomIndex]['childrenAges']);
      if (childIndex < ages.length) {
        ages[childIndex] = age;
        rooms[roomIndex]['childrenAges'] = ages;
      }
    });
    updateGuests();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    
    return Container(
      height: screenHeight * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        border: Border.all(color: widget.secondaryColor.withOpacity(0.1), width: 1),
      ),
      child: Column(
        children: [
          // Header with drag handle
          Container(
            padding: EdgeInsets.only(top: 18, bottom: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
              border: Border(
                bottom: BorderSide(color: Color(0xFFF0F0F0), width: 1),
              ),
            ),
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: widget.secondaryColor,
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Guests & Rooms",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: widget.primaryColor,
                            ),
                          ),
                          Text(
                            "Configure your stay details",
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF666666),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: widget.secondaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          // border: Border.all(color: widget.secondaryColor.withOpacity(0.3), width: 1),
                        ),
                        child: Row(
                          children: [
                            Icon(Iconsax.home, size: 16, color: widget.secondaryColor),
                            SizedBox(width: 6),
                            Text(
                              "${rooms.length} Room${rooms.length > 1 ? 's' : ''}",
                              style: TextStyle(
                                color: widget.secondaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                              ),
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
          
          // Summary Card
          Padding(
            padding: EdgeInsets.all(0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              decoration: BoxDecoration(
                color: widget.secondaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
                // border: Border.all(color: widget.secondaryColor.withOpacity(0.2)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Guests",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "${totalAdults + totalChildren}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: widget.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Breakdown",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "$totalAdults Adult${totalAdults > 1 ? 's' : ''} • $totalChildren Child${totalChildren > 1 ? 'ren' : ''}",
                        style: TextStyle(
                          fontSize: 14,
                          color: widget.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Rooms List
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 100),
              child: Column(
                children: [
                  ...rooms.asMap().entries.map((entry) {
                    final index = entry.key;
                    final room = entry.value;
                    return _buildRoomCard(index, room);
                  }),
                  
                  // Add Room Button
                  if (rooms.length < 4)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: OutlinedButton(
                      onPressed: _addRoom,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: widget.secondaryColor,
                        side: BorderSide(color: widget.secondaryColor, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                        backgroundColor: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.add_circle, size: 16, color: widget.secondaryColor),
                          SizedBox(width: 10),
                          Text(
                            "Add Another Room",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: widget.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Bottom Action Bar
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: Offset(0, -5),
                ),
              ],
              border: Border(
                top: BorderSide(color: Color(0xFFF0F0F0), width: 1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.secondaryColor,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 18),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Iconsax.tick_circle, size: 22, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          "Apply Selection",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomCard(int index, Map<String, dynamic> room) {
    final int childrenCount = room['children'] as int;
    final int adultsCount = room['adults'] as int;
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        // border: Border.all(color: widget.secondaryColor.withOpacity(0.2), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Room header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: widget.secondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: widget.secondaryColor.withOpacity(0.2), width: 1),
                    ),
                    child: Icon(
                      Iconsax.home_hashtag,
                      color: widget.secondaryColor,
                      size: 16,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Room ${index + 1}",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: widget.primaryColor,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "$adultsCount Adult${adultsCount > 1 ? 's' : ''}, $childrenCount Child${childrenCount > 1 ? 'ren' : ''}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (rooms.length > 1)
              IconButton(
                onPressed: () => _removeRoom(index),
                icon: Icon(Iconsax.trash, color: Color(0xFFDC2626), size: 22),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                tooltip: "Remove Room",
              ),
            ],
          ),
          
          SizedBox(height: 20),
          
          // Adults and Children counters
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Adults",
                      style: TextStyle(
                        fontSize: 12,
                        color: widget.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    _buildCounter(
                      value: adultsCount,
                      minValue: 1,
                      maxValue: 4,
                      onIncrement: () => _updateRoom(index, 'adults', adultsCount + 1),
                      onDecrement: () {
                        if (adultsCount > 1) {
                          _updateRoom(index, 'adults', adultsCount - 1);
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Children",
                      style: TextStyle(
                        fontSize: 12,
                        color: widget.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 12),
                    _buildCounter(
                      value: childrenCount,
                      minValue: 0,
                      maxValue: 3,
                      onIncrement: () => _updateRoom(index, 'children', childrenCount + 1),
                      onDecrement: () {
                        if (childrenCount > 0) {
                          _updateRoom(index, 'children', childrenCount - 1);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          // Children Ages if children > 0
          if (childrenCount > 0) ...[
            SizedBox(height: 24),
            Text(
              "Children's Ages (1-17 years)",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: widget.primaryColor,
              ),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: List.generate(childrenCount, (childIndex) {
                final currentAge = (room['childrenAges'] as List<int>)[childIndex];
                return SizedBox(
                  width: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Child ${childIndex + 1}",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: widget.secondaryColor.withOpacity(0.3), width: 1.5),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: currentAge,
                            isExpanded: true,
                            icon: Icon(Iconsax.arrow_down_1, size: 18, color: widget.secondaryColor),
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            dropdownColor: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            style: TextStyle(
                              fontSize: 14,
                              color: widget.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                            items: List.generate(17, (age) => age + 1)
                                .map((age) => DropdownMenuItem(
                                      value: age,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8),
                                        child: Text("$age years", style: TextStyle(color: widget.primaryColor)),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                _updateChildAge(index, childIndex, value);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCounter({
    required int value,
    required int minValue,
    required int maxValue,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.secondaryColor.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: value > minValue ? onDecrement : null,
            icon: Icon(
              Iconsax.minus,
              color: value > minValue ? widget.secondaryColor : Color(0xFFD1D5DB),
              size: 20,
            ),
            padding: EdgeInsets.all(10),
            constraints: BoxConstraints(),
          ),
          Expanded(
            child: Center(
              child: Text(
                value.toString(),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: widget.primaryColor,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: value < maxValue ? onIncrement : null,
            icon: Icon(
              Iconsax.add,
              color: value < maxValue ? widget.secondaryColor : Color(0xFFD1D5DB),
              size: 16,
            ),
            padding: EdgeInsets.all(10),
            constraints: BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

// Country Bottom Sheet
class CountryBottomSheet extends StatefulWidget {
  final bool isLoading;
  final String? selectedCountry;
  final Function(String) onCountrySelected;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;

  const CountryBottomSheet({
    super.key,
    required this.isLoading,
    required this.selectedCountry,
    required this.onCountrySelected,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
  });

  @override
  State<CountryBottomSheet> createState() => _CountryBottomSheetState();
}

class _CountryBottomSheetState extends State<CountryBottomSheet> {
  late List<String> filteredCountries;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCountries = countries.map((e) => e.name).toList();
    _searchController.addListener(_filterCountries);
  }

 void _filterCountries() {
  final query = _searchController.text.toLowerCase();

  setState(() {
    filteredCountries = query.isEmpty
        ? countries.map((e) => e.name).toList()
        : countries
            .where((e) => e.name.toLowerCase().contains(query))
            .map((e) => e.name)
            .toList();
  });
}

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    
    return Container(
      height: screenHeight * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        border: Border.all(color: widget.secondaryColor.withOpacity(0.1), width: 1),
      ),
      child: Column(
        children: [
          // Header with drag handle
          Container(
            padding: EdgeInsets.only(top: 18, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
              border: Border(
                bottom: BorderSide(color: Color(0xFFF0F0F0), width: 1),
              ),
            ),
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: widget.secondaryColor,
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Select Country",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: widget.primaryColor,
                          ),
                        ),
                      ),
                      if (widget.selectedCountry != null)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: widget.secondaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "Selected",
                            style: TextStyle(
                              color: widget.secondaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Search field
          Padding(
            padding: EdgeInsets.all(24),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search countries...",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  prefixIcon: Icon(Iconsax.search_normal, color: widget.secondaryColor),
                  filled: true,
                  fillColor: Colors.white,
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(16),
                  //   borderSide: BorderSide(color: widget.secondaryColor.withOpacity(0.3), width: 1),
                  // ),
                  // focusedBorder: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(16),
                  //   borderSide: BorderSide(color: widget.accentColor, width: 1.5),
                  // ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                ),
              ),
            ),
          ),
          
          // Countries list
          Expanded(
            child: widget.isLoading
                ? _buildShimmerList()
                : filteredCountries.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: EdgeInsets.only(bottom: 24, left: 24, right: 24),
                        itemCount: filteredCountries.length,
                        itemBuilder: (context, index) {
                          final country = filteredCountries[index];
                          final isSelected = country == widget.selectedCountry;
                          
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => widget.onCountrySelected(country),
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  padding: EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                    color: isSelected ? widget.secondaryColor.withOpacity(0.1) : Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: isSelected ? widget.secondaryColor.withOpacity(0.0) : Color(0xFFF0F0F0),
                                      width: 1,
                                    ),
                                 
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: isSelected ? widget.secondaryColor.withOpacity(0.15) : Color(0xFFFAFAFA),
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: isSelected ? widget.secondaryColor.withOpacity(0.3) : Color(0xFFF0F0F0),
                                            width: 1,
                                          ),
                                        ),
                                        child: Icon(
                                          Iconsax.flag,
                                          color: isSelected ? widget.secondaryColor : Color(0xFF999999),
                                          size: 20,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: Text(
                                          country,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: isSelected ? widget.primaryColor : Color(0xFF333333),
                                          ),
                                        ),
                                      ),
                                      if (isSelected)
                                        Icon(
                                          Iconsax.tick_circle,
                                          color: widget.secondaryColor,
                                          size: 20,
                                        ),
                                    ],
                                  ),
                                ),
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

  Widget _buildShimmerList() {
    return ListView.builder(
      padding: EdgeInsets.all(24),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Color(0xFFF0F0F0), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Color(0xFFFAFAFA),
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFFF0F0F0), width: 2),
              ),
              child: Icon(
                Iconsax.search_status,
                size: 50,
                color: Color(0xFF999999),
              ),
            ),
            SizedBox(height: 24),
            Text(
              "No countries found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: widget.primaryColor,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Try searching with different keywords",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
              ),
            ),
          ],
        ),
      ),
    );
  }
}