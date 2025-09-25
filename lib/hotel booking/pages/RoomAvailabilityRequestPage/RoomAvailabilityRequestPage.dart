
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/hotel%20booking/domain/hotel%20details%20/hotel_details.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:minna/hotel%20booking/domain/rooms/rooms.dart';
import 'package:minna/hotel%20booking/functions/fetch_rooms.dart';
import 'package:minna/hotel%20booking/pages/Room%20Results%20Page/RoomAvailabilityResultsPage.dart';
import 'package:minna/hotel%20booking/pages/holel%20home%20page/home_page_hotel.dart';

class RoomAvailabilityRequestPage extends StatefulWidget {
  final HotelDetail hotel;
  const RoomAvailabilityRequestPage({super.key, required this.hotel});

  @override
  State<RoomAvailabilityRequestPage> createState() =>
      _RoomAvailabilityRequestPageState();
}

class _RoomAvailabilityRequestPageState
    extends State<RoomAvailabilityRequestPage> {
  final _formKey = GlobalKey<FormState>();

  DateTime? checkIn;
  DateTime? checkOut;
  final hotelCodesController = TextEditingController();
  String nationality = 'IN';
  final noOfRoomsController = TextEditingController(text: '1');
  final responseTimeController = TextEditingController(text: '30');
  bool isDetailedResponse = false;
  bool refundableOnly = false;
  String mealType = 'All';
bool _isLoading = false;

  List<Map<String, dynamic>> paxRooms = [
    {'adults': 1, 'children': 0, 'childrenAges': <int>[]},
  ];

 

  // // Function to generate JSON data
  // Map<String, dynamic> _generateRequestJson() {
  //   List<Map<String, dynamic>> paxRoomsJson = paxRooms.map((room) {
  //     return {
  //       "Adults": room['adults'],
  //       "Children": room['children'],
  //       "ChildrenAges": (room['children'] as int) > 0 ? room['childrenAges'] : null
  //     };
  //   }).toList();

  //   return {
  //     "CheckIn": DateFormat('yyyy-MM-dd').format(checkIn!),
  //     "CheckOut": DateFormat('yyyy-MM-dd').format(checkOut!),
  //     "HotelCodes": widget.hotel.hotelCode ,
  //     "GuestNationality": nationality,
  //     "PaxRooms": paxRoomsJson,
  //     "ResponseTime": double.tryParse(responseTimeController.text) ?? 30.0,
  //     "IsDetailedResponse": isDetailedResponse,
  //     "Filters": {
  //       "Refundable": refundableOnly,
  //       "NoOfRooms": int.tryParse(noOfRoomsController.text) ?? 0,
  //       "MealType": mealType,
  //       "StarRating": "" // Add star rating if available
  //     }
  //   };
  // }

  // Validation function
  String? _validateForm() {
    if (checkIn == null) {
      return "Please select check-in date";
    }
    if (checkOut == null) {
      return "Please select check-out date";
    }
    if (checkOut!.isBefore(checkIn!) || checkOut!.isAtSameMomentAs(checkIn!)) {
      return "Check-out date must be after check-in date";
    }

    // Validate children ages
    for (int i = 0; i < paxRooms.length; i++) {
      final room = paxRooms[i];
      if ((room['children'] as int) > 0) {
        final childrenAges = room['childrenAges'] as List<int>;
        for (int j = 0; j < childrenAges.length; j++) {
          if (childrenAges[j] <= 0 || childrenAges[j] > 17) {
            return "Please enter valid age (1-17) for children in Room ${i + 1}";
          }
        }
      }
    }

    return null;
  }

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isCheckIn ? DateTime.now() : (checkIn ?? DateTime.now()).add(const Duration(days: 1)),
      firstDate: isCheckIn ? DateTime.now() : (checkIn ?? DateTime.now()),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: maincolor1!,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.teal),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          checkIn = picked;
          // Reset checkOut if it's before new checkIn
          if (checkOut != null && checkOut!.isBefore(picked)) {
            checkOut = null;
          }
        } else {
          checkOut = picked;
        }
      });
    }
  }

  Widget _roomCard(int index) {
    final room = paxRooms[index];
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.king_bed, color: maincolor1, size: 20),
                const SizedBox(width: 8),
                Text(
                  "Room ${index + 1}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.person, color: maincolor1, size: 18),
                const SizedBox(width: 8),
                const Text("Adults: "),
                const SizedBox(width: 8),
                DropdownButton<int>(
                  value: room['adults'],
                  items: List.generate(8, (i) => i + 1)
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            '$e',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (val) => setState(() => room['adults'] = val),
                  style: const TextStyle(color: Colors.black),
                  dropdownColor: Colors.white,
                ),
                const SizedBox(width: 24),
                Icon(Icons.child_care, color: maincolor1, size: 18),
                const SizedBox(width: 8),
                const Text("Children: "),
                const SizedBox(width: 8),
                DropdownButton<int>(
                  value: room['children'],
                  items: List.generate(5, (i) => i)
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            '$e',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      room['children'] = val;
                      room['childrenAges'] = List.filled(val ?? 0, 1); // Default age to 1
                    });
                  },
                  style: const TextStyle(color: Colors.black),
                  dropdownColor: Colors.white,
                ),
              ],
            ),
            if ((room['children'] ?? 0) > 0) ...[
              const SizedBox(height: 12),
              Text(
                "Children Ages (1-17 years):",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 12,
                children: List.generate(room['children'], (i) {
                  return SizedBox(
                    width: 100,
                    child: TextFormField(
                      initialValue: room['childrenAges'][i].toString(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Child ${i + 1} Age',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        errorStyle: TextStyle(fontSize: 10),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        final age = int.tryParse(value);
                        if (age == null || age < 1 || age > 17) {
                          return '1-17';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        final age = int.tryParse(value) ?? 1;
                        setState(() {
                          room['childrenAges'][i] = age;
                        });
                      },
                    ),
                  );
                }),
              ),
            ],
          ],
        ),
      ),
    );
  }


