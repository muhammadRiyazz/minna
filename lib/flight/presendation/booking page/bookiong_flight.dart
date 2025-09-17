// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:minna/comman/const/const.dart';
// import 'package:minna/flight/application/booking/booking_bloc.dart';
// import 'package:minna/flight/application/fare%20request/fare_request_bloc.dart';
// import 'package:minna/flight/application/nationality/nationality_bloc.dart';
// import 'package:minna/flight/application/search%20data/search_data_bloc.dart';
// import 'package:minna/flight/application/trip%20request/trip_request_bloc.dart';

// import 'package:minna/flight/domain/fare%20request%20and%20respo/fare_respo.dart';
// import 'package:minna/flight/domain/nation/nations.dart';
// import 'package:minna/flight/presendation/booking%20page/widget.dart/booking_card.dart';
// import 'package:minna/flight/presendation/booking%20page/widget.dart/loading.dart';
// import 'package:minna/flight/presendation/confirm%20booking/confirm_booking.dart';
// import 'package:minna/flight/presendation/widgets.dart';

// class FlightBookingPage extends StatefulWidget {
//   const FlightBookingPage({super.key});

//   @override
//   State<FlightBookingPage> createState() => _FlightBookingPageState();
// }

// class _FlightBookingPageState extends State<FlightBookingPage> {
//   final TextEditingController contactNumberController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();

//   // Lists to manage multiple passengers
//   List<TextEditingController> firstNameControllers = [];
//   List<TextEditingController> lastNameControllers = [];
//   List<TextEditingController> dobControllers = [];
//   List<TextEditingController> passportControllers = [];
//   List<TextEditingController> expiryControllers = [];
//   List<TextEditingController> addressControllers = [];
//   List<TextEditingController> pincodeControllers = [];

//   List<String?> selectedTitles = [];
//   List<Country?> selectedNationalities = [];
//   List<Country?> selectedCountriesOfIssue = [];
//   List<bool> sameAsFirstPassenger = [];
//   List<Meal?> selectedMeals = [];
//   List<Baggage?> selectedBaggages = [];

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   // Initialize controllers when nationality data is available
//   //   context.read<FetchNaionListBloc>().add(const FetchNaionListEvent.getList());
//   // }

//   void _initializePassengerData(int passengerCount) {
//     // Clear existing data
//     _clearPassengerData();

//     // Initialize data for each passenger
//     for (int i = 0; i < passengerCount; i++) {
//       firstNameControllers.add(TextEditingController());
//       lastNameControllers.add(TextEditingController());
//       dobControllers.add(TextEditingController());
//       passportControllers.add(TextEditingController());
//       expiryControllers.add(TextEditingController());
//       addressControllers.add(TextEditingController());
//       pincodeControllers.add(TextEditingController());

//       selectedTitles.add(i == 0 ? 'Mr' : null);
//       selectedNationalities.add(null);
//       selectedCountriesOfIssue.add(null);
//       sameAsFirstPassenger.add(i == 0 ? false : true);
//       selectedMeals.add(null);
//       selectedBaggages.add(null);
//     }
//   }

//   void _clearPassengerData() {
//     for (var controller in firstNameControllers) controller.dispose();
//     for (var controller in lastNameControllers) controller.dispose();
//     for (var controller in dobControllers) controller.dispose();
//     for (var controller in passportControllers) controller.dispose();
//     for (var controller in expiryControllers) controller.dispose();
//     for (var controller in addressControllers) controller.dispose();
//     for (var controller in pincodeControllers) controller.dispose();

//     firstNameControllers.clear();
//     lastNameControllers.clear();
//     dobControllers.clear();
//     passportControllers.clear();
//     expiryControllers.clear();
//     addressControllers.clear();
//     pincodeControllers.clear();

//     selectedTitles.clear();
//     selectedNationalities.clear();
//     selectedCountriesOfIssue.clear();
//     sameAsFirstPassenger.clear();
//     selectedMeals.clear();
//     selectedBaggages.clear();
//   }

//   @override
//   void dispose() {
//     _clearPassengerData();
//     contactNumberController.dispose();
//     emailController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text(
//           'Fill the deatils',
//           style: TextStyle(fontSize: 15, color: Colors.white),
//         ),
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: maincolor1!,
//       ),
//       body: BlocBuilder<FareRequestBloc, FareRequestState>(
//         builder: (context, state) {
//           if (state.isLoading) {
//             return bookingLoading();
//           } else {
//             final FFlightResponse flightResponse = state.respo!;
//             final flightOption = flightResponse.journey?.flightOption;
//             final searchState = context.read<SearchDataBloc>().state;

//             final int travellers =
//                 searchState.travellers['adults']! +
//                 searchState.travellers['children']! +
//                 searchState.travellers['infants']!;

//             // Initialize passenger data if not already done
//             if (firstNameControllers.length != travellers) {
//               _initializePassengerData(travellers);
//             }

//             // Check SSR availability
//             final hasSSRAvailability = flightResponse.ssrAvailability != null;
//             final hasMealOptions =
//                 hasSSRAvailability &&
//                 flightResponse.ssrAvailability!.mealInfo != null &&
//                 flightResponse.ssrAvailability!.mealInfo!.isNotEmpty;
//             final hasBaggageOptions =
//                 hasSSRAvailability &&
//                 flightResponse.ssrAvailability!.baggageInfo != null &&
//                 flightResponse.ssrAvailability!.baggageInfo!.isNotEmpty;

//             return Form(
//               key: _formKey,
//               child: ListView(
//                 children: [
//                   // FlightbookingCard(flightOption: flightOption!),

