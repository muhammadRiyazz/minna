// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:maaxusminihub/screen/insurance/screen/pages/2whlr_quik2/new_widget.dart';
// import 'package:maaxusminihub/screen/red_bus/application/first_bloc/bloc/bloc/wallet_bloc_bloc.dart';
// import 'package:maaxusminihub/screen/red_bus/domain/data_post_redBus.dart';
// import 'package:maaxusminihub/screen/red_bus/screen/personal_info/passenge_5.dart';
// import 'package:maaxusminihub/screen/red_bus/screen/personal_info/passenger_4.dart';
// import 'package:maaxusminihub/screen/red_bus/screen/personal_info/passenger_6.dart';

// import 'package:maaxusminihub/screen/red_bus/screen/personal_info/passenger_details_page.dart';
// import 'package:maaxusminihub/screen/red_bus/screen/ride_choose/seat_layout.dart';

// import '../personal_info/passenger_2.dart';
// import '../personal_info/passenger_3.dart';

// class BoardDropScreenNew extends StatefulWidget {
//   BoardDropScreenNew(
//       {Key? key,
//       required this.tripId,
//       required this.listFare,
//       required this.noPerson})
//       : super(key: key);
//   String tripId, noPerson;
//   List<ListOfSeatClass> listFare;

//   @override
//   State<BoardDropScreenNew> createState() =>
//       _BoardDropScreenNewState(tripId: tripId);
// }

// class _BoardDropScreenNewState extends State<BoardDropScreenNew> {
//   _BoardDropScreenNewState({required this.tripId});
//   String tripId;

//   @override
//   Widget build(BuildContext context) {
//     context.read<FirstBlocRedBus>().add(DpBpEvent(tripIdBpDp: tripId));
//     return Scaffold(
//       appBar: AppBar(
//           title: Text19Black(
//         test: 'Boarding point',
//       )),
//       body: BlocBuilder<FirstBlocRedBus, WalletBlocState>(
//         builder: (context, state) {
//           if (state is DpBpState) {
//             // context.read<FirstBlocRedBus>().add(DpBpEvent(tripIdBpDp: tripId));
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Center(
//                   child: Column(
//                     children: [
//                       CircularProgressIndicator(
//                         color: Colors.red,
//                       ),
//                       Text('Loading '),
//                       Text('Please wait! ')
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           }
//           if (state is DpBPkErrorState) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Center(
//                   child: TextButton(
//                       onPressed: () {
//                         context
//                             .read<FirstBlocRedBus>()
//                             .add(DpBpEvent(tripIdBpDp: tripId));
//                       },
//                       child: Text(' Refresh ')),
//                 ),
//               ],
//             );
//           }
//           if (state is DpBpGotDataState) {
//             return CardDropBoardNew(
//               onTap: () async {
//                 await Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => DropDropScreenNew22(
//                       bpName: state.dpBp.boardingPoints.name,
//                       noOfPerson: widget.noPerson,
//                       tripIdees: tripId,
//                       bPid: state.dpBp.boardingPoints.id,
//                       //  bPid: state.dpBp.boardingPoints[i].id,

//                       listSeat: widget.listFare,
//                       tripId: tripId,
//                     ),
//                   ),
//                 );
//                 setState(() {});
//               },
//               testBoard: state.dpBp.boardingPoints.name,
//               testLand: state.dpBp.boardingPoints.locationName,
//               testNumber: state.dpBp.boardingPoints.contactnumber,
//             );
//             // return ListView.builder(
//             //     itemCount: state.dpBp.boardingPoints.length,
//             //     itemBuilder: (c, i) {
//             //       return CardDropBoardNew(
//             //         onTap: () async {
//             //           print(state.dpBp.boardingPoints[i].id);
//             //           await Navigator.push(
//             //             context,
//             //             MaterialPageRoute(
//             //               builder: (context) => DropDropScreenNew22(
//             //                 noOfPerson: widget.noPerson,
//             //                 tripIdees: tripId,
//             //                 // bPid: state.dpBp.boardingPoints.id,
//             //                 bPid: state.dpBp.boardingPoints[i].id,

//             //                 listSeat: widget.listFare,
//             //                 tripId: tripId,
//             //               ),
//             //             ),
//             //           );
//             //           setState(() {});
//             //         },
//             //         testBoard: state.dpBp.boardingPoints[i].locationName,
//             //         testLand: state.dpBp.boardingPoints[i].landmark,
//             //         testNumber: state.dpBp.boardingPoints[i].contactnumber,
//             //       );
//             //     });
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }

