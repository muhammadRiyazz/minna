
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Hotel Booking',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: maincolor1,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFF8FAFF),
                Color(0xFFEFF4FF),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section
                    _buildHeaderSection(),
                    const SizedBox(height: 30),
                    
                    // Search Cards Section
                    _buildSearchCardsSection(),
                    const SizedBox(height: 32),
                    
                    // Search Button
                    _buildSearchButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Find Your Perfect Stay",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.grey[900],
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Discover luxury hotels at the best prices",          textAlign: TextAlign.center,

          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchCardsSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
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
          const SizedBox(height: 20),
          
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
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDisabled ? Colors.grey[50] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDisabled ? Colors.grey[200]! : Colors.blue.withOpacity(0.2),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDisabled ? Colors.grey[200] : maincolor1!.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isDisabled ? Colors.grey : maincolor1,
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
                      fontSize: 14,
                      color: isDisabled ? Colors.grey : Colors.grey[600],
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
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDisabled ? Colors.grey[400] : Colors.grey[900],
                      ),
                    ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: isDisabled ? Colors.grey[300] : Colors.grey[500],
              size: 16,
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
          backgroundColor: maincolor1,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
          shadowColor: maincolor1!.withOpacity(0.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_rounded,
              size: 20,
            ),
            const SizedBox(width: 8),
            const Text(
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
}

// ====== Country Bottom Sheet ======
class CountryBottomSheet extends StatefulWidget {
  final bool isLoading;
  final String? selectedCountry;
  final Function(String) onCountrySelected;

  const CountryBottomSheet({
    super.key,
    required this.isLoading,
    required this.selectedCountry,
    required this.onCountrySelected,
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
          const Text(
            "Select Country",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          
          // Search Box
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search countries...",
              prefixIcon: const Icon(Icons.search_rounded, color: Colors.grey),
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
                          
                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isSelected ? maincolor1!.withOpacity(0.1) : Colors.grey[50],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.flag_rounded,
                                color: isSelected ? maincolor1 : Colors.grey,
                              ),
                            ),
                            title: Text(
                              country,
                              style: TextStyle(
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                color: isSelected ? maincolor1 : Colors.grey[800],
                              ),
                            ),
                            trailing: isSelected
                                ? Icon(Icons.check_circle_rounded, color: maincolor1)
                                : null,
                            onTap: () => widget.onCountrySelected(country),
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

  const CityBottomSheet({
    super.key,
    required this.isLoading,
    required this.selectedCity,
    required this.cities,
    required this.onCitySelected,
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
          const Text(
            "Select City",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          
          // Search Box
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search cities...",
              prefixIcon: const Icon(Icons.search_rounded, color: Colors.grey),
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
                          
                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isSelected ? maincolor1!.withOpacity(0.1) : Colors.grey[50],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.location_city_rounded,
                                color: isSelected ? maincolor1 : Colors.grey,
                              ),
                            ),
                            title: Text(
                              city,
                              style: TextStyle(
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                color: isSelected ? maincolor1 : Colors.grey[800],
                              ),
                            ),
                            trailing: isSelected
                                ? Icon(Icons.check_circle_rounded, color: maincolor1)
                                : null,
                            onTap: () => widget.onCitySelected(city),
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