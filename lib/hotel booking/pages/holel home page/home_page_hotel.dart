import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minna/comman/const/const.dart';




class HotelBookingHome extends StatefulWidget {
  const HotelBookingHome({super.key});

  @override
  State<HotelBookingHome> createState() => _HotelBookingHomeState();
}

class _HotelBookingHomeState extends State<HotelBookingHome> {
  String selectedCountry = "India";
  String selectedCity = "Mumbai";

  // Sample data
  final List<String> countries = [
    "India",
    "United States",
    "United Kingdom",
    "France",
    "Germany",
    "Japan",
    "Australia",
    "Canada",
    "Brazil",
    "Mexico",
    "Spain",
    "Italy",
    "Thailand",
    "Singapore",
    "Dubai",
  ];

  final Map<String, List<String>> citiesByCountry = {
    "India": ["Mumbai", "Delhi", "Bangalore", "Chennai", "Kolkata", "Hyderabad"],
    "United States": ["New York", "Los Angeles", "Chicago", "Houston", "Phoenix"],
    "United Kingdom": ["London", "Manchester", "Liverpool", "Birmingham", "Edinburgh"],
    "France": ["Paris", "Marseille", "Lyon", "Toulouse", "Nice"],
    "Germany": ["Berlin", "Munich", "Hamburg", "Frankfurt", "Cologne"],
  };

  void _showCountryBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CountrySelectionSheet(
        countries: countries,
        selectedCountry: selectedCountry,
        onCountrySelected: (country) {
          setState(() {
            selectedCountry = country;
            // Reset city when country changes
            selectedCity = citiesByCountry[country]?.first ?? "";
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showCityBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CitySelectionSheet(
        cities: citiesByCountry[selectedCountry] ?? [],
        selectedCity: selectedCity,
        onCitySelected: (city) {
          setState(() {
            selectedCity = city;
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.amberAccent,
      // extendBodyBehindAppBar: true,
      appBar:  AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Hotel Booking',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: maincolor1,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      
      
      
      
   
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 80, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome message
              const Text(
                "Find Your Perfect Stay",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Discover luxury hotels at the best prices",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black38,
                ),
              ),
              
              const SizedBox(height: 40),
            
              
              
              // Location selection cards
              Row(
                children: [
                  Expanded(
                    child: _buildLocationCard(
                      title: "Country",
                      value: selectedCountry,
                      icon: Icons.flag,
                      onTap: _showCountryBottomSheet,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildLocationCard(
                      title: "City",
                      value: selectedCity,
                      icon: Icons.location_city,
                      onTap: _showCityBottomSheet,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Search hotels button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle search
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: maincolor1,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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
    required VoidCallback onTap,
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
                Text(
                  title,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }



  


}


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
      if (query.isEmpty) {
        filteredCountries = widget.countries;
      } else {
        filteredCountries = widget.countries
            .where((country) => country.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.only(top: 50),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Select Country",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search countries...",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
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
                  trailing: country == widget.selectedCountry
                      ? const Icon(Icons.check, color: Colors.blue)
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
}
















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
      if (query.isEmpty) {
        filteredCities = widget.cities;
      } else {
        filteredCities = widget.cities
            .where((city) => city.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.only(top: 50),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Select City",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search cities...",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
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
                  trailing: city == widget.selectedCity
                      ? const Icon(Icons.check, color: Colors.blue)
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
}