// class DropDropScreenNew22 extends StatefulWidget {
//   DropDropScreenNew22(
//       {Key? key,
//       required this.tripId,
//       required this.listSeat,
//       required this.bPid,
//       required this.tripIdees,
//       required this.noOfPerson,
//       required this.bpName})
//       : super(key: key);
//   String tripId, noOfPerson, bpName;
//   List<ListOfSeatClass> listSeat;
//   String bPid;
//   String tripIdees;

//   @override
//   State<DropDropScreenNew22> createState() => _DropDropScreenNew22State();
// }

// class _DropDropScreenNew22State extends State<DropDropScreenNew22> {
//   @override
//   Widget build(BuildContext context) {
//     print('****************/*******************');

//     context.read<FirstBlocRedBus>().add(DpBpEvent(
//           tripIdBpDp: widget.tripId,
//         ));
//     return Scaffold(
//       appBar: AppBar(
//           title: Text19Black(
//         test: 'Droping point',
//       )),
//       body: BlocBuilder<FirstBlocRedBus, WalletBlocState>(
//         builder: (context, state) {
//           if (state is DpBpState) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Center(
//                   child: Column(
//                     children: [
//                       CircularProgressIndicator(
//                         color: Colors.red,
//                       ),
//                       Text('Loading '),
//                       Text('Please wait! ')
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           }
//           if (state is DpBPkErrorState) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Center(
//                   child: TextButton(
//                       onPressed: () {
//                         context.read<FirstBlocRedBus>().add(DpBpEvent(
//                               tripIdBpDp: widget.tripId,
//                             ));
//                       },
//                       child: Text(' Refresh ')),
//                 ),
//               ],
//             );
//           }
//           if (state is DpBpGotDataState) {
//             return CardDropBoardNew(
//               onTap: () async {
//                 log('********************************');

//                 print(widget.noOfPerson);

//                 widget.noOfPerson == '2'
//                     ? await Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => PssengerBookingDetailPage2(
//                                   bPid: widget.bPid,
//                                   listSeat: widget.listSeat,
//                                   tripId: widget.tripId,
//                                   tripIdees: widget.tripIdees,
//                                   bpName: widget.bpName,
//                                   dpName: state.dpBp.droppingPoints.name,
//                                 )),
//                       )
//                     : widget.noOfPerson == '3'
//                         ? await Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     PssengerBookingDetailPage3(
//                                       bpName: widget.bpName,
//                                       dpName: state.dpBp.droppingPoints.name,
//                                       bPid: widget.bPid,
//                                       listSeat: widget.listSeat,
//                                       tripId: widget.tripId,
//                                       tripIdees: widget.tripIdees,
//                                     )),
//                           )
//                         : widget.noOfPerson == '4'
//                             ? await Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         PssengerBookingDetailPage4(
//                                           bpName: widget.bpName,
//                                           dpName:
//                                               state.dpBp.droppingPoints.name,
//                                           bPid: widget.bPid,
//                                           listSeat: widget.listSeat,
//                                           tripId: widget.tripId,
//                                           tripIdees: widget.tripIdees,
//                                         )),
//                               )
//                             : widget.noOfPerson == '5'
//                                 ? await Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             PssengerBookingDetailPage5(
//                                               bpName: widget.bpName,
//                                               dpName: state
//                                                   .dpBp.droppingPoints.name,
//                                               bPid: widget.bPid,
//                                               listSeat: widget.listSeat,
//                                               tripId: widget.tripId,
//                                               tripIdees: widget.tripIdees,
//                                             )),
//                                   )
//                                 : widget.noOfPerson == '6'
//                                     ? await Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 PssengerBookingDetailPage6(
//                                                   bpName: widget.bpName,
//                                                   dpName: state
//                                                       .dpBp.droppingPoints.name,
//                                                   bPid: widget.bPid,
//                                                   listSeat: widget.listSeat,
//                                                   tripId: widget.tripId,
//                                                   tripIdees: widget.tripIdees,
//                                                 )),
//                                       )
//                                     : await Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 PssengerBookingDetailPage1(
//                                                   droppingPointIdee: state
//                                                       .dpBp.droppingPoints.id,
//                                                   passerngerCount: 1,
//                                                   bPid: widget.bPid,
//                                                   listSeat: widget.listSeat,
//                                                   tripId: widget.tripId,
//                                                   tripIdees: widget.tripIdees,
//                                                 )),
//                                       );
//                 setState(() {});
//               },
//               testBoard: state.dpBp.droppingPoints.name,
//               testLand: state.dpBp.droppingPoints.landmark,
//               testNumber: state.dpBp.droppingPoints.contactnumber,
//             );

