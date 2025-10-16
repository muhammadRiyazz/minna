


import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/flight/application/booking/booking_bloc.dart';
import 'package:minna/flight/application/fare%20request/fare_request_bloc.dart';
import 'package:minna/flight/application/nationality/nationality_bloc.dart';
import 'package:minna/flight/application/search%20data/search_data_bloc.dart';
import 'package:minna/flight/application/trip%20request/trip_request_bloc.dart';
import 'package:minna/flight/domain/fare%20request%20and%20respo/fare_respo.dart';
import 'package:minna/flight/domain/nation/nations.dart';
import 'package:minna/flight/presendation/booking%20page/widget.dart/loading.dart';
import 'package:minna/flight/presendation/confirm%20booking/confirm_booking.dart';
import 'package:minna/flight/presendation/widgets.dart';

class FlightBookingPage extends StatefulWidget {
  const FlightBookingPage({super.key});

  @override
  State<FlightBookingPage> createState() => _FlightBookingPageState();
}

class _FlightBookingPageState extends State<FlightBookingPage> {
  // Theme colors matching the hotel booking page
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37);
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);
  final Color _errorColor = Color(0xFFE53935);
  final Color _successColor = Color(0xFF4CAF50);
  final Color _warningColor = Color(0xFFFF9800);

  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // Lists to manage multiple passengers
  List<TextEditingController> firstNameControllers = [];
  List<TextEditingController> lastNameControllers = [];
  List<TextEditingController> dobControllers = [];
  List<TextEditingController> passportControllers = [];
  List<TextEditingController> expiryControllers = [];
  List<TextEditingController> addressControllers = [];
  List<TextEditingController> pincodeControllers = [];

  List<String?> selectedTitles = [];
  List<Country?> selectedNationalities = [];
  List<Country?> selectedCountriesOfIssue = [];
  List<bool> sameAsFirstPassenger = [];
  List<Meal?> selectedMeals = [];
  List<Baggage?> selectedBaggages = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  void _initializePassengerData(int passengerCount) {
    _clearPassengerData();

    for (int i = 0; i < passengerCount; i++) {
      firstNameControllers.add(TextEditingController());
      lastNameControllers.add(TextEditingController());
      dobControllers.add(TextEditingController());
      passportControllers.add(TextEditingController());
      expiryControllers.add(TextEditingController());
      addressControllers.add(TextEditingController());
      pincodeControllers.add(TextEditingController());

      selectedTitles.add(i == 0 ? 'Mr' : null);
      selectedNationalities.add(null);
      selectedCountriesOfIssue.add(null);
      sameAsFirstPassenger.add(i == 0 ? false : true);
      selectedMeals.add(null);
      selectedBaggages.add(null);
    }
  }

  void _clearPassengerData() {
    for (var controller in firstNameControllers) {
      controller.dispose();
    }
    for (var controller in lastNameControllers) {
      controller.dispose();
    }
    for (var controller in dobControllers) {
      controller.dispose();
    }
    for (var controller in passportControllers) {
      controller.dispose();
    }
    for (var controller in expiryControllers) {
      controller.dispose();
    }
    for (var controller in addressControllers) {
      controller.dispose();
    }
    for (var controller in pincodeControllers) {
      controller.dispose();
    }

    firstNameControllers.clear();
    lastNameControllers.clear();
    dobControllers.clear();
    passportControllers.clear();
    expiryControllers.clear();
    addressControllers.clear();
    pincodeControllers.clear();

    selectedTitles.clear();
    selectedNationalities.clear();
    selectedCountriesOfIssue.clear();
    sameAsFirstPassenger.clear();
    selectedMeals.clear();
    selectedBaggages.clear();
  }

  @override
  void dispose() {
    _clearPassengerData();
    contactNumberController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _showValidationError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: _errorColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: BlocBuilder<FareRequestBloc, FareRequestState>(
        builder: (context, state) {
          if (state.isLoading) {
            return bookingLoading();
          } else {
            final FFlightResponse flightResponse = state.respo!;
            final flightOption = flightResponse.journey?.flightOption;
            final searchState = context.read<SearchDataBloc>().state;

            final int travellers =
                searchState.travellers['adults']! +
                searchState.travellers['children']! +
                searchState.travellers['infants']!;

            if (firstNameControllers.length != travellers) {
              _initializePassengerData(travellers);
            }

            final hasSSRAvailability = flightResponse.ssrAvailability != null;
            final hasMealOptions =
                hasSSRAvailability &&
                flightResponse.ssrAvailability!.mealInfo != null &&
                flightResponse.ssrAvailability!.mealInfo!.isNotEmpty;
            final hasBaggageOptions =
                hasSSRAvailability &&
                flightResponse.ssrAvailability!.baggageInfo != null &&
                flightResponse.ssrAvailability!.baggageInfo!.isNotEmpty;

            return CustomScrollView(
              slivers: [
                // App Bar
                SliverAppBar(
                  backgroundColor: _primaryColor,
                  expandedHeight: 120,
                  floating: false,
                  pinned: true,
                  elevation: 4,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  shadowColor: Colors.black.withOpacity(0.3),
                  surfaceTintColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      'Passenger Details',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    centerTitle: true,
                    background: Container(
                      color: _primaryColor,
                    ),
                  ),
                ),

                // SSR Availability Card
                if (hasSSRAvailability && (hasMealOptions || hasBaggageOptions))
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.all(16),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: _secondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        // border: Border.all(color: _secondaryColor.withOpacity(0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: _secondaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.star_outlined,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Enhance Your Flight',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: _primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Add meals and extra baggage for a comfortable journey',
                            style: TextStyle(
                              color: _textSecondary,
                              fontSize: 13,
                              height: 1.5,
                            ),
                          ),
                          if (hasMealOptions || hasBaggageOptions) ...[
                            SizedBox(height: 16),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                if (hasMealOptions)
                                  _buildAddOnChip(
                                    icon: Icons.restaurant_menu_rounded,
                                    label: 'In-Flight Meals',
                                  ),
                                if (hasBaggageOptions)
                                  _buildAddOnChip(
                                    icon: Icons.work_outline_rounded,
                                    label: 'Extra Baggage',
                                  ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                // Contact Information
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(right: 15,left: 15,),
                    decoration: BoxDecoration(
                      color: _cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Header
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _secondaryColor.withOpacity(.1),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: _secondaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.contact_mail_rounded,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Contact Information',
                                style: TextStyle(
                                  fontSize: 13,
                                  
                                  fontWeight: FontWeight.w600,
                                  color: _primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Content
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your ticket and flight details will be sent to this contact',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: _textSecondary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 20),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    // Contact Number
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Contact Number',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: _textPrimary,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        TextFormField(
                                          controller: contactNumberController,
                                          decoration: InputDecoration(
                                            hintText: 'Enter your phone number',
                                            hintStyle: TextStyle(
                                              color: _textLight,
                                              fontSize: 14,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(color: Colors.grey[300]!),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(color: Colors.grey[300]!),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(color: _secondaryColor, width: 2),
                                            ),
                                            filled: true,
                                            fillColor: _backgroundColor,
                                            prefixIcon: Icon(Icons.phone_iphone_rounded, color: _textLight),
                                          ),
                                          keyboardType: TextInputType.phone,
                                          style: TextStyle(fontSize: 14, color: _textPrimary),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter contact number';
                                            }
                                            if (!RegExp(r'^[0-9]{10,15}$').hasMatch(value)) {
                                              return 'Please enter a valid phone number';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    // Email
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Email Address',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: _textPrimary,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        TextFormField(
                                          controller: emailController,
                                          decoration: InputDecoration(
                                            hintText: 'Enter your email address',
                                            hintStyle: TextStyle(
                                              color: _textLight,
                                              fontSize: 14,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(color: Colors.grey[300]!),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(color: Colors.grey[300]!),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(color: _secondaryColor, width: 2),
                                            ),
                                            filled: true,
                                            fillColor: _backgroundColor,
                                            prefixIcon: Icon(Icons.email_rounded, color: _textLight),
                                          ),
                                          keyboardType: TextInputType.emailAddress,
                                          style: TextStyle(fontSize: 14, color: _textPrimary),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter email address';
                                            }
                                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                              return 'Please enter a valid email';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Traveller Details Section
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: ExpansionTile(
                        collapsedIconColor: _primaryColor,
                        iconColor: _primaryColor,
                        initiallyExpanded: true,
                        textColor: _primaryColor,
                        tilePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                        collapsedBackgroundColor: _secondaryColor.withOpacity(.1),
                        collapsedTextColor: _primaryColor,
                        backgroundColor: _secondaryColor.withOpacity(.1),
                        collapsedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        title: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: _secondaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.people_rounded,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Traveller Details',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _secondaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                travellers.toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        children: List.generate(travellers, (index) {
                          final isAdult = index < searchState.travellers['adults']!;
                          final isChild = !isAdult && index < searchState.travellers['adults']! + searchState.travellers['children']!;
                          final isInfant = !isAdult && !isChild;
                          final isFirstPassenger = index == 0;

                          return _buildPassengerForm(
                            context: context,
                            index: index,
                            isAdult: isAdult,
                            isChild: isChild,
                            isInfant: isInfant,
                            isFirstPassenger: isFirstPassenger,
                            hasMeals: hasMealOptions,
                            hasBaggage: hasBaggageOptions,
                            flightResponse: flightResponse,
                          );
                        }),
                      ),
                    ),
                  ),
                ),

                // Submit Button
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: _isSubmitting ? null : () => _submitForm(context, state, flightOption!, searchState),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            padding: EdgeInsets.symmetric(vertical: 18),
                            elevation: 2,
                            minimumSize: Size(double.infinity, 50),
                          ),
                          child: _isSubmitting
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.arrow_forward_rounded, size: 20),
                                    SizedBox(width: 12),
                                    Text(
                                      'Continue to Payment',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 30)),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildPassengerForm({
    required BuildContext context,
    required int index,
    required bool isAdult,
    required bool isChild,
    required bool isInfant,
    required bool isFirstPassenger,
    required bool hasMeals,
    required bool hasBaggage,
    required FFlightResponse flightResponse,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          color: _cardColor,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: BlocBuilder<NationalityBloc, NationalityState>(
                builder: (context, state) {
                  if (selectedNationalities[index] == null && state.nationalitList.isNotEmpty) {
                    selectedNationalities[index] = state.nationalitList.firstWhere(
                      (country) => country.countryCode == 'IN',
                      orElse: () => state.nationalitList.first,
                    );
                  }
                  if (selectedCountriesOfIssue[index] == null && state.nationalitList.isNotEmpty) {
                    selectedCountriesOfIssue[index] = state.nationalitList.firstWhere(
                      (country) => country.countryCode == 'IN',
                      orElse: () => state.nationalitList.first,
                    );
                  }
                  if (selectedTitles[index] == null) {
                    selectedTitles[index] = isChild || isInfant ? 'Mstr' : 'Mr';
                  }
            
                  final ptc = isChild ? 'CHD' : isInfant ? 'INF' : 'ADT';
                  final mealOptions = hasMeals
                      ? flightResponse.ssrAvailability!.mealInfo![0].meals!.where((meal) => meal.ptc == ptc).toList()
                      : [];
                  final baggageOptions = hasBaggage
                      ? flightResponse.ssrAvailability!.baggageInfo![0].baggages!.where((baggage) => baggage.ptc == ptc).toList()
                      : [];
            
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Passenger Header
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              _secondaryColor.withOpacity(0.1),
                              _secondaryColor.withOpacity(0.05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: _secondaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isAdult ? Icons.person_rounded : 
                                isChild ? Icons.child_care_rounded : Icons.child_friendly_rounded,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 12),
                            Text(
                              isAdult ? 'ADULT ${index + 1}' : isChild ? 'CHILD ${index + 1}' : 'INFANT ${index + 1}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: _primaryColor,
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _primaryColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                isAdult ? 'ADULT' : isChild ? 'CHILD' : 'INFANT',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
            
                      // Title Dropdown
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: _textPrimary,
                            ),
                          ),
                          SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              hintText: 'Select Title',
                              hintStyle: TextStyle(color: _textLight, fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: _secondaryColor, width: 2),
                              ),
                              filled: true,
                              fillColor: _backgroundColor,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            ),
                            isExpanded: true,
                            dropdownColor: _cardColor,
                            icon: Icon(Icons.arrow_drop_down_rounded, color: _textSecondary, size: 24),
                            items: [
                              if (isChild || isInfant)
                                DropdownMenuItem(
                                  value: 'Mstr',
                                  child: Text('Master', style: TextStyle(fontSize: 14, color: _textPrimary)),
                                ),
                              if (!isChild && !isInfant) ...[
                                DropdownMenuItem(
                                  value: 'Mr',
                                  child: Text('Mr', style: TextStyle(fontSize: 14, color: _textPrimary)),
                                ),
                                DropdownMenuItem(
                                  value: 'Mrs',
                                  child: Text('Mrs', style: TextStyle(fontSize: 14, color: _textPrimary)),
                                ),
                                DropdownMenuItem(
                                  value: 'Ms',
                                  child: Text('Ms', style: TextStyle(fontSize: 14, color: _textPrimary)),
                                ),
                              ],
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedTitles[index] = value;
                              });
                            },
                            value: selectedTitles[index],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
            Row(children: [
            
              Expanded(
                child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'First Name',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: _textPrimary,
                              ),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              controller: firstNameControllers[index],
                              decoration: InputDecoration(
                                hintText: 'Enter first name',
                                hintStyle: TextStyle(color: _textLight, fontSize: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: _secondaryColor, width: 2),
                                ),
                                filled: true,
                                fillColor: _backgroundColor,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              ),
                              style: TextStyle(fontSize: 14, color: _textPrimary),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter first name';
                                }
                                if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                                  return 'Only alphabets are allowed';
                                }
                                if (value.length < 2) {
                                  return 'Minimum 2 characters required';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
              ),
            SizedBox(width: 12,),
                      // Last Name
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Last Name',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: _textPrimary,
                              ),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              controller: lastNameControllers[index],
                              decoration: InputDecoration(
                                hintText: 'Enter last name',
                                hintStyle: TextStyle(color: _textLight, fontSize: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: _secondaryColor, width: 1),
                                ),
                                filled: true,
                                fillColor: _backgroundColor,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              ),
                              style: TextStyle(fontSize: 14, color: _textPrimary),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter last name';
                                }
                                if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                                  return 'Only alphabets are allowed';
                                }
                                if (value.length < 2) {
                                  return 'Minimum 2 characters required';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
            
            
            ],),
                      // First Name
                    
                      SizedBox(height: 20),
            
                      // Nationality
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nationality',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: _textPrimary,
                            ),
                          ),
                          SizedBox(height: 8),
                          DropdownButtonFormField<Country>(
                            decoration: InputDecoration(
                              hintText: 'Select Nationality',
                              hintStyle: TextStyle(color: _textLight, fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: _secondaryColor, width: 1),
                              ),
                              filled: true,
                              fillColor: _backgroundColor,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            ),
                            isExpanded: true,
                            dropdownColor: _cardColor,
                            icon: Icon(Icons.arrow_drop_down_rounded, color: _textSecondary, size: 24),
                            value: selectedNationalities[index],
                            items: state.nationalitList.map((Country value) {
                              return DropdownMenuItem<Country>(
                                value: value,
                                child: Text(value.countryName, style: TextStyle(fontSize: 14, color: _textPrimary)),
                              );
                            }).toList(),
                            onChanged: (Country? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  selectedNationalities[index] = newValue;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
            
                      // Date of Birth
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date of Birth',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: _textPrimary,
                            ),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            readOnly: true,
                            controller: dobControllers[index],
                            decoration: InputDecoration(
                              hintText: 'Select date of birth',
                              hintStyle: TextStyle(color: _textLight, fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: _secondaryColor, width: 1),
                              ),
                              filled: true,
                              fillColor: _backgroundColor,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              suffixIcon: Icon(Icons.calendar_today_rounded, size: 20, color: _textSecondary),
                            ),
                            style: TextStyle(fontSize: 14, color: _textPrimary),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: isInfant
                                    ? DateTime.now().subtract(Duration(days: 365))
                                    : isChild
                                        ? DateTime.now().subtract(Duration(days: 365 * 5))
                                        : DateTime.now().subtract(Duration(days: 365 * 18)),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  dobControllers[index].text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                });
                              }
                            },
                          ),
                        ],
                      ),
            
                      if (!isInfant) ...[
                        SizedBox(height: 20),
                        // Passport Number
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Passport Number',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: _textPrimary,
                              ),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              controller: passportControllers[index],
                              decoration: InputDecoration(
                                hintText: 'Enter passport number',
                                hintStyle: TextStyle(color: _textLight, fontSize: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: _secondaryColor, width: 1),
                                ),
                                filled: true,
                                fillColor: _backgroundColor,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              ),
                              style: TextStyle(fontSize: 14, color: _textPrimary),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        // Passport Expiry
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Passport Expiry',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: _textPrimary,
                              ),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              readOnly: true,
                              controller: expiryControllers[index],
                              decoration: InputDecoration(
                                hintText: 'Select expiry date',
                                hintStyle: TextStyle(color: _textLight, fontSize: 14),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: _secondaryColor, width: 2),
                                ),
                                filled: true,
                                fillColor: _backgroundColor,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                suffixIcon: Icon(Icons.calendar_today_rounded, size: 20, color: _textSecondary),
                              ),
                              style: TextStyle(fontSize: 14, color: _textPrimary),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now().add(Duration(days: 365 * 5)),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
                                if (pickedDate != null) {
                                  setState(() {
                                    expiryControllers[index].text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        // Country of Issue
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Country of Issue',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: _textPrimary,
                              ),
                            ),
                            SizedBox(height: 8),
                            DropdownButtonFormField<Country>(
                              decoration: InputDecoration(
                                hintText: 'Select country',
                                hintStyle: TextStyle(color: _textLight, fontSize: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: _secondaryColor, width: 2),
                                ),
                                filled: true,
                                fillColor: _backgroundColor,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              ),
                              isExpanded: true,
                              dropdownColor: _cardColor,
                              icon: Icon(Icons.arrow_drop_down_rounded, color: _textSecondary, size: 24),
                              value: selectedCountriesOfIssue[index],
                              items: state.nationalitList.map((Country value) {
                                return DropdownMenuItem<Country>(
                                  value: value,
                                  child: Text(value.countryName, style: TextStyle(fontSize: 14, color: _textPrimary)),
                                );
                              }).toList(),
                              onChanged: (Country? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    selectedCountriesOfIssue[index] = newValue;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ],
            
                      // Same as first passenger checkbox
                      if (!isFirstPassenger) ...[
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: _secondaryColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: _secondaryColor.withOpacity(0.2)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: _secondaryColor, width: 2),
                                ),
                                child: Theme(
                                  data: ThemeData(unselectedWidgetColor: Colors.transparent),
                                  child: Checkbox(
                                    value: sameAsFirstPassenger[index],
                                    onChanged: (value) {
                                      setState(() {
                                        sameAsFirstPassenger[index] = value ?? false;
                                      });
                                    },
                                    activeColor: _secondaryColor,
                                    checkColor: Colors.white,
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Use same details as first passenger',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: _textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
            
                      // Address fields (only if not same as first passenger)
                      if (!sameAsFirstPassenger[index]) ...[
                        SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Address',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: _textPrimary,
                              ),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              controller: addressControllers[index],
                              decoration: InputDecoration(
                                hintText: 'Enter your address',
                                hintStyle: TextStyle(color: _textLight, fontSize: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: _secondaryColor, width: 2),
                                ),
                                filled: true,
                                fillColor: _backgroundColor,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              ),
                              maxLines: 2,
                              style: TextStyle(fontSize: 14, color: _textPrimary),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pin Code',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: _textPrimary,
                              ),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              controller: pincodeControllers[index],
                              decoration: InputDecoration(
                                hintText: 'Enter pin code',
                                hintStyle: TextStyle(color: _textLight, fontSize: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: _secondaryColor, width: 2),
                                ),
                                filled: true,
                                fillColor: _backgroundColor,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              ),
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 14, color: _textPrimary),
                            ),
                          ],
                        ),
                      ],
            
                      // Meal selection
                      if (hasMeals) ...[
                        SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.restaurant_menu_rounded, size: 16, color: _secondaryColor),
                                SizedBox(width: 8),
                                Text(
                                  'Select Meal (Optional)',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: _textPrimary,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            DropdownButtonFormField<Meal>(
                              decoration: InputDecoration(
                                hintText: 'Choose a meal option',
                                hintStyle: TextStyle(color: _textLight, fontSize: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: _secondaryColor, width: 2),
                                ),
                                filled: true,
                                fillColor: _backgroundColor,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              ),
                              isExpanded: true,
                              dropdownColor: _cardColor,
                              icon: Icon(Icons.arrow_drop_down_rounded, color: _textSecondary, size: 24),
                              hint: Text('No meal selected', style: TextStyle(fontSize: 14, color: _textLight)),
                              value: selectedMeals[index],
                              items: mealOptions.cast<Meal>().map<DropdownMenuItem<Meal>>((meal) {
                                return DropdownMenuItem<Meal>(
                                  value: meal,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        meal.name ?? 'Meal',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: _textPrimary,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        '${meal.amount?.toStringAsFixed(2) ?? '0.00'} ${meal.currency ?? 'INR'}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: _secondaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (Meal? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    selectedMeals[index] = newValue;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ],
            
                      // Baggage selection
                      if (hasBaggage) ...[
                        SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.work_outline_rounded, size: 16, color: _secondaryColor),
                                SizedBox(width: 8),
                                Text(
                                  'Add Baggage (Optional)',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: _textPrimary,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            DropdownButtonFormField<Baggage>(
                              decoration: InputDecoration(
                                hintText: 'Choose baggage option',
                                hintStyle: TextStyle(color: _textLight, fontSize: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: _secondaryColor, width: 2),
                                ),
                                filled: true,
                                fillColor: _backgroundColor,
                              ),
                              isExpanded: true,
                              dropdownColor: _cardColor,
                              icon: Icon(Icons.arrow_drop_down_rounded, color: _textSecondary, size: 24),
                              hint: Text('No baggage selected', style: TextStyle(fontSize: 14, color: _textLight)),
                              value: selectedBaggages[index],
                              items: baggageOptions.map((dynamic item) {
                                final baggage = item as Baggage;
                                return DropdownMenuItem<Baggage>(
                                  value: baggage,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        baggage.name ?? baggage.code ?? 'Baggage',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: _textPrimary,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        '${baggage.amount ?? ''} ${baggage.currency ?? 'INR'}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: _secondaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (Baggage? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    selectedBaggages[index] = newValue;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                      SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ),
          ));
          });
    //   },
    // );
  }

  Widget _buildAddOnChip({
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(color: _secondaryColor.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: _secondaryColor.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: _secondaryColor),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: _primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm(BuildContext context, FareRequestState state, FFlightOption flightOption, SearchDataState searchState) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      final hasReprice = state.respo!.journey!.flightOption!.reprice == true;
      final hasBaggage = selectedBaggages.any((b) => b != null);
      final hasMeals = selectedMeals.any((m) => m != null);

      final tripState = context.read<TripRequestBloc>().state;
      final searchData = context.read<SearchDataBloc>().state;

      List<Map<String, dynamic>> passengerDataList = [];

      for (int i = 0; i < firstNameControllers.length; i++) {
        final legKey = flightOption.flightLegs!.first.key;

        passengerDataList.add({
          'paxNo': state.respo!.passengerInfo![i].paxNo,
          'paxKey': state.respo!.passengerInfo![i].paxKey,
          'email': emailController.text,
          'contact': contactNumberController.text,
          'title': selectedTitles[i]!.trim(),
          'firstName': firstNameControllers[i].text,
          'lastName': lastNameControllers[i].text,
          'dob': dobControllers[i].text,
          'nationality': selectedNationalities[i]?.countryCode,
          'passportNumber': passportControllers[i].text,
          'passportExpiry': expiryControllers[i].text,
          "CountryCode": "0091",
          'countryOfIssue': selectedCountriesOfIssue[i]?.countryCode,
          'address': sameAsFirstPassenger[i] && i > 0
              ? addressControllers[0].text
              : addressControllers[i].text,
          'pincode': sameAsFirstPassenger[i] && i > 0
              ? pincodeControllers[0].text
              : pincodeControllers[i].text,
          'passengerType': i < searchData.travellers['adults']!
              ? 'ADT'
              : i < searchData.travellers['adults']! + searchData.travellers['children']!
                  ? 'CHD'
                  : 'INF',
          'meal': selectedMeals[i] != null
              ? {
                  'code': selectedMeals[i]!.code,
                  'name': selectedMeals[i]!.name,
                  'amount': selectedMeals[i]!.amount,
                  'currency': selectedMeals[i]!.currency,
                  'legKey': legKey,
                }
              : null,
          'baggage': selectedBaggages[i] != null
              ? {
                  'code': selectedBaggages[i]!.code,
                  'name': selectedBaggages[i]!.name,
                  'amount': selectedBaggages[i]!.amount,
                  'currency': selectedBaggages[i]!.currency,
                  'legKey': legKey,
                }
              : null,
        });
      }

      context.read<BookingBloc>().add(
        BookingEvent.getRePrice(
          reprice: hasReprice || hasBaggage || hasMeals,
          tripMode: searchData.oneWay ? 'O' : 'S',
          fareReData: flightOption,
          passengerDataList: passengerDataList,
          token: tripState.token ?? '',
        ),
      );

      log('Booking request payload: ${passengerDataList.toString()}');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingConfirmationScreen(
            flightinfo: flightOption,
          ),
        ),
      ).then((_) {
        setState(() {
          _isSubmitting = false;
        });
      });
    } else {
      _showValidationError('Please fill all required fields correctly');
    }
  }
}