//                   // Additional Baggage Purchase
//                   if (hasSSRAvailability &&
//                       (hasMealOptions || hasBaggageOptions))
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 8,
//                         vertical: 6,
//                       ),
//                       child: Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: maincolor1!.withOpacity(0.3),
//                             width: 0.5,
//                           ),
//                           color: maincolor1!.withOpacity(0.05),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Icon(
//                                   Icons.add_circle_outline,
//                                   size: 18,
//                                   color: maincolor1!,
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Text(
//                                   'Need More Baggage or Meals?',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                     color: maincolor1!,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               'You can add extra baggage and meals while filling traveler details below.',
//                               style: TextStyle(
//                                 color: Colors.grey.shade600,
//                                 fontSize: 12,
//                                 height: 1.4,
//                               ),
//                             ),
//                             if (hasMealOptions || hasBaggageOptions) ...[
//                               const SizedBox(height: 12),
//                               Wrap(
//                                 spacing: 8,
//                                 runSpacing: 8,
//                                 children: [
//                                   if (hasMealOptions)
//                                     _buildAddOnChip(
//                                       icon: Icons.restaurant,
//                                       label: 'Add Meals',
//                                       onTap: () {},
//                                     ),
//                                   if (hasBaggageOptions)
//                                     _buildAddOnChip(
//                                       icon: Icons.luggage,
//                                       label: 'Add Baggage',
//                                       onTap: () {},
//                                     ),
//                                 ],
//                               ),
//                             ],
//                           ],
//                         ),
//                       ),
//                     ),

//                   // Contact Information
//                   Container(
//                     margin: const EdgeInsets.symmetric(
//                       horizontal: 8,
//                       vertical: 6,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(
//                         color: Colors.grey.shade300,
//                         width: 0.5,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.05),
//                           spreadRadius: 1,
//                           blurRadius: 6,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         Container(
//                           width: double.infinity,
//                           padding: const EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: maincolor1!,
//                             borderRadius: const BorderRadius.vertical(
//                               top: Radius.circular(12),
//                             ),
//                           ),
//                           child: Row(
//                             children: [
//                               const Icon(
//                                 Icons.contact_mail_outlined,
//                                 size: 18,
//                                 color: Colors.white,
//                               ),
//                               const SizedBox(width: 10),
//                               Text(
//                                 'Contact Information',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(16),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Your ticket and flight info will be sent to this contact',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.grey.shade600,
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//                               TextFormField(
//                                 controller: contactNumberController,
//                                 decoration: InputDecoration(
//                                   labelText: 'Contact Number',
//                                   labelStyle: TextStyle(
//                                     color: Colors.grey.shade600,
//                                     fontSize: 13,
//                                   ),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                     borderSide: BorderSide(
//                                       color: Colors.grey.shade300,
//                                     ),
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                     borderSide: BorderSide(
//                                       color: Colors.grey.shade300,
//                                     ),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                     borderSide: BorderSide(
//                                       color: maincolor1!,
//                                       width: 1,
//                                     ),
//                                   ),
//                                   prefixIcon: Icon(
//                                     Icons.phone,
//                                     color: Colors.grey.shade600,
//                                     size: 18,
//                                   ),
//                                   contentPadding: const EdgeInsets.symmetric(
//                                     vertical: 14,
//                                     horizontal: 16,
//                                   ),
//                                 ),
//                                 keyboardType: TextInputType.phone,
//                                 style: const TextStyle(fontSize: 14),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Please enter contact number';
//                                   }
//                                   if (!RegExp(
//                                     r'^[0-9]{10,15}$',
//                                   ).hasMatch(value)) {
//                                     return 'Please enter a valid phone number';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                               const SizedBox(height: 16),
//                               TextFormField(
//                                 controller: emailController,
//                                 decoration: InputDecoration(
//                                   labelText: 'Email Address',
//                                   labelStyle: TextStyle(
//                                     color: Colors.grey.shade600,
//                                     fontSize: 13,
//                                   ),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                     borderSide: BorderSide(
//                                       color: Colors.grey.shade300,
//                                     ),
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                     borderSide: BorderSide(
//                                       color: Colors.grey.shade300,
//                                     ),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                     borderSide: BorderSide(
//                                       color: maincolor1!,
//                                       width: 1,
//                                     ),
//                                   ),
//                                   prefixIcon: Icon(
//                                     Icons.email,
//                                     color: Colors.grey.shade600,
//                                     size: 18,
//                                   ),
//                                   contentPadding: const EdgeInsets.symmetric(
//                                     vertical: 14,
//                                     horizontal: 16,
//                                   ),
//                                 ),
//                                 keyboardType: TextInputType.emailAddress,
//                                 style: const TextStyle(fontSize: 14),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Please enter email address';
//                                   }
//                                   if (!RegExp(
//                                     r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
//                                   ).hasMatch(value)) {
//                                     return 'Please enter a valid email';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 5),

//                   // Traveller Details
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(
//                           color: Colors.grey.shade300,
//                           width: 0.1,
//                         ),
//                       ),
//                       child: ExpansionTile(
//                         collapsedIconColor: Colors.white,
//                         iconColor: Colors.white,
//                         initiallyExpanded: true,
//                         textColor: Colors.white,
//                         tilePadding: const EdgeInsets.symmetric(horizontal: 16),
//                         collapsedBackgroundColor: maincolor1!,
//                         collapsedTextColor: Colors.white,
//                         backgroundColor: maincolor1!,
//                         collapsedShape: RoundedRectangleBorder(
//                           side: BorderSide(color: Colors.grey.shade300),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         title: Row(
//                           children: [
//                             Icon(
//                               Icons.person_outline_rounded,
//                               size: 15,
//                               color: Colors.white,
//                             ),
//                             const SizedBox(width: 10),
//                             Text(
//                               'Traveller Details',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                         children: List.generate(travellers, (index) {
//                           final isAdult =
//                               index < searchState.travellers['adults']!;
//                           final isChild =
//                               !isAdult &&
//                               index <
//                                   searchState.travellers['adults']! +
//                                       searchState.travellers['children']!;
//                           final isInfant = !isAdult && !isChild;
//                           final isFirstPassenger = index == 0;

//                           return _buildPassengerForm(
//                             context: context,
//                             index: index,
//                             isAdult: isAdult,
//                             isChild: isChild,
//                             isInfant: isInfant,
//                             isFirstPassenger: isFirstPassenger,
//                             hasMeals: hasMealOptions,
//                             hasBaggage: hasBaggageOptions,
//                             flightResponse: flightResponse,
//                           );
//                         }),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10),

//                   buildPaymentButton(context, 'Next', () {
//                     if (_formKey.currentState!.validate()) {
//                       final hasReprice =
//                           state.respo!.journey!.flightOption!.reprice == true;
//                       final hasBaggage = selectedBaggages.any((b) => b != null);
//                       final hasMeals = selectedMeals.any((m) => m != null);

//                       final tripState = context.read<TripRequestBloc>().state;
//                       final searchData = context.read<SearchDataBloc>().state;

//                       List<Map<String, dynamic>> passengerDataList = [];

//                       for (int i = 0; i < firstNameControllers.length; i++) {
//                         passengerDataList.add({
//                           'paxNo': state.respo!.passengerInfo![i].paxNo,
//                           'paxKey': state.respo!.passengerInfo![i].paxKey,
//                           'email': emailController.text,
//                           'contact': contactNumberController.text,
//                           'title': selectedTitles[i],
//                           'firstName': firstNameControllers[i].text,
//                           'lastName': lastNameControllers[i].text,
//                           'dob': dobControllers[i].text,
//                           'nationality': selectedNationalities[i]?.countryCode,
//                           'passportNumber': passportControllers[i].text,
//                           'passportExpiry': expiryControllers[i].text,
//                           'countryOfIssue':
//                               selectedCountriesOfIssue[i]?.countryCode,
//                           'address': sameAsFirstPassenger[i] && i > 0
//                               ? addressControllers[0].text
//                               : addressControllers[i].text,
//                           'pincode': sameAsFirstPassenger[i] && i > 0
//                               ? pincodeControllers[0].text
//                               : pincodeControllers[i].text,
//                           'meal': selectedMeals[i]?.code,
//                           'baggage': selectedBaggages[i]?.code,
//                           'passengerType': i < searchData.travellers['adults']!
//                               ? 'ADT'
//                               : i <
//                                     searchData.travellers['adults']! +
//                                         searchData.travellers['children']!
//                               ? 'CHD'
//                               : 'INF',
//                         });
//                       }

//                       context.read<BookingBloc>().add(
//                         BookingEvent.getRePrice(
//                           reprice: hasReprice || hasBaggage || hasMeals,
//                           tripMode: searchData.oneWay ? 'O' : 'S',
//                           fareReData: flightOption!,
//                           passengerDataList: passengerDataList,
//                           token: tripState.token ?? '',
//                         ),
//                       );

//                       log(({hasReprice || hasBaggage || hasMeals}).toString());

//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) {
//                             return BookingConfirmationScreen(
//                               flightinfo: flightOption,
//                             );
//                           },
//                         ),
//                       );
//                     }
//                   }),

//                   SizedBox(height: 10),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildPassengerForm({
//     required BuildContext context,
//     required int index,
//     required bool isAdult,
//     required bool isChild,
//     required bool isInfant,
//     required bool isFirstPassenger,
//     required bool hasMeals,
//     required bool hasBaggage,
//     required FFlightResponse flightResponse,
//   }) {
//     return StatefulBuilder(
//       builder: (context, setState) {
//         return Container(
//           color: Colors.white,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 5),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: BlocBuilder<NationalityBloc, NationalityState>(
//                   builder: (context, state) {
//                     // Initialize nationality and country of issue if not set
//                     if (selectedNationalities[index] == null &&
//                         state.nationalitList.isNotEmpty) {
//                       selectedNationalities[index] = state.nationalitList
//                           .firstWhere(
//                             (country) => country.countryCode == 'IN',
//                             orElse: () => state.nationalitList.first,
//                           );
//                     }
//                     if (selectedCountriesOfIssue[index] == null &&
//                         state.nationalitList.isNotEmpty) {
//                       selectedCountriesOfIssue[index] = state.nationalitList
//                           .firstWhere(
//                             (country) => country.countryCode == 'IN',
//                             orElse: () => state.nationalitList.first,
//                           );
//                     }
//                     // Initialize title
//                     if (selectedTitles[index] == null) {
//                       selectedTitles[index] = isChild || isInfant
//                           ? 'Mstr'
//                           : 'Mr';
//                     }

//                     // Get meal and baggage options for this passenger type
//                     final ptc = isChild
//                         ? 'CHD'
//                         : isInfant
//                         ? 'INF'
//                         : 'ADT';
//                     final mealOptions = hasMeals
//                         ? flightResponse.ssrAvailability!.mealInfo![0].meals!
//                               .where((meal) => meal.ptc == ptc)
//                               .toList()
//                         : [];
//                     final baggageOptions = hasBaggage
//                         ? flightResponse
//                               .ssrAvailability!
//                               .baggageInfo![0]
//                               .baggages!
//                               .where((baggage) => baggage.ptc == ptc)
//                               .toList()
//                         : [];

//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           width: double.infinity,
//                           height: 12,
//                           decoration: BoxDecoration(
//                             color: maincolor1!,
//                             borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(6),
//                               topRight: Radius.circular(6),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           width: double.infinity,
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 13,
//                             horizontal: 13,
//                           ),
//                           decoration: BoxDecoration(color: Colors.blue.shade50),
//                           child: Text(
//                             isAdult
//                                 ? 'ADULT ${index + 1}'
//                                 : isChild
//                                 ? 'CHILD ${index + 1}'
//                                 : 'INFANT ${index + 1}',
//                             style: TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w600,
//                               color: maincolor1!,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 16),

//                         // Title Dropdown
//                         DropdownButtonFormField<String>(
//                           decoration: InputDecoration(
//                             labelText: 'Title',
//                             labelStyle: const TextStyle(fontSize: 13),
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.grey.shade300,
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.grey.shade400,
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 12,
//                               vertical: 12,
//                             ),
//                           ),
//                           isExpanded: true,
//                           dropdownColor: Colors.white,
//                           icon: Icon(
//                             Icons.arrow_drop_down,
//                             color: Colors.grey.shade600,
//                           ),
//                           items: [
//                             if (isChild || isInfant)
//                               const DropdownMenuItem(
//                                 value: 'Mstr',
//                                 child: Text(
//                                   'Master',
//                                   style: TextStyle(fontSize: 13),
//                                 ),
//                               ),
//                             if (!isChild && !isInfant) ...[
//                               const DropdownMenuItem(
//                                 value: 'Mr',
//                                 child: Text(
//                                   'Mr',
//                                   style: TextStyle(fontSize: 13),
//                                 ),
//                               ),
//                               const DropdownMenuItem(
//                                 value: 'Mrs',
//                                 child: Text(
//                                   'Mrs',
//                                   style: TextStyle(fontSize: 13),
//                                 ),
//                               ),
//                               const DropdownMenuItem(
//                                 value: 'Ms',
//                                 child: Text(
//                                   'Ms',
//                                   style: TextStyle(fontSize: 13),
//                                 ),
//                               ),
//                             ],
//                           ],
//                           onChanged: (value) {
//                             setState(() {
//                               selectedTitles[index] = value;
//                             });
//                           },
//                           value: selectedTitles[index],
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please select a title';
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 16),

//                         // First Name
//                         TextFormField(
//                           controller: firstNameControllers[index],
//                           decoration: InputDecoration(
//                             labelText: 'First Name',
//                             labelStyle: const TextStyle(fontSize: 13),
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.grey.shade300,
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.grey.shade400,
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 12,
//                               vertical: 12,
//                             ),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter first name';
//                             }
//                             if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
//                               return 'Only alphabets are allowed';
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 16),

//                         // Last Name
//                         TextFormField(
//                           controller: lastNameControllers[index],
//                           decoration: InputDecoration(
//                             labelText: 'Last Name',
//                             labelStyle: const TextStyle(fontSize: 13),
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.grey.shade300,
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.grey.shade400,
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 12,
//                               vertical: 12,
//                             ),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter last name';
//                             }
//                             if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
//                               return 'Only alphabets are allowed';
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 16),

//                         // Nationality
//                         DropdownButtonFormField<Country>(
//                           decoration: InputDecoration(
//                             labelText: 'Nationality',
//                             labelStyle: const TextStyle(fontSize: 13),
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.grey.shade300,
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.grey.shade400,
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 12,
//                               vertical: 12,
//                             ),
//                           ),
//                           isExpanded: true,
//                           dropdownColor: Colors.white,
//                           icon: Icon(
//                             Icons.arrow_drop_down,
//                             color: Colors.grey.shade600,
//                           ),
//                           value: selectedNationalities[index],
//                           items: state.nationalitList.map((Country value) {
//                             return DropdownMenuItem<Country>(
//                               value: value,
//                               child: Text(
//                                 value.countryName,
//                                 style: const TextStyle(fontSize: 13),
//                               ),
//                             );
//                           }).toList(),
//                           onChanged: (Country? newValue) {
//                             if (newValue != null) {
//                               setState(() {
//                                 selectedNationalities[index] = newValue;
//                               });
//                             }
//                           },
//                           validator: (value) {
//                             if (value == null) {
//                               return 'Please select nationality';
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 16),

