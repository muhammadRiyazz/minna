// import 'package:minna/comman/const/const.dart';
// import 'package:minna/red_bus/screen/new/const/color.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:minna/red_bus/screen/new/domain/trips%20list%20modal/trip_list_modal.dart';

// import '../../../../application/bus filter selection bloc/bus_filter_selection_bloc.dart';
// import '../../../../application/bus trip list/bus_trip_list_bloc.dart';

// Future<dynamic> filterPart(
//   BuildContext context,
//   // List<AvailableTrip> availableTrip,
// ) {
//   List<String> filterCategories = [
//     'Bus Types',
//     'Departure Times',
//     'Arrival Times',
//   ];
//   List<String> bustypes = ['Sleeper', 'Seater', 'Ac', 'Non Ac'];
//   List<String> departureTimes = [
//     'Before 6 am',
//     '6 am to 12 pm',
//     '12 pm to 6 pm',
//     'After 6 pm',
//   ];
//   List<String> arrivalTimes = [
//     'Before 6 am',
//     '6 am to 12 pm',
//     '12 pm to 6 pm',
//     'After 6 pm',
//   ];

//   return showModalBottomSheet(
//     backgroundColor: Color.fromARGB(0, 0, 0, 0),
//     context: context,
//     builder: (context) {
//       return BlocBuilder<BusFilterSelectionBloc, BusFilterSelectionState>(
//         builder: (context, state) {
//           return Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(30),
//                 topRight: Radius.circular(30),
//               ),
//             ),
//             //  height: 180,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//               child: Column(
//                 children: [
//                   Container(
//                     height: 4,
//                     width: 40,
//                     decoration: BoxDecoration(
//                       color: maincolor1,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Divider(height: 0),
//                   Expanded(
//                     child: ListView(
//                       children: [
//                         ListTile(
//                           title: Text(filterCategories[0]),
//                           subtitle: Column(
//                             children: List.generate(bustypes.length, (index) {
//                               return InkWell(
//                                 onTap: () {
//                                   List<bool> busTypeslistselection = [];

//                                   for (var i = 0; i <= 3; i++) {
//                                     if (i != index) {
//                                       busTypeslistselection.add(
//                                         state.busTypeslist[i],
//                                       );
//                                     } else if (i == index) {
//                                       if (state.busTypeslist[i]) {
//                                         busTypeslistselection.add(false);
//                                       } else {
//                                         busTypeslistselection.add(true);
//                                       }
//                                     }
//                                   }

