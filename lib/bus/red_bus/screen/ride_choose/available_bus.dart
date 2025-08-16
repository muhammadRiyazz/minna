// import 'package:flutter/material.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:maaxusminihub/screen/insurance/domain/2whlr_Q_requestModel/instance_of_post.dart';
// import 'package:maaxusminihub/screen/insurance/screen/pages/2whlr_quik2/new_widget.dart';
// import 'package:maaxusminihub/screen/red_bus/domain/data_post_redBus.dart';
// import 'package:maaxusminihub/screen/red_bus/screen/ride_choose/from_to_date.dart';
// import 'package:maaxusminihub/screen/red_bus/screen/ride_choose/seat_layout.dart';
// import 'package:maaxusminihub/screen/red_bus/screen/ride_choose/test_seat_layout/test_layout.dart';

// import '../../application/first_bloc/bloc/bloc/wallet_bloc_bloc.dart';

// class AvailableBusScreen extends StatefulWidget {
//   const AvailableBusScreen({Key? key}) : super(key: key);

//   @override
//   State<AvailableBusScreen> createState() => _AvailableBusScreenState();
// }

// class _AvailableBusScreenState extends State<AvailableBusScreen> {
//   @override
//   Widget build(BuildContext context) {
//     //departure
//     String depTimeFromRedbus, depdecimelDivided, depsplitedValue, depTime;
//     List depsplitdeList;
//     //arrival
//     String arrivalTimeFromRedbus,
//         arriDecimalDivide,
//         arrivalSplitedValue,
//         arrivalTime;
//     List arriSplitedList;

//     List listOfFares;