//                         // Date of Birth
//                         TextFormField(
//                           readOnly: true,
//                           controller: dobControllers[index],
//                           decoration: InputDecoration(
//                             labelText: 'Date of Birth',
//                             labelStyle: const TextStyle(fontSize: 13),
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.grey.shade300,
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.grey.shade400,
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 12,
//                               vertical: 12,
//                             ),
//                             suffixIcon: Icon(
//                               Icons.calendar_today,
//                               size: 18,
//                               color: Colors.grey.shade600,
//                             ),
//                           ),
//                           onTap: () async {
//                             DateTime? pickedDate = await showDatePicker(
//                               context: context,
//                               initialDate: isInfant
//                                   ? DateTime.now().subtract(
//                                       const Duration(days: 365),
//                                     )
//                                   : isChild
//                                   ? DateTime.now().subtract(
//                                       const Duration(days: 365 * 5),
//                                     )
//                                   : DateTime.now().subtract(
//                                       const Duration(days: 365 * 18),
//                                     ),
//                               firstDate: DateTime(1900),
//                               lastDate: DateTime.now(),
//                             );
//                             if (pickedDate != null) {
//                               dobControllers[index].text = DateFormat(
//                                 'dd-MM-yyyy',
//                               ).format(pickedDate);
//                             }
//                           },
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please select date of birth';
//                             }
//                             return null;
//                           },
//                         ),
//                         if (!isInfant) ...[
//                           const SizedBox(height: 16),
//                           TextFormField(
//                             controller: passportControllers[index],
//                             decoration: InputDecoration(
//                               labelText: 'Passport Number',
//                               labelStyle: const TextStyle(fontSize: 13),
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.grey.shade300,
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.grey.shade400,
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 12,
//                                 vertical: 12,
//                               ),
//                             ),
//                             validator: (value) {
//                               if (!isInfant &&
//                                   (value == null || value.isEmpty)) {
//                                 return 'Please enter passport number';
//                               }
//                               if (value != null &&
//                                   value.isNotEmpty &&
//                                   !RegExp(
//                                     r'^[a-zA-Z0-9]{6,20}$',
//                                   ).hasMatch(value)) {
//                                 return 'Invalid passport number';
//                               }
//                               return null;
//                             },
//                           ),
//                           const SizedBox(height: 16),
//                           TextFormField(
//                             readOnly: true,
//                             controller: expiryControllers[index],
//                             decoration: InputDecoration(
//                               labelText: 'Passport Expiry',
//                               labelStyle: const TextStyle(fontSize: 13),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.grey.shade400,
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.grey.shade300,
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 12,
//                                 vertical: 12,
//                               ),
//                               suffixIcon: Icon(
//                                 Icons.calendar_today,
//                                 size: 18,
//                                 color: Colors.grey.shade600,
//                               ),
//                             ),
//                             onTap: () async {
//                               DateTime? pickedDate = await showDatePicker(
//                                 context: context,
//                                 initialDate: DateTime.now().add(
//                                   const Duration(days: 365 * 5),
//                                 ),
//                                 firstDate: DateTime.now(),
//                                 lastDate: DateTime(2100),
//                               );
//                               if (pickedDate != null) {
//                                 expiryControllers[index].text = DateFormat(
//                                   'dd-MM-yyyy',
//                                 ).format(pickedDate);
//                               }
//                             },
//                             validator: (value) {
//                               if (!isInfant &&
//                                   (value == null || value.isEmpty)) {
//                                 return 'Please select expiry date';
//                               }
//                               return null;
//                             },
//                           ),
//                           const SizedBox(height: 16),
//                           DropdownButtonFormField<Country>(
//                             decoration: InputDecoration(
//                               labelText: 'Country of Issue',
//                               labelStyle: const TextStyle(fontSize: 13),
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.grey.shade300,
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.grey.shade400,
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 12,
//                                 vertical: 12,
//                               ),
//                             ),
//                             isExpanded: true,
//                             dropdownColor: Colors.white,
//                             icon: Icon(
//                               Icons.arrow_drop_down,
//                               color: Colors.grey.shade600,
//                             ),
//                             value: selectedCountriesOfIssue[index],
//                             items: state.nationalitList.map((Country value) {
//                               return DropdownMenuItem<Country>(
//                                 value: value,
//                                 child: Text(
//                                   value.countryName,
//                                   style: const TextStyle(fontSize: 13),
//                                 ),
//                               );
//                             }).toList(),
//                             onChanged: (Country? newValue) {
//                               if (newValue != null) {
//                                 setState(() {
//                                   selectedCountriesOfIssue[index] = newValue;
//                                 });
//                               }
//                             },
//                             validator: (value) {
//                               if (!isInfant && value == null) {
//                                 return 'Please select country of issue';
//                               }
//                               return null;
//                             },
//                           ),
//                         ],

