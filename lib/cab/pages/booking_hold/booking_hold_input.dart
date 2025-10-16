import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/cab/application/hold%20cab/hold_cab_bloc.dart';
import 'package:minna/cab/domain/cab%20list%20model/cab_list_data.dart';
import 'package:minna/cab/function/commission_data.dart';
import 'package:minna/cab/pages/payment%20page/payment.dart';
import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/pages/log%20in/login_page.dart';

class BookingPage extends StatefulWidget {
  final CabRate selectedCab;
  final Map<String, dynamic> requestData;

  const BookingPage({
    super.key,
    required this.selectedCab,
    required this.requestData,
  });

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Only India country code
  final String countryCode = '+91';
  
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
  late CommissionProvider commissionProvider;

  // Color Theme
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37);
  final Color _accentColor = Color(0xFFC19B3C);
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);
  final Color _errorColor = Color(0xFFE53935);
  final Color _successColor = Color(0xFF00C853);

  @override
  void initState() {
    context.read<LoginBloc>().add(const LoginEvent.loginInfo());
    super.initState();
    commissionProvider = context.read<CommissionProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preCalculateCommissions();
    });
  }

  Future<void> _preCalculateCommissions() async {
    commissionProvider = context.read<CommissionProvider>();
    try {
      await commissionProvider.getCommission();
    } catch (e) {
      log('Commission pre-calculation error: $e');
    }
  }

  Future<Map<String, dynamic>> _onConfirmBooking() async {
    final isLoggedIn = context.read<LoginBloc>().state.isLoggedIn ?? false;

    if (!isLoggedIn) {
      final loginResult = await showModalBottomSheet<bool>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const LoginBottomSheet(login: 1),
      );

      if (loginResult != true) {
        _showCustomSnackbar('Please login to continue', isError: true);
        return {};
      }
    }

    final cab = widget.selectedCab;
    final req = widget.requestData;

    int getCabTypeId(String type) {
      final t = type.toLowerCase().trim();
      log("Cab type from API: $t");

      if (t.contains("compact") && t.contains("value")) {
        return 1;
      }
      if (t.contains("compact") && (t.contains("cng") || t.contains("economy"))) {
        return 72;
      }
      if (t.contains("suv") && t.contains("value")) {
        return 2;
      }
      if (t.contains("suv") && (t.contains("cng") || t.contains("economy"))) {
        return 74;
      }
      if (t.contains("sedan") && t.contains("value")) {
        return 3;
      }
      if (t.contains("sedan") && (t.contains("cng") || t.contains("economy"))) {
        return 73;
      }
      if (t.contains("assured dzire")) {
        return 5;
      }
      if (t.contains("assured innova") || t.contains("toyota innova")) {
        return 6;
      }
      return 1;
    }

    final traveller = {
      "firstName": _firstName,
      "lastName": _lastName,
      "primaryContact": {
        "code": 91, // Fixed to India code
        "number": _primaryPhone,
      },
      "alternateContact": {
        "code": 91, // Fixed to India code
        "number": _alternatePhone,
      },
      "email": _email,
    };

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

    final bookingJson = {
      "tnc": 1,
      "referenceId": "tttt",
      "tripType": req["tripType"],
      "cabType": getCabTypeId(cab.cab.type),
      "fare": {
        "advanceReceived": 0,
        "totalAmount": cab.fare.totalAmount ?? 0,
      },
      "sendEmail": 1,
      "sendSms": 1,
      "routes": routes,
      "traveller": traveller,
      "additionalInfo": additionalInfo,
      "platform": "android",
      "apkVersion": "1.0.0",
    };

    log("Booking JSON: ${bookingJson.toString()}");
    return bookingJson;
  }

  void _showCustomSnackbar(String message, {bool isError = false}) {
    final color = isError ? _errorColor : _successColor;
    final icon = isError ? Icons.error_outline_rounded : Icons.check_circle_rounded;

    final snackBar = SnackBar(
      margin: const EdgeInsets.fromLTRB(16, 20, 16, 10),
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      duration: const Duration(seconds: 3),
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final cab = widget.selectedCab;

    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: Text(
          "Cab Booking",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Selected Cab Card
            _buildCabCard(cab),
            const SizedBox(height: 24),

            // Passenger Information Section
            _buildSectionHeader("Passenger Information"),
            const SizedBox(height: 16),
            _buildPassengerInfoForm(),

            const SizedBox(height: 24),

            // Additional Information Section
            _buildSectionHeader("Additional Information", optional: true),
            const SizedBox(height: 16),
            _buildAdditionalInfoSection(),

            const SizedBox(height: 32),

            // Confirm Booking Button
            _buildConfirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCabCard(CabRate cab) {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Car Image
                Container(
                  width: 100,
                  height: 80,
                  decoration: BoxDecoration(
                    color: _backgroundColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: cab.cab.image.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            cab.cab.image,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(
                                  Icons.directions_car_rounded,
                                  size: 40,
                                  color: _secondaryColor,
                                ),
                              );
                            },
                          ),
                        )
                      : Center(
                          child: Icon(
                            Icons.directions_car_rounded,
                            size: 40,
                            color: _secondaryColor,
                          ),
                        ),
                ),
                const SizedBox(width: 16),

                // Cab Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cab.cab.category,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        cab.cab.model,
                        style: TextStyle(
                          fontSize: 14,
                          color: _textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
          
            // Row(
            //   children: [
            //     _buildInfoItem(
            //       icon: Icons.local_gas_station_rounded,
            //       text: cab.cab.fuelType ?? "Petrol",
            //     ),
            //     Spacer(),
            //     _buildInfoItem(
            //       icon: Icons.policy_rounded,
            //       text: "Free cancellation",
            //       textColor: _successColor,
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {bool optional = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _textPrimary,
          ),
        ),
        if (optional)
          Text(
            "(Optional)",
            style: TextStyle(
              fontSize: 14,
              color: _textLight,
            ),
          ),
      ],
    );
  }

  Widget _buildPassengerInfoForm() {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Name Row
              Row(
                children: [
                  Expanded(
                    child: _buildTextFormField(
                      label: "First Name",
                      prefixIcon: Icons.person_outline_rounded,
                      validator: (v) => v!.isEmpty ? "Required" : null,
                      onChanged: (value) => _firstName = value,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextFormField(
                      label: "Last Name",
                      validator: (v) => v!.isEmpty ? "Required" : null,
                      onChanged: (value) => _lastName = value,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Primary Phone Row
              Row(
                children: [
                  // Country Code (Fixed +91)
                  Container(
                    width: 80,
                    child: _buildCountryCodeField(countryCode),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextFormField(
                      label: "Primary Phone",
                      prefixIcon: Icons.phone_rounded,
                      keyboardType: TextInputType.phone,
                      validator: (v) => v!.isEmpty ? "Required" : null,
                      onChanged: (value) => _primaryPhone = value,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Alternate Phone Row
              Row(
                children: [
                  // Country Code (Fixed +91)
                  Container(
                    width: 80,
                    child: _buildCountryCodeField(countryCode),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextFormField(
                      label: "Alternate Phone (Optional)",
                      prefixIcon: Icons.phone_rounded,
                      keyboardType: TextInputType.phone,
                      onChanged: (value) => _alternatePhone = value,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Email Field
              _buildTextFormField(
                label: "Email",
                prefixIcon: Icons.email_rounded,
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
    );
  }

  Widget _buildCountryCodeField(String code) {
    return TextFormField(
      initialValue: code,
      readOnly: true,
      decoration: InputDecoration(
        labelText: "Code",
        labelStyle: TextStyle(color: _textSecondary),
        border: _outlineInputBorder(),
        enabledBorder: _outlineInputBorder(),
        focusedBorder: _outlineInputBorder(_secondaryColor),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        isDense: true,
        // suffixIcon: Icon(Icons.lock_outline_rounded, size: 16, color: _textLight),
      ),
      style: TextStyle(fontSize: 13, color: _textPrimary),
    );
  }

  Widget _buildAdditionalInfoSection() {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTextFormField(
              label: "Special Instructions",
              prefixIcon: Icons.note_alt_rounded,
              maxLines: 2,
              onChanged: (value) => _specialInstructions = value,
            ),
            const SizedBox(height: 16),
            _buildTextFormField(
              label: "No. of Persons",
              prefixIcon: Icons.people_alt_rounded,
              keyboardType: TextInputType.number,
              initialValue: _numPersons.toString(),
              onChanged: (value) => _numPersons = int.tryParse(value) ?? 1,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextFormField(
                    label: "Large Bags",
                    prefixIcon: Icons.work_outline_rounded,
                    keyboardType: TextInputType.number,
                    initialValue: _numLargeBags.toString(),
                    onChanged: (value) => _numLargeBags = int.tryParse(value) ?? 0,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextFormField(
                    label: "Small Bags",
                    prefixIcon: Icons.work_outlined,
                    keyboardType: TextInputType.number,
                    initialValue: _numSmallBags.toString(),
                    onChanged: (value) => _numSmallBags = int.tryParse(value) ?? 0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(height: 1, color: Colors.grey.shade200),
            const SizedBox(height: 16),
            _buildSwitchTile(
              title: "Carrier Required",
              value: _carrierRequired,
              icon: Icons.luggage_rounded,
              onChanged: (value) => setState(() => _carrierRequired = value),
            ),
            _buildSwitchTile(
              title: "Kids Travelling",
              value: _kidsTravelling,
              icon: Icons.child_care_rounded,
              onChanged: (value) => setState(() => _kidsTravelling = value),
            ),
            _buildSwitchTile(
              title: "Senior Citizen",
              value: _seniorCitizenTravelling,
              icon: Icons.elderly_rounded,
              onChanged: (value) => setState(() => _seniorCitizenTravelling = value),
            ),
            _buildSwitchTile(
              title: "Woman Travelling",
              value: _womanTravelling,
              icon: Icons.female_rounded,
              onChanged: (value) => setState(() => _womanTravelling = value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return BlocConsumer<HoldCabBloc, HoldCabState>(
      listener: (context, state) {
        if (state is HoldCabError) {
          _showCustomSnackbar(state.message, isError: true);
        }

        if (state is HoldCabSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BookingConfirmationPage(
                requestData: state.requestData,
                bookingId: state.bookingId,
                tableID: state.tableID,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is HoldCabLoading;

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
              shadowColor: _secondaryColor.withOpacity(0.3),
            ),
            onPressed: isLoading
                ? null
                : () async {
                    if (_formKey.currentState!.validate()) {
                      final bookingData = await _onConfirmBooking();
                      if (bookingData.isEmpty) return;
                      log(bookingData.toString());
                      context.read<HoldCabBloc>().add(
                            HoldCabEvent.holdCab(requestData: bookingData),
                          );
                    } else {
                      _showCustomSnackbar('Please fill all required fields', isError: true);
                    }
                  },
            child: isLoading
                ? SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_forward_rounded, size: 20),
                      const SizedBox(width: 12),
                      Text(
                        "CONFIRM BOOKING",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Widget _buildTextFormField({
    String? label,
    IconData? prefixIcon,
    TextInputType? keyboardType,
    String? initialValue,
    int maxLines = 1,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: _textSecondary,fontSize: 12),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: _secondaryColor, size: 20)
            : null,
        border: _outlineInputBorder(),
        enabledBorder: _outlineInputBorder(),
        focusedBorder: _outlineInputBorder(_secondaryColor),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        isDense: true,
      ),
      style: TextStyle(fontSize: 13, color: _textPrimary),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      onChanged: onChanged,
    );
  }

  Widget _buildInfoItem({required IconData icon, required String text, Color? textColor}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: _textLight),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: textColor ?? _textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
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
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _secondaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: _secondaryColor, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 15, color: _textPrimary, fontWeight: FontWeight.w500),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: _secondaryColor,
        activeTrackColor: _secondaryColor.withOpacity(0.5),
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder([Color color = Colors.grey]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color.withOpacity(0.3), width: 1.5),
    );
  }
}