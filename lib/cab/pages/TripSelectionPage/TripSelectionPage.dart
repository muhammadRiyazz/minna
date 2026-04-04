import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:minna/cab/application/fetch%20cab/fetch_cabs_bloc.dart';
import 'package:minna/cab/pages/cabs_list/cabs_list_data.dart';
import 'package:minna/comman/const/const.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:minna/comman/core/api.dart';
import 'package:iconsax/iconsax.dart';

// Enum to track which location field is being edited
enum LocationFieldType {
  source,
  destination,
  multiCitySource,
  multiCityDestination,
}

class TripSelectionPage extends StatefulWidget {
  const TripSelectionPage({super.key});

  @override
  _TripSelectionPageState createState() => _TripSelectionPageState();
}

class _TripSelectionPageState extends State<TripSelectionPage> {
  int _selectedTripType = 1;
  final Set<int> _selectedCabTypes = {};
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  // For location search
  final String _apiKey = locationapiKey;
  List<dynamic> _searchResults = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  bool _isGettingCurrentLocation = false;
  LocationFieldType? _currentLocationField;

  // Location data storage
  Map<String, dynamic> _sourceLocationData = {};
  Map<String, dynamic> _destinationLocationData = {};
  final List<Map<String, dynamic>> _multiCityLocationData = [];

  // For multi-city trips
  List<Map<String, dynamic>> _multiCityRoutes = [
    {
      'source': TextEditingController(),
      'destination': TextEditingController(),
      'date': DateTime.now(),
      'time': TimeOfDay.now(),
      'sourceData': {},
      'destinationData': {},
    },
  ];

  // For round trip
  DateTime? _returnDate;
  TimeOfDay? _returnTime;

  // For airport transfer
  bool _isAirportPickup = true;

  // Theme standardizing: Use global constants directly from const.dart

  final Map<int, String> tripTypes = {
    1: 'ONE WAY',
    2: 'ROUND TRIP',
    3: 'MULTI CITY',
    4: 'AIRPORT TRANSFER',
    10: 'DAY RENTAL (8HR/80KM)',
    11: 'DAY RENTAL (12HR/120KM)',
  };