//                         // Same as first passenger checkbox
//                         if (!isFirstPassenger) ...[
//                           const SizedBox(height: 16),
//                           Row(
//                             children: [
//                               Checkbox(
//                                 value: sameAsFirstPassenger[index],
//                                 onChanged: (value) {
//                                   setState(() {
//                                     sameAsFirstPassenger[index] =
//                                         value ?? false;
//                                   });
//                                 },
//                                 activeColor: maincolor1!,
//                                 materialTapTargetSize:
//                                     MaterialTapTargetSize.shrinkWrap,
//                               ),
//                               Text(
//                                 'Same as first passenger',
//                                 style: const TextStyle(fontSize: 13),
//                               ),
//                             ],
//                           ),
//                         ],

//                         // Address fields (only if not same as first passenger)
//                         if (!sameAsFirstPassenger[index]) ...[
//                           const SizedBox(height: 16),
//                           TextFormField(
//                             controller: addressControllers[index],
//                             decoration: InputDecoration(
//                               labelText: 'Address',
//                               labelStyle: const TextStyle(fontSize: 13),
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.grey.shade300,
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.grey.shade400,
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 12,
//                                 vertical: 12,
//                               ),
//                             ),
//                             maxLines: 2,
//                             validator: (value) {
//                               if (!sameAsFirstPassenger[index] &&
//                                   (value == null || value.isEmpty)) {
//                                 return 'Please enter address';
//                               }
//                               return null;
//                             },
//                           ),
//                           const SizedBox(height: 16),
//                           TextFormField(
//                             controller: pincodeControllers[index],
//                             decoration: InputDecoration(
//                               labelText: 'Pin Code',
//                               labelStyle: const TextStyle(fontSize: 13),
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.grey.shade300,
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.grey.shade400,
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 12,
//                                 vertical: 12,
//                               ),
//                             ),
//                             keyboardType: TextInputType.number,
//                             validator: (value) {
//                               if (!sameAsFirstPassenger[index] &&
//                                   (value == null || value.isEmpty)) {
//                                 return 'Please enter pin code';
//                               }
//                               if (value != null &&
//                                   value.isNotEmpty &&
//                                   !RegExp(r'^[0-9]{6}$').hasMatch(value)) {
//                                 return 'Pin code must be 6 digits';
//                               }
//                               return null;
//                             },
//                           ),
//                         ],

