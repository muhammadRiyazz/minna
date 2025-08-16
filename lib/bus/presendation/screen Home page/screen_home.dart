// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';

// import '../../domain/data_post_redBus.dart';
// import '../../application/location change/location_change_bloc.dart';
// import '../../infrastructure/cancelTicket/cancel_Ticket_Details.dart';
// import '../../infrastructure/cancelTicket/conform_cancel_seat.dart';
// import '../screen reports/screen_reports.dart';
// import '../search location screen/search_location_screen.dart';

// class ScreenBushome extends StatefulWidget {
//   ScreenBushome({Key? key}) : super(key: key);
//   @override
//   State<ScreenBushome> createState() => _ScreenBushomeState();
// }
// class _ScreenBushomeState extends State<ScreenBushome> {

//   String templocation = '';
//   String templocationid = '';

//   String tempStrLocation = '';

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//           actionsIconTheme: IconThemeData(color: Colors.black),
//           iconTheme: IconThemeData(color: Colors.black),
//           //      backgroundColor: Colors.red,
//           actions: [
//             InkWell(
//               onTap: () {
//                 //    cancelSeats(tin: '583N78CA');
//                 Navigator.push(context, MaterialPageRoute(
//                   builder: (context) {
//                     return ScreenReport();
//                   },
//                 ));
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Icon(
//                   Icons.menu,
//                   size: 27,
//                 ),
//               ),
//             ),
//           ]),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(5.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                   height: size.height * .325,
//                   child: Image.asset(
//                     'asset/buss.jpeg',
//                     fit: BoxFit.contain,
//                   )),
//               Container(
//                 padding: EdgeInsets.all(15),
//                 decoration:
//                     BoxDecoration(borderRadius: BorderRadius.circular(10)),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       //height: 220,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                         color: Color.fromARGB(255, 241, 235, 235),
//                       ), ///////////q
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 10, horizontal: 10),
//                         child: BlocBuilder<LocationChangeBloc,
//                             LocationChangeState>(
//                           builder: (context, state) {
//                             log('rebuild');
//                             log(state.from);
//                             log(state.to);
//                             return Stack(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(5.0),
//                                   child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       InkWell(
//                                         onTap: () {
//                                           Navigator.push(context,
//                                               MaterialPageRoute(
//                                             builder: (context) {
//                                               return LocationSearchPage(
//                                                 fromOrto: 'from',
//                                               );
//                                             },
//                                           ));
//                                         },
//                                         child: Container(
//                                           width: double.infinity,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(15),
//                                             color: Colors.white,
//                                           ),
//                                           child: ListTile(
//                                               title: Text(
//                                                 'From',
//                                                 style: TextStyle(
//                                                     fontSize: 13,
//                                                     color: Color.fromARGB(
//                                                         255, 180, 174, 174)),
//                                               ),
//                                               subtitle: Text(
//                                                 state.from,
//                                                 style: TextStyle(
//                                                     fontSize: 15,
//                                                     fontWeight:
//                                                         FontWeight.w500),
//                                               ),
//                                               leading: Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(1.0),
//                                                 child: Icon(
//                                                   Icons.location_on_sharp,
//                                                   color: Colors.red,
//                                                   size: 37,
//                                                 ),
//                                               )),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 15,
//                                       ),
//                                       InkWell(
//                                         onTap: () async {
//                                           await Navigator.push(context,
//                                               MaterialPageRoute(
//                                             builder: (context) {
//                                               return LocationSearchPage(
//                                                 fromOrto: 'to',
//                                               );
//                                             },
//                                           ));
//                                         },
//                                         child: Container(
//                                           width: double.infinity,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(15),
//                                             color: Colors.white,
//                                           ),
//                                           child: ListTile(
//                                               title: Text(
//                                                 'To',
//                                                 style: TextStyle(
//                                                     fontSize: 13,
//                                                     color: Color.fromARGB(
//                                                         255, 180, 174, 174)),
//                                               ),
//                                               subtitle: Text(
//                                                 state.to,
//                                                 style: TextStyle(
//                                                     fontSize: 15,
//                                                     fontWeight:
//                                                         FontWeight.w500),
//                                               ),
//                                               leading: Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(1.0),
//                                                 child: Icon(
//                                                   Icons.location_on_sharp,
//                                                   color: Colors.red,
//                                                   size: 37,
//                                                 ),
//                                               )),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Positioned(
//                                   right: 20,
//                                   bottom: 50,
//                                   top: 48,
//                                   child: Container(
//                                     // color: Colors.amberAccent,
//                                     child: IconButton(
//                                         onPressed: () {
//                                           context
//                                               .read<LocationChangeBloc>()
//                                               .add(AddLocation(
//                                                 from:
//                                                     globalPostRedBus.toLocation,
//                                                 to: globalPostRedBus
//                                                     .fromLocation,
//                                               ));

