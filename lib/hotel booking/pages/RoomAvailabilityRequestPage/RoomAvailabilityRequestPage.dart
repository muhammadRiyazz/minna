// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:minna/comman/const/const.dart';
// import 'package:minna/hotel%20booking/domain/hotel%20details%20/hotel_details.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:minna/hotel%20booking/domain/rooms/rooms.dart';
// import 'package:minna/hotel%20booking/functions/fetch_rooms.dart';
// import 'package:minna/hotel%20booking/pages/Room%20Results%20Page/RoomAvailabilityResultsPage.dart';
// import 'package:minna/hotel%20booking/pages/holel%20home%20page/home_page_hotel.dart';

// class RoomAvailabilityRequestPage extends StatefulWidget {
//   final HotelDetail hotel;
//   const RoomAvailabilityRequestPage({super.key, required this.hotel});

//   @override
//   State<RoomAvailabilityRequestPage> createState() =>
//       _RoomAvailabilityRequestPageState();
// }

// class _RoomAvailabilityRequestPageState
//     extends State<RoomAvailabilityRequestPage> {
//   final _formKey = GlobalKey<FormState>();

//   DateTime? checkIn;
//   DateTime? checkOut;
//   final hotelCodesController = TextEditingController();
//   String nationality = 'IN';
//   final noOfRoomsController = TextEditingController(text: '1');
//   final responseTimeController = TextEditingController(text: '30');
//   bool isDetailedResponse = false;
//   bool refundableOnly = false;
//   String mealType = 'All';
//   bool _isLoading = false;

//   List<Map<String, dynamic>> paxRooms = [
//     {'adults': 1, 'children': 0, 'childrenAges': <int>[]},
//   ];

//   // Color Theme - Consistent throughout
//   final Color _primaryColor = Colors.black;
//   final Color _secondaryColor = Color(0xFFD4AF37); // Gold
//   final Color _accentColor = Color(0xFFC19B3C); // Darker Gold
//   final Color _backgroundColor = Color(0xFFF8F9FA);
//   final Color _cardColor = Colors.white;
//   final Color _textPrimary = Colors.black;
//   final Color _textSecondary = Color(0xFF666666);
//   final Color _textLight = Color(0xFF999999);

//   String? _validateForm() {
//     if (checkIn == null) {
//       return "Please select check-in date";
//     }
//     if (checkOut == null) {
//       return "Please select check-out date";
//     }
//     if (checkOut!.isBefore(checkIn!) || checkOut!.isAtSameMomentAs(checkIn!)) {
//       return "Check-out date must be after check-in date";
//     }

//     for (int i = 0; i < paxRooms.length; i++) {
//       final room = paxRooms[i];
//       if ((room['children'] as int) > 0) {
//         final childrenAges = room['childrenAges'] as List<int>;
//         for (int j = 0; j < childrenAges.length; j++) {
//           if (childrenAges[j] <= 0 || childrenAges[j] > 17) {
//             return "Please enter valid age (1-17) for children in Room ${i + 1}";
//           }
//         }
//       }
//     }

//     return null;
//   }