//     context.read<FirstBlocRedBus>().add(AvailableBudEvent());
//     return Scaffold(
//       body: SafeArea(
//         child: ListView(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 3, right: 3),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.red,
//                   border: Border.all(
//                     color: Colors.red,
//                     width: 1,
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 height: MediaQuery.of(context).size.height / 9.5,
//                 width: double.infinity,
//                 child: BlocBuilder<FirstBlocRedBus, WalletBlocState>(
//                   builder: (context, state) {
//                     if (state is GettingAvailableBusState) {
//                       return Center(
//                           child: Padding(
//                         padding: const EdgeInsets.only(top: 50),
//                         child: CircularProgressIndicator(
//                           color: Colors.red,
//                         ),
//                       ));
//                     }
//                     if (state is NetworkErrorAvailableState) {
//                       return Text('f');
//                     }
//                     if (state is GotDataAvailableListState) {
//                       return Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           GestureDetector(
//                             onTap: () async {
//                               // Navigator.pushAndRemoveUntil(
//                               //     context,
//                               //     MaterialPageRoute(
//                               //         builder: (context) =>
//                               //             FromToDateSearchPage()),
//                               //     (route) => true);
//                               Navigator.pop(context);
//                             },
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 CircleAvatar(
//                                     backgroundColor: Colors.white,
//                                     child: Icon(
//                                       Icons.arrow_back_ios_new_sharp,
//                                       color: Colors.black,
//                                     )),
//                                 Text(
//                                   'Back',
//                                   style: TextStyle(color: Colors.white),
//                                 )
//                               ],
//                             ),
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 15),
//                                 child: Row(
//                                   children: [
//                                     Text19WhiteBold(
//                                         test: globalPostRedBus.fromLocation),
//                                     Icon(Icons.arrow_forward),
//                                     Text19WhiteBold(
//                                         test: globalPostRedBus.toLocation),
//                                   ],
//                                 ),
//                               ),
//                               TextSize17BoldWhite(
//                                 test: globalPostRedBus.dateOfJurny,
//                               )
//                             ],
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               border: Border.all(
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Column(
//                               children: [
//                                 TextNormalColorBlack(
//                                   test: ' Available ',
//                                 ),
//                                 TextSize21BlkBold(
//                                     test: state.modelList.availableTrips.length
//                                         .toString()),
//                                 TextNormalColorBlack(
//                                   test: 'Buses',
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       );
//                     }
//                     return Container();
//                   },
//                 ),
//               ),
//             ),
//             Column(
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.height / 1.25,
//                   child: BlocBuilder<FirstBlocRedBus, WalletBlocState>(
//                     builder: (context, state) {
//                       if (state is GettingAvailableBusState) {
//                         return Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Center(
//                               child: Column(
//                                 children: [
//                                   CircularProgressIndicator(
//                                     color: Colors.red,
//                                   ),
//                                   Text('Loading '),
//                                   Text('Please wait! ')
//                                 ],
//                               ),
//                             ),
//                           ],
//                         );
//                       }
//                       if (state is NetworkErrorAvailableState) {
//                         context
//                             .read<FirstBlocRedBus>()
//                             .add(AvailableBudEvent());
//                         return Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Center(
//                               child: TextButton(
//                                   onPressed: () {
//                                     context
//                                         .read<FirstBlocRedBus>()
//                                         .add(AvailableBudEvent());
//                                   },
//                                   child: Text(' Refresh ')),
//                             ),
//                           ],
//                         );
//                       }
//                       if (state is GotDataAvailableListState) {
//                         return ListView.builder(
//                             itemCount: state.modelList.availableTrips.length,
//                             itemBuilder: (c, i) {
//                               //depatrture
//                               print('Departure timee');
//                               depTimeFromRedbus = state
//                                   .modelList.availableTrips[i].departureTime;
//                               print(
//                                   'Remaining is ${int.parse(depTimeFromRedbus) % 60}');
//                               print(
//                                   'Division is ${int.parse(depTimeFromRedbus) / 60}');

//                               depdecimelDivided =
//                                   '${int.parse(depTimeFromRedbus) / 60}';
//                               depsplitdeList =
//                                   depdecimelDivided.split('.').toList();
//                               depsplitedValue = depsplitdeList[0];
//                               print('Splited value ${depsplitedValue}');

//                               print('value issssss');

//                               print(int.parse(depsplitedValue) % 24);
//                               depTime =
//                                   "${int.parse(depsplitedValue) % 24} : ${int.parse(depTimeFromRedbus) % 60}";

//                               print('dep time ${depTime}');
//                               print(state
//                                   .modelList.availableTrips[i].departureTime);
//                               if (int.parse(depsplitedValue) < 24) {
//                                 print(
//                                     ' Departure is ${depsplitedValue} : ${int.parse(depTimeFromRedbus) % 60}');
//                               } else {
//                                 print('sorry');
//                               }
//                               print('arrrriiivvvalll timeee');

//                               ///Arrival time ////
//                               arrivalTimeFromRedbus =
//                                   state.modelList.availableTrips[i].arrivalTime;
//                               arriDecimalDivide =
//                                   '${int.parse(arrivalTimeFromRedbus) / 60}';
//                               arriSplitedList =
//                                   arriDecimalDivide.split('.').toList();

//                               arrivalSplitedValue = arriSplitedList[0];
//                               arrivalTime =
//                                   "${int.parse(arrivalSplitedValue) % 24} : ${int.parse(arrivalTimeFromRedbus) % 60}";

//                               /////
//                               print('listtttttttt');
//                               // listOfFares = state.modelList.availableTrips[i].fares;
//                               // print(state.modelList.availableTrips[i]
//                               //     .fareDetails[i].baseFare);
//                               print(state.modelList.availableTrips[i].fares[1]
//                                   .toString());

//                               // print(state.modelList.availableTrips[i].fares
//                               //     .toString());

//                               // print(listOfFares);

//                               return Padding(
//                                 padding: const EdgeInsets.all(5.0),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                       color: Colors.black,
//                                       width: 1,
//                                     ),
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   height: 215,
//                                   width: double.infinity,
//                                   // color: Colors.white,
//                                   child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 3.0,
//                                             right: 3.0,
//                                             bottom: 1.0,
//                                             top: 7),
//                                         child: TextSize21BlkBold(
//                                           test: state.modelList
//                                               .availableTrips[i].travels,
//                                         ),
//                                       ),
//                                       TextNormalColorBlack(
//                                           test:
//                                               '${state.modelList.availableTrips[i].availableSeats} Seats Available/${state.modelList.availableTrips[i].availableSingleSeat} Single Seats'),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           TextNormalColorBlack(
//                                               test: state
//                                                           .modelList
//                                                           .availableTrips[i]
//                                                           .ac ==
//                                                       'true'
//                                                   ? 'AC'
//                                                   : 'NON AC'
//                                               //          ==
//                                               //     'false'
//                                               // ? '${state.modelList.availableTrips[i].ac}'
//                                               // : 'false',
//                                               ),
//                                           TextNormalColorBlack(
//                                             test: state
//                                                         .modelList
//                                                         .availableTrips[i]
//                                                         .sleeper ==
//                                                     'true'
//                                                 ? '/Sleeper'
//                                                 : '/Semi Sleeper',
//                                           )
//                                         ],
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                           DepArrivaCard(
//                                               depTime: depTime,
//                                               test: 'Departure'),
//                                           TextNormalColorBlack(
//                                               test: '----->----'),
//                                           DepArrivaCard(
//                                               depTime: state.modelList
//                                                   .availableTrips[i].duration,
//                                               test: ' Duration '),
//                                           TextNormalColorBlack(
//                                               test: '----->----'),
//                                           DepArrivaCard(
//                                               depTime: arrivalTime,
//                                               test: '   Arrival   '),
//                                         ],
//                                       ),
//                                       Divider(
//                                         height: 1,
//                                         thickness: 2,
//                                       ),
//                                       Container(
//                                         width: double.infinity,
//                                         height: 39,
//                                         // color: Colors.red,
//                                         decoration: BoxDecoration(
//                                           color: Colors.red,
//                                           border: Border.all(
//                                             width: 1,
//                                             color: Color.fromARGB(
//                                                 255, 205, 42, 17),
//                                           ),
//                                           borderRadius: BorderRadius.only(
//                                               bottomLeft: Radius.circular(12),
//                                               bottomRight: Radius.circular(12)),
//                                         ),
//                                         child: TextButton(
//                                           onPressed: () async {
//                                             print(
//                                                 'trip idddddddddddddddddddddddddddddddddddd ****************'); //2000002144500065605///g
//                                             print(state.modelList
//                                                 .availableTrips[i].id);
//                                             await Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) =>

//                                                     //  MyListView()
//                                                     // SeatsScreen()
//                                                     // TestLayout(
//                                                     //   tripid: state
//                                                     //       .modelList
//                                                     //       .availableTrips[i]
//                                                     //       .id,
//                                                     // )
//                                                     SeatLayOutPage(
//                                                   tripId: state.modelList
//                                                       .availableTrips[i].id,
//                                                 ),
//                                               ),
//                                             );
//                                             setState(() {});
//                                           },
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               state.modelList.availableTrips[i].fares[0] == '1' ||
//                                                       state
//                                                               .modelList
//                                                               .availableTrips[i]
//                                                               .fares[0] ==
//                                                           '2' ||
//                                                       state
//                                                               .modelList
//                                                               .availableTrips[i]
//                                                               .fares[0] ==
//                                                           '3' ||
//                                                       state
//                                                               .modelList
//                                                               .availableTrips[i]
//                                                               .fares[0] ==
//                                                           '4' ||
//                                                       state
//                                                               .modelList
//                                                               .availableTrips[i]
//                                                               .fares[0] ==
//                                                           '8' ||
//                                                       state
//                                                               .modelList
//                                                               .availableTrips[i]
//                                                               .fares[0] ==
//                                                           '6' ||
//                                                       state
//                                                               .modelList
//                                                               .availableTrips[i]
//                                                               .fares[0] ==
//                                                           '7' ||
//                                                       state
//                                                               .modelList
//                                                               .availableTrips[i]
//                                                               .fares[0] ==
//                                                           '5' ||
//                                                       state
//                                                               .modelList
//                                                               .availableTrips[i]
//                                                               .fares[0] ==
//                                                           '9'
//                                                   ? TextNormalColorWhite(
//                                                       test:
//                                                           'Prices at ${state.modelList.availableTrips[i].fares}')
//                                                   : TextNormalColorWhite(
//                                                       test:
//                                                           'Prices at ${state.modelList.availableTrips[i].fares[0]}'),
//                                               Row(
//                                                 children: [
//                                                   TextNormalColorWhite(
//                                                     test: 'View seats',
//                                                   ),
//                                                   WhiteIconColor(),
//                                                   WhiteIconColor(),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             });
//                       }
//                       return TextButton(
//                           onPressed: () {
//                             context
//                                 .read<FirstBlocRedBus>()
//                                 .add(AvailableBudEvent());
//                           },
//                           child: Text('Refresh'));
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // class NewwwBuAvaScreennn extends StatelessWidget {
// //   const NewwwBuAvaScreennn({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     context.read<FirstBlocRedBus>().add(AvailableBudEvent());
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Asd')),
// //       body: BlocBuilder<FirstBlocRedBus, WalletBlocState>(
// //         builder: (context, state) {
// //           if (state is GettingAvailableBusState) {
// //             return Center(
// //                 child: CircularProgressIndicator(
// //               color: Colors.red,
// //             ));
// //           }
// //           if (state is NetworkErrorAvailableState) {
// //             return Text(state.error);
// //           }
// //           if (state is GotDataAvailableListState) {
// //             return ListView.builder(
// //                 itemCount: state.modelList.availableTrips.length,
// //                 itemBuilder: (c, i) {
// //                   return Text(state.modelList.availableTrips[i].ac);
// //                 });
// //             // return Column(
// //             //   children: [
// //             //     Text(state.modelList.agentMappedToCp),
// //             //     Text(state.modelList.agentMappedToEarning),
// //             //   ],
// //             // );
// //           }
// //           return Container();
// //         },
// //       ),
// //     );
// //   }
// // }

// // class Sample extends StatelessWidget {
// //   const Sample({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     context.read<FirstBlocRedBus>().add(DpBpEvent());
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('data'),
// //       ),
// //       body: BlocBuilder<FirstBlocRedBus, WalletBlocState>(
// //         builder: (context, state) {
// //           if (state is DpBpState) {
// //             return Center(
// //                 child: CircularProgressIndicator(
// //               color: Colors.red,
// //             ));
// //           }
// //           if (state is DpBPkErrorState) {
// //             return Text(state.error);
// //           }
// //           if (state is DpBpGotDataState)
// //             return ListView.builder(
// //                 itemCount: state.dpBp.boardingPoints.length,
// //                 itemBuilder: (c, i) {
// //                   print('***************************************');
// //                   return Text(state.dpBp.boardingPoints[i].locationName);
// //                 });
// //           return Container();
// //         },
// //       ),
// //     );
// //   }
// // }

// class WhiteIconColor extends StatelessWidget {
//   const WhiteIconColor({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Icon(
//       Icons.arrow_forward_ios,
//       color: Colors.white,
//     );
//   }
// }

// class Text19WhiteBold extends StatelessWidget {
//   Text19WhiteBold({Key? key, required this.test}) : super(key: key);
//   String test;
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       test,
//       style: TextStyle(
//           fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),
//     );
//   }
// }

// class TextNormalColorBlack extends StatelessWidget {
//   TextNormalColorBlack({Key? key, required this.test}) : super(key: key);
//   String test;
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       test,
//       style: TextStyle(color: Colors.black),
//     );
//   }
// }

// class TextNormalColorWhite extends StatelessWidget {
//   TextNormalColorWhite({Key? key, required this.test}) : super(key: key);
//   String test;
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       test,
//       style: TextStyle(
//           color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
//     );
//   }
// }

// class DepArrivaCard extends StatelessWidget {
//   const DepArrivaCard({Key? key, required this.depTime, required this.test})
//       : super(key: key);

//   final String depTime;
//   final String test;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: Column(
//           children: [
//             Text(test),
//             Text(depTime),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TextSize21BlkBold extends StatelessWidget {
//   TextSize21BlkBold({Key? key, required this.test}) : super(key: key);
//   String test;

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       test,
//       style: TextStyle(
//         fontWeight: FontWeight.bold,
//         fontSize: 21,
//       ),
//     );
//   }
// }

// class Samoe extends StatefulWidget {
//   Samoe({Key? key, required this.value}) : super(key: key);
//   String value;

//   @override
//   State<Samoe> createState() => _SamoeState();
// }

// class _SamoeState extends State<Samoe> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
