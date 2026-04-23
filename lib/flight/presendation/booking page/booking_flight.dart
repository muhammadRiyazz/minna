import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/pages/log%20in/login_page.dart';
import 'package:minna/flight/application/booking/booking_bloc.dart';
import 'package:minna/flight/application/fare%20request/fare_request_bloc.dart';
import 'package:minna/flight/application/nationality/nationality_bloc.dart';
import 'package:minna/flight/application/search%20data/search_data_bloc.dart';
import 'package:minna/flight/application/trip%20request/trip_request_bloc.dart';
import 'package:minna/flight/domain/fare%20request%20and%20respo/fare_respo.dart';
import 'package:minna/flight/domain/nation/nations.dart';
import 'package:minna/flight/presendation/booking%20page/widget.dart/loading.dart';
import 'package:minna/flight/presendation/confirm%20booking/confirm_booking.dart';

class FlightBookingPage extends StatefulWidget {
  final String triptype;

  const FlightBookingPage({super.key, required this.triptype});

  @override
  State<FlightBookingPage> createState() => _FlightBookingPageState();
}

class _FlightBookingPageState extends State<FlightBookingPage> {
  final Color _errorColor = Color(0xFFE53935);
  final Color _successColor = Color(0xFF4CAF50);

  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController(
    text: '+91',
  ); // Default to India
  final TextEditingController emailController = TextEditingController();

  final List<Map<String, String>> countryCodes = [
    {'name': 'India', 'code': '+91', 'flag': '🇮🇳'},
    {'name': 'UAE', 'code': '+971', 'flag': '🇦🇪'},
    {'name': 'Qatar', 'code': '+974', 'flag': '🇶🇦'},
    {'name': 'Kuwait', 'code': '+965', 'flag': '🇰🇼'},
    {'name': 'Oman', 'code': '+968', 'flag': '🇴🇲'},
    {'name': 'Saudi Arabia', 'code': '+966', 'flag': '🇸🇦'},
    {'name': 'Bahrain', 'code': '+973', 'flag': '🇧🇭'},
    {'name': 'United Kingdom', 'code': '+44', 'flag': '🇬🇧'},
    {'name': 'USA', 'code': '+1', 'flag': '🇺🇸'},
  ];

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
  List<List<Meal?>> selectedMeals = [];
  List<List<Baggage?>> selectedBaggages = [];

  String _selectedISD = '+91';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;
  bool _isInfoExpanded = false;
  bool _waitingForReprice = false;