//                         // Meal selection (only if available)
//                         if (hasMeals) ...[
//                           const SizedBox(height: 16),
//                           DropdownButtonFormField<Meal>(
//                             decoration: InputDecoration(
//                               labelText: 'Select Meal (Optional)',
//                               labelStyle: const TextStyle(fontSize: 13),
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.grey.shade300,
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.grey.shade400,
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 12,
//                                 vertical: 12,
//                               ),
//                             ),
//                             isExpanded: true,
//                             dropdownColor: Colors.white,
//                             icon: Icon(
//                               Icons.arrow_drop_down,
//                               color: Colors.grey.shade600,
//                             ),
//                             hint: const Text(
//                               'No meal selected',
//                               style: TextStyle(fontSize: 13),
//                             ),
//                             value: selectedMeals[index],
//                             items: mealOptions
//                                 .cast<Meal>()
//                                 .map<DropdownMenuItem<Meal>>((meal) {
//                                   return DropdownMenuItem<Meal>(
//                                     value: meal,
//                                     child: Text(
//                                       '${meal.name} - ${meal.amount?.toStringAsFixed(2) ?? '0.00'} ${meal.currency ?? 'INR'}',
//                                       style: const TextStyle(fontSize: 13),
//                                     ),
//                                   );
//                                 })
//                                 .toList(),
//                             onChanged: (Meal? newValue) {
//                               if (newValue != null) {
//                                 setState(() {
//                                   selectedMeals[index] = newValue;
//                                 });
//                               }
//                             },
//                           ),
//                         ],