//                                   BlocProvider.of<BusFilterSelectionBloc>(
//                                     context,
//                                   ).add(
//                                     SelectFilter(
//                                       busTypeslist: busTypeslistselection,
//                                       departureTimes: state.departureTimes,
//                                       arrivalTimes: state.arrivalTimes,
//                                     ),
//                                   );
//                                 },
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(bustypes[index].toString()),
//                                     Padding(
//                                       padding: const EdgeInsets.all(10.0),
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           border: Border.all(
//                                             color: Colors.black26,
//                                           ),
//                                           borderRadius: BorderRadius.circular(
//                                             13,
//                                           ),
//                                         ),
//                                         child: Padding(
//                                           padding: EdgeInsets.all(3),
//                                           child: CircleAvatar(
//                                             radius: 8,
//                                             backgroundColor:
//                                                 state.busTypeslist[index]
//                                                     ? maincolor1
//                                                     : Colors.white,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             }),
//                           ),
//                         ),
//                         Divider(),
//                         ListTile(
//                           title: Text(filterCategories[1]),
//                           subtitle: Column(
//                             children: List.generate(bustypes.length, (index) {
//                               return InkWell(
//                                 // onTap: () {
//                                 onTap: () {
//                                   List<bool> departureTimesselection = [];

//                                   for (var i = 0; i <= 3; i++) {
//                                     if (i != index) {
//                                       departureTimesselection.add(
//                                         state.departureTimes[i],
//                                       );
//                                     } else if (i == index) {
//                                       if (state.departureTimes[i]) {
//                                         departureTimesselection.add(false);
//                                       } else {
//                                         departureTimesselection.add(true);
//                                       }
//                                     }
//                                   }

//                                   BlocProvider.of<BusFilterSelectionBloc>(
//                                     context,
//                                   ).add(
//                                     SelectFilter(
//                                       busTypeslist: state.busTypeslist,
//                                       departureTimes: departureTimesselection,
//                                       arrivalTimes: state.arrivalTimes,
//                                     ),
//                                   );
//                                 },

//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(departureTimes[index].toString()),
//                                     Padding(
//                                       padding: const EdgeInsets.all(10.0),
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           border: Border.all(
//                                             color: Colors.black26,
//                                           ),
//                                           borderRadius: BorderRadius.circular(
//                                             13,
//                                           ),
//                                         ),
//                                         child: Padding(
//                                           padding: EdgeInsets.all(3),
//                                           child: CircleAvatar(
//                                             radius: 8,
//                                             backgroundColor:
//                                                 state.departureTimes[index]
//                                                     ? maincolor1
//                                                     : Colors.white,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             }),
//                           ),
//                         ),
//                         Divider(),
//                         ListTile(
//                           title: Text(filterCategories[2]),
//                           subtitle: Column(
//                             children: List.generate(bustypes.length, (index) {
//                               return InkWell(
//                                 onTap: () {
//                                   List<bool> arrivalTimesselection = [];

//                                   for (var i = 0; i <= 3; i++) {
//                                     if (i != index) {
//                                       arrivalTimesselection.add(
//                                         state.arrivalTimes[i],
//                                       );
//                                     } else if (i == index) {
//                                       if (state.arrivalTimes[i]) {
//                                         arrivalTimesselection.add(false);
//                                       } else {
//                                         arrivalTimesselection.add(true);
//                                       }
//                                     }
//                                   }

//                                   BlocProvider.of<BusFilterSelectionBloc>(
//                                     context,
//                                   ).add(
//                                     SelectFilter(
//                                       busTypeslist: state.busTypeslist,
//                                       departureTimes: state.departureTimes,
//                                       arrivalTimes: arrivalTimesselection,
//                                     ),
//                                   );
//                                 },

//                                 // onTap: () {
//                                 //   List<bool> arrivalTimesselection = [];

//                                 //   for (var i = 0; i <= 3; i++) {
//                                 //     if (i != index) {
//                                 //       arrivalTimesselection
//                                 //           .add(state.arrivalTimes[i]);
//                                 //     } else if (i == index) {
//                                 //       if (state.busTypeslist[i]) {
//                                 //         arrivalTimesselection.add(false);
//                                 //       } else {
//                                 //         arrivalTimesselection.add(true);
//                                 //       }
//                                 //     }
//                                 //   }

//                                 //   BlocProvider.of<BusFilterSelectionBloc>(
//                                 //           context)
//                                 //       .add(SelectFilter(
//                                 //           busTypeslist: state.busTypeslist,
//                                 //           departureTimes: state.departureTimes,
//                                 //           arrivalTimes: arrivalTimesselection));
//                                 // },
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(arrivalTimes[index].toString()),
//                                     Padding(
//                                       padding: const EdgeInsets.all(10.0),
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           border: Border.all(
//                                             color: Colors.black26,
//                                           ),
//                                           borderRadius: BorderRadius.circular(
//                                             13,
//                                           ),
//                                         ),
//                                         child: Padding(
//                                           padding: EdgeInsets.all(3),
//                                           child: CircleAvatar(
//                                             radius: 8,
//                                             backgroundColor:
//                                                 state.arrivalTimes[index]
//                                                     ? maincolor1
//                                                     : Colors.white,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             }),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(15),
//                     child: ElevatedButton(
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all<Color>(
//                           maincolor1,
//                         ),
//                       ),
//                       onPressed: () {
//                         // BlocProvider.of<BusTripListBloc>(context).add(
//                         //   FilterConform(
//                         //     sleeper: state.busTypeslist[0],
//                         //     seater: state.busTypeslist[1],
//                         //     ac: state.busTypeslist[2],
//                         //     nonAC: state.busTypeslist[3],
//                         //     departureCase1: state.departureTimes[0],
//                         //     departureCase2: state.departureTimes[1],
//                         //     departureCase3: state.departureTimes[2],
//                         //     departureCase4: state.departureTimes[3],
//                         //     arrivalCase1: state.arrivalTimes[0],
//                         //     arrivalCase2: state.arrivalTimes[1],
//                         //     arrivalCase3: state.arrivalTimes[2],
//                         //     arrivalCase4: state.arrivalTimes[3],
//                         //     availableTrips: availableTrip,
//                         //   ),
//                         // );
//                         // Navigator.pop(context);
//                       },
//                       child: SizedBox(
//                         height: 40,
//                         width: double.infinity,
//                         child: Center(
//                           child: Text(
//                             'Done',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     },
//   );
// }
