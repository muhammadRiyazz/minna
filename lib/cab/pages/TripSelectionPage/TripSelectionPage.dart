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
    }
  ];
  
  // For round trip
  DateTime? _returnDate;
  TimeOfDay? _returnTime;
  
  // For airport transfer
  bool _isAirportPickup = true;

  // New Color Theme - Consistent with flight booking
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37); // Gold
  final Color _accentColor = Color(0xFFC19B3C); // Darker Gold
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);
  final Color _errorColor = Color(0xFFE53935);

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
              margin: EdgeInsets.only(top: 60),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
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

                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Choose Your Vehicle',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _textPrimary,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: _textLight),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),

                  // Vehicle list
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemCount: cabTypes.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: Colors.grey[200],
                      ),
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

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: _secondaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(Icons.directions_car, color: _secondaryColor, size: 28),
      ),
      title: Text(
        cabName,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: _textPrimary,
        ),
      ),
      trailing: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? _secondaryColor : Colors.grey,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: isSelected
            ? Icon(Icons.check, color: _secondaryColor, size: 16)
            : null,
      ),
      onTap: () {
        setModalState(() {
          if (isSelected) {
            _selectedCabTypes.remove(cabId);
          } else {
            _selectedCabTypes.add(cabId);
          }
        });
        setState(() {});
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  void _showLocationSearchSheet(LocationFieldType fieldType, [int? multiCityIndex]) {
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
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 12,),

                  // Header
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: _textPrimary),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _getLocationFieldTitle(fieldType, multiCityIndex),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
SizedBox(height: 6,),

                  // Current Location Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, ),
                    child: GestureDetector(
                      onTap: () => _getCurrentLocation(setModalState, fieldType, multiCityIndex),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: _secondaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: _secondaryColor.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.my_location,
                              color: _secondaryColor,
                              size: 24,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Use Current Location',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: _secondaryColor,
                                    ),
                                  ),
                                  Text(
                                    'Get your current location automatically',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: _secondaryColor.withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (_isGettingCurrentLocation)
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: _secondaryColor,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
SizedBox(height: 12,),

                  // Divider
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey[300],
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'OR',
                            style: TextStyle(
                              color: _textLight,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey[300],
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
SizedBox(height: 12,),
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search for a place...',
                        hintStyle: TextStyle(color: _textLight),
                        prefixIcon: Icon(Icons.search, color: _secondaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: _secondaryColor, width: 2),
                        ),
                        filled: true,
                        fillColor: _backgroundColor,
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

                  // Search Results
                  Expanded(
                    child: _isSearching
                        ? Center(
                            child: CircularProgressIndicator(color: _secondaryColor),
                          )
                        : _searchResults.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 64,
                                      color: Colors.grey[300],
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      _searchController.text.isEmpty
                                          ? 'Search for places'
                                          : 'No results found',
                                      style: TextStyle(
                                        color: _textLight,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.only(bottom: 10),
                                itemCount: _searchResults.length,
                                itemBuilder: (context, index) {
                                  final place = _searchResults[index];
                                  return ListTile(
                                    // contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                    leading: Container(
                                      width: 44,
                                      height: 44,
                                      decoration: BoxDecoration(
                                        color: _secondaryColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        Icons.place,
                                        color: _secondaryColor,
                                        size: 20,
                                      ),
                                    ),
                                    title: Text(
                                      place['description'] ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: _textPrimary,
                                      ),
                                    ),
                                    subtitle: place['structured_formatting'] != null
                                        ? Text(
                                            place['structured_formatting']['secondary_text'] ?? '',
                                            style: TextStyle(
                                              color: _textSecondary,
                                              fontSize: 12,
                                            ),
                                          )
                                        : null,
                                    onTap: () {
                                      _selectPlace(place, fieldType, multiCityIndex);
                                      Navigator.pop(context);
                                    },
                                  );
                                },
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

  Future<void> _getCurrentLocation(StateSetter setModalState, LocationFieldType fieldType, int? multiCityIndex) async {
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
                _sourceLocationData = locationData;
                break;
              case LocationFieldType.destination:
                _destinationController.text = locationData['address'] as String;
                _destinationLocationData = locationData;
                break;
              case LocationFieldType.multiCitySource:
                _multiCityRoutes[multiCityIndex!]['source'].text = locationData['address'] as String;
                _multiCityRoutes[multiCityIndex]['sourceData'] = locationData;
                break;
              case LocationFieldType.multiCityDestination:
                _multiCityRoutes[multiCityIndex!]['destination'].text = locationData['address'] as String;
                _multiCityRoutes[multiCityIndex]['destinationData'] = locationData;
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
    if (placemark.administrativeArea != null && placemark.administrativeArea!.isNotEmpty) {
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

  String _getLocationFieldTitle(LocationFieldType fieldType, int? multiCityIndex) {
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
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$_apiKey&components=country:in'
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

  Future<void> _selectPlace(dynamic place, LocationFieldType fieldType, int? multiCityIndex) async {
    try {
      final placeId = place['place_id'];
      final detailsUrl = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$_apiKey&fields=name,formatted_address,geometry'
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
                _sourceLocationData = locationData;
                break;
              case LocationFieldType.destination:
                _destinationController.text = locationData['address'] as String;
                _destinationLocationData = locationData;
                break;
              case LocationFieldType.multiCitySource:
                _multiCityRoutes[multiCityIndex!]['source'].text = locationData['address'] as String;
                _multiCityRoutes[multiCityIndex]['sourceData'] = locationData;
                break;
              case LocationFieldType.multiCityDestination:
                _multiCityRoutes[multiCityIndex!]['destination'].text = locationData['address'] as String;
                _multiCityRoutes[multiCityIndex]['destinationData'] = locationData;
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
            _sourceLocationData = locationData;
            break;
          case LocationFieldType.destination:
            _destinationController.text = locationData['address'] as String;
            _destinationLocationData = locationData;
            break;
          case LocationFieldType.multiCitySource:
            _multiCityRoutes[multiCityIndex!]['source'].text = locationData['address'] as String;
            _multiCityRoutes[multiCityIndex]['sourceData'] = locationData;
            break;
          case LocationFieldType.multiCityDestination:
            _multiCityRoutes[multiCityIndex!]['destination'].text = locationData['address'] as String;
            _multiCityRoutes[multiCityIndex]['destinationData'] = locationData;
            break;
        }
      });
    }
  }

  Future<void> _selectDate(BuildContext context, {bool isReturnDate = false, int? multiCityIndex}) async {
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
              primary: _secondaryColor,
              onPrimary: Colors.white,
              surface: _cardColor,
              onSurface: _textPrimary,
            ), 
            dialogTheme: DialogThemeData(backgroundColor: _backgroundColor),
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

  Future<void> _selectTime(BuildContext context, {bool isReturnTime = false, int? multiCityIndex}) async {
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
              primary: _secondaryColor,
              onPrimary: Colors.white,
              surface: _cardColor,
              onSurface: _textPrimary,
            ), 
            dialogTheme: DialogThemeData(backgroundColor: _backgroundColor),
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
        final destinationData = route['destinationData'] as Map<String, dynamic>;
        
        routes.add({
          "startDate": DateFormat('yyyy-MM-dd').format(route['date']),
          "startTime": "${route['time'].hour.toString().padLeft(2, '0')}:${route['time'].minute.toString().padLeft(2, '0')}:00",
          "source": {
            "address": route['source'].text,
            "coordinates": {
              "latitude": sourceData['latitude'] ?? 22.6531496,
              "longitude": sourceData['longitude'] ?? 88.4448719,
            }
          },
          "destination": {
            "address": route['destination'].text,
            "coordinates": {
              "latitude": destinationData['latitude'] ?? 22.7008099,
              "longitude": destinationData['longitude'] ?? 88.3747597,
            }
          },
        });
      }
    } else if (_selectedTripType == 4) {
      if (_isAirportPickup) {
        routes.add({
          "startDate": DateFormat('yyyy-MM-dd').format(_selectedDate),
          "startTime": "${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}:00",
          "source": {
            "isAirport": 1,
            "address": _sourceController.text,
            "coordinates": {
              "latitude": _sourceLocationData['latitude'] ?? 22.6531496,
              "longitude": _sourceLocationData['longitude'] ?? 88.4448719,
            }
          },
          "destination": {
            "address": _destinationController.text,
            "coordinates": {
              "latitude": _destinationLocationData['latitude'] ?? 22.7008099,
              "longitude": _destinationLocationData['longitude'] ?? 88.3747597,
            }
          },
        });
      } else {
        routes.add({
          "startDate": DateFormat('yyyy-MM-dd').format(_selectedDate),
          "startTime": "${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}:00",
          "source": {
            "address": _sourceController.text,
            "coordinates": {
              "latitude": _sourceLocationData['latitude'] ?? 22.6531496,
              "longitude": _sourceLocationData['longitude'] ?? 88.4448719,
            }
          },
          "destination": {
            "isAirport": 1,
            "address": _destinationController.text,
            "coordinates": {
              "latitude": _destinationLocationData['latitude'] ?? 22.7008099,
              "longitude": _destinationLocationData['longitude'] ?? 88.3747597,
            }
          },
        });
      }
    } else if (_selectedTripType == 10 || _selectedTripType == 11) {
      routes.add({
        "startDate": DateFormat('yyyy-MM-dd').format(_selectedDate),
        "startTime": "${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}:00",
        "source": {
          "address": _sourceController.text,
          "coordinates": {
            "latitude": _sourceLocationData['latitude'] ?? 22.6531496,
            "longitude": _sourceLocationData['longitude'] ?? 88.4448719,
          }
        },
        "destination": {
          "address": _sourceController.text,
          "coordinates": {
            "latitude": _sourceLocationData['latitude'] ?? 22.7008099,
            "longitude": _sourceLocationData['longitude'] ?? 88.3747597,
          }
        },
      });
    } else {
      routes.add({
        "startDate": DateFormat('yyyy-MM-dd').format(_selectedDate),
        "startTime": "${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}:00",
        "source": {
          "address": _sourceController.text,
          "coordinates": {
            "latitude": _sourceLocationData['latitude'] ?? 22.6531496,
            "longitude": _sourceLocationData['longitude'] ?? 88.4448719,
          }
        },
        "destination": {
          "address": _destinationController.text,
          "coordinates": {
            "latitude": _destinationLocationData['latitude'] ?? 22.7008099,
            "longitude": _destinationLocationData['longitude'] ?? 88.3747597,
          }
        },
      });

      if (_selectedTripType == 2 && _returnDate != null && _returnTime != null) {
        routes.add({
          "startDate": DateFormat('yyyy-MM-dd').format(_returnDate!),
          "startTime": "${_returnTime!.hour.toString().padLeft(2, '0')}:${_returnTime!.minute.toString().padLeft(2, '0')}:00",
          "source": {
            "address": _destinationController.text,
            "coordinates": {
              "latitude": _destinationLocationData['latitude'] ?? 22.6531496,
              "longitude": _destinationLocationData['longitude'] ?? 88.4448719,
            }
          },
          "destination": {
            "address": _sourceController.text,
            "coordinates": {
              "latitude": _sourceLocationData['latitude'] ?? 22.7008099,
              "longitude": _sourceLocationData['longitude'] ?? 88.3747597,
            }
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
      if (_sourceController.text.isEmpty || _destinationController.text.isEmpty) {
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
        margin: EdgeInsets.all(16),
        backgroundColor: _errorColor,
        content: Row(
          children: [
            Icon(Icons.error_outline_rounded, color: Colors.white, size: 20),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        duration: Duration(seconds: 3),
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
      backgroundColor: _backgroundColor,
    
      body: CustomScrollView(
        slivers: [



      SliverAppBar(
                backgroundColor: _primaryColor,
                expandedHeight: 130,
                floating: false,
                pinned: true,
                elevation: 4,leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
                shadowColor: Colors.black.withOpacity(0.3),
                surfaceTintColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'Cab Booking',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  centerTitle: true,
                  background: Container(
                    decoration: BoxDecoration(
                    color: _primaryColor
                    ),
                  ),
                ),
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.vertical(
                //     bottom: Radius.circular(20),
                //   ),
                // ),
              ),








          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  _buildHeaderSection(),
                  const SizedBox(height: 20),

                  // Trip Type Selection
                  _buildTripTypeSection(),
                  const SizedBox(height: 20),

                  // Airport Transfer Type (if applicable)
                  if (_selectedTripType == 4) ...[
                    _buildTransferTypeSection(),
                    const SizedBox(height: 8),
                  ],

                  // Location Fields
                  if (_selectedTripType != 3) 
                    _buildLocationSection(),
                                      const SizedBox(height: 8),

                  // Multi-city routes
                  if (_selectedTripType == 3)
                    _buildMultiCitySection(),
                    const SizedBox(height: 8),

                  // Date and Time Section
                  if (_selectedTripType != 3)
                    _buildDateTimeSection(),

                  const SizedBox(height: 20),

                  // Vehicle Selection
                  _buildVehicleSelectionSection(),
                  const SizedBox(height: 20),

                  // Search Button
                  _buildSearchButton(),
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
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _primaryColor,
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
              Icons.directions_car_rounded,
              color: _secondaryColor,
              size: 28,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Find Your Perfect Ride",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Safe, comfortable and on-time cab service",
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

  Widget _buildTripTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SELECT TRIP TYPE',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: _textLight,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
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
                          }
                        ];
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? _secondaryColor : _cardColor,
                      borderRadius: BorderRadius.circular(14),
                      // border: Border.all(
                      //   color: isSelected ? _secondaryColor : Colors.grey.shade300,
                      //   width: 1.5,
                      // ),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black.withOpacity(0.05),
                      //     blurRadius: 8,
                      //     offset: Offset(0, 2),
                      //   ),
                      // ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getTripTypeIcon(entry.key),
                          size: 20,
                          color: isSelected ? Colors.white : _secondaryColor,
                        ),

                        const SizedBox(width: 6),


                         Text(
                          entry.value,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : _textPrimary,
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
            color: _textLight,
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
                    color: _isAirportPickup ? _secondaryColor : _cardColor,
                    borderRadius: BorderRadius.circular(16),
                    // border: Border.all(
                    //   color: _isAirportPickup ? _secondaryColor : Colors.grey.shade300,
                    //   width: 1.5,
                    // ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.flight_land,size: 12,
                        color: _isAirportPickup ? Colors.white : _secondaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Airport Pickup',
                        style: TextStyle(
                          color: _isAirportPickup ? Colors.white : _textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 12
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
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: !_isAirportPickup ? _secondaryColor : _cardColor,
                    borderRadius: BorderRadius.circular(16),
                    // border: Border.all(
                    //   color: !_isAirportPickup ? _secondaryColor : Colors.grey.shade300,
                    //   width: 1.5,
                    // ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.flight_takeoff,size: 12,
                        color: !_isAirportPickup ? Colors.white : _secondaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Airport Drop',
                        style: TextStyle(
                          color: !_isAirportPickup ? Colors.white : _textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 12
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildLocationField(
            controller: _sourceController,
            label: _selectedTripType == 4 && _isAirportPickup
                ? 'Airport'
                : 'Pickup Location',
            icon: Icons.location_on_rounded,
            onTap: () => _showLocationSearchSheet(LocationFieldType.source),
          ),
          if (_selectedTripType != 10 && _selectedTripType != 11) ...[
            SizedBox(height: 16),
            _buildLocationField(
              controller: _destinationController,
              label: _selectedTripType == 4 && !_isAirportPickup
                  ? 'Airport'
                  : 'Drop Location',
              icon: Icons.location_on_rounded,
              onTap: () => _showLocationSearchSheet(LocationFieldType.destination),
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
            margin: EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(12),
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
                Row(
                  children: [
                                    SizedBox(height: 10),

                    Text(
                      ' Route ${i + 1}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _secondaryColor,
                        fontSize: 16,
                      ),
                    ),
                    Spacer(),
                    if (_multiCityRoutes.length > 1)
                      IconButton(
                        icon: Icon(Icons.remove_circle, color: _errorColor),
                        onPressed: () => _removeMultiCityRoute(i),
                      ),
                  ],
                ),
                SizedBox(height: 10),
                _buildLocationField(
                  controller: _multiCityRoutes[i]['source'],
                  label: 'Pickup Location',
                  icon: Icons.location_on_rounded,
                  onTap: () => _showLocationSearchSheet(LocationFieldType.multiCitySource, i),
                ),
                SizedBox(height: 16),
                _buildLocationField(
                  controller: _multiCityRoutes[i]['destination'],
                  label: 'Drop Location',
                  icon: Icons.location_on_rounded,
                  onTap: () => _showLocationSearchSheet(LocationFieldType.multiCityDestination, i),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildDateTimeField(
                        label: 'Pickup Date',
                        value: DateFormat('dd MMM yyyy').format(_multiCityRoutes[i]['date']),
                        icon: Icons.calendar_month_rounded,
                        onTap: () => _selectDate(context, multiCityIndex: i),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildDateTimeField(
                        label: 'Pickup Time',
                        value: _multiCityRoutes[i]['time'].format(context),
                        icon: Icons.access_time_rounded,
                        onTap: () => _selectTime(context, multiCityIndex: i),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ElevatedButton.icon(
          onPressed: _addMultiCityRoute,
          icon: Icon(Icons.add, color: Colors.white),
          label: Text('Add Another Route', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: _secondaryColor,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimeSection() {
    return Container(
      padding: const EdgeInsets.all(12),
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
          Row(
            children: [
              Expanded(
                child: _buildDateTimeField(
                  label: 'Pickup Date',
                  value: DateFormat('dd MMM yyyy').format(_selectedDate),
                  icon: Icons.calendar_month_rounded,
                  onTap: () => _selectDate(context),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildDateTimeField(
                  label: 'Pickup Time',
                  value: _selectedTime.format(context),
                  icon: Icons.access_time_rounded,
                  onTap: () => _selectTime(context),
                ),
              ),
            ],
          ),
          if (_selectedTripType == 2) ...[
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildDateTimeField(
                    label: 'Return Date',
                    value: _returnDate != null
                        ? DateFormat('dd MMM yyyy').format(_returnDate!)
                        : 'Select date',
                    icon: Icons.calendar_month_rounded,
                    onTap: () => _selectDate(context, isReturnDate: true),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildDateTimeField(
                    label: 'Return Time',
                    value: _returnTime != null
                        ? _returnTime!.format(context)
                        : 'Select time',
                    icon: Icons.access_time_rounded,
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
            color: _textLight,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: _showVehicleSelectionSheet,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.directions_car_rounded,
                    color: _selectedCabTypes.isNotEmpty ? _secondaryColor : _textLight,
                    size: 22,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vehicle Type',
                        style: TextStyle(fontSize: 10, color: _textLight),
                      ),
                      SizedBox(height: 4),
                      Text(
                        _selectedCabTypes.isNotEmpty
                            ? _selectedCabTypes
                                .map((id) => cabTypes[id])
                                .join(", ")
                            : 'Select your vehicle',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: _selectedCabTypes.isNotEmpty
                              ? _textPrimary
                              : _textLight,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded, color: _textLight, size: 18),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _proceedToBooking,
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
          shadowColor: _primaryColor.withOpacity(0.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_rounded, size: 20),
            SizedBox(width: 12),
            Text(
              'FIND CABS',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ],
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
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(16),
          // border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _secondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: _secondaryColor,
                size: 24,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 10,
                      color: _textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    controller.text.isEmpty ? 'Select location' : controller.text,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: controller.text.isEmpty ? _textLight : _textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: _textLight,
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
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(16),
          // border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: _secondaryColor,
              size: 20,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 10,
                      color: _textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _textPrimary,
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

  IconData _getTripTypeIcon(int tripType) {
    switch (tripType) {
      case 1:
        return Icons.arrow_forward_rounded;
      case 2:
        return Icons.compare_arrows_rounded;
      case 3:
        return Icons.alt_route_rounded;
      case 4:
        return Icons.airplanemode_active_rounded;
      case 10:
      case 11:
        return Icons.timer_rounded;
      default:
        return Icons.directions_car_rounded;
    }
  }
}