//                         // Baggage selection (only if available)
//                         if (hasBaggage) ...[
//                           const SizedBox(height: 16),
//                           DropdownButtonFormField<Baggage>(
//                             decoration: InputDecoration(
//                               labelText: 'Add Baggage (Optional)',
//                               labelStyle: const TextStyle(fontSize: 13),
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.grey.shade300,
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 12,
//                                 vertical: 12,
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.grey.shade400,
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             isExpanded: true,
//                             dropdownColor: Colors.white,
//                             icon: Icon(
//                               Icons.arrow_drop_down,
//                               color: Colors.grey.shade600,
//                             ),
//                             hint: const Text(
//                               'No baggage selected',
//                               style: TextStyle(fontSize: 12),
//                             ),
//                             value: selectedBaggages[index],
//                             items: baggageOptions.map((dynamic item) {
//                               final baggage = item as Baggage;
//                               return DropdownMenuItem<Baggage>(
//                                 value: baggage,
//                                 child: Text(
//                                   '${baggage.name ?? baggage.code} - ${baggage.amount ?? ''}',
//                                   style: const TextStyle(fontSize: 11),
//                                 ),
//                               );
//                             }).toList(),
//                             onChanged: (Baggage? newValue) {
//                               if (newValue != null) {
//                                 setState(() {
//                                   selectedBaggages[index] = newValue;
//                                 });
//                               }
//                             },
//                           ),
//                         ],
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildAddOnChip({
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: maincolor1!.withOpacity(0.3)),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(icon, size: 14, color: maincolor1!),
//             const SizedBox(width: 6),
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: maincolor1!,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildBaggageDetailRow(String type, String baggage) {
//     final formattedBaggage = baggage
//         .replaceAll('Kilograms', 'kg')
//         .replaceAll('Kilogram', 'kg');

//     return Padding(
//       padding: const EdgeInsets.only(left: 26, bottom: 6),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             type,
//             style: const TextStyle(
//               color: Colors.grey,
//               fontSize: 12,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//             decoration: BoxDecoration(
//               color: maincolor1!.withOpacity(0.08),
//               borderRadius: BorderRadius.circular(4),
//               border: Border.all(color: maincolor1!.withOpacity(0.2)),
//             ),
//             child: Text(
//               formattedBaggage,
//               style: TextStyle(
//                 color: maincolor1!,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
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
  final TextEditingController contactNumberController = TextEditingController();
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
    for (var controller in firstNameControllers) controller.dispose();
    for (var controller in lastNameControllers) controller.dispose();
    for (var controller in dobControllers) controller.dispose();
    for (var controller in passportControllers) controller.dispose();
    for (var controller in expiryControllers) controller.dispose();
    for (var controller in addressControllers) controller.dispose();
    for (var controller in pincodeControllers) controller.dispose();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Fill the details',
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: maincolor1!,
      ),
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

            return Form(
              key: _formKey,
              child: ListView(
                children: [
                  if (hasSSRAvailability &&
                      (hasMealOptions || hasBaggageOptions))
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: maincolor1!.withOpacity(0.3),
                            width: 0.5,
                          ),
                          color: maincolor1!.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.add_circle_outline,
                                  size: 18,
                                  color: maincolor1!,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Need More Baggage or Meals?',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: maincolor1!,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'You can add extra baggage and meals while filling traveler details below.',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                                height: 1.4,
                              ),
                            ),
                            if (hasMealOptions || hasBaggageOptions) ...[
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  if (hasMealOptions)
                                    _buildAddOnChip(
                                      icon: Icons.restaurant,
                                      label: 'Add Meals',
                                      onTap: () {},
                                    ),
                                  if (hasBaggageOptions)
                                    _buildAddOnChip(
                                      icon: Icons.luggage,
                                      label: 'Add Baggage',
                                      onTap: () {},
                                    ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),

                  // Contact Information
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 0.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.05),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: maincolor1!,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.contact_mail_outlined,
                                size: 18,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Contact Information',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your ticket and flight info will be sent to this contact',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: contactNumberController,
                                decoration: InputDecoration(
                                  labelText: 'Contact Number',
                                  labelStyle: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: maincolor1!,
                                      width: 1,
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: Colors.grey.shade600,
                                    size: 18,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 16,
                                  ),
                                ),
                                keyboardType: TextInputType.phone,
                                style: const TextStyle(fontSize: 14),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter contact number';
                                  }
                                  if (!RegExp(
                                    r'^[0-9]{10,15}$',
                                  ).hasMatch(value)) {
                                    return 'Please enter a valid phone number';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  labelText: 'Email Address',
                                  labelStyle: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: maincolor1!,
                                      width: 1,
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.grey.shade600,
                                    size: 18,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 16,
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(fontSize: 14),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter email address';
                                  }
                                  if (!RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                  ).hasMatch(value)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),

                  // Traveller Details
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 0.1,
                        ),
                      ),
                      child: ExpansionTile(
                        collapsedIconColor: Colors.white,
                        iconColor: Colors.white,
                        initiallyExpanded: true,
                        textColor: Colors.white,
                        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                        collapsedBackgroundColor: maincolor1!,
                        collapsedTextColor: Colors.white,
                        backgroundColor: maincolor1!,
                        collapsedShape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        title: Row(
                          children: [
                            Icon(
                              Icons.person_outline_rounded,
                              size: 15,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Traveller Details',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
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
                            flightResponse: flightResponse,
                          );
                        }),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  buildPaymentButton(context, 'Next', () {
                    if (_formKey.currentState!.validate()) {
                      final hasReprice =
                          state.respo!.journey!.flightOption!.reprice == true;
                      final hasBaggage = selectedBaggages.any((b) => b != null);
                      final hasMeals = selectedMeals.any((m) => m != null);

                      final tripState = context.read<TripRequestBloc>().state;
                      final searchData = context.read<SearchDataBloc>().state;

                      List<Map<String, dynamic>> passengerDataList = [];

                      for (int i = 0; i < firstNameControllers.length; i++) {
                        final legKey = flightOption!.flightLegs!.first.key;

                        passengerDataList.add({
                          'paxNo': state.respo!.passengerInfo![i].paxNo,
                          'paxKey': state.respo!.passengerInfo![i].paxKey,
                          'email': emailController.text,
                          'contact': contactNumberController.text,
                          'title': selectedTitles[i],
                          'firstName': firstNameControllers[i].text,
                          'lastName': lastNameControllers[i].text,
                          'dob': dobControllers[i].text,
                          'nationality': selectedNationalities[i]?.countryCode,
                          'passportNumber': passportControllers[i].text,
                          'passportExpiry': expiryControllers[i].text,
                          'countryOfIssue':
                              selectedCountriesOfIssue[i]?.countryCode,
                          'address': sameAsFirstPassenger[i] && i > 0
                              ? addressControllers[0].text
                              : addressControllers[i].text,
                          'pincode': sameAsFirstPassenger[i] && i > 0
                              ? pincodeControllers[0].text
                              : pincodeControllers[i].text,
                          'passengerType': i < searchData.travellers['adults']!
                              ? 'ADT'
                              : i <
                                    searchData.travellers['adults']! +
                                        searchData.travellers['children']!
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
                          fareReData: flightOption!,
                          passengerDataList: passengerDataList,
                          token: tripState.token ?? '',
                        ),
                      );

                      log(
                        'Booking request payload: ${passengerDataList.toString()}',
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingConfirmationScreen(
                            flightinfo: flightOption,
                          ),
                        ),
                      );
                    }
                  }),

                  SizedBox(height: 10),
                ],
              ),
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
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: BlocBuilder<NationalityBloc, NationalityState>(
                  builder: (context, state) {
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
                      selectedTitles[index] = isChild || isInfant
                          ? 'Mstr'
                          : 'Mr';
                    }

                    final ptc = isChild
                        ? 'CHD'
                        : isInfant
                        ? 'INF'
                        : 'ADT';
                    final mealOptions = hasMeals
                        ? flightResponse.ssrAvailability!.mealInfo![0].meals!
                              .where((meal) => meal.ptc == ptc)
                              .toList()
                        : [];
                    final baggageOptions = hasBaggage
                        ? flightResponse
                              .ssrAvailability!
                              .baggageInfo![0]
                              .baggages!
                              .where((baggage) => baggage.ptc == ptc)
                              .toList()
                        : [];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 12,
                          decoration: BoxDecoration(
                            color: maincolor1!,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(6),
                              topRight: Radius.circular(6),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 13,
                            horizontal: 13,
                          ),
                          decoration: BoxDecoration(color: Colors.blue.shade50),
                          child: Text(
                            isAdult
                                ? 'ADULT ${index + 1}'
                                : isChild
                                ? 'CHILD ${index + 1}'
                                : 'INFANT ${index + 1}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: maincolor1!,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Title Dropdown
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Title',
                            labelStyle: const TextStyle(fontSize: 13),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                          ),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.grey.shade600,
                          ),
                          items: [
                            if (isChild || isInfant)
                              const DropdownMenuItem(
                                value: 'Mstr',
                                child: Text(
                                  'Master',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            if (!isChild && !isInfant) ...[
                              const DropdownMenuItem(
                                value: 'Mr',
                                child: Text(
                                  'Mr',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              const DropdownMenuItem(
                                value: 'Mrs',
                                child: Text(
                                  'Mrs',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              const DropdownMenuItem(
                                value: 'Ms',
                                child: Text(
                                  'Ms',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedTitles[index] = value;
                            });
                          },
                          value: selectedTitles[index],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a title';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // First Name
                        TextFormField(
                          controller: firstNameControllers[index],
                          decoration: InputDecoration(
                            labelText: 'First Name',
                            labelStyle: const TextStyle(fontSize: 13),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter first name';
                            }
                            if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                              return 'Only alphabets are allowed';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Last Name
                        TextFormField(
                          controller: lastNameControllers[index],
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                            labelStyle: const TextStyle(fontSize: 13),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter last name';
                            }
                            if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                              return 'Only alphabets are allowed';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Nationality
                        DropdownButtonFormField<Country>(
                          decoration: InputDecoration(
                            labelText: 'Nationality',
                            labelStyle: const TextStyle(fontSize: 13),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                          ),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.grey.shade600,
                          ),
                          value: selectedNationalities[index],
                          items: state.nationalitList.map((Country value) {
                            return DropdownMenuItem<Country>(
                              value: value,
                              child: Text(
                                value.countryName,
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                          onChanged: (Country? newValue) {
                            if (newValue != null) {
                              setState(() {
                                selectedNationalities[index] = newValue;
                              });
                            }
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select nationality';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Date of Birth
                        TextFormField(
                          readOnly: true,
                          controller: dobControllers[index],
                          decoration: InputDecoration(
                            labelText: 'Date of Birth',
                            labelStyle: const TextStyle(fontSize: 13),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            suffixIcon: Icon(
                              Icons.calendar_today,
                              size: 18,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: isInfant
                                  ? DateTime.now().subtract(
                                      const Duration(days: 365),
                                    )
                                  : isChild
                                  ? DateTime.now().subtract(
                                      const Duration(days: 365 * 5),
                                    )
                                  : DateTime.now().subtract(
                                      const Duration(days: 365 * 18),
                                    ),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            dobControllers[index].text = DateFormat(
                              'dd-MM-yyyy',
                            ).format(pickedDate!);
                                                    },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select date of birth';
                            }
                            return null;
                          },
                        ),
                        if (!isInfant) ...[
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: passportControllers[index],
                            decoration: InputDecoration(
                              labelText: 'Passport Number',
                              labelStyle: const TextStyle(fontSize: 13),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                            ),
                            validator: (value) {
                              if (!isInfant &&
                                  (value == null || value.isEmpty)) {
                                return 'Please enter passport number';
                              }
                              if (value != null &&
                                  value.isNotEmpty &&
                                  !RegExp(
                                    r'^[a-zA-Z0-9]{6,20}$',
                                  ).hasMatch(value)) {
                                return 'Invalid passport number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            readOnly: true,
                            controller: expiryControllers[index],
                            decoration: InputDecoration(
                              labelText: 'Passport Expiry',
                              labelStyle: const TextStyle(fontSize: 13),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                              suffixIcon: Icon(
                                Icons.calendar_today,
                                size: 18,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now().add(
                                  const Duration(days: 365 * 5),
                                ),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                              expiryControllers[index].text = DateFormat(
                                'dd-MM-yyyy',
                              ).format(pickedDate!);
                                                        },
                            validator: (value) {
                              if (!isInfant &&
                                  (value == null || value.isEmpty)) {
                                return 'Please select expiry date';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<Country>(
                            decoration: InputDecoration(
                              labelText: 'Country of Issue',
                              labelStyle: const TextStyle(fontSize: 13),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                            ),
                            isExpanded: true,
                            dropdownColor: Colors.white,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey.shade600,
                            ),
                            value: selectedCountriesOfIssue[index],
                            items: state.nationalitList.map((Country value) {
                              return DropdownMenuItem<Country>(
                                value: value,
                                child: Text(
                                  value.countryName,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              );
                            }).toList(),
                            onChanged: (Country? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  selectedCountriesOfIssue[index] = newValue;
                                });
                              }
                            },
                            validator: (value) {
                              if (!isInfant && value == null) {
                                return 'Please select country of issue';
                              }
                              return null;
                            },
                          ),
                        ],

                        // Same as first passenger checkbox
                        if (!isFirstPassenger) ...[
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Checkbox(
                                value: sameAsFirstPassenger[index],
                                onChanged: (value) {
                                  setState(() {
                                    sameAsFirstPassenger[index] =
                                        value ?? false;
                                  });
                                },
                                activeColor: maincolor1!,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                              Text(
                                'Same as first passenger',
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ],

                        // Address fields (only if not same as first passenger)
                        if (!sameAsFirstPassenger[index]) ...[
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: addressControllers[index],
                            decoration: InputDecoration(
                              labelText: 'Address',
                              labelStyle: const TextStyle(fontSize: 13),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                            ),
                            maxLines: 2,
                            validator: (value) {
                              if (!sameAsFirstPassenger[index] &&
                                  (value == null || value.isEmpty)) {
                                return 'Please enter address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: pincodeControllers[index],
                            decoration: InputDecoration(
                              labelText: 'Pin Code',
                              labelStyle: const TextStyle(fontSize: 13),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (!sameAsFirstPassenger[index] &&
                                  (value == null || value.isEmpty)) {
                                return 'Please enter pin code';
                              }
                              if (value != null &&
                                  value.isNotEmpty &&
                                  !RegExp(r'^[0-9]{6}$').hasMatch(value)) {
                                return 'Pin code must be 6 digits';
                              }
                              return null;
                            },
                          ),
                        ],

                        // Meal selection (only if available)
                        if (hasMeals) ...[
                          const SizedBox(height: 16),
                          DropdownButtonFormField<Meal>(
                            decoration: InputDecoration(
                              labelText: 'Select Meal (Optional)',
                              labelStyle: const TextStyle(fontSize: 13),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                            ),
                            isExpanded: true,
                            dropdownColor: Colors.white,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey.shade600,
                            ),
                            hint: const Text(
                              'No meal selected',
                              style: TextStyle(fontSize: 13),
                            ),
                            value: selectedMeals[index],
                            items: mealOptions
                                .cast<Meal>()
                                .map<DropdownMenuItem<Meal>>((meal) {
                                  return DropdownMenuItem<Meal>(
                                    value: meal,
                                    child: Text(
                                      '${meal.name} - ${meal.amount?.toStringAsFixed(2) ?? '0.00'} ${meal.currency ?? 'INR'}',
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  );
                                })
                                .toList(),
                            onChanged: (Meal? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  selectedMeals[index] = newValue;
                                });
                              }
                            },
                          ),
                        ],

                        // Baggage selection (only if available)
                        if (hasBaggage) ...[
                          const SizedBox(height: 16),
                          DropdownButtonFormField<Baggage>(
                            decoration: InputDecoration(
                              labelText: 'Add Baggage (Optional)',
                              labelStyle: const TextStyle(fontSize: 13),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            isExpanded: true,
                            dropdownColor: Colors.white,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey.shade600,
                            ),
                            hint: const Text(
                              'No baggage selected',
                              style: TextStyle(fontSize: 12),
                            ),
                            value: selectedBaggages[index],
                            items: baggageOptions.map((dynamic item) {
                              final baggage = item as Baggage;
                              return DropdownMenuItem<Baggage>(
                                value: baggage,
                                child: Text(
                                  '${baggage.name ?? baggage.code} - ${baggage.amount ?? ''}',
                                  style: const TextStyle(fontSize: 11),
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
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddOnChip({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: maincolor1!.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: maincolor1!),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: maincolor1!,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