//   Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: isCheckIn ? DateTime.now() : (checkIn ?? DateTime.now()).add(const Duration(days: 1)),
//       firstDate: isCheckIn ? DateTime.now() : (checkIn ?? DateTime.now()),
//       lastDate: DateTime(2101),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: ColorScheme.light(
//               primary: _secondaryColor,
//               onPrimary: Colors.white,
//               onSurface: Colors.black,
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(foregroundColor: _secondaryColor),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (picked != null) {
//       setState(() {
//         if (isCheckIn) {
//           checkIn = picked;
//           if (checkOut != null && checkOut!.isBefore(picked)) {
//             checkOut = null;
//           }
//         } else {
//           checkOut = picked;
//         }
//       });
//     }
//   }

//   Widget _roomCard(int index) {
//     final room = paxRooms[index];
//     return Container(
//       margin: EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: _cardColor,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: _secondaryColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(Icons.king_bed_rounded, color: _secondaryColor, size: 20),
//                 ),
//                 SizedBox(width: 12),
//                 Text(
//                   "Room ${index + 1}",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                     color: _textPrimary,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Adults",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: _textSecondary,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 12),
//                         decoration: BoxDecoration(
//                           color: _backgroundColor,
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(color: Colors.grey.withOpacity(0.2)),
//                         ),
//                         child: DropdownButton<int>(
//                           value: room['adults'],
//                           isExpanded: true,
//                           underline: Container(),
//                           items: List.generate(8, (i) => i + 1)
//                               .map(
//                                 (e) => DropdownMenuItem(
//                                   value: e,
//                                   child: Text(
//                                     '$e',
//                                     style: TextStyle(fontSize: 14),
//                                   ),
//                                 ),
//                               )
//                               .toList(),
//                           onChanged: (val) => setState(() => room['adults'] = val),
//                           style: TextStyle(color: _textPrimary),
//                           dropdownColor: _cardColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Children",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: _textSecondary,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 12),
//                         decoration: BoxDecoration(
//                           color: _backgroundColor,
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(color: Colors.grey.withOpacity(0.2)),
//                         ),
//                         child: DropdownButton<int>(
//                           value: room['children'],
//                           isExpanded: true,
//                           underline: Container(),
//                           items: List.generate(5, (i) => i)
//                               .map(
//                                 (e) => DropdownMenuItem(
//                                   value: e,
//                                   child: Text(
//                                     '$e',
//                                     style: TextStyle(fontSize: 14),
//                                   ),
//                                 ),
//                               )
//                               .toList(),
//                           onChanged: (val) {
//                             setState(() {
//                               room['children'] = val;
//                               room['childrenAges'] = List.filled(val ?? 0, 1);
//                             });
//                           },
//                           style: TextStyle(color: _textPrimary),
//                           dropdownColor: _cardColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             if ((room['children'] ?? 0) > 0) ...[
//               SizedBox(height: 16),
//               Text(
//                 "Children Ages (1-17 years)",
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   color: _textPrimary,
//                   fontSize: 14,
//                 ),
//               ),
//               SizedBox(height: 12),
//               Wrap(
//                 spacing: 12,
//                 runSpacing: 12,
//                 children: List.generate(room['children'], (i) {
//                   return Container(
//                     width: 100,
//                     child: TextFormField(
//                       initialValue: room['childrenAges'][i].toString(),
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         labelText: 'Child ${i + 1}',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
//                         ),
//                         contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//                         errorStyle: TextStyle(fontSize: 10),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Required';
//                         }
//                         final age = int.tryParse(value);
//                         if (age == null || age < 1 || age > 17) {
//                           return '1-17';
//                         }
//                         return null;
//                       },
//                       onChanged: (value) {
//                         final age = int.tryParse(value) ?? 1;
//                         setState(() {
//                           room['childrenAges'][i] = age;
//                         });
//                       },
//                     ),
//                   );
//                 }),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }

//   void _submitForm() async {
//     final validationError = _validateForm();
//     if (validationError != null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(validationError), 
//           backgroundColor: Colors.red,
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//       return;
//     }

//     if (_formKey.currentState!.validate()) {
//       setState(() => _isLoading = true);

//       try {
//         final request = HotelSearchRequest(
//           checkIn: DateFormat('yyyy-MM-dd').format(checkIn!),
//           checkOut: DateFormat('yyyy-MM-dd').format(checkOut!),
//           hotelCodes: widget.hotel.hotelCode.toString(),
//           guestNationality: nationality,
//           paxRooms: paxRooms.map((room) {
//             return PaxRoom(
//               adults: room['adults'],
//               children: room['children'],
//               childrenAges: (room['children'] as int) > 0
//                   ? List<int>.from(room['childrenAges'])
//                   : null,
//             );
//           }).toList(),
//           responseTime: double.tryParse(responseTimeController.text) ?? 30.0,
//           isDetailedResponse: true,
//           refundable: refundableOnly,
//           noOfRooms: int.tryParse(noOfRoomsController.text) ?? 0,
//           mealType: mealType,
//           starRating: null,
//         );

//         final response = await HotelRoomApiService.searchHotels(request);

//         if (response.statusCode == 200) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => RoomAvailabilityResultsPage(
//                 hotel: widget.hotel,
//                 hotelSearchRequest: request,
//                 hotelRoomResult: response.hotelResult,
//               ),
//             ),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(response.description), 
//               backgroundColor: Colors.red,
//               behavior: SnackBarBehavior.floating,
//             ),
//           );
//         }
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Error: $e"), 
//             backgroundColor: Colors.red,
//             behavior: SnackBarBehavior.floating,
//           ),
//         );
//       } finally {
//         setState(() => _isLoading = false);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: _backgroundColor,
//       body: CustomScrollView(
//         slivers: [
//              SliverAppBar(
//             backgroundColor: _primaryColor,
//             expandedHeight: 120,
//             floating: false,
//             pinned: true,
//             elevation: 4,
//             shadowColor: Colors.black.withOpacity(0.3),
//             surfaceTintColor: Colors.white,
//             flexibleSpace: FlexibleSpaceBar(
//               title: Text(
//  "Room Availability",                style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               centerTitle: true,
//               background: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [_primaryColor, Color(0xFF2D2D2D)],
//                   ),
//                 ),
//               ),
//             ),
//             // shape: RoundedRectangleBorder(
//             //   borderRadius: BorderRadius.vertical(
//             //     bottom: Radius.circular(20),
//             //   ),
//             // ),
//           ),

//           // // Sliver App Bar
//           // SliverAppBar(
//           //   backgroundColor: _primaryColor,
//           //   expandedHeight: 280,
//           //   floating: false,
//           //   pinned: true,
//           //   elevation: 4,
//           //   shadowColor: Colors.black.withOpacity(0.3),
//           //   surfaceTintColor: Colors.white,
//           //   flexibleSpace: FlexibleSpaceBar(
//           //     title: Text(
//           //       "Room Availability",
//           //       style: TextStyle(
//           //         color: Colors.white,
//           //         fontSize: 16,
//           //         fontWeight: FontWeight.w600,
//           //       ),
//           //     ),
//           //     centerTitle: true,
//           //     background: Stack(
//           //       children: [
//           //         // Hotel Image Carousel
//           //         CarouselSlider(
//           //           options: CarouselOptions(
//           //             height: 280,
//           //             autoPlay: true,
//           //             autoPlayInterval: Duration(seconds: 3),
//           //             autoPlayAnimationDuration: Duration(milliseconds: 800),
//           //             autoPlayCurve: Curves.fastOutSlowIn,
//           //             pauseAutoPlayOnTouch: true,
//           //             enlargeCenterPage: false,
//           //             viewportFraction: 1.0,
//           //           ),
//           //           items: widget.hotel.images.map((i) {
//           //             return Builder(
//           //               builder: (BuildContext context) {
//           //                 return Container(
//           //                   width: MediaQuery.of(context).size.width,
//           //                   child: Image.network(
//           //                     i,
//           //                     fit: BoxFit.cover,
//           //                     errorBuilder: (context, error, stackTrace) {
//           //                       return Container(
//           //                         color: Colors.grey[300],
//           //                         child: Icon(Icons.broken_image_rounded, color: Colors.grey),
//           //                       );
//           //                     },
//           //                     loadingBuilder: (context, child, loadingProgress) {
//           //                       if (loadingProgress == null) return child;
//           //                       return Center(
//           //                         child: CircularProgressIndicator(
//           //                           value: loadingProgress.expectedTotalBytes != null
//           //                               ? loadingProgress.cumulativeBytesLoaded / 
//           //                                 loadingProgress.expectedTotalBytes!
//           //                               : null,
//           //                           color: _secondaryColor,
//           //                         ),
//           //                       );
//           //                     },
//           //                   ),
//           //                 );
//           //               },
//           //             );
//           //           }).toList(),
//           //         ),
//           //         // Gradient Overlay
//           //         Container(
//           //           decoration: BoxDecoration(
//           //             gradient: LinearGradient(
//           //               begin: Alignment.bottomCenter,
//           //               end: Alignment.topCenter,
//           //               colors: [
//           //                 Colors.black.withOpacity(0.6),
//           //                 Colors.transparent,
//           //                 Colors.transparent,
//           //               ],
//           //             ),
//           //           ),
//           //         ),
//           //       ],
//           //     ),
//           //   ),
//           //   shape: RoundedRectangleBorder(
//           //     borderRadius: BorderRadius.vertical(
//           //       bottom: Radius.circular(20),
//           //     ),
//           //   ),
//           // ),



//           // Main Content
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.all(20),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Hotel Info Card
//                    Container(
//                   decoration: BoxDecoration(
//                     color: _cardColor,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.05),
//                         blurRadius: 10,
//                         offset: Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(20),
//                           topRight: Radius.circular(20),
//                         ),
//                         child: CarouselSlider(
//                           options: CarouselOptions(
//                             height: 180.0,
//                             autoPlay: true,
//                             autoPlayInterval: Duration(seconds: 3),
//                             autoPlayAnimationDuration: Duration(milliseconds: 800),
//                             autoPlayCurve: Curves.fastOutSlowIn,
//                             pauseAutoPlayOnTouch: true,
//                             enlargeCenterPage: false,
//                             viewportFraction: 1.0,
//                           ),
//                           items: widget.hotel.images.map((i) {
//                             return Builder(
//                               builder: (BuildContext context) {
//                                 return Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   child: Image.network(
//                                     i,
//                                     fit: BoxFit.cover,
//                                     errorBuilder: (context, error, stackTrace) {
//                                       return Container(
//                                         color: Colors.grey[300],
//                                         child: Icon(Icons.broken_image_rounded, color: Colors.grey),
//                                       );
//                                     },
//                                     loadingBuilder: (context, child, loadingProgress) {
//                                       if (loadingProgress == null) return child;
//                                       return Center(
//                                         child: CircularProgressIndicator(
//                                           value: loadingProgress.expectedTotalBytes != null
//                                               ? loadingProgress.cumulativeBytesLoaded / 
//                                                 loadingProgress.expectedTotalBytes!
//                                               : null,
//                                           color: _secondaryColor,
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 );
//                               },
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(20),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               widget.hotel.hotelName,
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: _textPrimary,
//                               ),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             SizedBox(height: 8),
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Icon(
//                                   Icons.location_on_rounded,
//                                   color: _secondaryColor,
//                                   size: 16,
//                                 ),
//                                 SizedBox(width: 8),
//                                 Expanded(
//                                   child: Text(
//                                     widget.hotel.address,
//                                     style: TextStyle(
//                                       color: _textSecondary,
//                                       fontSize: 14,
//                                     ),
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 8),
//                             Container(
//                               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                               decoration: BoxDecoration(
//                                 color: _secondaryColor.withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Icon(Icons.star_rounded, color: _secondaryColor, size: 14),
//                                   SizedBox(width: 4),
//                                   Text(
//                                     "${widget.hotel.hotelRating} Star Hotel",
//                                     style: TextStyle(
//                                       color: _secondaryColor,
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                     // Dates Section
//                     _buildSectionHeader("Booking Dates"),
//                     SizedBox(height: 16),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: _buildDateCard(
//                             "Check-In",
//                             checkIn,
//                             () => _selectDate(context, true),
//                           ),
//                         ),
//                         SizedBox(width: 12),
//                         Expanded(
//                           child: _buildDateCard(
//                             "Check-Out",
//                             checkOut,
//                             () => _selectDate(context, false),
//                           ),
//                         ),
//                       ],
//                     ),
//                     if (checkIn != null && checkOut != null && checkOut!.isBefore(checkIn!))
//                       Padding(
//                         padding: EdgeInsets.only(top: 8.0),
//                         child: Text(
//                           "Check-out date must be after check-in date",
//                           style: TextStyle(color: Colors.red, fontSize: 12),
//                         ),
//                       ),
//                     SizedBox(height: 24),

