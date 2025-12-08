import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/hotel%20booking/domain/Nation%20and%20city/city.dart';
import 'package:minna/hotel%20booking/domain/Nation%20and%20city/nation';
import 'package:minna/hotel%20booking/functions/get_city_and_nation.dart';
import 'package:minna/hotel%20booking/pages/hotel%20list/hotel_list.dart';

List<CountryModel> countries = [];

class HotelBookingHome extends StatefulWidget {
  const HotelBookingHome({super.key});

  @override
  State<HotelBookingHome> createState() => _HotelBookingHomeState();
}

class _HotelBookingHomeState extends State<HotelBookingHome> {
  String? selectedCountry;
  String? selectedCity;

  List<HotelCityHotel> cities = [];
  bool _countriesLoaded = false;

  bool isLoadingCountries = false;
  bool isLoadingCities = false;

  final ApiService apiService = ApiService();

  // Color Theme - Consistent throughout
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37); // Gold
  final Color _accentColor = Color(0xFFC19B3C); // Darker Gold
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);

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
      final countryCode = countries.firstWhere((c) => c.name == countryName).code;
      cities = await apiService.getCities(countryCode);
      if (cities.isNotEmpty) {
        selectedCity = cities.first.name;
      } else {
        selectedCity = null;
      }
    } catch (e) {
      log('Error fetching cities: $e');
      selectedCity = null;
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
      builder: (context) => CountryBottomSheet(
        isLoading: isLoadingCountries,
        selectedCountry: selectedCountry,
        onCountrySelected: (country) async {
          Navigator.pop(context);
          if (country != selectedCountry) {
            setState(() {
              selectedCountry = country;
              selectedCity = null;
              cities = [];
            });
            await fetchCities(country);
          }
        },
        primaryColor: _primaryColor,
        secondaryColor: _secondaryColor,
      ),
    );
  }

  void _showCityBottomSheet() {
    if (selectedCountry == null || isLoadingCities) return;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CityBottomSheet(
        isLoading: isLoadingCities,
        selectedCity: selectedCity,
        cities: cities,
        onCitySelected: (city) {
          setState(() => selectedCity = city);
          Navigator.pop(context);
        },
        primaryColor: _primaryColor,
        secondaryColor: _secondaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            backgroundColor: _primaryColor,
            expandedHeight: 140,
            floating: false,
            pinned: true,
            elevation: 4,   leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            shadowColor: Colors.black.withOpacity(0.3),
            surfaceTintColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Hotel Booking',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [_primaryColor,],
                  ),
                ),
              ),
            ),
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.vertical(
            //     bottom: Radius.circular(20),
            //   ),
            // ),
          ),

          // Main Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                                    const SizedBox(height: 5),

                  _buildHeaderSection(),
                  const SizedBox(height: 20),
                  
                  // Search Cards Section
                  _buildSearchCardsSection(),
                  const SizedBox(height: 15),
                  
                  // Search Button
                  _buildSearchButton(),
                  
                  // Features Section
                  _buildFeaturesSection(),
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
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(

        color: _primaryColor,
        // gradient: LinearGradient(
        //   colors: [_primaryColor, Color(0xFF2D2D2D)],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _secondaryColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.hotel_rounded,
              color: _secondaryColor,
              size: 22,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Find Your Perfect Stay",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Discover luxury hotels at the best prices",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
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
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Country Card
          _buildLocationCard(
            title: "Country",
            value: selectedCountry ?? "Select Country",
            icon: Icons.flag_rounded,
            isLoading: isLoadingCountries,
            onTap: _showCountryBottomSheet,
          ),
          const SizedBox(height: 15),
          
          // City Card
          _buildLocationCard(
            title: "City",
            value: selectedCity ?? (isLoadingCities ? "Loading cities..." : "Select City"),
            icon: Icons.location_city_rounded,
            isLoading: isLoadingCities,
            onTap: _showCityBottomSheet,
            isDisabled: selectedCountry == null || isLoadingCities,
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
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isDisabled ? Colors.grey[50] : _cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDisabled ? Colors.grey[200]! : _secondaryColor.withOpacity(0.2),
            width: 2,
          ),
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
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDisabled ? Colors.grey[200] : _secondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isDisabled ? Colors.grey : _secondaryColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDisabled ? Colors.grey : _textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (isLoading)
                    _buildShimmerText()
                  else
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDisabled ? Colors.grey[400] : _textPrimary,
                      ),
                    ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isDisabled ? Colors.grey[100] : _backgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: isDisabled ? Colors.grey[300] : _textLight,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerText() {
    return Container(
      height: 20,
      width: 120,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildSearchButton() {
    final isEnabled = selectedCountry != null && selectedCity != null && !isLoadingCities;
    
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isEnabled
            ? () {
                final cityCode = cities.firstWhere((c) => c.name == selectedCity!).code;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HotelListPage(
                      cityCode: cityCode,
                      cityName: selectedCity!,
                    ),
                  ),
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? _primaryColor : Colors.grey[400],
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
          shadowColor: isEnabled ? _primaryColor.withOpacity(0.3) : Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_rounded,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              "Search Hotels",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesSection() {
    final features = [
      {
        'icon': Icons.star_rounded,
        'title': 'Best Prices',
        'subtitle': 'Guaranteed lowest rates'
      },
      {
        'icon': Icons.verified_user_rounded,
        'title': 'Verified Stays',
        'subtitle': 'Quality assured hotels'
      },
      {
        'icon': Icons.support_agent_rounded,
        'title': '24/7 Support',
        'subtitle': 'Always here to help'
      },
    ];

    return Container(
      margin: EdgeInsets.only(top: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Why Book With Us",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _textPrimary,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: features.map((feature) {
              return Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _cardColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _secondaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          feature['icon'] as IconData,
                          color: _secondaryColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        feature['title'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4),
                      Text(
                        feature['subtitle'] as String,
                        style: TextStyle(
                          fontSize: 10,
                          color: _textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ====== Country Bottom Sheet ======
class CountryBottomSheet extends StatefulWidget {
  final bool isLoading;
  final String? selectedCountry;
  final Function(String) onCountrySelected;
  final Color primaryColor;
  final Color secondaryColor;

  const CountryBottomSheet({
    super.key,
    required this.isLoading,
    required this.selectedCountry,
    required this.onCountrySelected,
    required this.primaryColor,
    required this.secondaryColor,
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
          : countries.map((e) => e.name).where((c) => c.toLowerCase().contains(query)).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 60),
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 48,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Title
          Text(
            "Select Country",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: widget.primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          
          // Search Box
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search countries...",
              prefixIcon: Icon(Icons.search_rounded, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[50],
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
          const SizedBox(height: 20),
          
          // List
          Expanded(
            child: widget.isLoading
                ? _buildShimmerList()
                : filteredCountries.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        itemCount: filteredCountries.length,
                        itemBuilder: (context, index) {
                          final country = filteredCountries[index];
                          final isSelected = country == widget.selectedCountry;
                          
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              color: isSelected ? widget.secondaryColor.withOpacity(0.1) : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              leading: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: isSelected ? widget.secondaryColor.withOpacity(0.2) : Colors.grey[50],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.flag_rounded,
                                  color: isSelected ? widget.secondaryColor : Colors.grey,
                                ),
                              ),
                              title: Text(
                                country,
                                style: TextStyle(
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                  color: isSelected ? widget.primaryColor : Colors.grey[800],
                                ),
                              ),
                              trailing: isSelected
                                  ? Icon(Icons.check_circle_rounded, color: widget.secondaryColor)
                                  : null,
                              onTap: () => widget.onCountrySelected(country),
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
      itemCount: 8,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 16,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 12,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            "No countries found",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ====== City Bottom Sheet ======
class CityBottomSheet extends StatefulWidget {
  final bool isLoading;
  final String? selectedCity;
  final List<HotelCityHotel> cities;
  final Function(String) onCitySelected;
  final Color primaryColor;
  final Color secondaryColor;

  const CityBottomSheet({
    super.key,
    required this.isLoading,
    required this.selectedCity,
    required this.cities,
    required this.onCitySelected,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  State<CityBottomSheet> createState() => _CityBottomSheetState();
}

class _CityBottomSheetState extends State<CityBottomSheet> {
  late List<String> filteredCities;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCities = widget.cities.map((e) => e.name).toList();
    _searchController.addListener(_filterCities);
  }

  void _filterCities() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredCities = query.isEmpty
          ? widget.cities.map((e) => e.name).toList()
          : widget.cities.map((e) => e.name).where((c) => c.toLowerCase().contains(query)).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 60),
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 48,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Title
          Text(
            "Select City",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: widget.primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          
          // Search Box
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search cities...",
              prefixIcon: Icon(Icons.search_rounded, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[50],
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
          const SizedBox(height: 20),
          
          // List
          Expanded(
            child: widget.isLoading
                ? _buildShimmerList()
                : filteredCities.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        itemCount: filteredCities.length,
                        itemBuilder: (context, index) {
                          final city = filteredCities[index];
                          final isSelected = city == widget.selectedCity;
                          
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              color: isSelected ? widget.secondaryColor.withOpacity(0.1) : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              leading: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: isSelected ? widget.secondaryColor.withOpacity(0.2) : Colors.grey[50],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.location_city_rounded,
                                  color: isSelected ? widget.secondaryColor : Colors.grey,
                                ),
                              ),
                              title: Text(
                                city,
                                style: TextStyle(
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                  color: isSelected ? widget.primaryColor : Colors.grey[800],
                                ),
                              ),
                              trailing: isSelected
                                  ? Icon(Icons.check_circle_rounded, color: widget.secondaryColor)
                                  : null,
                              onTap: () => widget.onCitySelected(city),
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
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_off_rounded,
            size: 64,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            "No cities found",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Try selecting a different country",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}