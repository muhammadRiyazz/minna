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
import 'package:iconsax/iconsax.dart';

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
  // Theme standardizing: Use global constants directly from const.dart

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
      if (t.contains("compact") &&
          (t.contains("cng") || t.contains("economy"))) {
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
            },
          },
          "destination": {
            "address": route["destination"]["address"] ?? "",
            "coordinates": {
              "latitude": route["destination"]["coordinates"]["latitude"],
              "longitude": route["destination"]["coordinates"]["longitude"],
            },
          },
        });
      }
    }

    final bookingJson = {
      "tnc": 1,
      "referenceId": "tttt",
      "tripType": req["tripType"],
      "cabType": getCabTypeId(cab.cab.type),
      "fare": {"advanceReceived": 0, "totalAmount": cab.fare.totalAmount ?? 0},
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
    final color = isError ? errorColor : successColor;
    final icon = isError
        ? Icons.error_outline_rounded
        : Icons.check_circle_rounded;

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
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
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
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Premium Sliver App Bar
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            backgroundColor: maincolor1,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 20,
              ),
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
                    colors: [maincolor1, maincolor1.withOpacity(0.8)],
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
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: maincolor1.withOpacity(0.08),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: maincolor1.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          // Car Image
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: maincolor1.withOpacity(0.03)),
            ),
            height: 85,
            width: 100,
            child: cab.cab.image.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      cab.cab.image,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.directions_car_rounded,
                        size: 36,
                        color: secondaryColor.withOpacity(0.5),
                      ),
                    ),
                  )
                : Icon(
                    Icons.directions_car_rounded,
                    size: 36,
                    color: secondaryColor.withOpacity(0.5),
                  ),
          ),
          const SizedBox(width: 20),

          // Cab Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: secondaryColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    cab.cab.category.toUpperCase(),
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      color: secondaryColor,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  cab.cab.model,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: maincolor1,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _buildCompactSpec(
                      Icons.person_outline_rounded,
                      "${cab.cab.seatingCapacity} Seats",
                    ),
                    const SizedBox(width: 12),
                    _buildCompactSpec(Icons.work_outline_rounded, "Luggage"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactSpec(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: textSecondary),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: textSecondary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
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
            color: textLight,
            letterSpacing: 1,
          ),
        ),
        if (optional) ...[
          const SizedBox(width: 8),
          Text(
            "(OPTIONAL)",
            style: TextStyle(
              fontSize: 10,
              color: textLight.withOpacity(0.6),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPassengerInfoForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 25,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: maincolor1.withOpacity(0.04)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Full Name Section
            Text(
              'Full Name',
              style: TextStyle(
                color: textSecondary,
                fontWeight: FontWeight.w500,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildTextFormField(
                    label: "First Name",
                    prefixIcon: Iconsax.user,
                    validator: (v) => v!.isEmpty ? "Required" : null,
                    onChanged: (value) => _firstName = value,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTextFormField(
                    label: "Last Name",
                    prefixIcon: Iconsax.user,
                    validator: (v) => v!.isEmpty ? "Required" : null,
                    onChanged: (value) => _lastName = value,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Contact Information Section
            Text(
              'Contact Information',
              style: TextStyle(
                color: textSecondary,
                fontWeight: FontWeight.w500,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                // Country Code (Fixed +91)
                SizedBox(width: 80, child: _buildCountryCodeField(countryCode)),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildTextFormField(
                    label: "Primary Phone",
                    prefixIcon: Iconsax.mobile,
                    keyboardType: TextInputType.phone,
                    validator: (v) => v!.isEmpty ? "Required" : null,
                    onChanged: (value) => _primaryPhone = value,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                // Country Code (Fixed +91)
                SizedBox(width: 80, child: _buildCountryCodeField(countryCode)),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildTextFormField(
                    label: "Alternate Phone",
                    prefixIcon: Iconsax.call,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) => _alternatePhone = value,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Email Field
            _buildTextFormField(
              label: "Email Address",
              prefixIcon: Iconsax.sms,
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v!.isEmpty) return "Email is required";
                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(v))
                  return "Invalid email format";
                return null;
              },
              onChanged: (value) => _email = value,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCountryCodeField(String code) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderSoft, width: 1.5),
      ),
      child: TextFormField(
        initialValue: code,
        readOnly: true,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          labelText: "CODE",
          labelStyle: TextStyle(
            fontSize: 9,
            color: textSecondary,
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          isDense: true,
        ),
        style: TextStyle(
          fontSize: 14,
          color: textPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAdditionalInfoSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 25,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: maincolor1.withOpacity(0.03)),
      ),
      child: Column(
        children: [
          _buildTextFormField(
            label: "Special Instructions",
            prefixIcon: Iconsax.note_21,
            maxLines: 2,
            onChanged: (value) => _specialInstructions = value,
          ),
          const SizedBox(height: 24),

          // Counters Selection Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                _buildNumericSelector(
                  label: "Number of Persons",
                  value: _numPersons,
                  icon: Iconsax.user_tick,
                  onChanged: (v) => setState(() => _numPersons = v),
                ),
                const Divider(height: 24),
                _buildNumericSelector(
                  label: "Large Bags",
                  value: _numLargeBags,
                  icon: Iconsax.bag_2,
                  onChanged: (v) => setState(() => _numLargeBags = v),
                ),
                const Divider(height: 24),
                _buildNumericSelector(
                  label: "Small Bags",
                  value: _numSmallBags,
                  icon: Iconsax.bag_tick,
                  onChanged: (v) => setState(() => _numSmallBags = v),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Toggle Services Row (Wrap for responsiveness)
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildServiceToggle(
                "Kids",
                _kidsTravelling,
                (v) => setState(() => _kidsTravelling = v),
              ),
              _buildServiceToggle(
                "Carrier",
                _carrierRequired,
                (v) => setState(() => _carrierRequired = v),
              ),
              _buildServiceToggle(
                "Senior Citizen",
                _seniorCitizenTravelling,
                (v) => setState(() => _seniorCitizenTravelling = v),
              ),
              _buildServiceToggle(
                "Woman",
                _womanTravelling,
                (v) => setState(() => _womanTravelling = v),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNumericSelector({
    required String label,
    required int value,
    required IconData icon,
    required Function(int) onChanged,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: secondaryColor),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: textPrimary,
            ),
          ),
        ),
        Row(
          children: [
            _buildIconButton(
              Icons.remove_rounded,
              () => value > 0 ? onChanged(value - 1) : null,
            ),
            SizedBox(
              width: 40,
              child: Text(
                "$value",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: maincolor1,
                ),
              ),
            ),
            _buildIconButton(Icons.add_rounded, () => onChanged(value + 1)),
          ],
        ),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: maincolor1.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20, color: maincolor1),
      ),
    );
  }

  Widget _buildServiceToggle(
    String label,
    bool value,
    Function(bool) onChanged,
  ) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: value ? maincolor1 : backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: value ? maincolor1 : maincolor1.withOpacity(0.1),
          ),
          boxShadow: value
              ? [
                  BoxShadow(
                    color: maincolor1.withOpacity(0.2),
                    blurRadius: 8,
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: value ? Colors.white : textPrimary,
          ),
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
          child: GestureDetector(
            onTap: isLoading
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
                      _showCustomSnackbar(
                        'Please fill all required fields',
                        isError: true,
                      );
                    }
                  },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isLoading
                      ? [Colors.grey.shade400, Colors.grey.shade600]
                      : [maincolor1, const Color(0xFF004D9D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: isLoading
                    ? null
                    : [
                        BoxShadow(
                          color: maincolor1.withOpacity(0.35),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: isLoading
                  ? Center(
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "CONFIRM BOOKING",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                          ),
                        ),
                        SizedBox(width: 12),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextFormField({
    required String label,
    required IconData prefixIcon,
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
        labelStyle: TextStyle(
          fontSize: 10,
          color: textSecondary,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelStyle: TextStyle(
          color: secondaryColor,
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        fillColor: cardColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: borderSoft, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: borderSoft, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: secondaryColor, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: errorColor.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: errorColor, width: 2),
        ),
        prefixIcon: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(right: 5),
          child: Icon(prefixIcon, color: maincolor1, size: 16),
        ),
        isDense: true,
      ),
      style: TextStyle(
        fontSize: 12,
        color: textPrimary,
        fontWeight: FontWeight.bold,
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      onChanged: onChanged,
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String text,
    Color? textColor,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: textLight),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: textColor ?? textSecondary,
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
          color: secondaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: secondaryColor, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          color: textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: secondaryColor,
        activeTrackColor: secondaryColor.withOpacity(0.5),
      ),
    );
  }
}