//                     // Guest Information
//                     _buildSectionHeader("Guest Information"),
//                     SizedBox(height: 16),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: _cardColor,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.05),
//                             blurRadius: 10,
//                             offset: Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.all(20),
//                         child: Column(
//                           children: [
//                             DropdownButtonFormField<String>(
//                               value: nationality,
//                               decoration: InputDecoration(
//                                 labelText: 'Guest Nationality',
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
//                                 ),
//                                 prefixIcon: Icon(Icons.flag_rounded, color: _secondaryColor),
//                                 contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//                               ),
//                               items: countries
//                                   .map(
//                                     (c) => DropdownMenuItem(
//                                       value: c.code,
//                                       child: Text(c.name),
//                                     ),
//                                   )
//                                   .toList(),
//                               onChanged: (val) => setState(() => nationality = val!),
//                             ),
//                             SizedBox(height: 16),
//                             TextFormField(
//                               controller: noOfRoomsController,
//                               keyboardType: TextInputType.number,
//                               decoration: InputDecoration(
//                                 labelText: 'Number of Rooms',
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
//                                 ),
//                                 prefixIcon: Icon(Icons.meeting_room_rounded, color: _secondaryColor),
//                                 contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//                               ),
//                               onChanged: (val) {
//                                 final newCount = int.tryParse(val) ?? 1;
//                                 setState(() {
//                                   paxRooms = List.generate(newCount, (index) {
//                                     return {
//                                       'adults': 2,
//                                       'children': 0,
//                                       'childrenAges': <int>[],
//                                     };
//                                   });
//                                 });
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 24),