//                                           templocationid =
//                                               globalPostRedBus.idToLocation;

//                                           globalPostRedBus =
//                                               globalPostRedBus.copyWith(
//                                                   idToLocation: globalPostRedBus
//                                                       .idFromLocation);

//                                           globalPostRedBus =
//                                               globalPostRedBus.copyWith(
//                                                   idFromLocation:
//                                                       templocationid);

//                                           //////
//                                           templocation =
//                                               globalPostRedBus.toLocation;

//                                           globalPostRedBus =
//                                               globalPostRedBus.copyWith(
//                                                   toLocation: globalPostRedBus
//                                                       .fromLocation);

//                                           globalPostRedBus =
//                                               globalPostRedBus.copyWith(
//                                                   fromLocation: templocation);
//                                           context
//                                               .read<LocationChangeBloc>()
//                                               .add(AddLocation(
//                                                 from: globalPostRedBus
//                                                     .fromLocation,
//                                                 to: globalPostRedBus.toLocation,
//                                               ));

//                                           log(' from ${globalPostRedBus.idFromLocation}');
//                                           log(' to ${globalPostRedBus.idToLocation}');
//                                         },
//                                         icon: Icon(
//                                           Icons.swap_vert_circle,
//                                           size: 59,
//                                           color: Colors.red,
//                                         )),
//                                   ),
//                                 )
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         InkWell(
//                           onTap: () async {
//                             DateTime? pickedDate = await showDatePicker(
//                                 builder: (context, child) {
//                                   return Theme(
//                                     data: Theme.of(context).copyWith(
//                                       colorScheme: ColorScheme.light(
//                                         primary: Colors.red, // <-- SEE HERE
//                                         onPrimary: Colors.white, // <-- SEE HERE
//                                         onSurface: Colors.red, // <-- SEE HERE
//                                       ),
//                                     ),
//                                     child: child!,
//                                   );
//                                 },
//                                 context: context, //context of current state
//                                 initialDate: DateTime.now(),
//                                 firstDate: DateTime
//                                     .now(), //DateTime.now() - not to allow to choose before today.
//                                 lastDate: DateTime(2101));

//                             if (pickedDate != null) {
//                               String formattedDate =
//                                   DateFormat('yyyy-MM-dd').format(pickedDate);

//                               globalPostRedBus = globalPostRedBus.copyWith(
//                                   dateOfJurny: formattedDate);

//                               setState(() {});
//                             } else {}
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: Color.fromARGB(255, 223, 216, 216),
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Icon(
//                                     Icons.calendar_month_outlined,
//                                     color: Colors.green,
//                                     size: 27,
//                                   ),
//                                   SizedBox(
//                                     width: 9,
//                                   ),
//                                   Text(
//                                     globalPostRedBus.dateOfJurny,
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.w500),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         // Navigator.push(context, MaterialPageRoute(
//                         //   builder: (context) {
//                         //     return ScreenAvailableTrips();
//                         //   },
//                         // ));
//                       },
//                       child: Container(
//                         height: 50,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colors.red,
//                         ),
//                         child: Center(
//                             child: Text(
//                           'Search Bus'.toUpperCase(),
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 15,
//                               fontWeight: FontWeight.w400),
//                         )),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