void _submitForm() async {
  final validationError = _validateForm();
  if (validationError != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(validationError), backgroundColor: Colors.red),
    );
    return;
  }

  if (_formKey.currentState!.validate()) {
    setState(() => _isLoading = true);

    try {
      final request = HotelSearchRequest(
        checkIn: DateFormat('yyyy-MM-dd').format(checkIn!),
        checkOut: DateFormat('yyyy-MM-dd').format(checkOut!),
        hotelCodes: widget.hotel.hotelCode.toString(),
        guestNationality: nationality,
        paxRooms: paxRooms.map((room) {
          return PaxRoom(
            adults: room['adults'],
            children: room['children'],
            childrenAges: (room['children'] as int) > 0
                ? List<int>.from(room['childrenAges'])
                : null,
          );
        }).toList(),
        responseTime: double.tryParse(responseTimeController.text) ?? 30.0,
        isDetailedResponse: true,
        refundable: refundableOnly,
        noOfRooms:  int.tryParse(noOfRoomsController.text) ??0,
        mealType: mealType,
        starRating: null,
      );

      final response = await HotelRoomApiService.searchHotels(request);

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RoomAvailabilityResultsPage(
              hotelRoomResult: response.hotelResult,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.description), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Room Availability",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: maincolor1,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hotel Card
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 200.0,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        pauseAutoPlayOnTouch: true,
                        enlargeCenterPage: false,
                        viewportFraction: 1.0,
                      ),
                      items: widget.hotel.images.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Image.network(
                                i,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.broken_image, color: Colors.grey),
                                  );
                                },
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded / 
                                            loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  Padding(
  padding: const EdgeInsets.all(16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        widget.hotel.hotelName,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1, // Limit to 1 line
        overflow: TextOverflow.ellipsis, // Add "..." if text overflows
      ),
      const SizedBox(height: 4),
      Row(crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on,
            color: maincolor1,
            size: 16,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              widget.hotel.address,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
              maxLines: 2, // Limit to 2 lines
              overflow: TextOverflow.ellipsis, // Add "..." if text overflows
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
    ],
  ),
),

                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Dates Section with validation
              const Text(
                "Booking Dates *",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectDate(context, true),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: checkIn == null ? Colors.red : Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: checkIn == null ? Colors.red : maincolor1,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Check-In",
                                  style: TextStyle(
                                    color: checkIn == null ? Colors.red : Colors.grey.shade700,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              checkIn != null
                                  ? DateFormat('EEE, MMM d, y').format(checkIn!)
                                  : 'Select Date *',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: checkIn == null ? Colors.red : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectDate(context, false),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: checkOut == null ? Colors.red : Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: checkOut == null ? Colors.red : maincolor1,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Check-Out",
                                  style: TextStyle(
                                    color: checkOut == null ? Colors.red : Colors.grey.shade700,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              checkOut != null
                                  ? DateFormat('EEE, MMM d, y').format(checkOut!)
                                  : 'Select Date *',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: checkOut == null ? Colors.red : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (checkIn != null && checkOut != null && checkOut!.isBefore(checkIn!))
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Check-out date must be after check-in date",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 24),

              // Guest Information
              const Text(
                "Guest Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: nationality,
                decoration: InputDecoration(
                  labelText: 'Guest Nationality',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.flag, color: maincolor1),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                items: countries
                    .map(
                      (c) => DropdownMenuItem(
                        value: c.code,
                        child: Text(c.name),
                      ),
                    )
                    .toList(),
                onChanged: (val) => setState(() => nationality = val!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: noOfRoomsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Number of Rooms',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.meeting_room, color: maincolor1),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                onChanged: (val) {
                  final newCount = int.tryParse(val) ?? 1;
                  setState(() {
                    paxRooms = List.generate(newCount, (index) {
                      return {
                        'adults': 2,
                        'children': 0,
                        'childrenAges': <int>[],
                      };
                    });
                  });
                },
              ),
              const SizedBox(height: 16),
              Column(children: List.generate(paxRooms.length, _roomCard)),
              const SizedBox(height: 16),

              // Preferences Section
              const Text(
                "Preferences",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SwitchListTile(
                        value: refundableOnly,
                        onChanged: (val) => setState(() => refundableOnly = val),
                        title: const Text("Only Refundable Rooms"),
                        secondary: Icon(
                          Icons.assignment_return,
                          color: maincolor1,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 0,
                        ),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: Icon(Icons.restaurant, color: maincolor1),
                        title: const Text("Meal Type"),
                        trailing: DropdownButton<String>(
                          value: mealType,
                          underline: Container(),
                          items: const [
                            DropdownMenuItem(
                              value: 'All',
                              child: Text('All Meals'),
                            ),
                            DropdownMenuItem(
                              value: 'WithMeal',
                              child: Text('With Meal'),
                            ),
                            DropdownMenuItem(
                              value: 'RoomOnly',
                              child: Text('Room Only'),
                            ),
                          ],
                          onChanged: (val) => setState(() => mealType = val!),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Submit Button
             SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: _isLoading ? null : _submitForm,
    style: ElevatedButton.styleFrom(
      backgroundColor: maincolor1,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
      elevation: 4,
    ),
    child: _isLoading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
        : const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search, size: 20),
              SizedBox(width: 8),
              Text(
                "Check Availability",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
  ),
),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}