//             // return ListView.builder(
//             //     itemCount: state.dpBp.droppingPoints.length,
//             //     itemBuilder: (c, i) {
//             //       return CardDropBoardNew(
//             //         onTap: () async {
//             //           // await Navigator.push(
//             //           //   context,
//             //           //   MaterialPageRoute(
//             //           //       builder: (context) =>

//             //           //           ),
//             //           // );
//             //           print('obj');

//             //           widget.noOfPerson == '2'
//             //               ? await Navigator.push(
//             //                   context,
//             //                   MaterialPageRoute(
//             //                       builder: (context) =>
//             //                           PssengerBookingDetailPage2(
//             //                             bPid: widget.bPid,
//             //                             listSeat: widget.listSeat,
//             //                             tripId: widget.tripId,
//             //                             tripIdees: widget.tripIdees,
//             //                           )),
//             //                 )
//             //               : widget.noOfPerson == '3'
//             //                   ? await Navigator.push(
//             //                       context,
//             //                       MaterialPageRoute(
//             //                           builder: (context) =>
//             //                               PssengerBookingDetailPage3(
//             //                                 bPid: widget.bPid,
//             //                                 listSeat: widget.listSeat,
//             //                                 tripId: widget.tripId,
//             //                                 tripIdees: widget.tripIdees,
//             //                               )),
//             //                     )
//             //                   : widget.noOfPerson == '4'
//             //                       ? await Navigator.push(
//             //                           context,
//             //                           MaterialPageRoute(
//             //                               builder: (context) =>
//             //                                   PssengerBookingDetailPage4(
//             //                                     bPid: widget.bPid,
//             //                                     listSeat: widget.listSeat,
//             //                                     tripId: widget.tripId,
//             //                                     tripIdees: widget.tripIdees,
//             //                                   )),
//             //                         )
//             //                       : widget.noOfPerson == '5'
//             //                           ? await Navigator.push(
//             //                               context,
//             //                               MaterialPageRoute(
//             //                                   builder: (context) =>
//             //                                       PssengerBookingDetailPage5(
//             //                                         bPid: widget.bPid,
//             //                                         listSeat: widget.listSeat,
//             //                                         tripId: widget.tripId,
//             //                                         tripIdees: widget.tripIdees,
//             //                                       )),
//             //                             )
//             //                           : widget.noOfPerson == '6'
//             //                               ? await Navigator.push(
//             //                                   context,
//             //                                   MaterialPageRoute(
//             //                                       builder: (context) =>
//             //                                           PssengerBookingDetailPage6(
//             //                                             bPid: widget.bPid,
//             //                                             listSeat:
//             //                                                 widget.listSeat,
//             //                                             tripId: widget.tripId,
//             //                                             tripIdees:
//             //                                                 widget.tripIdees,
//             //                                           )),
//             //                                 )
//             //                               : await Navigator.push(
//             //                                   context,
//             //                                   MaterialPageRoute(
//             //                                       builder: (context) =>
//             //                                           PssengerBookingDetailPage1(
//             //                                             passerngerCount: 1,
//             //                                             bPid: widget.bPid,
//             //                                             listSeat:
//             //                                                 widget.listSeat,
//             //                                             tripId: widget.tripId,
//             //                                             tripIdees:
//             //                                                 widget.tripIdees,
//             //                                           )),
//             //                                 );

//             //           setState(() {});
//             //         },
//             //         testBoard: state.dpBp.droppingPoints[i].locationName,
//             //         testLand: state.dpBp.droppingPoints[i].landmark,
//             //         testNumber: state.dpBp.droppingPoints[i].contactnumber,
//             //       );
//             //     });
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }

// class CardDropBoardNew extends StatelessWidget {
//   const CardDropBoardNew(
//       {Key? key,
//       required this.testBoard,
//       required this.testLand,
//       required this.testNumber,
//       required this.onTap})
//       : super(key: key);

//   final String testBoard, testLand, testNumber;
//   final onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Card(
//           child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 7, top: 7, bottom: 1),
//                 child: TextSize17Bold(
//                   test: testBoard,
//                 ),
//               ),
//             ],
//           ),
//           TextSize17(
//             test: 'Boarding : ${testBoard}',
//           ),
//           TextSize17(
//             test: 'Landmark : ${testLand}',
//           ),
//           TextSize17(
//             test: 'Phone : ${testNumber}',
//           ),

//           Padding(
//             padding: const EdgeInsets.only(top: 5, right: 9, left: 9),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,

