import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:minna/cab/application/fetch%20cab/fetch_cabs_bloc.dart';
import 'package:minna/cab/pages/cabs_list/cabs_list_data.dart';
import 'package:minna/comman/const/const.dart';

class TripSelectionPage extends StatefulWidget {
  const TripSelectionPage({super.key});

  @override
  _TripSelectionPageState createState() => _TripSelectionPageState();
}

class _TripSelectionPageState extends State<TripSelectionPage> {
  int _selectedTripType = 1;
  Set<int> _selectedCabTypes = {};
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  
  // For multi-city trips
  List<Map<String, dynamic>> _multiCityRoutes = [
    {
      'source': TextEditingController(),
      'destination': TextEditingController(),
      'date': DateTime.now(),
      'time': TimeOfDay.now(),
    }
  ];
  
  // For round trip
  DateTime? _returnDate;
  TimeOfDay? _returnTime;
  
  // For airport transfer
  bool _isAirportPickup = true;

  // Color scheme
  final Color primaryColor = maincolor1!;
  final Color secondaryColor = const Color(0xFF00CC99);
  final Color backgroundColor = const Color(0xFFF8F9FA);
  final Color cardColor = Colors.white;
  final Color textColor = const Color(0xFF333333);
  final Color hintColor = const Color(0xFF999999);

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

  void _showVehicleSelectionSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag handle
                  Center(
                    child: Container(
                      width: 60,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Choose Your Vehicle',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.grey[600]),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),

                  // Vehicle list
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemCount: cabTypes.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: Colors.grey[200],
                        indent: 20,
                        endIndent: 20,
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(Icons.directions_car, color: Colors.blue[700], size: 30),
      ),
      title: Text(
        cabName,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey[800],
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: Colors.blue[700])
          : Icon(Icons.radio_button_unchecked, color: Colors.grey[400]),
      onTap: () {
        setModalState(() {
          if (isSelected) {
            _selectedCabTypes.remove(cabId);
          } else {
            _selectedCabTypes.add(cabId);
          }
        });

        // also update main page
        setState(() {});
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
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
              primary: primaryColor,
              onPrimary: Colors.white,
              surface: cardColor,
              onSurface: textColor,
            ),
            dialogBackgroundColor: backgroundColor,
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
              primary: primaryColor,
              onPrimary: Colors.white,
              surface: cardColor,
              onSurface: textColor,
            ),
            dialogBackgroundColor: backgroundColor,
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
    // Basic structure
    Map<String, dynamic> request = {
      "tripType": _selectedTripType,
      "cabType": _selectedCabTypes.toList(),
    };

    // Add return date for round trips
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

    // Build routes based on trip type
    List<Map<String, dynamic>> routes = [];

    if (_selectedTripType == 3) {
      // Multi-city
      for (var route in _multiCityRoutes) {
        routes.add({
          "startDate": DateFormat('yyyy-MM-dd').format(route['date']),
          "startTime": "${route['time'].hour.toString().padLeft(2, '0')}:${route['time'].minute.toString().padLeft(2, '0')}:00",
          "source": {
            "address": route['source'].text,
            "coordinates": {
               "latitude": 22.6531496,
            "longitude": 88.4448719
            }
          },
          "destination": {
            "address": route['destination'].text,
            "coordinates": {
             "latitude": 22.7008099,
            "longitude": 88.3747597,
            }
          },
        });
      }
    } else if (_selectedTripType == 4) {
      // Airport transfer
      if (_isAirportPickup) {
        routes.add({
          "startDate": DateFormat('yyyy-MM-dd').format(_selectedDate),
          "startTime": "${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}:00",
          "source": {
            "isAirport": 1,
            "address": _sourceController.text,
            "coordinates": {
              "latitude": 22.6531496,
            "longitude": 88.4448719
            }
          },
          "destination": {
            "address": _destinationController.text,
            "coordinates": {
              "latitude": 22.7008099,
            "longitude": 88.3747597,
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
               "latitude": 22.6531496,
            "longitude": 88.4448719
            }
          },
          "destination": {
            "isAirport": 1,
            "address": _destinationController.text,
            "coordinates": {
             "latitude": 22.7008099,
            "longitude": 88.3747597,
            }
          },
        });
      }
    } else if (_selectedTripType == 10 || _selectedTripType == 11) {
      // Day rental - source and destination are the same
      routes.add({
        "startDate": DateFormat('yyyy-MM-dd').format(_selectedDate),
        "startTime": "${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}:00",
        "source": {
          "address": _sourceController.text,
          "coordinates": {
             "latitude": 22.6531496,
            "longitude": 88.4448719
          }
        },
        "destination": {
          "address": _sourceController.text, // Same as source for day rental
          "coordinates": {
            "latitude": 22.7008099,
            "longitude": 88.3747597,
          }
        },
      });
    } else {
      // One way or round trip (first leg)
      routes.add({
        "startDate": DateFormat('yyyy-MM-dd').format(_selectedDate),
        "startTime": "${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}:00",
        "source": {
          "address": _sourceController.text,
          "coordinates": {
             "latitude": 22.6531496,
            "longitude": 88.4448719
          }
        },
        "destination": {
          "address": _destinationController.text,
          "coordinates": {
            "latitude": 27.176670,
            "longitude": 78.008072,
          }
        },
      });

      // Add return trip for round trip
      if (_selectedTripType == 2 && _returnDate != null && _returnTime != null) {
        routes.add({
          "startDate": DateFormat('yyyy-MM-dd').format(_returnDate!),
          "startTime": "${_returnTime!.hour.toString().padLeft(2, '0')}:${_returnTime!.minute.toString().padLeft(2, '0')}:00",
          "source": {
            "address": _destinationController.text,
            "coordinates": {
              "latitude": 22.6531496,
            "longitude": 88.4448719
            }
          },
          "destination": {
            "address": _sourceController.text,
            "coordinates": {
               "latitude": 22.7008099,
            "longitude": 88.3747597,
            }
          },
        });
      }
    }