  void _initializePassengerData(
    int passengerCount,
    FFlightOption? flightOption,
  ) {
    _clearPassengerData();
    final int legCount = flightOption?.flightLegs?.length ?? 1;

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
      selectedMeals.add(List.generate(legCount, (_) => null));
      selectedBaggages.add(List.generate(legCount, (_) => null));
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
  void initState() {
    super.initState();
    _setupBookingListener();
    context.read<LoginBloc>().add(const LoginEvent.loginInfo());
  }

  void _setupBookingListener() {
    // This will be set up in the build method using BlocListener
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
            Icon(Iconsax.danger, color: Colors.white, size: 20),
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

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Iconsax.tick_circle, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: _successColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _navigateToConfirmationScreen(
    FFlightOption flightOption,
    String triptype,
  ) {
    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingConfirmationScreen(
          triptype: triptype,
          flightinfo: flightOption,
        ),
      ),
    ).then((_) {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
          _waitingForReprice = false;
        });
        // Reset the booking state
        context.read<BookingBloc>().add(BookingEvent.resetBooking());
      }
    });
  }

  void _handleRepriceCompletion(
    BookingState bookingState,
    FFlightOption flightOption,
    String tripType,
  ) {
    if (bookingState.isRepriceCompleted && _waitingForReprice) {
      // _showSuccessMessage('Flight details updated successfully!');
      _navigateToConfirmationScreen(flightOption, tripType);
      // log(
      //   ' flightOption ------------------------ _handleRepriceCompletion ========== ${flightOption.toJson().toString()}',
      // );
    } else if (bookingState.bookingError != null && _waitingForReprice) {
      setState(() {
        _isSubmitting = false;
        _waitingForReprice = false;
      });
      _showValidationError(bookingState.bookingError!);
    }
  }

  void _showCustomSnackbar(String message, {bool isError = false}) {
    final color = isError ? _errorColor : _successColor;
    final icon = isError ? Iconsax.danger : Iconsax.tick_circle;

    final snackBar = SnackBar(
      margin: EdgeInsets.all(16),
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withOpacity(0.2), width: 1),
      ),
      duration: Duration(seconds: 4),
      content: Row(
        children: [
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isError ? 'Error' : 'Success',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  message,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
      action: SnackBarAction(
        label: 'OK',
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _submitForm(
    BuildContext context,
    FareRequestState state,
    FFlightOption flightOption,
    SearchDataState searchState,
  ) async {
    final flightResponse = state.respo!;
    if (_formKey.currentState!.validate()) {
      final isLoggedIn = context.read<LoginBloc>().state.isLoggedIn ?? false;

      if (!isLoggedIn) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => const LoginBottomSheet(login: 1),
        );
        final newLoginState = context.read<LoginBloc>().state;
        if (newLoginState.isLoggedIn != true) {
          _showCustomSnackbar('Please login to continue', isError: true);
          return;
        }
      }

      setState(() {
        _isSubmitting = true;
        _waitingForReprice = true;
      });

      final hasReprice = state.respo!.journey!.flightOption!.reprice == true;
      final hasBaggage = selectedBaggages.any((b) => b != null);
      final hasMeals = selectedMeals.any((m) => m != null);

      final tripState = context.read<TripRequestBloc>().state;
      final searchData = context.read<SearchDataBloc>().state;

      List<Map<String, dynamic>> passengerDataList = [];

      for (int i = 0; i < firstNameControllers.length; i++) {
        final legKey = flightOption.flightLegs!.first.key;
        final tripMode = searchData.oneWay ? 'O' : 'S';

        final paxType = i < searchData.travellers['adults']!
            ? 'ADT'
            : i <
                  searchData.travellers['adults']! +
                      searchData.travellers['children']!
            ? 'CHD'
            : 'INF';

        final pInfo = state.respo!.passengerInfo!.firstWhere(
          (info) => info.ptc == paxType,
          orElse: () => state.respo!.passengerInfo!.first,
        );

        passengerDataList.add({
          'paxNo': pInfo.paxNo,
          'paxKey': pInfo.paxKey,
          'email': emailController.text,
          'contact': contactNumberController.text,
          'title': selectedTitles[i]!.trim(),
          'firstName': firstNameControllers[i].text,
          'lastName': lastNameControllers[i].text,
          'dob': dobControllers[i].text,
          'nationality': selectedNationalities[i]?.countryCode,
          'passportNumber': passportControllers[i].text,
          'passportExpiry': expiryControllers[i].text,
          'CountryCode': countryCodeController.text.replaceAll('+', ''),
          'countryOfIssue': selectedCountriesOfIssue[i]?.countryCode,
          'address': sameAsFirstPassenger[i] && i > 0
              ? addressControllers[0].text
              : addressControllers[i].text,
          'pincode': sameAsFirstPassenger[i] && i > 0
              ? pincodeControllers[0].text
              : pincodeControllers[i].text,
          'pincode': sameAsFirstPassenger[i] && i > 0
              ? pincodeControllers[0].text
              : pincodeControllers[i].text,
          'passengerType': paxType,
          'meals': selectedMeals[i]
              .asMap()
              .entries
              .where((entry) => entry.value != null)
              .map((entry) {
                final legIndex = entry.key;
                final meal = entry.value!;
                // Safely get legKey from flightOption
                final legKey =
                    (flightOption.flightLegs != null &&
                        flightOption.flightLegs!.length > legIndex)
                    ? flightOption.flightLegs![legIndex].key
                    : flightOption.flightLegs!.first.key;

                return {
                  'code': meal.code,
                  'name': meal.name,
                  'amount': meal.amount,
                  'currency': meal.currency,
                  'legKey': legKey,
                  'mealKey':
                      flightResponse.ssrAvailability?.mealInfo != null &&
                          flightResponse.ssrAvailability!.mealInfo!.length >
                              legIndex
                      ? flightResponse
                            .ssrAvailability!
                            .mealInfo![legIndex]
                            .mealKey
                      : flightResponse.ssrAvailability?.mealInfo?.first.mealKey,
                  'ptc': paxType,
                  'tripMode': tripMode,
                };
              })
              .toList(),
          'baggages': selectedBaggages[i]
              .asMap()
              .entries
              .where((entry) => entry.value != null)
              .map((entry) {
                final legIndex = entry.key;
                final baggage = entry.value!;
                // Safely get legKey from flightOption
                final legKey =
                    (flightOption.flightLegs != null &&
                        flightOption.flightLegs!.length > legIndex)
                    ? flightOption.flightLegs![legIndex].key
                    : flightOption.flightLegs!.first.key;

                return {
                  'code': baggage.code,
                  'name': baggage.name,
                  'amount': baggage.amount,
                  'currency': baggage.currency,
                  'legKey': legKey,
                  'baggageKey':
                      flightResponse.ssrAvailability?.baggageInfo != null &&
                          flightResponse.ssrAvailability!.baggageInfo!.length >
                              legIndex
                      ? flightResponse
                            .ssrAvailability!
                            .baggageInfo![legIndex]
                            .baggageKey
                      : flightResponse
                            .ssrAvailability
                            ?.baggageInfo
                            ?.first
                            .baggageKey,
                  'ptc': paxType,
                  'weight': baggage.name,
                  'tripMode': tripMode,
                };
              })
              .toList(),
        });
      }

      // Dispatch the reprice event
      context.read<BookingBloc>().add(
        BookingEvent.getRePrice(
          triptype: widget.triptype,
          reprice: hasReprice || hasBaggage || hasMeals,
          tripMode: searchData.oneWay ? 'O' : 'S',
          fareReData: flightOption,
          passengerDataList: passengerDataList,
          token: tripState.token ?? '',
          lastRespo: state.respo!,
        ),
      );

      log('Booking request payload: ${passengerDataList.toString()}');

      // Show loading indicator - navigation will happen automatically when reprice completes
    } else {
      _showValidationError('Please fill all required fields correctly');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocListener<BookingBloc, BookingState>(
        listener: (context, bookingState) {
          // Get the current fare state to access flight option
          final fareState = context.read<FareRequestBloc>().state;
          if (fareState.respo != null) {
            final flightOption = fareState.respo!.journey!.flightOption!;
            _handleRepriceCompletion(
              bookingState,
              flightOption,
              widget.triptype,
            );
          }
        },
        child: BlocBuilder<FareRequestBloc, FareRequestState>(
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

              final isInternational =
                  searchState.from?.countryCode != 'IN' ||
                  searchState.to?.countryCode != 'IN';

              if (firstNameControllers.length != travellers) {
                _initializePassengerData(travellers, flightOption);
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
                    backgroundColor: maincolor1,
                    expandedHeight: 120,
                    floating: false,
                    pinned: true,
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(
                        Iconsax.arrow_left,
                        color: Colors.white,
                        size: 22,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    centerTitle: true,
                    title: Text(
                      'Booking Details',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [maincolor1, maincolor1.withOpacity(0.8)],
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              right: -20,
                              top: -20,
                              child: Icon(
                                Iconsax.airplane,
                                size: 140,
                                color: Colors.white.withOpacity(0.05),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Flight Info Section
                  _buildFlightInfoSection(flightResponse),

                  // SSR Availability Card
                  if (hasSSRAvailability &&
                      (hasMealOptions || hasBaggageOptions))
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.all(16),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: secondaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: secondaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Iconsax.star,
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
                                    color: maincolor1,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Add meals and extra baggage for a comfortable journey',
                              style: TextStyle(
                                color: textSecondary,
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
                                      icon: Iconsax.coffee,
                                      label: 'In-Flight Meals',
                                    ),
                                  if (hasBaggageOptions)
                                    _buildAddOnChip(
                                      icon: Iconsax.briefcase,
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
                      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.grey.shade100,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: maincolor1.withOpacity(0.04),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Header
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: maincolor1.withOpacity(0.02),
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(24),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: maincolor1.withOpacity(0.05),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Iconsax.user_square,
                                    size: 20,
                                    color: maincolor1,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Contact Details',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                        color: maincolor1,
                                      ),
                                    ),
                                    Text(
                                      'Receive your ticket & updates here',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: textSecondary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Content
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: _buildModernDropdown<String>(
                                          label: 'Code',
                                          value: _selectedISD,
                                          icon: Iconsax.global,
                                          hint: '+91',
                                          items: countryCodes.map((country) {
                                            return DropdownMenuItem<String>(
                                              value: country['code'],
                                              child: Text(
                                                '${country['flag']} ${country['code']}',
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            );
                                          }).toList(),
                                          selectedItemBuilder: (context) {
                                            return countryCodes.map((country) {
                                              return Text(
                                                country['code']!,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              );
                                            }).toList();
                                          },
                                          onChanged: (val) {
                                            if (val != null) {
                                              setState(() {
                                                _selectedISD = val;
                                                countryCodeController.text =
                                                    val;
                                              });
                                            }
                                          },
                                          validator: (value) =>
                                              value == null ? 'Required' : null,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        flex: 5,
                                        child: _buildModernTextField(
                                          label: 'Phone Number',
                                          controller: contactNumberController,
                                          icon: Iconsax.mobile,
                                          hint: '9876543210',
                                          keyboardType: TextInputType.phone,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Required';
                                            }
                                            if (!RegExp(
                                              r'^[0-9]{7,12}$',
                                            ).hasMatch(value)) {
                                              return 'Invalid number';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  _buildModernTextField(
                                    label: 'Email Address',
                                    controller: emailController,
                                    icon: Iconsax.direct_right,
                                    hint: 'e.g. name@example.com',
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Required field';
                                      }
                                      if (!RegExp(
                                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                      ).hasMatch(value)) {
                                        return 'Invalid email';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Traveller Details Section
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.grey.shade100,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: maincolor1.withOpacity(0.04),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Theme(
                          data: Theme.of(
                            context,
                          ).copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            collapsedIconColor: maincolor1,
                            iconColor: maincolor1,
                            initiallyExpanded: true,
                            textColor: maincolor1,
                            tilePadding: EdgeInsets.zero,
                            collapsedBackgroundColor: maincolor1.withOpacity(
                              0.02,
                            ),
                            collapsedTextColor: maincolor1,
                            backgroundColor: Colors.transparent,
                            collapsedShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            title: Container(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: maincolor1.withOpacity(0.05),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Iconsax.user_tag,
                                      size: 20,
                                      color: maincolor1,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Traveller Details',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w900,
                                                color: maincolor1,
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: maincolor1.withOpacity(
                                                  0.1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                travellers.toString(),
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w900,
                                                  color: maincolor1,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Add passenger information for booking',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: textSecondary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            children: List.generate(travellers, (index) {
                              final isAdult =
                                  index < searchState.travellers['adults']!;
                              final isChild =
                                  !isAdult &&
                                  index <
                                      searchState.travellers['adults']! +
                                          searchState.travellers['children']!;
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
                                isInternational: isInternational,
                                flightResponse: flightResponse,
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Submit Button
                  SliverToBoxAdapter(
                    child: BlocBuilder<BookingBloc, BookingState>(
                      builder: (context, bookingState) {
                        final isProcessing =
                            _isSubmitting || bookingState.isRepriceLoading;

                        return Container(
                          margin: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: isProcessing
                                    ? null
                                    : () => _submitForm(
                                        context,
                                        state,
                                        flightOption!,
                                        searchState,
                                      ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isProcessing
                                      ? textLight
                                      : maincolor1,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 18),
                                  elevation: 2,
                                  minimumSize: Size(double.infinity, 50),
                                ),
                                child: isProcessing
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                    Colors.white,
                                                  ),
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          Text(
                                            'Processing...',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.arrow_forward_rounded,
                                            size: 20,
                                          ),
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
                              if (isProcessing) ...[
                                SizedBox(height: 16),
                                Text(
                                  'Please wait while we update your flight details...',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: textSecondary,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  SliverToBoxAdapter(child: const SizedBox(height: 30)),
                ],
              );
            }
          },
        ),
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
    required bool isInternational,
    required FFlightResponse flightResponse,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          color: cardColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: BlocBuilder<NationalityBloc, NationalityState>(
                builder: (context, state) {
                  // Initialize selected values if needed
                  if (selectedNationalities[index] == null &&
                      state.nationalitList.isNotEmpty) {
                    selectedNationalities[index] = state.nationalitList
                        .firstWhere(
                          (country) => country.countryCode == 'IN',
                          orElse: () => state.nationalitList.first,
                        );
                  }
                  if (selectedCountriesOfIssue[index] == null &&
                      state.nationalitList.isNotEmpty) {
                    selectedCountriesOfIssue[index] = state.nationalitList
                        .firstWhere(
                          (country) => country.countryCode == 'IN',
                          orElse: () => state.nationalitList.first,
                        );
                  }
                  if (selectedTitles[index] == null) {
                    selectedTitles[index] = isChild || isInfant ? 'Mstr' : 'Mr';
                  }

                  final ptc = isChild
                      ? 'CHD'
                      : isInfant
                      ? 'INF'
                      : 'ADT';

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),

                        // Name Row
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: _buildModernDropdown<String>(
                                label: 'Title',
                                value: selectedTitles[index],
                                icon: Iconsax.user_edit,
                                hint: 'Mr',
                                items: [
                                  if (isChild || isInfant)
                                    const DropdownMenuItem(
                                      value: 'Mstr',
                                      child: Text('Master'),
                                    ),
                                  if (!isChild && !isInfant) ...[
                                    const DropdownMenuItem(
                                      value: 'Mr',
                                      child: Text('Mr'),
                                    ),
                                    const DropdownMenuItem(
                                      value: 'Mrs',
                                      child: Text('Mrs'),
                                    ),
                                    const DropdownMenuItem(
                                      value: 'Ms',
                                      child: Text('Ms'),
                                    ),
                                  ],
                                ],
                                onChanged: (value) => setState(
                                  () => selectedTitles[index] = value,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Title required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 3,
                              child: _buildModernTextField(
                                label: 'First Name',
                                controller: firstNameControllers[index],
                                icon: Iconsax.user,
                                hint: 'First Name',
                                validator: (value) {
                                  if (value == null || value.isEmpty)
                                    return 'Required';
                                  if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value))
                                    return 'Alpha only';
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildModernTextField(
                          label: 'Last Name',
                          controller: lastNameControllers[index],
                          icon: Iconsax.user,
                          hint: 'Last Name',
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Required';
                            if (value.length < 2) return 'Min 2 characters';
                            if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value))
                              return 'Alpha only';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // DOB and Nationality
                        Row(
                          children: [
                            Expanded(
                              child: _buildModernTextField(
                                label: 'Date of Birth',
                                controller: dobControllers[index],
                                icon: Iconsax.calendar_1,
                                hint: 'YYYY-MM-DD',
                                readOnly: true,
                                suffixIcon: Icon(
                                  Iconsax.calendar_2,
                                  size: 18,
                                  color: maincolor1.withOpacity(0.4),
                                ),
                                onTap: () async {
                                  final now = DateTime.now();
                                  DateTime first, last, initial;

                                  if (isInfant) {
                                    // 0-2 years
                                    first = DateTime(
                                      now.year - 2,
                                      now.month,
                                      now.day,
                                    );
                                    last = now;
                                    initial = now.subtract(
                                      const Duration(days: 365),
                                    );
                                  } else if (isChild) {
                                    // 2-11 years
                                    first = DateTime(
                                      now.year - 12,
                                      now.month,
                                      now.day + 1,
                                    );
                                    last = DateTime(
                                      now.year - 2,
                                      now.month,
                                      now.day,
                                    );
                                    initial = DateTime(
                                      now.year - 5,
                                      now.month,
                                      now.day,
                                    );
                                  } else {
                                    // 12+ years
                                    first = DateTime(1900);
                                    last = DateTime(
                                      now.year - 12,
                                      now.month,
                                      now.day,
                                    );
                                    initial = DateTime(
                                      now.year - 25,
                                      now.month,
                                      now.day,
                                    );
                                  }

                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: initial.isAfter(last)
                                        ? last
                                        : (initial.isBefore(first)
                                              ? first
                                              : initial),
                                    firstDate: first,
                                    lastDate: last,
                                  );
                                  if (pickedDate != null) {
                                    setState(() {
                                      dobControllers[index].text = DateFormat(
                                        'yyyy-MM-dd',
                                      ).format(pickedDate);
                                    });
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'DOB required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildModernDropdown<Country>(
                          label: 'Nationality',
                          value: selectedNationalities[index],
                          icon: Iconsax.global,
                          hint: 'Select Nationality',
                          items: state.nationalitList.map((country) {
                            return DropdownMenuItem(
                              value: country,
                              child: Text(
                                country.countryName,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) => setState(
                            () => selectedNationalities[index] = newValue,
                          ),
                        ),

                        if (!isInfant) ...[
                          const SizedBox(height: 16),
                          _buildModernTextField(
                            label: 'Street Address',
                            controller: addressControllers[index],
                            icon: Iconsax.location,
                            hint: 'Enter your address',
                          ),
                          const SizedBox(height: 16),
                          _buildModernTextField(
                            label: 'Pin Code',
                            controller: pincodeControllers[index],
                            icon: Iconsax.mask,
                            hint: 'Enter pin code',
                            keyboardType: TextInputType.number,
                          ),
                        ],

                        if (isInternational) ...[
                          const SizedBox(height: 24),
                          // Passport Details Header
                          Row(
                            children: [
                              Icon(
                                Iconsax.card_pos,
                                size: 16,
                                color: secondaryColor,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Passport Details',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: maincolor1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildModernTextField(
                            label: 'Passport Number',
                            controller: passportControllers[index],
                            icon: Iconsax.card_pos,
                            hint: 'Enter passport number',
                            validator: (value) {
                              if (isInternational &&
                                  (value == null || value.isEmpty)) {
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          _buildModernDropdown<Country>(
                            label: 'Country of Issue',
                            value: selectedCountriesOfIssue[index],
                            icon: Iconsax.global_edit,
                            hint: 'Select Country',
                            items: state.nationalitList.map((country) {
                              return DropdownMenuItem(
                                value: country,
                                child: Text(
                                  country.countryName,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) => setState(
                              () => selectedCountriesOfIssue[index] = newValue,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildModernTextField(
                            label: 'Passport Expiry Date',
                            controller: expiryControllers[index],
                            icon: Iconsax.calendar_tick,
                            hint: 'YYYY-MM-DD',
                            readOnly: true,
                            suffixIcon: Icon(
                              Iconsax.calendar_2,
                              size: 18,
                              color: maincolor1.withOpacity(0.4),
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now().add(
                                  const Duration(days: 180),
                                ),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2050),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  expiryControllers[index].text = DateFormat(
                                    'yyyy-MM-dd',
                                  ).format(pickedDate);
                                });
                              }
                            },
                            validator: (value) {
                              if (isInternational &&
                                  (value == null || value.isEmpty)) {
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                        ],

                        if (hasMeals || hasBaggage) ...[
                          const SizedBox(height: 32),
                          Row(
                            children: [
                              Container(
                                width: 4,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Personalize your trip',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: maincolor1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          if (hasMeals)
                            ...List.generate(
                              flightResponse.ssrAvailability!.mealInfo!.length,
                              (legIndex) {
                                final options = flightResponse
                                    .ssrAvailability!
                                    .mealInfo![legIndex]
                                    .meals!
                                    .where((meal) => meal.ptc == ptc)
                                    .toList();
                                if (options.isEmpty) return const SizedBox();

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: _buildModernDropdown<Meal>(
                                    label:
                                        flightResponse
                                                .ssrAvailability!
                                                .mealInfo!
                                                .length >
                                            1
                                        ? (legIndex == 0
                                              ? 'Select Meal (Going)'
                                              : 'Select Meal (Return)')
                                        : 'Select Meal (Optional)',
                                    value: selectedMeals[index][legIndex],
                                    icon: Iconsax.coffee,
                                    hint: 'Choose a meal option',
                                    items: options.cast<Meal>().map((meal) {
                                      return DropdownMenuItem(
                                        value: meal,
                                        child: Text(
                                          '${meal.name} (+${meal.amount} ${meal.currency})',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) => setState(
                                      () => selectedMeals[index][legIndex] =
                                          value,
                                    ),
                                  ),
                                );
                              },
                            ),

                          if (hasBaggage)
                            ...List.generate(
                              flightResponse
                                  .ssrAvailability!
                                  .baggageInfo!
                                  .length,
                              (legIndex) {
                                final options = flightResponse
                                    .ssrAvailability!
                                    .baggageInfo![legIndex]
                                    .baggages!
                                    .where((baggage) => baggage.ptc == ptc)
                                    .toList();

                                if (options.isEmpty) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: maincolor1.withOpacity(0.02),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: maincolor1.withOpacity(0.05),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Iconsax.info_circle,
                                            size: 16,
                                            color: secondaryColor,
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              'Standard baggage allowance applies for this leg. No additional selection required.',
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: maincolor1.withOpacity(
                                                  0.6,
                                                ),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: _buildModernDropdown<Baggage>(
                                    label:
                                        flightResponse
                                                .ssrAvailability!
                                                .baggageInfo!
                                                .length >
                                            1
                                        ? (legIndex == 0
                                              ? 'Add Baggage (Going)'
                                              : 'Add Baggage (Return)')
                                        : 'Add Baggage (Optional)',
                                    value: selectedBaggages[index][legIndex],
                                    icon: Iconsax.bag_2,
                                    hint: 'Choose baggage option',
                                    items: options.cast<Baggage>().map((
                                      baggage,
                                    ) {
                                      return DropdownMenuItem(
                                        value: baggage,
                                        child: Text(
                                          '${baggage.name ?? baggage.code} (+${baggage.amount} ${baggage.currency})',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) => setState(
                                      () => selectedBaggages[index][legIndex] =
                                          value,
                                    ),
                                  ),
                                );
                              },
                            ),
                          const SizedBox(height: 10),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddOnChip({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: maincolor1.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: secondaryColor),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: maincolor1,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    String? hint,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    VoidCallback? onTap,
    bool readOnly = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: maincolor1.withOpacity(0.8),
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          onTap: onTap,
          readOnly: readOnly,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: maincolor1,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: textLight,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Icon(
              icon,
              color: maincolor1.withOpacity(0.4),
              size: 16,
            ),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: maincolor1.withOpacity(0.03),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: secondaryColor.withOpacity(0.5),
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Colors.red.withOpacity(0.5),
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModernDropdown<T>({
    required String label,
    required T? value,
    required List<DropdownMenuItem<T>> items,
    required void Function(T?)? onChanged,
    required IconData icon,
    String? hint,
    String? Function(T?)? validator,
    List<Widget> Function(BuildContext)? selectedItemBuilder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: maincolor1.withOpacity(0.8),
            ),
          ),
        ),
        DropdownButtonFormField<T>(
          key: Key(
            value?.toString() ?? 'dropdown',
          ), // Force rebuild on value change
          isExpanded: true,
          value: value,
          items: items,
          onChanged: onChanged,
          validator: validator,
          selectedItemBuilder: selectedItemBuilder,
          icon: Icon(
            Iconsax.arrow_down_1,
            color: maincolor1.withOpacity(0.4),
            size: 15,
          ),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: maincolor1,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: textLight,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            // prefixIcon: Icon(
            //   icon,
            //   color: maincolor1.withOpacity(0.4),
            //   size: 10,
            // ),
            filled: true,
            fillColor: maincolor1.withOpacity(0.03),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: secondaryColor.withOpacity(0.5),
                width: 1.5,
              ),
            ),
          ),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ],
    );
  }

  Widget _buildFlightInfoSection(FFlightResponse response) {
    final option = response.journey?.flightOption;
    if (option == null) return const SliverToBoxAdapter(child: SizedBox());

    return SliverToBoxAdapter(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: _isInfoExpanded
                ? secondaryColor.withOpacity(0.5)
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () => setState(() => _isInfoExpanded = !_isInfoExpanded),
              borderRadius: BorderRadius.circular(16),
              child: _buildCollapsedInfo(option),
            ),
            if (_isInfoExpanded) _buildExpandedInfo(option, response),
          ],
        ),
      ),
    );
  }

  Widget _buildCollapsedInfo(FFlightOption option) {
    final firstLeg = option.flightLegs?.first;
    final lastLeg = option.flightLegs?.last;
    final fare = option.flightFares?.first;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (firstLeg?.flightimg != null)
                    Image.network(
                      firstLeg!.flightimg!,
                      height: 24,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Iconsax.airplane, size: 20),
                    )
                  else
                    const Icon(Iconsax.airplane, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    '${firstLeg?.airlineCode ?? ''} ${firstLeg?.flightNo ?? ''}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${fare?.currency ?? 'INR'} ${fare?.totalAmount?.toStringAsFixed(2) ?? '0.00'}',
                  style: TextStyle(
                    color: maincolor1,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildTimeCity(
                firstLeg?.departureTime,
                firstLeg?.origin,
                CrossAxisAlignment.start,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      option.flightLegs?.length == 1
                          ? 'Non-stop'
                          : '${option.flightLegs!.length - 1} stop(s)',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Expanded(child: Divider(thickness: 1)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(
                            Iconsax.airplane,
                            size: 14,
                            color: secondaryColor,
                          ),
                        ),
                        const Expanded(child: Divider(thickness: 1)),
                      ],
                    ),
                  ],
                ),
              ),
              _buildTimeCity(
                lastLeg?.arrivalTime,
                lastLeg?.destination,
                CrossAxisAlignment.end,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isInfoExpanded ? 'Hide Details' : 'View Details',
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Icon(
                _isInfoExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: secondaryColor,
                size: 18,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeCity(
    String? time,
    String? city,
    CrossAxisAlignment alignment,
  ) {
    String formattedTime = '--:--';
    if (time != null) {
      try {
        final dateTime = DateTime.parse(time);
        formattedTime = DateFormat('HH:mm').format(dateTime);
      } catch (e) {
        formattedTime = time.contains('T')
            ? time.split('T')[1].substring(0, 5)
            : time;
      }
    }

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          formattedTime,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        Text(
          city ?? '',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildExpandedInfo(FFlightOption option, FFlightResponse response) {
    final fare = option.flightFares?.first;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          const SizedBox(height: 8),
          const Text(
            'Flight Details',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
          ),
          const SizedBox(height: 12),
          if (option.flightLegs != null)
            ...option.flightLegs!.map((leg) => _buildLegDetail(leg)),
          const SizedBox(height: 16),
          const Text(
            'Fare Breakdown',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
          ),
          const SizedBox(height: 8),
          _buildFareRow(
            'Base Fare',
            '${fare?.currency ?? 'INR'} ${fare?.aprxTotalBaseFare?.toStringAsFixed(2) ?? '0.00'}',
          ),
          _buildFareRow(
            'Taxes & Fees',
            '${fare?.currency ?? 'INR'} ${fare?.aprxTotalTax?.toStringAsFixed(2) ?? '0.00'}',
          ),
          if (fare?.totalDiscount != null && fare!.totalDiscount! > 0)
            _buildFareRow(
              'Discount',
              '- ${fare.currency ?? 'INR'} ${fare.totalDiscount!.toStringAsFixed(2)}',
              isDiscount: true,
            ),
          const Divider(),
          _buildFareRow(
            'Total Amount',
            '${fare?.currency ?? 'INR'} ${fare?.totalAmount?.toStringAsFixed(2) ?? '0.00'}',
            isTotal: true,
          ),
          const SizedBox(height: 16),
          const Text(
            'Baggage Information',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
          ),
          const SizedBox(height: 8),
          ...option.flightLegs!.map((leg) {
            final baggage =
                leg.freeBaggages?.firstOrNull?.adtBaggage ?? 'Not Available';
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  const Icon(Iconsax.bag_2, size: 14, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${leg.origin} to ${leg.destination}: $baggage',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildLegDetail(FFlightLeg leg) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Iconsax.airplane, size: 16, color: maincolor1),
              const SizedBox(width: 8),
              Text(
                '${leg.airlineCode} ${leg.flightNo} • ${leg.rbd ?? ''}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Column(
                children: [
                  const Icon(Icons.circle, size: 8, color: Colors.grey),
                  Container(width: 1, height: 20, color: Colors.grey[300]),
                  const Icon(Icons.location_on, size: 10, color: Colors.grey),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${leg.originName ?? leg.origin} (${leg.origin})',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Terminal ${leg.departureTerminal ?? 'N/A'}',
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${leg.destinationName ?? leg.destination} (${leg.destination})',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Terminal ${leg.arrivalTerminal ?? 'N/A'}',
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFareRow(
    String label,
    String value, {
    bool isTotal = false,
    bool isDiscount = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 14 : 12,
              fontWeight: isTotal ? FontWeight.w900 : FontWeight.w500,
              color: isTotal ? maincolor1 : Colors.grey[700],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 14 : 12,
              fontWeight: isTotal ? FontWeight.w900 : FontWeight.w700,
              color: isDiscount
                  ? Colors.green
                  : (isTotal ? maincolor1 : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