//                 shadowColor: Colors.red,
//                 elevation: 3,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15.0)),
//                 minimumSize: Size(double.infinity, 40), //////// HERE
//               ),
//               onPressed: onTap,
//               child: Text(
//                 ' Select ',
//                 style: TextStyle(color: Colors.white, fontSize: 19),
//               ),
//             ),
//           )

//           // RowBetween(
//           //   testCol1: 'Name',
//           //   testCol2:
//           //       state.bpDpPoint.boardingTimes[i]!.bpName,
//           // ),
//         ],
//       )),
//     );
//   }
// }

// class CardDropBoard extends StatelessWidget {
//   const CardDropBoard(
//       {Key? key,
//       required this.bpTimeFinal,
//       required this.testBoard,
//       required this.testLand,
//       required this.testNumber,
//       required this.onTap})
//       : super(key: key);

//   final String bpTimeFinal, testBoard, testLand, testNumber;
//   final onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//         child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 7, top: 7, bottom: 1),
//               child: TextSize17Bold(
//                 test: bpTimeFinal,
//               ),
//             ),
//             TextButton(onPressed: onTap, child: Text('Select'))
//           ],
//         ),
//         TextSize17(
//           test: 'Boarding : ${testBoard}',
//         ),
//         TextSize17(
//           test: 'Landmark : ${testLand}',
//         ),
//         TextSize17(
//           test: 'Phone : ${testNumber}',
//         ),

//         // RowBetween(
//         //   testCol1: 'Name',
//         //   testCol2:
//         //       state.bpDpPoint.boardingTimes[i]!.bpName,
//         // ),
//       ],
//     ));
//   }
// }

// // class BoardingPointScrnn extends StatefulWidget {
// //   const BoardingPointScrnn({Key? key}) : super(key: key);

// //   @override
// //   State<BoardingPointScrnn> createState() => _BoardingPointScrnnState();
// // }

// // class _BoardingPointScrnnState extends State<BoardingPointScrnn> {
// //   @override
// //   Widget build(BuildContext context) {
// //     context.read<FirstBlocRedBus>().add(BpDpEvent());
// //     String bpTimeInitial, bpTimeDividedby60, bpSplitedValue, bpTimeFinal;
// //     List bPsplitedList, bpListFirst;
// //     return Scaffold(
// //       appBar: AppBar(
// //           title: Text19Black(
// //         test: 'Boarding point',
// //       )),
// //       body: BlocBuilder<FirstBlocRedBus, WalletBlocState>(
// //         builder: (context, state) {
// //           if (state is BpDpState) {
// //             return Center(
// //                 child: CircularProgressIndicator(
// //               color: Colors.black,
// //             ));
// //           }
// //           if (state is BpDpNetworkErrorState) {
// //             return Text(state.error);
// //           }
// //           if (state is GotDataBpDpState) {
// //             return ListView.builder(
// //                 itemCount: state.bpAndDpPoint.boardingTimes.length,
// //                 itemBuilder: (c, i) {
// //                   bpTimeInitial = state.bpAndDpPoint.boardingTimes[i]!.time;
// //                   bpTimeDividedby60 = '${int.parse(bpTimeInitial) / 60}';
// //                   bPsplitedList = bpTimeDividedby60.split('.').toList();
// //                   bpSplitedValue = bpTimeDividedby60[0];

// //                   bpListFirst = bpTimeDividedby60.split('.').toList();

// //                   bpTimeFinal =
// //                       "${int.parse(bpListFirst[0])} : ${int.parse(bpTimeInitial) % 60}";

// //                   return CardDropBoard(
// //                     onTap: () async {
// //                       globalPostRedBus = globalPostRedBus.copyWith(
// //                           boardingPointId:
// //                               state.bpAndDpPoint.boardingTimes[i]!.bpId);
// //                       await Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                             builder: (context) => DropingPointScrnn()),
// //                       );
// //                       setState(() {});
// //                     },
// //                     bpTimeFinal: bpTimeFinal,
// //                     testBoard: state.bpAndDpPoint.boardingTimes[i]!.bpName,
// //                     testLand: state.bpAndDpPoint.boardingTimes[i]!.landmark,
// //                     testNumber:
// //                         state.bpAndDpPoint.boardingTimes[i]!.contactNumber,
// //                   );
// //                 });
// //           }
// //           return Container();
// //         },
// //       ),
// //     );
// //   }
// // }

// // class DropingPointScrnn extends StatefulWidget {
// //   DropingPointScrnn({
// //     Key? key,
// //   }) : super(key: key);

