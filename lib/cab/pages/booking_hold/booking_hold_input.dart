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
  // Color Theme
  final Color _primaryColor = maincolor1;
  final Color _secondaryColor = secondaryColor;
  final Color _accentColor = accentColor;
  final Color _backgroundColor = backgroundColor;
  final Color _cardColor = cardColor;
  final Color _textPrimary = textPrimary;
  final Color _textSecondary = textSecondary;
  final Color _textLight = textLight;
  final Color _errorColor = errorColor;
  final Color _successColor = const Color(0xFF0D9488);

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
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Premium Sliver App Bar
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            backgroundColor: _primaryColor,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: const Text(
                'Passenger Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [_primaryColor, _primaryColor.withOpacity(0.8)],
                  ),
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Selected Cab Card
                _buildCabCard(cab),
                const SizedBox(height: 24),

                // Passenger Information Section
                _buildSectionHeader("PASSENGER CONTACT"),
                const SizedBox(height: 16),
                _buildPassengerInfoForm(),

                const SizedBox(height: 24),

                // Additional Information Section
                _buildSectionHeader("ADDITIONAL DETAILS", optional: true),
                const SizedBox(height: 16),
                _buildAdditionalInfoSection(),

                const SizedBox(height: 40),

                // Confirm Booking Button
                _buildConfirmButton(),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCabCard(CabRate cab) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          // Car Image
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _backgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            height: 70,
            width: 85,
            child: cab.cab.image.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      cab.cab.image,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => 
                          Icon(Icons.directions_car_rounded, size: 30, color: _secondaryColor),
                    ),
                  )
                : Icon(Icons.directions_car_rounded, size: 30, color: _secondaryColor),
          ),
          const SizedBox(width: 16),

          // Cab Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cab.cab.category.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: _secondaryColor,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  cab.cab.model,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: _textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.person_outline_rounded, size: 12, color: _textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      "${cab.cab.seatingCapacity} Seats",
                      style: TextStyle(fontSize: 11, color: _textSecondary, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {bool optional = false}) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: _textLight,
            letterSpacing: 1,
          ),
        ),
        if (optional) ...[
          const SizedBox(width: 8),
          Text(
            "(OPTIONAL)",
            style: TextStyle(
              fontSize: 10,
              color: _textLight.withOpacity(0.6),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
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
                  SizedBox(
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
                  SizedBox(
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
    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        initialValue: code,
        readOnly: true,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          labelText: "CODE",
          labelStyle: TextStyle(color: _textLight, fontSize: 10, fontWeight: FontWeight.w800),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          isDense: true,
        ),
        style: TextStyle(fontSize: 14, color: _textPrimary, fontWeight: FontWeight.bold),
      ),
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
        labelStyle: TextStyle(color: _textLight, fontSize: 12, fontWeight: FontWeight.w600),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: _secondaryColor, size: 20)
            : null,
        filled: true,
        fillColor: _backgroundColor,
        border: _outlineInputBorder(Colors.transparent),
        enabledBorder: _outlineInputBorder(Colors.transparent),
        focusedBorder: _outlineInputBorder(_secondaryColor),
        errorBorder: _outlineInputBorder(_errorColor),
        focusedErrorBorder: _outlineInputBorder(_errorColor),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        isDense: true,
      ),
      style: TextStyle(fontSize: 14, color: _textPrimary, fontWeight: FontWeight.w600),
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
        activeThumbColor: _secondaryColor,
        activeTrackColor: _secondaryColor.withOpacity(0.5),
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder([Color color = Colors.grey]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: color.withOpacity(0.5), width: 1.5),
    );
  }
}