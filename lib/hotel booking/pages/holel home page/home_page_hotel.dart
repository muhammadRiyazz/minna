import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/hotel%20booking/domain/Nation%20and%20city/city.dart';
import 'package:minna/hotel%20booking/domain/Nation%20and%20city/nation';
import 'package:minna/hotel%20booking/functions/get_city_and_nation.dart';
import 'package:minna/hotel%20booking/pages/hotel%20list/hotel_list.dart';

class HotelBookingHome extends StatefulWidget {
  const HotelBookingHome({super.key});

  @override
  State<HotelBookingHome> createState() => _HotelBookingHomeState();
}

class _HotelBookingHomeState extends State<HotelBookingHome> {
  String? selectedCountry;
  String? selectedCity;

  List<CountryModel> countries = [];
  List<HotelCityHotel> cities = [];

  bool isLoadingCountries = false; // We load in bottom sheet
  bool isLoadingCities = false;

  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    // Fetch countries in background
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    setState(() => isLoadingCountries = true);
    try {
      countries = await apiService.getCountries();
      if (countries.isNotEmpty) {
        // selectedCountry ??= countries.first.name;
        // await fetchCities(selectedCountry!);
      }
    } catch (e) {
      debugPrint('Error fetching countries: $e');
    } finally {
      setState(() => isLoadingCountries = false);
    }
  }

  Future<void> fetchCities(String countryName) async {
    setState(() => isLoadingCities = true);
    try {
      final countryCode =
          countries.firstWhere((c) => c.name == countryName).code;
      cities = await apiService.getCities(countryCode);
      if (cities.isNotEmpty) {
        selectedCity ??= cities.first.name;
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
      builder: (context) => Container(
        margin: const EdgeInsets.only(top: 50),
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: isLoadingCountries
            ? const Center(child: CircularProgressIndicator())
            : CountrySelectionSheet(
                countries: countries.map((e) => e.name).toList(),
                selectedCountry: selectedCountry ?? "",
                onCountrySelected: (country) async {
                  setState(() {
                    selectedCountry = country;
                    selectedCity = null;
                    cities = [];
                    isLoadingCities = true;
                  });
                  Navigator.pop(context);
                  await fetchCities(country);
                },
              ),
      ),
    );
  }

  void _showCityBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: const EdgeInsets.only(top: 50),
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: isLoadingCities
            ? const Center(child: CircularProgressIndicator())
            : CitySelectionSheet(
                cities: cities.map((e) => e.name).toList(),
                selectedCity: selectedCity ?? "",
                onCitySelected: (city) {
                  setState(() {
                    selectedCity = city;
                  });
                  Navigator.pop(context);
                },
              ),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 80, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Find Your Perfect Stay",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 4),
              const Text(
                "Discover luxury hotels at the best prices",
                style: TextStyle(fontSize: 16, color: Colors.black38),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: _buildLocationCard(
                      title: "Country",
                      value: selectedCountry ?? "Select Country",
                      icon: Icons.flag,
                      onTap: _showCountryBottomSheet,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildLocationCard(
                      title: "City",
                      value: selectedCity ?? (isLoadingCities ? "Loading..." : "Select City"),
                      icon: Icons.location_city,
                      onTap: _showCityBottomSheet,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                onPressed: (selectedCountry != null && selectedCity != null)
      ? () {
          final cityCode = cities.firstWhere((c) => c.name == selectedCity!).code;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HotelListPage(cityCode: cityCode, cityName: selectedCity!),
            ),
          );
        }
      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: maincolor1,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    "Search Hotels",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationCard({
    required String title,
    required String value,
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 194, 194, 194).withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue, size: 20),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// ====== Country Bottom Sheet ======
class CountrySelectionSheet extends StatefulWidget {
  final List<String> countries;
  final String selectedCountry;
  final Function(String) onCountrySelected;

  const CountrySelectionSheet({
    super.key,
    required this.countries,
    required this.selectedCountry,
    required this.onCountrySelected,
  });

  @override
  State<CountrySelectionSheet> createState() => _CountrySelectionSheetState();
}

class _CountrySelectionSheetState extends State<CountrySelectionSheet> {
  late List<String> filteredCountries;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCountries = widget.countries;
    _searchController.addListener(_filterCountries);
  }

  void _filterCountries() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredCountries = query.isEmpty
          ? widget.countries
          : widget.countries.where((c) => c.toLowerCase().contains(query)).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(5)),
          ),
        ),
        const SizedBox(height: 16),
        const Text("Select Country", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: "Search countries...",
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: filteredCountries.length,
            itemBuilder: (context, index) {
              final country = filteredCountries[index];
              return ListTile(
                title: Text(country),
                trailing: country == widget.selectedCountry ? const Icon(Icons.check, color: Colors.blue) : null,
                onTap: () => widget.onCountrySelected(country),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ====== City Bottom Sheet ======
class CitySelectionSheet extends StatefulWidget {
  final List<String> cities;
  final String selectedCity;
  final Function(String) onCitySelected;

  const CitySelectionSheet({
    super.key,
    required this.cities,
    required this.selectedCity,
    required this.onCitySelected,
  });

  @override
  State<CitySelectionSheet> createState() => _CitySelectionSheetState();
}

class _CitySelectionSheetState extends State<CitySelectionSheet> {
  late List<String> filteredCities;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCities = widget.cities;
    _searchController.addListener(_filterCities);
  }

  void _filterCities() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredCities = query.isEmpty
          ? widget.cities
          : widget.cities.where((c) => c.toLowerCase().contains(query)).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(5)),
          ),
        ),
        const SizedBox(height: 16),
        const Text("Select City", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: "Search cities...",
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: filteredCities.length,
            itemBuilder: (context, index) {
              final city = filteredCities[index];
              return ListTile(
                title: Text(city),
                trailing: city == widget.selectedCity ? const Icon(Icons.check, color: Colors.blue) : null,
                onTap: () => widget.onCitySelected(city),
              );
            },
          ),
        ),
      ],
    );
  }
}