  final Map<int, String> cabTypes = {
    1: 'Compact',
    2: 'SUV',
    3: 'Sedan',
    5: 'Assured Dzire',
    6: 'Assured Innova',
    72: 'Compact CNG',
    73: 'Sedan CNG',
    74: 'SUV CNG',
  };

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _showVehicleSelectionSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: maincolor1.withOpacity(0.15),
                    blurRadius: 30,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Drag handle
                  const SizedBox(height: 12),
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select Vehicle',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: maincolor1,
                                letterSpacing: -0.5,
                              ),
                            ),
                            Text(
                              'Choose one or more car types',
                              style: TextStyle(
                                fontSize: 13,
                                color: textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Iconsax.close_circle,
                              color: textLight,
                              size: 24,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Vehicle list
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      itemCount: cabTypes.length,
                      itemBuilder: (context, index) {
                        final entry = cabTypes.entries.elementAt(index);
                        return _buildVehicleItem(
                          entry.key,
                          entry.value,
                          setModalState,
                        );
                      },
                    ),
                  ),

                  // Action Button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [maincolor1, maincolor1.withOpacity(0.9)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: maincolor1.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'CONFIRM SELECTION',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildVehicleItem(
    int cabId,
    String cabName,
    StateSetter setModalState,
  ) {
    final bool isSelected = _selectedCabTypes.contains(cabId);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          setModalState(() {
            if (isSelected) {
              _selectedCabTypes.remove(cabId);
            } else {
              _selectedCabTypes.add(cabId);
            }
          });
          setState(() {}); // Update main UI
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? secondaryColor.withOpacity(0.05) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? Colors.transparent
                  : Colors.grey.withOpacity(0.2),
              width: isSelected ? 2 : 1,
            ),
            // boxShadow: isSelected
            //     ? [
            //         BoxShadow(
            //           color: secondaryColor.withOpacity(0.1),
            //           blurRadius: 10,
            //           offset: const Offset(0, 4),
            //         ),
            //       ]
            //     : [],
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isSelected
                      ? secondaryColor.withOpacity(0.15)
                      : backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Iconsax.car,
                  color: isSelected ? secondaryColor : textSecondary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cabName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: isSelected ? maincolor1 : textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _getVehicleSubtitle(cabName),
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
                    Iconsax.tick_circle,
                    color: Colors.white,
                    size: 16,
                  ),
                )
              else
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _getVehicleSubtitle(String type) {
    String typeLower = type.toLowerCase();
    if (typeLower.contains('suv') || typeLower.contains('innova')) {
      return '6-7 Seater • Spacious • AC';
    } else if (typeLower.contains('sedan') || typeLower.contains('dzire')) {
      return '4 Seater • Comfortable • AC';
    } else if (typeLower.contains('compact')) {
      return '4 Seater • Economy • AC';
    }
    return 'Professional Driver • AC';
  }

  void _showLocationSearchSheet(
    LocationFieldType fieldType, [
    int? multiCityIndex,
  ]) {
    _currentLocationField = fieldType;
    _searchController.clear();
    _searchResults.clear();
    _isSearching = false;
    _isGettingCurrentLocation = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.95,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 30,
                    spreadRadius: 0,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Premium Drag Handle
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 12, bottom: 8),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  // Enhanced Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 15, 15),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Iconsax.arrow_left_2,
                            color: maincolor1,
                            size: 22,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Expanded(
                          child: Text(
                            _getLocationFieldTitle(fieldType, multiCityIndex),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: maincolor1,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        // Redesigned Current Location Card
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GestureDetector(
                            onTap: () => _getCurrentLocation(
                              setModalState,
                              fieldType,
                              multiCityIndex,
                            ),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    secondaryColor.withOpacity(0.08),
                                    secondaryColor.withOpacity(0.02),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                // border: Border.all(
                                //   color: secondaryColor.withOpacity(0.2),
                                //   width: 1.5,
                                // ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: secondaryColor.withOpacity(0.15),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Iconsax.gps,
                                      color: secondaryColor,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'USE CURRENT LOCATION',
                                          style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w900,
                                            color: secondaryColor,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Quickly pick your precise location',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: textPrimary.withOpacity(0.6),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (_isGettingCurrentLocation)
                                    SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: secondaryColor,
                                      ),
                                    )
                                  else
                                    Icon(
                                      Iconsax.arrow_right_3,
                                      color: secondaryColor.withOpacity(0.5),
                                      size: 18,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // OR Divider with Premium Style
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.grey.withOpacity(0.2),
                                  thickness: 1,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Text(
                                  'OR SEARCH PLACE',
                                  style: TextStyle(
                                    color: textLight,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 10,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Colors.grey.withOpacity(0.2),
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Modernized Search Bar
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: _searchController,
                              style: TextStyle(
                                color: textPrimary,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Where to go?',
                                hintStyle: TextStyle(
                                  color: textLight.withOpacity(0.6),
                                  fontWeight: FontWeight.w500,
                                ),
                                prefixIcon: Icon(
                                  Iconsax.search_normal_1,
                                  color: secondaryColor,
                                  size: 20,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.1),
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: secondaryColor.withOpacity(0.5),
                                    width: 1.5,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                ),
                              ),
                              onChanged: (query) {
                                if (query.length > 2) {
                                  _searchPlaces(query, setModalState);
                                } else {
                                  setModalState(() {
                                    _searchResults.clear();
                                    _isSearching = false;
                                  });
                                }
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Search Results or Empty State
                        _isSearching
                            ? Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: secondaryColor,
                                    strokeWidth: 3,
                                  ),
                                ),
                              )
                            : _searchResults.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(top: 60),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(24),
                                      decoration: BoxDecoration(
                                        color: secondaryColor.withOpacity(0.05),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Iconsax.location_add,
                                        size: 48,
                                        color: secondaryColor.withOpacity(0.3),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      _searchController.text.isEmpty
                                          ? 'Enter a destination to search'
                                          : 'No matches found',
                                      style: TextStyle(
                                        color: textLight,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.fromLTRB(
                                  20,
                                  0,
                                  20,
                                  30,
                                ),
                                itemCount: _searchResults.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 6),
                                itemBuilder: (context, index) {
                                  final place = _searchResults[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: Colors.grey.withOpacity(0.05),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.01),
                                          blurRadius: 10,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.all(8),
                                      leading: Container(
                                        width: 48,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: maincolor1.withOpacity(0.05),
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),
                                        child: Icon(
                                          Iconsax.location,
                                          color: maincolor1,
                                          size: 22,
                                        ),
                                      ),
                                      title: Text(
                                        place['description'] ?? '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          color: maincolor1,
                                          fontSize: 12,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      subtitle:
                                          place['structured_formatting'] != null
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                top: 4,
                                              ),
                                              child: Text(
                                                place['structured_formatting']['secondary_text'] ??
                                                    '',
                                                style: TextStyle(
                                                  color: textSecondary
                                                      .withOpacity(0.7),
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          : null,
                                      onTap: () {
                                        _selectPlace(
                                          place,
                                          fieldType,
                                          multiCityIndex,
                                        );
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                },
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _getCurrentLocation(
    StateSetter setModalState,
    LocationFieldType fieldType,
    int? multiCityIndex,
  ) async {
    setModalState(() {
      _isGettingCurrentLocation = true;
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showErrorSnackBar('Please enable location services');
        setModalState(() {
          _isGettingCurrentLocation = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        _showErrorSnackBar('Location permission is required');
        setModalState(() {
          _isGettingCurrentLocation = false;
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        String address = _formatAddress(placemark);

        final locationData = {
          'address': address,
          'latitude': position.latitude,
          'longitude': position.longitude,
        };

        if (mounted) {
          setState(() {
            switch (fieldType) {
              case LocationFieldType.source:
                _sourceController.text = locationData['address'] as String;
                break;
              case LocationFieldType.destination:
                _destinationController.text = locationData['address'] as String;
                break;
              case LocationFieldType.multiCitySource:
                _multiCityRoutes[multiCityIndex!]['source'].text =
                    locationData['address'] as String;
                _multiCityRoutes[multiCityIndex]['sourceData'] = locationData;
                break;
              case LocationFieldType.multiCityDestination:
                _multiCityRoutes[multiCityIndex!]['destination'].text =
                    locationData['address'] as String;
                _multiCityRoutes[multiCityIndex]['destinationData'] =
                    locationData;
                break;
            }
          });
        }

        Navigator.pop(context);
      }
    } catch (e) {
      log(e.toString());
      _showErrorSnackBar('Error getting location: $e');
    } finally {
      setModalState(() {
        _isGettingCurrentLocation = false;
      });
    }
  }

  String _formatAddress(Placemark placemark) {
    List<String> addressParts = [];

    if (placemark.street != null && placemark.street!.isNotEmpty) {
      addressParts.add(placemark.street!);
    }
    if (placemark.subLocality != null && placemark.subLocality!.isNotEmpty) {
      addressParts.add(placemark.subLocality!);
    }
    if (placemark.locality != null && placemark.locality!.isNotEmpty) {
      addressParts.add(placemark.locality!);
    }
    if (placemark.administrativeArea != null &&
        placemark.administrativeArea!.isNotEmpty) {
      addressParts.add(placemark.administrativeArea!);
    }
    if (placemark.postalCode != null && placemark.postalCode!.isNotEmpty) {
      addressParts.add(placemark.postalCode!);
    }
    if (placemark.country != null && placemark.country!.isNotEmpty) {
      addressParts.add(placemark.country!);
    }

    return addressParts.join(', ');
  }

  String _getLocationFieldTitle(
    LocationFieldType fieldType,
    int? multiCityIndex,
  ) {
    switch (fieldType) {
      case LocationFieldType.source:
        return 'Pickup Location';
      case LocationFieldType.destination:
        return 'Drop Location';
      case LocationFieldType.multiCitySource:
        return 'Route ${multiCityIndex! + 1} - Pickup';
      case LocationFieldType.multiCityDestination:
        return 'Route ${multiCityIndex! + 1} - Drop';
    }
  }

  Future<void> _searchPlaces(String query, StateSetter setModalState) async {
    setModalState(() {
      _isSearching = true;
    });

    try {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$_apiKey&components=country:in',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          setModalState(() {
            _searchResults = data['predictions'];
            _isSearching = false;
          });
        } else {
          setModalState(() {
            _searchResults = [];
            _isSearching = false;
          });
        }
      } else {
        setModalState(() {
          _searchResults = [];
          _isSearching = false;
        });
      }
    } catch (e) {
      setModalState(() {
        _searchResults = [];
        _isSearching = false;
      });
    }
  }

  Future<void> _selectPlace(
    dynamic place,
    LocationFieldType fieldType,
    int? multiCityIndex,
  ) async {
    try {
      final placeId = place['place_id'];
      final detailsUrl = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$_apiKey&fields=name,formatted_address,geometry',
      );

      final detailsResponse = await http.get(detailsUrl);

      if (detailsResponse.statusCode == 200) {
        final detailsData = json.decode(detailsResponse.body);

        if (detailsData['status'] == 'OK') {
          final result = detailsData['result'];
          final locationData = {
            'address': result['formatted_address'] ?? place['description'],
            'latitude': result['geometry']['location']['lat'],
            'longitude': result['geometry']['location']['lng'],
          };

          setState(() {
            switch (fieldType) {
              case LocationFieldType.source:
                _sourceController.text = locationData['address'] as String;
                break;
              case LocationFieldType.destination:
                _destinationController.text = locationData['address'] as String;
                break;
              case LocationFieldType.multiCitySource:
                _multiCityRoutes[multiCityIndex!]['source'].text =
                    locationData['address'] as String;
                _multiCityRoutes[multiCityIndex]['sourceData'] = locationData;
                break;
              case LocationFieldType.multiCityDestination:
                _multiCityRoutes[multiCityIndex!]['destination'].text =
                    locationData['address'] as String;
                _multiCityRoutes[multiCityIndex]['destinationData'] =
                    locationData;
                break;
            }
          });
        }
      }
    } catch (e) {
      final locationData = {
        'address': place['description'] ?? '',
        'latitude': 0.0,
        'longitude': 0.0,
      };

      setState(() {
        switch (fieldType) {
          case LocationFieldType.source:
            _sourceController.text = locationData['address'] as String;
            break;
          case LocationFieldType.destination:
            _destinationController.text = locationData['address'] as String;
            break;
          case LocationFieldType.multiCitySource:
            _multiCityRoutes[multiCityIndex!]['source'].text =
                locationData['address'] as String;
            _multiCityRoutes[multiCityIndex]['sourceData'] = locationData;
            break;
          case LocationFieldType.multiCityDestination:
            _multiCityRoutes[multiCityIndex!]['destination'].text =
                locationData['address'] as String;
            _multiCityRoutes[multiCityIndex]['destinationData'] = locationData;
            break;
        }
      });
    }
  }

  Future<void> _selectDate(
    BuildContext context, {
    bool isReturnDate = false,
    int? multiCityIndex,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isReturnDate
          ? _returnDate ?? DateTime.now().add(const Duration(days: 1))
          : multiCityIndex != null
          ? _multiCityRoutes[multiCityIndex]['date']
          : _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: secondaryColor,
              onPrimary: Colors.white,
              surface: cardColor,
              onSurface: textPrimary,
            ),
            dialogTheme: DialogThemeData(backgroundColor: backgroundColor),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isReturnDate) {
          _returnDate = picked;
        } else if (multiCityIndex != null) {
          _multiCityRoutes[multiCityIndex]['date'] = picked;
        } else {
          _selectedDate = picked;
        }
      });
    }
  }

  Future<void> _selectTime(
    BuildContext context, {
    bool isReturnTime = false,
    int? multiCityIndex,
  }) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isReturnTime
          ? _returnTime ?? TimeOfDay.now()
          : multiCityIndex != null
          ? _multiCityRoutes[multiCityIndex]['time']
          : _selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: secondaryColor,
              onPrimary: Colors.white,
              surface: cardColor,
              onSurface: textPrimary,
            ),
            dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isReturnTime) {
          _returnTime = picked;
        } else if (multiCityIndex != null) {
          _multiCityRoutes[multiCityIndex]['time'] = picked;
        } else {
          _selectedTime = picked;
        }
      });
    }
  }

  void _addMultiCityRoute() {
    setState(() {
      _multiCityRoutes.add({
        'source': TextEditingController(),
        'destination': TextEditingController(),
        'date': DateTime.now(),
        'time': TimeOfDay.now(),
        'sourceData': {},
        'destinationData': {},
      });
    });
  }

  void _removeMultiCityRoute(int index) {
    if (_multiCityRoutes.length > 1) {
      setState(() {
        _multiCityRoutes.removeAt(index);
      });
    }
  }

  Map<String, dynamic> _buildRequestJson() {
    Map<String, dynamic> request = {
      "tripType": _selectedTripType,
      "cabType": _selectedCabTypes.toList(),
    };

    if (_selectedTripType == 2 && _returnDate != null && _returnTime != null) {
      request["returnDate"] = DateFormat('yyyy-MM-dd HH:mm:ss').format(
        DateTime(
          _returnDate!.year,
          _returnDate!.month,
          _returnDate!.day,
          _returnTime!.hour,
          _returnTime!.minute,
        ),
      );
    }

    List<Map<String, dynamic>> routes = [];

    if (_selectedTripType == 3) {
      for (var route in _multiCityRoutes) {
        final sourceData = route['sourceData'] as Map<String, dynamic>;
        final destinationData =
            route['destinationData'] as Map<String, dynamic>;

        routes.add({
          "startDate": DateFormat('yyyy-MM-dd').format(route['date']),
          "startTime":
              "${route['time'].hour.toString().padLeft(2, '0')}:${route['time'].minute.toString().padLeft(2, '0')}:00",
          "source": {
            "address": route['source'].text,
            "coordinates": {
              "latitude": sourceData['latitude'] ?? 22.6531496,
              "longitude": sourceData['longitude'] ?? 88.4448719,
            },
          },
          "destination": {
            "address": route['destination'].text,
            "coordinates": {
              "latitude": destinationData['latitude'] ?? 22.7008099,
              "longitude": destinationData['longitude'] ?? 88.3747597,
            },
          },
        });
      }
    } else if (_selectedTripType == 4) {
      if (_isAirportPickup) {
        routes.add({
          "startDate": DateFormat('yyyy-MM-dd').format(_selectedDate),
          "startTime":
              "${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}:00",
          "source": {
            "isAirport": 1,
            "address": _sourceController.text,
            "coordinates": {
              "latitude": _sourceLocationData['latitude'] ?? 22.6531496,
              "longitude": _sourceLocationData['longitude'] ?? 88.4448719,
            },
          },
          "destination": {
            "address": _destinationController.text,
            "coordinates": {
              "latitude": _destinationLocationData['latitude'] ?? 22.7008099,
              "longitude": _destinationLocationData['longitude'] ?? 88.3747597,
            },
          },
        });
      } else {
        routes.add({
          "startDate": DateFormat('yyyy-MM-dd').format(_selectedDate),
          "startTime":
              "${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}:00",
          "source": {
            "address": _sourceController.text,
            "coordinates": {
              "latitude": _sourceLocationData['latitude'] ?? 22.6531496,
              "longitude": _sourceLocationData['longitude'] ?? 88.4448719,
            },
          },
          "destination": {
            "isAirport": 1,
            "address": _destinationController.text,
            "coordinates": {
              "latitude": _destinationLocationData['latitude'] ?? 22.7008099,
              "longitude": _destinationLocationData['longitude'] ?? 88.3747597,
            },
          },
        });
      }
    } else if (_selectedTripType == 10 || _selectedTripType == 11) {
      routes.add({
        "startDate": DateFormat('yyyy-MM-dd').format(_selectedDate),
        "startTime":
            "${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}:00",
        "source": {
          "address": _sourceController.text,
          "coordinates": {
            "latitude": _sourceLocationData['latitude'] ?? 22.6531496,
            "longitude": _sourceLocationData['longitude'] ?? 88.4448719,
          },
        },
        "destination": {
          "address": _sourceController.text,
          "coordinates": {
            "latitude": _sourceLocationData['latitude'] ?? 22.7008099,
            "longitude": _sourceLocationData['longitude'] ?? 88.3747597,
          },
        },
      });
    } else {
      routes.add({
        "startDate": DateFormat('yyyy-MM-dd').format(_selectedDate),
        "startTime":
            "${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}:00",
        "source": {
          "address": _sourceController.text,
          "coordinates": {
            "latitude": _sourceLocationData['latitude'] ?? 22.6531496,
            "longitude": _sourceLocationData['longitude'] ?? 88.4448719,
          },
        },
        "destination": {
          "address": _destinationController.text,
          "coordinates": {
            "latitude": _destinationLocationData['latitude'] ?? 22.7008099,
            "longitude": _destinationLocationData['longitude'] ?? 88.3747597,
          },
        },
      });

      if (_selectedTripType == 2 &&
          _returnDate != null &&
          _returnTime != null) {
        routes.add({
          "startDate": DateFormat('yyyy-MM-dd').format(_returnDate!),
          "startTime":
              "${_returnTime!.hour.toString().padLeft(2, '0')}:${_returnTime!.minute.toString().padLeft(2, '0')}:00",
          "source": {
            "address": _destinationController.text,
            "coordinates": {
              "latitude": _destinationLocationData['latitude'] ?? 22.6531496,
              "longitude": _destinationLocationData['longitude'] ?? 88.4448719,
            },
          },
          "destination": {
            "address": _sourceController.text,
            "coordinates": {
              "latitude": _sourceLocationData['latitude'] ?? 22.7008099,
              "longitude": _sourceLocationData['longitude'] ?? 88.3747597,
            },
          },
        });
      }
    }

    request["routes"] = routes;
    return request;
  }

  void _proceedToBooking() {
    if (_selectedCabTypes.isEmpty) {
      _showErrorSnackBar('Please select at least one vehicle type');
      return;
    }

    if (_selectedTripType == 3) {
      for (var route in _multiCityRoutes) {
        if (route['source'].text.isEmpty || route['destination'].text.isEmpty) {
          _showErrorSnackBar('Please fill all source and destination fields');
          return;
        }
      }
    } else if (_selectedTripType == 2) {
      if (_returnDate == null || _returnTime == null) {
        _showErrorSnackBar('Please select return date and time');
        return;
      }
    } else {
      if (_sourceController.text.isEmpty ||
          _destinationController.text.isEmpty) {
        _showErrorSnackBar('Please fill all required fields');
        return;
      }
    }

    final requestJson = _buildRequestJson();
    log('Request JSON: $requestJson');

    context.read<FetchCabsBloc>().add(
      FetchCabsEvent.fetchCabs(requestData: requestJson),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CabsListPage(requestData: requestJson),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        backgroundColor: errorColor,
        content: Row(
          children: [
            const Icon(Iconsax.info_circle, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Premium Sliver App Bar
          SliverAppBar(
            expandedHeight: 220.0,
            floating: false,
            pinned: true,
            backgroundColor: maincolor1,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Iconsax.arrow_left_2,
                color: Colors.white,
                size: 20,
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
                    'https://images.unsplash.com/photo-1593950315186-76a92975b60c?auto=format&fit=crop&q=80&w=1000',
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
                          maincolor1.withOpacity(0.5),
                          maincolor1,
                        ],
                        stops: const [0.0, 0.6, 1.0],
                      ),
                    ),
                  ),
                  // Header Content
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            "PREMIUM RIDES",
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Book Your Comfort\nJourney",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
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
              offset: Offset(0, 10),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: maincolor1.withOpacity(0.08),
                      blurRadius: 40,
                      offset: const Offset(0, 15),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.05),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Trip Type Selection
                    _buildTripTypeSection(),
                    const SizedBox(height: 24),

                    // Airport Transfer Type (if applicable)
                    if (_selectedTripType == 4) ...[
                      _buildTransferTypeSection(),
                      const SizedBox(height: 20),
                    ],

                    // Location Fields
                    if (_selectedTripType != 3) _buildLocationSection(),

                    // Multi-city routes
                    if (_selectedTripType == 3) _buildMultiCitySection(),

                    const SizedBox(height: 20),

                    // Date and Time Section
                    if (_selectedTripType != 3) _buildDateTimeSection(),

                    const SizedBox(height: 24),

                    // Vehicle Selection
                    _buildVehicleSelectionSection(),
                    const SizedBox(height: 32),

                    // Search Button
                    _buildSearchButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SELECT TRIP TYPE',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: textLight,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 48,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 4),
            children: tripTypes.entries.map((entry) {
              final isSelected = _selectedTripType == entry.key;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTripType = entry.key;
                      if (entry.key != 3) {
                        _multiCityRoutes = [
                          {
                            'source': TextEditingController(),
                            'destination': TextEditingController(),
                            'date': DateTime.now(),
                            'time': TimeOfDay.now(),
                            'sourceData': {},
                            'destinationData': {},
                          },
                        ];
                      }
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    decoration: BoxDecoration(
                      color: isSelected ? secondaryColor : backgroundColor,
                      borderRadius: BorderRadius.circular(16),
                      // boxShadow: isSelected
                      //     ? [
                      //         BoxShadow(
                      //           color: secondaryColor.withOpacity(0.3),
                      //           blurRadius: 10,
                      //           offset: const Offset(0, 4),
                      //         ),
                      //       ]
                      //     : [],
                      // border: Border.all(
                      //   color: isSelected
                      //       ? secondaryColor
                      //       : Colors.grey.withOpacity(0.1),
                      //   width: 1.5,
                      // ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getTripTypeIcon(entry.key),
                          size: 18,
                          color: isSelected ? Colors.white : secondaryColor,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          entry.value,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.2,
                            color: isSelected ? Colors.white : textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTransferTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TRANSFER TYPE',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: textLight,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isAirportPickup = true;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: _isAirportPickup ? secondaryColor : backgroundColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.airplane,
                        size: 16,
                        color: _isAirportPickup ? Colors.white : secondaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Airport Pickup',
                        style: TextStyle(
                          color: _isAirportPickup ? Colors.white : textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isAirportPickup = false;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: !_isAirportPickup ? secondaryColor : backgroundColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.airplane_square,
                        size: 16,
                        color: !_isAirportPickup
                            ? Colors.white
                            : secondaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Airport Drop',
                        style: TextStyle(
                          color: !_isAirportPickup ? Colors.white : textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLocationSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          _buildLocationField(
            controller: _sourceController,
            label: _selectedTripType == 4 && _isAirportPickup
                ? 'Airport'
                : 'Pickup Location',
            icon: Iconsax.location,
            onTap: () => _showLocationSearchSheet(LocationFieldType.source),
          ),
          if (_selectedTripType != 10 && _selectedTripType != 11) ...[
            const SizedBox(height: 16),
            _buildLocationField(
              controller: _destinationController,
              label: _selectedTripType == 4 && !_isAirportPickup
                  ? 'Airport'
                  : 'Drop Location',
              icon: Iconsax.location,
              onTap: () =>
                  _showLocationSearchSheet(LocationFieldType.destination),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMultiCitySection() {
    return Column(
      children: [
        for (int i = 0; i < _multiCityRoutes.length; i++)
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(24),
              // border: Border.all(
              //   color: secondaryColor.withOpacity(0.1),
              //   width: 1,
              // ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: secondaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'ROUTE ${i + 1}',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: secondaryColor,
                          fontSize: 10,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (_multiCityRoutes.length > 1)
                      IconButton(
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Iconsax.minus_cirlce,
                          color: errorColor,
                          size: 20,
                        ),
                        onPressed: () => _removeMultiCityRoute(i),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildLocationField(
                  controller: _multiCityRoutes[i]['source'],
                  label: 'Pickup Location',
                  icon: Iconsax.location,
                  onTap: () => _showLocationSearchSheet(
                    LocationFieldType.multiCitySource,
                    i,
                  ),
                ),
                const SizedBox(height: 12),
                _buildLocationField(
                  controller: _multiCityRoutes[i]['destination'],
                  label: 'Drop Location',
                  icon: Iconsax.location,
                  onTap: () => _showLocationSearchSheet(
                    LocationFieldType.multiCityDestination,
                    i,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildDateTimeField(
                        label: 'Date',
                        value: DateFormat(
                          'dd MMM yyyy',
                        ).format(_multiCityRoutes[i]['date']),
                        icon: Iconsax.calendar,
                        onTap: () => _selectDate(context, multiCityIndex: i),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDateTimeField(
                        label: 'Time',
                        value: _multiCityRoutes[i]['time'].format(context),
                        icon: Iconsax.clock,
                        onTap: () => _selectTime(context, multiCityIndex: i),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _addMultiCityRoute,
            icon: const Icon(Iconsax.add_circle, size: 18),
            label: const Text(
              'Add Another Route',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: secondaryColor,
              side: BorderSide(color: secondaryColor),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimeSection() {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        // border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildDateTimeField(
                  label: 'Pickup Date',
                  value: DateFormat('dd MMM yyyy').format(_selectedDate),
                  icon: Iconsax.calendar,
                  onTap: () => _selectDate(context),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDateTimeField(
                  label: 'Pickup Time',
                  value: _selectedTime.format(context),
                  icon: Iconsax.clock,
                  onTap: () => _selectTime(context),
                ),
              ),
            ],
          ),
          if (_selectedTripType == 2) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildDateTimeField(
                    label: 'Return Date',
                    value: _returnDate != null
                        ? DateFormat('dd MMM yyyy').format(_returnDate!)
                        : 'Select date',
                    icon: Iconsax.calendar,
                    onTap: () => _selectDate(context, isReturnDate: true),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDateTimeField(
                    label: 'Return Time',
                    value: _returnTime != null
                        ? _returnTime!.format(context)
                        : 'Select time',
                    icon: Iconsax.clock,
                    onTap: () => _selectTime(context, isReturnTime: true),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVehicleSelectionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SELECT VEHICLE TYPE',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: textLight,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: _showVehicleSelectionSheet,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.02),
              borderRadius: BorderRadius.circular(16),
              // border: Border.all(
              //   color: secondaryColor.withOpacity(0.15),
              //   width: 1,
              // ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Iconsax.car, color: maincolor1, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vehicle Type',
                        style: TextStyle(
                          fontSize: 8,
                          color: textLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _selectedCabTypes.isNotEmpty
                            ? _selectedCabTypes
                                  .map((id) => cabTypes[id])
                                  .join(", ")
                            : 'Select your preferred vehicle(s)',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: maincolor1,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Iconsax.more, color: textLight, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchButton() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [maincolor1, maincolor1.withOpacity(0.9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: maincolor1.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _proceedToBooking,
          borderRadius: BorderRadius.circular(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Iconsax.search_normal_1, size: 22, color: Colors.white),
              SizedBox(width: 12),
              Text(
                'FIND CABS',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          // border: Border.all(
          //   color: secondaryColor.withOpacity(0.15),
          //   width: 1,
          // ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: secondaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: secondaryColor, size: 18),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 8,
                      color: textSecondary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    controller.text.isEmpty
                        ? 'Tap to select location'
                        : controller.text,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: maincolor1,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Iconsax.arrow_right_3,
              color: secondaryColor.withOpacity(0.5),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTimeField({
    required String label,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          // border: Border.all(
          //   color: secondaryColor.withOpacity(0.15),
          //   width: 1,
          // ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: secondaryColor, size: 14),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 10,
                      color: textSecondary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: maincolor1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getTripTypeIcon(int tripType) {
    switch (tripType) {
      case 1:
        return Iconsax.arrow_right;
      case 2:
        return Iconsax.arrow_swap;
      case 3:
        return Iconsax.route_square;
      case 4:
        return Iconsax.airplane;
      case 10:
      case 11:
        return Iconsax.timer;
      default:
        return Iconsax.car;
    }
  }
}
