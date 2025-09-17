import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/cab/application/hold%20cab/hold_cab_bloc.dart';
import 'package:minna/cab/domain/cab%20list%20model/cab_list_data.dart';
import 'package:minna/cab/pages/payment%20page/payment.dart';
import 'package:minna/comman/const/const.dart';

class BookingPage extends StatefulWidget {
  final CabRate selectedCab;
  final Map<String, dynamic> requestData;

  const BookingPage({
    Key? key,
    required this.selectedCab,
    required this.requestData,
  }) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();
  final _primaryPhoneCodeController = TextEditingController(text: '+91');
  final _alternatePhoneCodeController = TextEditingController(text: '+91');

 
  String _firstName = '';
  String _lastName = '';
  String _primaryPhone = '';
  String _alternatePhone = '';
  String _email = '';
  String _specialInstructions = '';
  int _numPersons = 1;
  int _numLargeBags = 0;
  int _numSmallBags = 0;
  bool _carrierRequired = false;
  bool _kidsTravelling = false;
  bool _seniorCitizenTravelling = false;
  bool _womanTravelling = false;

  @override
  void dispose() {
    _primaryPhoneCodeController.dispose();
    _alternatePhoneCodeController.dispose();
    super.dispose();
  }

Map<String, dynamic>  _onConfirmBooking() {
  

  final cab = widget.selectedCab;
  final req = widget.requestData;

  // Function to get cab type ID
  int getCabTypeId(String type) {
    switch (type.toLowerCase()) {
      case "compact":
        return 1;
      case "suv":
        return 2;
      case "sedan":
        return 3;
      case "assured dzire":
        return 5;
      case "assured innova":
        return 6;
      case "compact (cng)":
        return 72;
      case "sedan (cng)":
        return 73;
      case "suv (cng)":
        return 74;
      default:
        return 1; // fallback to compact if type not found
    }
  }

  // Build traveller info
  final traveller = {
    "firstName": _firstName,
    "lastName": _lastName,
    "primaryContact": {
      "code": int.tryParse(_primaryPhoneCodeController.text.replaceAll('+', '')) ?? 91,
      "number": _primaryPhone,
    },
    "alternateContact": {
      "code": int.tryParse(_alternatePhoneCodeController.text.replaceAll('+', '')) ?? 91,
      "number": _alternatePhone,
    },
    "email": _email,
  };

  // Build additional info
  final additionalInfo = {
    "specialInstructions": _specialInstructions,
    "noOfPerson": _numPersons,
    "noOfLargeBags": _numLargeBags,
    "noOfSmallBags": _numSmallBags,
    "carrierRequired": _carrierRequired ? 1 : 0,
    "kidsTravelling": _kidsTravelling ? 1 : 0,
    "seniorCitizenTravelling": _seniorCitizenTravelling ? 1 : 0,
    "womanTravelling": _womanTravelling ? 1 : 0,
  };

  // Build routes array
  final List<Map<String, dynamic>> routes = [];
  if (req["routes"] != null && req["routes"].isNotEmpty) {
    for (var route in req["routes"]) {
      routes.add({
        "startDate": route["startDate"],
        "startTime": route["startTime"],
        "source": {
          "address": route["source"]["address"] ?? "",
          "coordinates": {
            "latitude": route["source"]["coordinates"]["latitude"],
            "longitude": route["source"]["coordinates"]["longitude"],
          }
        },
        "destination": {
          "address": route["destination"]["address"] ?? "",
          "coordinates": {
            "latitude": route["destination"]["coordinates"]["latitude"],
            "longitude": route["destination"]["coordinates"]["longitude"],
          }
        }
      });
    }
  }

  // Build the final JSON
  final bookingJson = {
    "tnc": 1,
    "referenceId": "tttt", // unique reference
    "tripType": req["tripType"], // 1,2,3,4,10,11 based on selection
    "cabType": getCabTypeId(cab.cab.type), // <-- use type ID
    "fare": {
      "advanceReceived": 0,
      "totalAmount": cab.fare.totalAmount ?? 0,
    },
    "sendEmail": 1,
    "sendSms": 1,
    "routes": routes,
    "traveller": traveller,
    "additionalInfo": additionalInfo,
    "platform": "android", // optional
    "apkVersion": "1.0.0", // optional
  };

  log("Booking JSON: ${bookingJson.toString()}");
  return bookingJson;
}