//                     // Room Configuration
//                     _buildSectionHeader("Room Configuration"),
//                     SizedBox(height: 16),
//                     Column(children: List.generate(paxRooms.length, _roomCard)),
//                     SizedBox(height: 24),

//                     // Preferences Section
//                     _buildSectionHeader("Preferences"),
//                     SizedBox(height: 16),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: _cardColor,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.05),
//                             blurRadius: 10,
//                             offset: Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.all(20),
//                         child: Column(
//                           children: [
//                             Container(
//                               padding: EdgeInsets.all(16),
//                               decoration: BoxDecoration(
//                                 color: _backgroundColor,
//                                 borderRadius: BorderRadius.circular(16),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     padding: EdgeInsets.all(8),
//                                     decoration: BoxDecoration(
//                                       color: _secondaryColor.withOpacity(0.1),
//                                       shape: BoxShape.circle,
//                                     ),
//                                     child: Icon(Icons.assignment_return_rounded, color: _secondaryColor, size: 20),
//                                   ),
//                                   SizedBox(width: 12),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "Only Refundable Rooms",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w600,
//                                             color: _textPrimary,
//                                           ),
//                                         ),
//                                         SizedBox(height: 4),
//                                         Text(
//                                           "Show only rooms with free cancellation",
//                                           style: TextStyle(
//                                             color: _textLight,
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Switch(
//                                     value: refundableOnly,
//                                     onChanged: (val) => setState(() => refundableOnly = val),
//                                     activeColor: _secondaryColor,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: 16),
//                             Container(
//                               padding: EdgeInsets.all(16),
//                               decoration: BoxDecoration(
//                                 color: _backgroundColor,
//                                 borderRadius: BorderRadius.circular(16),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     padding: EdgeInsets.all(8),
//                                     decoration: BoxDecoration(
//                                       color: _secondaryColor.withOpacity(0.1),
//                                       shape: BoxShape.circle,
//                                     ),
//                                     child: Icon(Icons.restaurant_rounded, color: _secondaryColor, size: 20),
//                                   ),
//                                   SizedBox(width: 12),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "Meal Type",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w600,
//                                             color: _textPrimary,
//                                           ),
//                                         ),
//                                         SizedBox(height: 4),
//                                         Text(
//                                           "Select your preferred meal option",
//                                           style: TextStyle(
//                                             color: _textLight,
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   DropdownButton<String>(
//                                     value: mealType,
//                                     underline: Container(),
//                                     items: const [
//                                       DropdownMenuItem(
//                                         value: 'All',
//                                         child: Text('All Meals'),
//                                       ),
//                                       DropdownMenuItem(
//                                         value: 'WithMeal',
//                                         child: Text('With Meal'),
//                                       ),
//                                       DropdownMenuItem(
//                                         value: 'RoomOnly',
//                                         child: Text('Room Only'),
//                                       ),
//                                     ],
//                                     onChanged: (val) => setState(() => mealType = val!),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 32),

//                     // Submit Button
//                     SizedBox(
//                       width: double.infinity,
//                       height: 56,
//                       child: ElevatedButton(
//                         onPressed: _isLoading ? null : _submitForm,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: _primaryColor,
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           elevation: 2,
//                         ),
//                         child: _isLoading
//                             ? SizedBox(
//                                 height: 20,
//                                 width: 20,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                   color: Colors.white,
//                                 ),
//                               )
//                             : Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(Icons.search_rounded, size: 20),
//                                   SizedBox(width: 12),
//                                   Text(
//                                     "Check Availability",
//                                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                                   ),
//                                 ],
//                               ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSectionHeader(String title) {
//     return Text(
//       title,
//       style: TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//         color: _textPrimary,
//       ),
//     );
//   }

//   Widget _buildDateCard(String title, DateTime? date, VoidCallback onTap) {
//     final isError = date == null;
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: _cardColor,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: isError ? Colors.red : Colors.grey.withOpacity(0.2),
//             width: 1.5,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.03),
//               blurRadius: 6,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(6),
//                   decoration: BoxDecoration(
//                     color: isError ? Colors.red.withOpacity(0.1) : _secondaryColor.withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     Icons.calendar_today_rounded,
//                     color: isError ? Colors.red : _secondaryColor,
//                     size: 16,
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Text(
//                   title,
//                   style: TextStyle(
//                     color: isError ? Colors.red : _textSecondary,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 8),
//             Text(
//               date != null
//                   ? DateFormat('EEE, MMM d, y').format(date)
//                   : 'Select Date',
//               style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w600,
//                 color: isError ? Colors.red : _textPrimary,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/countries.dart' hide countries;
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

  // Color Theme - Consistent throughout
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37); // Gold
  final Color _accentColor = Color(0xFFC19B3C); // Darker Gold
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);

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
              primary: _secondaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: _secondaryColor),
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
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.king_bed_rounded, color: _secondaryColor, size: 20),
                ),
                SizedBox(width: 12),
                Text(
                  "Room ${index + 1}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: _textPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Adults",
                        style: TextStyle(
                          fontSize: 14,
                          color: _textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: _backgroundColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.withOpacity(0.2)),
                        ),
                        child: DropdownButton<int>(
                          value: room['adults'],
                          isExpanded: true,
                          underline: Container(),
                          items: List.generate(8, (i) => i + 1)
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    '$e',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (val) => setState(() => room['adults'] = val),
                          style: TextStyle(color: _textPrimary),
                          dropdownColor: _cardColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Children",
                        style: TextStyle(
                          fontSize: 14,
                          color: _textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: _backgroundColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.withOpacity(0.2)),
                        ),
                        child: DropdownButton<int>(
                          value: room['children'],
                          isExpanded: true,
                          underline: Container(),
                          items: List.generate(5, (i) => i)
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    '$e',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              room['children'] = val;
                              room['childrenAges'] = List.filled(val ?? 0, 1);
                            });
                          },
                          style: TextStyle(color: _textPrimary),
                          dropdownColor: _cardColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if ((room['children'] ?? 0) > 0) ...[
              SizedBox(height: 16),
              Text(
                "Children Ages (1-17 years)",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: _textPrimary,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(room['children'], (i) {
                  return Container(
                    width: 100,
                    child: TextFormField(
                      initialValue: room['childrenAges'][i].toString(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Child ${i + 1}',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
        SnackBar(
          content: Text(validationError), 
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
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
          noOfRooms: int.tryParse(noOfRoomsController.text) ?? 0,
          mealType: mealType,
          starRating: null,
        );

        final response = await HotelRoomApiService.searchHotels(request);

        if (response.statusCode == 200) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RoomAvailabilityResultsPage(
                hotel: widget.hotel,
                hotelSearchRequest: request,
                hotelRoomResult: response.hotelResult,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.description), 
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: $e"), 
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: CustomScrollView(
        slivers: [
          // Sliver App Bar
          SliverAppBar(  leading: IconButton(
    icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
    onPressed: () => Navigator.pop(context),
  ),
            backgroundColor: _primaryColor,
            expandedHeight: 200,
            floating: false,
            pinned: true,
            elevation: 4,
            shadowColor: Colors.black.withOpacity(0.3),
            surfaceTintColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Room Availability",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
              background: Stack(
                children: [
                  // Hotel Image Carousel
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 240,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
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
                            child: Image.network(
                              i,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[300],
                                  child: Icon(Icons.broken_image_rounded, color: Colors.grey),
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
                                    color: _secondaryColor,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
           
            
          ),

          // Main Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hotel Info Card
                    Container(
                      margin: EdgeInsets.only(bottom: 24),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: _cardColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.hotel.hotelName,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: _textPrimary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on_rounded,
                                color: _secondaryColor,
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  widget.hotel.address,
                                  style: TextStyle(
                                    color: _textSecondary,
                                    fontSize: 14,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: _secondaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.star_rounded, color: _secondaryColor, size: 14),
                                SizedBox(width: 4),
                                Text(
                                  "${widget.hotel.hotelRating} Star Hotel",
                                  style: TextStyle(
                                    color: _secondaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Dates Section
                    _buildSectionHeader("Booking Dates"),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDateCard(
                            "Check-In",
                            checkIn,
                            () => _selectDate(context, true),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _buildDateCard(
                            "Check-Out",
                            checkOut,
                            () => _selectDate(context, false),
                          ),
                        ),
                      ],
                    ),
                    if (checkIn != null && checkOut != null && checkOut!.isBefore(checkIn!))
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Check-out date must be after check-in date",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    SizedBox(height: 24),

                    // Guest Information
                    _buildSectionHeader("Guest Information"),
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: _cardColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            DropdownButtonFormField<String>(
                              value: nationality,
                              decoration: InputDecoration(
                                labelText: 'Guest Nationality',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                                ),
                                prefixIcon: Icon(Icons.flag_rounded, color: _secondaryColor),
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                            SizedBox(height: 16),
                            TextFormField(
                              controller: noOfRoomsController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Number of Rooms',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                                ),
                                prefixIcon: Icon(Icons.meeting_room_rounded, color: _secondaryColor),
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24),

                    // Room Configuration
                    _buildSectionHeader("Room Configuration"),
                    SizedBox(height: 16),
                    Column(children: List.generate(paxRooms.length, _roomCard)),
                    SizedBox(height: 24),

                    // Preferences Section
                    _buildSectionHeader("Preferences"),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: _cardColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 25,horizontal: 15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: _secondaryColor.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.assignment_return_rounded, color: _secondaryColor, size: 20),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Only Refundable Rooms",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: _textPrimary,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Show only rooms with free cancellation",
                                        style: TextStyle(
                                          color: _textLight,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Switch(
                                  value: refundableOnly,
                                  onChanged: (val) => setState(() => refundableOnly = val),
                                  activeColor: _secondaryColor,
                                ),
                              ],
                            ),
                            Divider(height: 50,),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: _secondaryColor.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.restaurant_rounded, color: _secondaryColor, size: 20),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Meal Type",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: _textPrimary,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Select your preferred meal option",
                                        style: TextStyle(
                                          color: _textLight,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: mealType,
                                  underline: Container(),
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'All',
                                      child: Text('All Meals',style: TextStyle(fontSize: 13),),
                                    ),
                                    DropdownMenuItem(
                                      value: 'WithMeal',
                                      child: Text('With Meal',style: TextStyle(fontSize: 13),),
                                    ),
                                    DropdownMenuItem(
                                      value: 'RoomOnly',
                                      child: Text('Room Only',style: TextStyle(fontSize: 13),),
                                    ),
                                  ],
                                  onChanged: (val) => setState(() => mealType = val!),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 32),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 2,
                        ),
                        child: _isLoading
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.search_rounded, size: 20),
                                  SizedBox(width: 12),
                                  Text(
                                    "Check Availability",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: _textPrimary,
      ),
    );
  }

  Widget _buildDateCard(String title, DateTime? date, VoidCallback onTap) {
    final isError = date == null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isError ? Colors.red : Colors.grey.withOpacity(0.2),
            width: .5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: isError ? Colors.red.withOpacity(0.1) : _secondaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.calendar_today_rounded,
                    color: isError ? Colors.red : _secondaryColor,
                    size: 14,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: isError ? Colors.red : _textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              date != null
                  ? DateFormat('EEE, MMM d, y').format(date)
                  : 'Select Date',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isError ? Colors.red : _textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}