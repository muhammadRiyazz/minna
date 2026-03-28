import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iconsax/iconsax.dart';
import 'package:minna/comman/const/const.dart';
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
  CountryModel? guestNationality; // Added for Nationality
  DateTime checkInDate = DateTime.now();
  DateTime checkOutDate = DateTime.now().add(const Duration(days: 1));

  // Updated to support multiple rooms
  List<Map<String, dynamic>> rooms = [
    {'adults': 2, 'children': 0, 'childrenAges': <int>[]},
  ];

  List<HotelCityHotel> cities = [];
  bool _countriesLoaded = false;

  bool isLoadingCountries = false;
  bool isLoadingCities = false;

  final HotelApiService apiService = HotelApiService();

  // Format date getters
  String get formattedCheckIn => DateFormat('MMM dd, yyyy').format(checkInDate);
  String get formattedCheckOut =>
      DateFormat('MMM dd, yyyy').format(checkOutDate);

  // Calculate totals from rooms
  int get totalAdults =>
      rooms.fold(0, (sum, room) => sum + (room['adults'] as int));
  int get totalChildren =>
      rooms.fold(0, (sum, room) => sum + (room['children'] as int));
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

  static const Color _borderColor = Color(0xFFE0E0E0);

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
      ),
    );
  }

  void _showNationalityBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (context) => CountryBottomSheet(
        isLoading: isLoadingCountries,
        selectedCountry: guestNationality?.name,
        onCountrySelected: (name) {
          Navigator.pop(context);
          if (name != guestNationality?.name) {
            final country = countries.firstWhere((c) => c.name == name);
            setState(() {
              guestNationality = country;
            });
          }
        },
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
              primary: secondaryColor,
              onPrimary: Colors.white,
              surface: cardColor,
            ),
            dialogBackgroundColor: cardColor,
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
              primary: secondaryColor,
              onPrimary: Colors.white,
              surface: cardColor,
            ),
            dialogBackgroundColor: cardColor,
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
        borderColor: _borderColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: maincolor1,
            expandedHeight: 220,
            floating: false,
            pinned: true,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Iconsax.arrow_left_2,
                color: Colors.white,
                size: 24,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Hero Background Image
                  Image.network(
                    'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&q=80&w=1000',
                    fit: BoxFit.cover,
                  ),
                  // Premium Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          maincolor1.withOpacity(0.3),
                          maincolor1.withOpacity(0.8),
                          maincolor1,
                        ],
                        stops: const [0.0, 0.7, 1.0],
                      ),
                    ),
                  ),
                  // Header Content
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            "EXCEPTIONAL STAYS",
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Find Your Perfect\nHotel",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              height: 1.2,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(0, 2),
                                  blurRadius: 4,
                                ),
                              ],
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

          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -1),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: Column(
                  children: [
                    _buildSearchCardsSection(),
                    const SizedBox(height: 20),
                    _buildSearchButton(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchCardsSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: maincolor1.withOpacity(0.08),
              blurRadius: 30,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(color: Colors.grey.shade50, width: 1.5),
        ),
        child: Column(
          children: [
            // Country & City Selection
            _buildLocationCard(
              title: "Country",
              value: selectedCountry?.name ?? "Select Country",
              icon: Iconsax.flag,
              isLoading: isLoadingCountries,
              onTap: _showCountryBottomSheet,
              isBold: true,
            ),
            const SizedBox(height: 16),
            _buildLocationCard(
              title: "City",
              value: selectedCity ?? (isLoadingCities ? "..." : "Select City"),
              icon: Iconsax.buildings,
              isLoading: isLoadingCities,
              onTap: _showCityBottomSheet,
              isDisabled: selectedCountry == null || isLoadingCities,
              isBold: true,
            ),
            const SizedBox(height: 16),

            // Guest Nationality Card
            _buildLocationCard(
              title: "Guest Nationality",
              value: guestNationality?.name ?? "Select Nationality",
              icon: Iconsax.global,
              isLoading: isLoadingCountries,
              onTap: _showNationalityBottomSheet,
            ),
            const SizedBox(height: 16),

            // Dates Row
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
    bool isBold = false,
  }) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isDisabled ? Colors.grey[50] : cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDisabled ? _borderColor : secondaryColor.withOpacity(0.15),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDisabled
                    ? _borderColor.withOpacity(0.3)
                    : secondaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isDisabled ? Colors.grey[400] : secondaryColor,
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
                      fontSize: 10,
                      color: isDisabled ? Colors.grey[400] : textSecondary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  if (isLoading)
                    Container(
                      height: 14,
                      width: 80,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    )
                  else
                    Text(
                      value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isBold ? FontWeight.w900 : FontWeight.w700,
                        color: isDisabled ? Colors.grey[400] : maincolor1,
                      ),
                    ),
                ],
              ),
            ),
            Icon(
              Iconsax.arrow_right_3,
              color: isDisabled
                  ? Colors.grey[300]
                  : secondaryColor.withOpacity(0.5),
              size: 16,
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
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: secondaryColor.withOpacity(0.15), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: secondaryColor, size: 14),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10,
                    color: textSecondary,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w900,
                color: maincolor1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchButton() {
    final isEnabled =
        selectedCountry != null &&
        selectedCity != null &&
        selectedCityCode != null &&
        guestNationality != null &&
        !isLoadingCities;

    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),

        color: isEnabled ? maincolor1 : _borderColor,
      ),
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
                      guestNationalityCode: guestNationality!.code,
                    ),
                  ),
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Iconsax.search_normal_1, size: 22, color: Colors.white),
            const SizedBox(width: 12),
            const Text(
              "Search Hotels",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
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
          : widget.cities
                .where((c) => c.name.toLowerCase().contains(query))
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
      height: screenHeight * 0.87,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with drag handle
          Container(
            padding: const EdgeInsets.only(top: 12, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
              border: Border(
                bottom: BorderSide(
                  color: maincolor1.withOpacity(0.05),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: secondaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Iconsax.map,
                          color: secondaryColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Select City",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: maincolor1,
                                letterSpacing: -0.5,
                              ),
                            ),
                            Text(
                              "Where would you like to stay?",
                              style: TextStyle(
                                fontSize: 10,
                                color: textSecondary,
                                fontWeight: FontWeight.w500,
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

          // Search field
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey[200]!, width: 1),
              ),
              child: TextField(
                controller: _searchController,
                cursorColor: secondaryColor,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: maincolor1,
                ),
                decoration: InputDecoration(
                  hintText: "Search cities...",
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: Icon(
                    Iconsax.search_normal,
                    color: secondaryColor,
                    size: 20,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
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
                    padding: const EdgeInsets.all(24),
                    itemCount: filteredCities.length,
                    itemBuilder: (context, index) {
                      final city = filteredCities[index];
                      final isSelected = city.name == widget.selectedCity;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () =>
                                widget.onCitySelected(city.name, city.code),
                            borderRadius: BorderRadius.circular(16),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? maincolor1.withOpacity(0.02)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                // border: Border.all(
                                //   color: isSelected
                                //       ? secondaryColor.withOpacity(0.3)
                                //       : Colors.grey[100]!,
                                //   width: isSelected ? 1.5 : 1,
                                // ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: secondaryColor.withOpacity(
                                            0.05,
                                          ),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ]
                                    : [],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? secondaryColor.withOpacity(0.1)
                                          : Colors.grey[50],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      Iconsax.buildings,
                                      color: isSelected
                                          ? secondaryColor
                                          : Colors.grey[400],
                                      size: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          city.name,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: isSelected
                                                ? FontWeight.w900
                                                : FontWeight.w600,
                                            color: isSelected
                                                ? maincolor1
                                                : Colors.grey[800],
                                          ),
                                        ),
                                        Text(
                                          "Available Hotels",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: textSecondary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isSelected)
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: secondaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    )
                                  else
                                    Icon(
                                      Iconsax.arrow_right_3,
                                      color: Colors.grey[300],
                                      size: 16,
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
      padding: const EdgeInsets.all(24),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[100]!, width: 1),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 10,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
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
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Iconsax.location_slash,
                size: 32,
                color: Colors.grey[300],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "No cities found",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: maincolor1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "We couldn't find any results for \"${_searchController.text}\"",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GuestSelectorBottomSheet extends StatefulWidget {
  final int totalAdults;
  final int totalChildren;
  final List<int> childrenAges;
  final List<Map<String, dynamic>> rooms;
  final Function(int, int, List<int>, List<Map<String, dynamic>>)
  onGuestsChanged;
  final Color borderColor;

  const GuestSelectorBottomSheet({
    super.key,
    required this.totalAdults,
    required this.totalChildren,
    required this.childrenAges,
    required this.rooms,
    required this.onGuestsChanged,
    required this.borderColor,
  });

  @override
  State<GuestSelectorBottomSheet> createState() =>
      _GuestSelectorBottomSheetState();
}

class _GuestSelectorBottomSheetState extends State<GuestSelectorBottomSheet> {
  late List<Map<String, dynamic>> rooms;
  late int totalAdults;
  late int totalChildren;
  late List<int> childrenAges;

  @override
  void initState() {
    super.initState();
    rooms = widget.rooms.isNotEmpty
        ? List.from(widget.rooms.map((e) => Map<String, dynamic>.from(e)))
        : [
            {'adults': 2, 'children': 0, 'childrenAges': <int>[]},
          ];
    _calculateTotals();
  }

  void _calculateTotals() {
    totalAdults = rooms.fold(0, (sum, room) => sum + (room['adults'] as int));
    totalChildren = rooms.fold(
      0,
      (sum, room) => sum + (room['children'] as int),
    );

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
    if (rooms.length >= 4) return;
    setState(() {
      rooms.add({'adults': 2, 'children': 0, 'childrenAges': <int>[]});
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
        final List<int> currentAges = List<int>.from(
          rooms[index]['childrenAges'],
        );

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
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with drag handle
          Container(
            padding: const EdgeInsets.only(top: 12, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
              border: Border(
                bottom: BorderSide(
                  color: maincolor1.withOpacity(0.05),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: secondaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Iconsax.profile_2user,
                          color: secondaryColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Guests & Rooms",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: maincolor1,
                                letterSpacing: -0.5,
                              ),
                            ),
                            Text(
                              "Customize your accommodation needs",
                              style: TextStyle(
                                fontSize: 12,
                                color: textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: maincolor1.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(Iconsax.home, size: 14, color: maincolor1),
                            const SizedBox(width: 6),
                            Text(
                              "${rooms.length} Room${rooms.length > 1 ? 's' : ''}",
                              style: TextStyle(
                                color: maincolor1,
                                fontWeight: FontWeight.w800,
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

          // Total Summary Bar
          Container(
            margin: const EdgeInsets.fromLTRB(24, 20, 24, 10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [maincolor1, maincolor1.withOpacity(0.85)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: maincolor1.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Total Capacity",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${totalAdults + totalChildren} Persons",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(width: 1, height: 40, color: Colors.white24),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Occupancy",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "$totalAdults Adult${totalAdults > 1 ? 's' : ''} • $totalChildren Child${totalChildren > 1 ? 'ren' : ''}",
                          style: const TextStyle(
                            color: secondaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Rooms List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 10, 24, 100),
              children: [
                ...rooms.asMap().entries.map((entry) {
                  return _buildRoomCard(entry.key, entry.value);
                }),

                // Add Room Button
                if (rooms.length < 4)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _addRoom,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: secondaryColor.withOpacity(0.3),
                              width: 2,
                              style: BorderStyle
                                  .none, // Switched to dashed border look via bg
                            ),
                            color: secondaryColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: secondaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.add,
                                  size: 14,
                                  color: maincolor1,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                "Add Another Room",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: secondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Bottom Action Bar
          Container(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 34),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      foregroundColor: maincolor1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      elevation: 8,
                      shadowColor: secondaryColor.withOpacity(0.3),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Iconsax.tick_circle5, size: 20, color: maincolor1),
                        const SizedBox(width: 12),
                        const Text(
                          "Confirm Configuration",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
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
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[100]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Room header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: maincolor1.withOpacity(0.02),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: maincolor1.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Iconsax.home_hashtag,
                        color: maincolor1,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Room ${index + 1}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: maincolor1,
                      ),
                    ),
                  ],
                ),
                if (rooms.length > 1)
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _removeRoom(index),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Iconsax.trash,
                          color: Colors.red[400],
                          size: 18,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Adults Counter
                _buildModernCounter(
                  title: "Adults",
                  subtitle: "12+ years",
                  value: adultsCount,
                  minValue: 1,
                  maxValue: 4,
                  onIncrement: () =>
                      _updateRoom(index, 'adults', adultsCount + 1),
                  onDecrement: () =>
                      _updateRoom(index, 'adults', adultsCount - 1),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(height: 1),
                ),
                // Children Counter
                _buildModernCounter(
                  title: "Children",
                  subtitle: "0-11 years",
                  value: childrenCount,
                  minValue: 0,
                  maxValue: 3,
                  onIncrement: () =>
                      _updateRoom(index, 'children', childrenCount + 1),
                  onDecrement: () =>
                      _updateRoom(index, 'children', childrenCount - 1),
                ),

                // Children Ages if children > 0
                if (childrenCount > 0) ...[
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 16,
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Children's Ages",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: maincolor1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: childrenCount,
                    separatorBuilder: (context, _) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, childIndex) {
                      final ages = rooms[index]['childrenAges'] as List<int>;
                      final currentAge = childIndex < ages.length
                          ? ages[childIndex]
                          : 1;
                      return _buildChildAgeSelector(
                        roomIndex: index,
                        childIndex: childIndex,
                        age: currentAge,
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernCounter({
    required String title,
    required String subtitle,
    required int value,
    required int minValue,
    required int maxValue,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: maincolor1,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            children: [
              _counterButton(
                icon: Iconsax.minus,
                enabled: value > minValue,
                onTap: onDecrement,
              ),
              Container(
                constraints: const BoxConstraints(minWidth: 40),
                alignment: Alignment.center,
                child: Text(
                  value.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: maincolor1,
                  ),
                ),
              ),
              _counterButton(
                icon: Iconsax.add,
                enabled: value < maxValue,
                onTap: onIncrement,
                isPrimary: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _counterButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: enabled
                ? (isPrimary ? secondaryColor : Colors.white)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: enabled && isPrimary
                ? [
                    BoxShadow(
                      color: secondaryColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Icon(
            icon,
            size: 18,
            color: enabled
                ? (isPrimary ? maincolor1 : maincolor1)
                : Colors.grey[300],
          ),
        ),
      ),
    );
  }

  Widget _buildChildAgeSelector({
    required int roomIndex,
    required int childIndex,
    required int age,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(Iconsax.user_tag, size: 18, color: Colors.grey[400]),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "Child ${childIndex + 1} Age",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: maincolor1.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: age,
                icon: Icon(Iconsax.arrow_down_1, size: 16, color: maincolor1),
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(16),
                style: TextStyle(
                  fontSize: 13,
                  color: maincolor1,
                  fontWeight: FontWeight.w800,
                ),
                items: List.generate(17, (i) => i + 1).map((i) {
                  return DropdownMenuItem(value: i, child: Text("$i years"));
                }).toList(),
                onChanged: (val) {
                  if (val != null) _updateChildAge(roomIndex, childIndex, val);
                },
              ),
            ),
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
      height: screenHeight * 0.87,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with drag handle
          Container(
            padding: const EdgeInsets.only(top: 12, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
              border: Border(
                bottom: BorderSide(
                  color: maincolor1.withOpacity(0.05),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: secondaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Iconsax.global,
                          color: secondaryColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Select Country",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: maincolor1,
                                letterSpacing: -0.5,
                              ),
                            ),
                            Text(
                              "Choose your location or nationality",
                              style: TextStyle(
                                fontSize: 10,
                                color: textSecondary,
                                fontWeight: FontWeight.w500,
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

          // Search field
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey[200]!, width: 1),
              ),
              child: TextField(
                controller: _searchController,
                cursorColor: secondaryColor,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: maincolor1,
                ),
                decoration: InputDecoration(
                  hintText: "Search countries...",
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: Icon(
                    Iconsax.search_normal,
                    color: secondaryColor,
                    size: 20,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
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
                    padding: const EdgeInsets.all(24),
                    itemCount: filteredCountries.length,
                    itemBuilder: (context, index) {
                      final country = filteredCountries[index];
                      final isSelected = country == widget.selectedCountry;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => widget.onCountrySelected(country),
                            borderRadius: BorderRadius.circular(16),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? maincolor1.withOpacity(0.02)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                // border: Border.all(
                                //   color: isSelected
                                //       ? secondaryColor.withOpacity(0.3)
                                //       : Colors.grey[100]!,
                                //   width: isSelected ? 1.5 : 1,
                                // ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: secondaryColor.withOpacity(
                                            0.05,
                                          ),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ]
                                    : [],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? secondaryColor.withOpacity(0.1)
                                          : Colors.grey[50],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      Iconsax.flag,
                                      color: isSelected
                                          ? secondaryColor
                                          : Colors.grey[400],
                                      size: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          country,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: isSelected
                                                ? FontWeight.w900
                                                : FontWeight.w600,
                                            color: isSelected
                                                ? maincolor1
                                                : Colors.grey[800],
                                          ),
                                        ),
                                        Text(
                                          "Country Profile",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: textSecondary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isSelected)
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: secondaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    )
                                  else
                                    Icon(
                                      Iconsax.arrow_right_3,
                                      color: Colors.grey[300],
                                      size: 16,
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
      padding: const EdgeInsets.all(24),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[100]!, width: 1),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 10,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
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
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Iconsax.search_status,
                size: 32,
                color: Colors.grey[300],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "No countries found",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: maincolor1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "We couldn't find any results for \"${_searchController.text}\"",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
