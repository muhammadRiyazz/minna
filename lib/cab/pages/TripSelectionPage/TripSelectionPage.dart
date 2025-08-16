import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minna/comman/const/const.dart';

class TripSelectionPage extends StatefulWidget {
  const TripSelectionPage({super.key});

  @override
  _TripSelectionPageState createState() => _TripSelectionPageState();
}

class _TripSelectionPageState extends State<TripSelectionPage> {
  int _selectedTripType = 1;
  int? _selectedCabType;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

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
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
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
                    return _buildVehicleItem(entry.key, entry.value);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildVehicleItem(int cabId, String cabName) {
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
      trailing: _selectedCabType == cabId
          ? Icon(Icons.check_circle, color: Colors.blue[700])
          : null,
      onTap: () {
        setState(() {
          _selectedCabType = cabId;
        });
        Navigator.pop(context);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
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
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
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
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _proceedToBooking() {
    if (_sourceController.text.isEmpty ||
        _destinationController.text.isEmpty ||
        _selectedCabType == null) {
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
    // Navigate to booking summary
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

            // Location Fields
            _buildLocationCard(
              children: [
                _buildLocationField(
                  controller: _sourceController,
                  label: 'Pickup Location',
                  icon: Icons.local_taxi_outlined,
                  iconColor: primaryColor,
                ),
                const SizedBox(height: 16),
                _buildLocationField(
                  controller: _destinationController,
                  label: 'Drop Location',
                  icon: Icons.local_taxi_outlined,
                  iconColor: primaryColor,
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Date and Time
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
                      color: _selectedCabType != null
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
                            _selectedCabType != null
                                ? cabTypes[_selectedCabType]!
                                : 'Select your vehicle',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: _selectedCabType != null
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