    request["routes"] = routes;
    return request;
  }

  void _proceedToBooking() {
    // Validate required fields
    if (_selectedCabTypes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select at least one vehicle type'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.red[400],
        ),
      );
      return;
    }

    // Validate based on trip type
    if (_selectedTripType == 3) {
      // Multi-city validation
      for (var route in _multiCityRoutes) {
        if (route['source'].text.isEmpty || route['destination'].text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Please fill all source and destination fields'),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.red[400],
            ),
          );
          return;
        }
      }
    } else if (_selectedTripType == 2) {
      // Round trip validation
      if (_returnDate == null || _returnTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please select return date and time'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.red[400],
          ),
        );
        return;
      }
    } else {
      // Other trip types validation
      if (_sourceController.text.isEmpty || _destinationController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please fill all required fields'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.red[400],
          ),
        );
        return;
      }
    }

    // Generate the request JSON
    final requestJson = _buildRequestJson();
    log('Request JSON: $requestJson');


context.read<FetchCabsBloc>().add(
  FetchCabsEvent.fetchCabs(requestData: requestJson),
);

    // Navigate to booking summary with the JSON data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CabsListPage( requestData: requestJson,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Book Your Cab'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with image
            // Image.network(
            //   'https://i.pinimg.com/736x/3b/60/82/3b608284ce4ab57d640de64831a8adba.jpg',
            // ),
            SizedBox(height: 100),
            Align(
              alignment: Alignment.topRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Book Your Ride',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Safe, comfortable and on-time',
                    style: TextStyle(fontSize: 14, color: hintColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),

            // Trip Type Selection
            Text(
              'SELECT TRIP TYPE',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: hintColor,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: tripTypes.entries.map((entry) {
                  return Padding(
                    padding: EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTripType = entry.key;
                          // Reset multi-city routes when changing trip type
                          if (entry.key != 3) {
                            _multiCityRoutes = [
                              {
                                'source': TextEditingController(),
                                'destination': TextEditingController(),
                                'date': DateTime.now(),
                                'time': TimeOfDay.now(),
                              }
                            ];
                          }
                        });
                      },
                      child: Container(
                        // width: 110,
                        decoration: BoxDecoration(
                          color: _selectedTripType == entry.key
                              ? primaryColor
                              : cardColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(
                                255,
                                212,
                                212,
                                212,
                              ).withOpacity(0.1),
                              blurRadius: 12,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _getTripTypeIcon(entry.key),
                              size: 20,
                              color: _selectedTripType == entry.key
                                  ? Colors.white
                                  : primaryColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              entry.value,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: _selectedTripType == entry.key
                                    ? Colors.white
                                    : textColor,
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
            const SizedBox(height: 10),

            // Airport Transfer Type Selection
            if (_selectedTripType == 4)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TRANSFER TYPE',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: hintColor,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 10),
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
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: _isAirportPickup
                                  ? primaryColor
                                  : cardColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _isAirportPickup
                                    ? primaryColor
                                    : Colors.grey.shade300,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.flight_land,
                                  color: _isAirportPickup
                                      ? Colors.white
                                      : primaryColor,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Airport Pickup',
                                  style: TextStyle(
                                    color: _isAirportPickup
                                        ? Colors.white
                                        : textColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isAirportPickup = false;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: !_isAirportPickup
                                  ? primaryColor
                                  : cardColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: !_isAirportPickup
                                    ? primaryColor
                                    : Colors.grey.shade300,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.flight_takeoff,
                                  color: !_isAirportPickup
                                      ? Colors.white
                                      : primaryColor,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Airport Drop',
                                  style: TextStyle(
                                    color: !_isAirportPickup
                                        ? Colors.white
                                        : textColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),

            // Location Fields
            if (_selectedTripType != 3) // Not multi-city
              _buildLocationCard(
                children: [
                  _buildLocationField(
                    controller: _sourceController,
                    label: _selectedTripType == 4 && _isAirportPickup
                        ? 'Airport'
                        : 'Pickup Location',
                    icon: Icons.local_taxi_outlined,
                    iconColor: primaryColor,
                  ),
                  const SizedBox(height: 16),
                  if (_selectedTripType != 10 && _selectedTripType != 11) // Not day rental
                    _buildLocationField(
                      controller: _destinationController,
                      label: _selectedTripType == 4 && !_isAirportPickup
                          ? 'Airport'
                          : 'Drop Location',
                      icon: Icons.local_taxi_outlined,
                      iconColor: primaryColor,
                    ),
                ],
              ),

            // Multi-city routes
            if (_selectedTripType == 3)
              Column(
                children: [
                  for (int i = 0; i < _multiCityRoutes.length; i++)
                    Column(
                      children: [
                        _buildLocationCard(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Route ${i + 1}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                const Spacer(),
                                if (_multiCityRoutes.length > 1)
                                  IconButton(
                                    icon: Icon(Icons.remove_circle, color: Colors.red),
                                    onPressed: () => _removeMultiCityRoute(i),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            _buildLocationField(
                              controller: _multiCityRoutes[i]['source'],
                              label: 'Pickup Location',
                              icon: Icons.local_taxi_outlined,
                              iconColor: primaryColor,
                            ),
                            const SizedBox(height: 16),
                            _buildLocationField(
                              controller: _multiCityRoutes[i]['destination'],
                              label: 'Drop Location',
                              icon: Icons.local_taxi_outlined,
                              iconColor: primaryColor,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildDateTimeField(
                                    label: 'Pickup Date',
                                    value: DateFormat('MMM dd, yyyy').format(_multiCityRoutes[i]['date']),
                                    icon: Icons.calendar_today,
                                    onTap: () => _selectDate(context, multiCityIndex: i),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _buildDateTimeField(
                                    label: 'Pickup Time',
                                    value: _multiCityRoutes[i]['time'].format(context),
                                    icon: Icons.access_time,
                                    onTap: () => _selectTime(context, multiCityIndex: i),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ElevatedButton.icon(
                    onPressed: _addMultiCityRoute,
                    icon: Icon(Icons.add, color: Colors.white),
                    label: Text('Add Another Route', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),

            // Date and Time
            if (_selectedTripType != 3) // Not multi-city
              _buildLocationCard(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildDateTimeField(
                          label: 'Pickup Date',
                          value: DateFormat('MMM dd, yyyy').format(_selectedDate),
                          icon: Icons.calendar_today,
                          onTap: () => _selectDate(context),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildDateTimeField(
                          label: 'Pickup Time',
                          value: _selectedTime.format(context),
                          icon: Icons.access_time,
                          onTap: () => _selectTime(context),
                        ),
                      ),
                    ],
                  ),
                  
                  // Return date and time for round trip
                  if (_selectedTripType == 2)
                    Column(
                      children: [
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildDateTimeField(
                                label: 'Return Date',
                                value: _returnDate != null
                                    ? DateFormat('MMM dd, yyyy').format(_returnDate!)
                                    : 'Select date',
                                icon: Icons.calendar_today,
                                onTap: () => _selectDate(context, isReturnDate: true),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildDateTimeField(
                                label: 'Return Time',
                                value: _returnTime != null
                                    ? _returnTime!.format(context)
                                    : 'Select time',
                                icon: Icons.access_time,
                                onTap: () => _selectTime(context, isReturnTime: true),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            const SizedBox(height: 25),

            // Cab Type Selection
            Text(
              'SELECT VEHICLE TYPE',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: hintColor,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _showVehicleSelectionSheet,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.directions_car,
                      // ignore: unnecessary_null_comparison
                      color: _selectedCabTypes != null
                          ? primaryColor
                          : hintColor,
                      size: 30,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Vehicle Type',
                            style: TextStyle(fontSize: 12, color: hintColor),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _selectedCabTypes.isNotEmpty
                                ? _selectedCabTypes
                                      .map((id) => cabTypes[id])
                                      .join(", ")
                                : 'Select your vehicle',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: _selectedCabTypes.isNotEmpty
                                  ? textColor
                                  : hintColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, color: hintColor, size: 18),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Proceed Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _proceedToBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  shadowColor: primaryColor.withOpacity(0.3),
                ),
                child: const Text(
                  'FIND CABS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
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
        return Icons.arrow_forward;
      case 2:
        return Icons.compare_arrows;
      case 3:
        return Icons.alt_route;
      case 4:
        return Icons.airplanemode_active;
      case 10:
      case 11:
        return Icons.timer;
      default:
        return Icons.directions_car;
    }
  }

  Widget _buildLocationCard({required List<Widget> children}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildLocationField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required Color iconColor,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: hintColor),
        prefixIcon: Icon(icon, color: iconColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade50),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade50),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryColor, width: 1),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: hintColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: primaryColor, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(icon, color: primaryColor),
          ],
        ),
      ),
    );
  }
}