// //   @override
// //   State<DropingPointScrnn> createState() => _DropingPointScrnn();
// // }

// // class _DropingPointScrnn extends State<DropingPointScrnn> {
// //   @override
// //   Widget build(BuildContext context) {
// //     context.read<FirstBlocRedBus>().add(BpDpEvent());
// //     String bpTimeInitial,
// //         bpTimeDividedby60,
// //         bpSplitedValue,
// //         bpTimeFinal,
// //         finalTimeis;
// //     List bPsplitedList, bpListFirst;

// //     String dpTimeInitial, dpTimeDividedby60, dpSplitedValue, dpTimeFinal;

// //     List dPsplitedList, dpListFirst;
// //     return Scaffold(
// //       appBar: AppBar(
// //           title: Text19Black(
// //         test: 'Droping point',
// //       )),
// //       body: BlocBuilder<FirstBlocRedBus, WalletBlocState>(
// //         builder: (context, state) {
// //           if (state is BpDpState) {
// //             return Center(
// //                 child: CircularProgressIndicator(
// //               color: Colors.black,
// //             ));
// //           }
// //           if (state is BpDpNetworkErrorState) {
// //             return Text(state.error);
// //           }
// //           if (state is GotDataBpDpState) {
// //             return ListView.builder(
// //                 itemCount: state.bpAndDpPoint.droppingTimes.length,
// //                 itemBuilder: (c, i) {
// //                   print('droping point isssssssssssssssssssssssssssssssssss');

// //                   dpTimeInitial = state.bpAndDpPoint.droppingTimes[i]!.time;
// //                   print(' start values${dpTimeInitial} ');

// //                   print(dpTimeInitial);

// //                   dpTimeDividedby60 = '${int.parse(dpTimeInitial) / 60}';
// //                   print('division by 60    ${dpTimeDividedby60}');
// //                   dPsplitedList = dpTimeDividedby60.split('.').toList();
// //                   print('splited value is${dPsplitedList}');
// //                   dpSplitedValue = dPsplitedList[0];
// //                   print('Splited val ${dpSplitedValue}');
// //                   print('Multiplied by is  ${int.parse(dpSplitedValue) * 60}');

// //                   print(
// //                       'divident ${int.parse(dpTimeInitial) - (int.parse(dpSplitedValue) * 60)}');
// //                   print(
// //                       ' 24hrsss ${int.parse(dpSplitedValue) > 24 ? int.parse(dpSplitedValue) - 24 : int.parse(dpSplitedValue)}');
// //                   print(
// //                       'final time isss ${int.parse(dpSplitedValue) > 24 ? int.parse(dpSplitedValue) - 24 : int.parse(dpSplitedValue)} : ${int.parse(dpTimeInitial) - (int.parse(dpSplitedValue) * 60)}');

// //                   //  int.parse(finalTimeis)  > 24 ?

// //                   dpListFirst = dpTimeDividedby60.split('.').toList();

// //                   dpTimeFinal =
// //                       "${int.parse(dpListFirst[0])} : ${int.parse(dpTimeInitial) % 60}";
// //                   print('Finalll${dpTimeFinal}');
// //                   return CardDropBoard(
// //                     onTap: () async {
// //                       globalPostRedBus = globalPostRedBus.copyWith(
// //                           dropingPointId:
// //                               state.bpAndDpPoint.droppingTimes[i]!.bpId);
// //                       // await Navigator.push(
// //                       //   context,
// //                       //   MaterialPageRoute(
// //                       //       builder: (context) => PersonalInfo(
// //                       //             tripIdeez: '',
// //                       //             bpId: '',
// //                       //             listNameSeat: [],
// //                       //             dpId:
// //                       //                 state.bpAndDpPoint.droppingTimes[i]!.bpId,
// //                       //           )),
// //                       // );
// //                       setState(() {});
// //                     },
// //                     bpTimeFinal:
// //                         'final time isss ${int.parse(dpSplitedValue) > 24 ? int.parse(dpSplitedValue) - 24 : int.parse(dpSplitedValue)} : ${int.parse(dpTimeInitial) - (int.parse(dpSplitedValue) * 60)}',
// //                     testBoard: state.bpAndDpPoint.droppingTimes[i]!.bpName,
// //                     testLand: state.bpAndDpPoint.droppingTimes[i]!.landmark,
// //                     testNumber:
// //                         state.bpAndDpPoint.droppingTimes[i]!.contactNumber,
// //                   );
// //                 });
// //           }
// //           return Container();
// //         },
// //       ),
// //     );
// //   }
// // }
