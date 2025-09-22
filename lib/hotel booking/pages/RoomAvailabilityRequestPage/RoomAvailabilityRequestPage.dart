import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/hotel%20booking/pages/Room%20Results%20Page/RoomAvailabilityResultsPage.dart';

class RoomAvailabilityRequestPage extends StatefulWidget {
  const RoomAvailabilityRequestPage({super.key});

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
  String nationality = 'AE';
  final noOfRoomsController = TextEditingController(text: '1');
  final responseTimeController = TextEditingController(text: '30');
  bool isDetailedResponse = false;
  bool refundableOnly = false;
  String mealType = 'All';

  List<Map<String, dynamic>> paxRooms = [
    {'adults': 2, 'children': 0, 'childrenAges': <int>[]},
  ];

  final List<Map<String, String>> countries = [
    {'code': 'AE', 'name': 'United Arab Emirates'},
    {'code': 'IN', 'name': 'India'},
    {'code': 'TR', 'name': 'Turkey'},
    {'code': 'US', 'name': 'United States'},
    {'code': 'GB', 'name': 'United Kingdom'},
  ];

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
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
                      room['childrenAges'] = List.filled(val ?? 0, 0);
                    });
                  },
                  style: const TextStyle(color: Colors.black),
                  dropdownColor: Colors.white,
                ),
              ],
            ),
            if ((room['children'] ?? 0) > 0) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 16,
                runSpacing: 12,
                children: List.generate(room['children'], (i) {
                  return SizedBox(
                    width: 80,
                    child: TextFormField(
                      initialValue: room['childrenAges'][i].toString(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Age ${i + 1}',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                      onChanged: (value) {
                        room['childrenAges'][i] = int.tryParse(value) ?? 0;
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
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c',
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Royale President Hotel',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: maincolor1,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '79 Place de la Madeleine, Paris, France',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
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

              // Dates Section
              const Text(
                "Booking Dates",
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
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: maincolor1,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Check-In",
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              checkIn != null
                                  ? DateFormat('EEE, MMM d, y').format(checkIn!)
                                  : 'Select Date',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
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
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: maincolor1,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Check-Out",
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              checkOut != null
                                  ? DateFormat(
                                      'EEE, MMM d, y',
                                    ).format(checkOut!)
                                  : 'Select Date',
                              style: const TextStyle(
                                fontSize: 16,
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
              const SizedBox(height: 24),

              // Guest Information
              const Text(
                "Guest Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: nationality,
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
                        value: c['code'],
                        child: Text(c['name']!),
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
                        onChanged: (val) =>
                            setState(() => refundableOnly = val),
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
                   onPressed: () {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RoomAvailabilityResultsPage(
            checkInDate: checkIn!,
            checkOutDate: checkOut!,
            rooms: paxRooms,
            nationality: nationality,
          ),
        ),
      );
    }
  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: maincolor1,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 4,
                  ),
                  child: const Row(
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