  @override
  Widget build(BuildContext context) {
    final cab = widget.selectedCab;
    final req = widget.requestData;

    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Cab Booking",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: maincolor1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              shadowColor: Colors.black12,
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Car Image
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: 80,
                      width: 100,
                      child: cab.cab.image.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                cab.cab.image,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.directions_car, 
                                      size: 40, color: maincolor1);
                                },
                              ),
                            )
                          : Icon(Icons.directions_car, size: 40, color: maincolor1),
                    ),
                    const SizedBox(width: 12),
    
                    // Cab Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cab.cab.category,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            cab.cab.model,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(
                                Icons.event_seat,
                                size: 18,
                                color: maincolor1,
                              ),
                              SizedBox(width: 4),
                              Text("${cab.cab.seatingCapacity} seats"),
                              SizedBox(width: 12),
                              Icon(
                                Icons.work,
                                size: 18,
                                color: Colors.orange,
                              ),
                              SizedBox(width: 4),
                              Text("${cab.cab.bagCapacity} bags"),
                            ],
                          ),
                        ],
                      ),
                    ),
    
                    // Fare
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "₹${cab.fare.totalAmount?.toStringAsFixed(0) ?? '0'}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: maincolor1,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Base: ₹${cab.fare.baseFare.toStringAsFixed(0)}",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
    
                const Divider(height: 20),
    
                // Extra Info Row
                Row(
                  children: [
                    Icon(
                      Icons.local_gas_station,
                      size: 16,
                      color: maincolor1,
                    ),
                    SizedBox(width: 4),
                    Text(cab.cab.fuelType ?? "Petrol"),
                    Spacer(),
                    Text(
                      "Policy: ${cab.cancellationPolicy}",
                      style: TextStyle(color: Colors.red[700], fontSize: 12),
                    ),
                  ],
                ),
                  ],
                ),
              ),
            )
      ,
            // Trip Info Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.directions_car, color: maincolor1),
                        SizedBox(width: 8),
                        Text(
                          "Trip Details",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: maincolor1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "From",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 4),
                                Text(
                      req["routes"][0]["source"]["address"] ?? "N/A",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_forward,
                              color: maincolor1,
                              size: 18,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "To",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                      req["routes"][0]["destination"]["address"] ?? "N/A",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                     if (req["routes"] != null && req["routes"].isNotEmpty)
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.grey),
              SizedBox(width: 8),
              Text(
                "${req["routes"][0]["startDate"]} at ${req["routes"][0]["startTime"]}",
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
                   
                  ],
                ),
              ),
            ),
      
            SizedBox(height: 24),
      
            // Passenger Info Section
            Text(
              "Passenger Information",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: maincolor1,
              ),
            ),
            SizedBox(height: 12),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                // side: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // First Name & Last Name Row
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "First Name",
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  size: 20,
                                ),
                                border: _outlineInputBorder(),
                                enabledBorder: _outlineInputBorder(),
                                focusedBorder: _outlineInputBorder(
                                  maincolor1!,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 12,
                                ),
                                isDense: true,
                              ),
                              style: TextStyle(fontSize: 14),
                              validator: (v) =>
                                  v!.isEmpty ? "Required" : null,
                              onChanged: (value) => _firstName = value,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Last Name",
                                border: _outlineInputBorder(),
                                enabledBorder: _outlineInputBorder(),
                                focusedBorder: _outlineInputBorder(
                                  maincolor1!,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 12,
                                ),
                                isDense: true,
                              ),
                              style: TextStyle(fontSize: 14),
                              validator: (v) =>
                                  v!.isEmpty ? "Required" : null,
                              onChanged: (value) => _lastName = value,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
      
                      // Primary Phone Row
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: _primaryPhoneCodeController,
                              decoration: InputDecoration(
                                labelText: "Code",
                                border: _outlineInputBorder(),
                                enabledBorder: _outlineInputBorder(),
                                focusedBorder: _outlineInputBorder(
                                  maincolor1!,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 12,
                                ),
                                isDense: true,
                              ),
                              style: TextStyle(fontSize: 14),
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            flex: 8,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Primary Phone",
                                prefixIcon: Icon(Icons.phone, size: 20),
                                border: _outlineInputBorder(),
                                enabledBorder: _outlineInputBorder(),
                                focusedBorder: _outlineInputBorder(
                                  maincolor1!,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 12,
                                ),
                                isDense: true,
                              ),
                              style: TextStyle(fontSize: 14),
                              keyboardType: TextInputType.phone,
                              validator: (v) =>
                                  v!.isEmpty ? "Required" : null,
                              onChanged: (value) => _primaryPhone = value,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
      
                      // Alternate Phone Row
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: _alternatePhoneCodeController,
                              decoration: InputDecoration(
                                labelText: "Code",
                                border: _outlineInputBorder(),
                                enabledBorder: _outlineInputBorder(),
                                focusedBorder: _outlineInputBorder(
                                  maincolor1!,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 12,
                                ),
                                isDense: true,
                              ),
                              style: TextStyle(fontSize: 14),
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            flex: 8,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Alternate Phone (Optional)",
                                prefixIcon: Icon(Icons.phone, size: 20),
                                border: _outlineInputBorder(),
                                enabledBorder: _outlineInputBorder(),
                                focusedBorder: _outlineInputBorder(
                                  maincolor1!,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 12,
                                ),
                                isDense: true,
                              ),
                              style: TextStyle(fontSize: 14),
                              keyboardType: TextInputType.phone,
                              onChanged: (value) => _alternatePhone = value,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
      
                      // Email Field
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email_outlined, size: 20),
                          border: _outlineInputBorder(),
                          enabledBorder: _outlineInputBorder(),
                          focusedBorder: _outlineInputBorder(maincolor1!),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 12,
                          ),
                          isDense: true,
                        ),
                        style: TextStyle(fontSize: 14),
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                          if (v!.isEmpty) return "Required";
                          if (!v.contains('@')) return "Invalid email";
                          return null;
                        },
                        onChanged: (value) => _email = value,
                      ),
                    ],
                  ),
                ),
              ),
            ),
      
            // Helper method for consistent borders
            SizedBox(height: 24),
      
            // Additional Info Section
            Text(
              "Additional Information",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color:  maincolor1,
              ),
            ),
            SizedBox(height: 8),
            Text("(Optional)", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 12),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Special Instructions
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Special Instructions",
                        prefixIcon: Icon(Icons.note_outlined, size: 20),
                        border: _outlineInputBorder(),
                        enabledBorder: _outlineInputBorder(),
                        focusedBorder: _outlineInputBorder(maincolor1!),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 12,
                        ),
                        isDense: true,
                      ),
                      style: TextStyle(fontSize: 14),
                      maxLines: 2,
                      onChanged: (value) => _specialInstructions = value,
                    ),
      
                    SizedBox(height: 15),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "No. of Persons",
                        prefixIcon: Icon(Icons.people_outline, size: 20),
                        border: _outlineInputBorder(),
                        enabledBorder: _outlineInputBorder(),
                        focusedBorder: _outlineInputBorder(maincolor1!),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 12,
                        ),
                        isDense: true,
                      ),
                      style: TextStyle(fontSize: 14),
                      keyboardType: TextInputType.number,
                      initialValue: _numPersons.toString(),
                      onChanged: (value) =>
                          _numPersons = int.tryParse(value) ?? 1,
                    ),
                    SizedBox(height: 15),
                    // Number Inputs Row
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Large Bags",
                              prefixIcon: Icon(Icons.work_outline, size: 20),
                              border: _outlineInputBorder(),
                              enabledBorder: _outlineInputBorder(),
                              focusedBorder: _outlineInputBorder(maincolor1!),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 12,
                              ),
                              isDense: true,
                            ),
                            style: TextStyle(fontSize: 14),
                            keyboardType: TextInputType.number,
                            initialValue: _numLargeBags.toString(),
                            onChanged: (value) =>
                                _numLargeBags = int.tryParse(value) ?? 0,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Small Bags",
                              prefixIcon: Icon(Icons.work_outlined, size: 20),
                              border: _outlineInputBorder(),
                              enabledBorder: _outlineInputBorder(),
                              focusedBorder: _outlineInputBorder(maincolor1!),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 12,
                              ),
                              isDense: true,
                            ),
                            style: TextStyle(fontSize: 14),
                            keyboardType: TextInputType.number,
                            initialValue: _numSmallBags.toString(),
                            onChanged: (value) =>
                                _numSmallBags = int.tryParse(value) ?? 0,
                          ),
                        ),
                      ],
                    ),
      
                    SizedBox(height: 8),
                    Divider(
                      height: 24,
                      thickness: 1,
                      color: Colors.grey.shade200,
                    ),
      
                    // Switch Tiles
                    _buildSwitchTile(
                      title: "Carrier Required",
                      value: _carrierRequired,
                      icon: Icons.luggage,
                      onChanged: (value) =>
                          setState(() => _carrierRequired = value),
                    ),
                    _buildSwitchTile(
                      title: "Kids Travelling",
                      value: _kidsTravelling,
                      icon: Icons.child_care,
                      onChanged: (value) =>
                          setState(() => _kidsTravelling = value),
                    ),
                    _buildSwitchTile(
                      title: "Senior Citizen",
                      value: _seniorCitizenTravelling,
                      icon: Icons.elderly,
                      onChanged: (value) =>
                          setState(() => _seniorCitizenTravelling = value),
                    ),
                    _buildSwitchTile(
                      title: "Woman Travelling",
                      value: _womanTravelling,
                      icon: Icons.female,
                      onChanged: (value) =>
                          setState(() => _womanTravelling = value),
                    ),
                  ],
                ),
              ),
            ),
      
            SizedBox(height: 32),
      
            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: maincolor1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  "CONFIRM BOOKING",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                onPressed: () {



                
  if (_formKey.currentState!.validate()) {
    // Build the booking JSON
    final bookingData = _onConfirmBooking();

    // Print for debugging
    log(bookingData.toString());

context.read<HoldCabBloc>().add(
HoldCabEvent.holdCab(requestData: bookingData),
);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookingConfirmationPage(
        ),
      ),
    );
  } else {
    // Show error snackbar if form invalid
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please fill all required fields')),
    );
  }


                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required IconData icon,
    required Function(bool) onChanged,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: maincolor1),
      title: Text(title, style: TextStyle(fontSize: 14)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: maincolor1!,
      ),
    );
  }
}

OutlineInputBorder _outlineInputBorder([Color color = Colors.grey]) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: color.withOpacity(0.3), width: 1),
  );
}

// // Switch Tile Widget (should be defined in your class)
Widget _buildSwitchTile({
  required String title,
  required bool value,
  required IconData icon,
  required Function(bool) onChanged,
}) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    minLeadingWidth: 24,
    leading: Icon(icon, size: 20, color: Colors.blue.shade700),
    title: Text(title, style: TextStyle(fontSize: 14)),
    trailing: Switch(
      value: value,
      onChanged: onChanged,
      activeColor: maincolor1!,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
  );
}
