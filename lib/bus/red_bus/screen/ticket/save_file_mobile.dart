// import 'package:flutter/material.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// import 'package:maaxusminihub/screen/red_bus/screen/ticket/show_ticket.dart';

// import '../../application/first_bloc/bloc/bloc/wallet_bloc_bloc.dart';

// class SuccusViewTicketScreen extends StatelessWidget {
//   SuccusViewTicketScreen(
//       {Key? key, required this.blockKey, required this.passengerCount})
//       : super(key: key);
//   String blockKey;
//   int passengerCount;
//   @override
//   Widget build(BuildContext context) {
//     // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//     context
//         .read<FirstBlocRedBus>()
//         .add(TinEventsssssssssss(blockKey: blockKey));
//     // });

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Details'),
//       ),
//       body: Center(
//         child: BlocBuilder<FirstBlocRedBus, WalletBlocState>(
//           builder: (context, state) {
//             if (state is TinEventsssssssssss) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CircularProgressIndicator(),
//                     TextButton(
//                       child: Text('Refresh'),
//                       onPressed: () {
//                         context
//                             .read<FirstBlocRedBus>()
//                             .add(TinEventsssssssssss(blockKey: blockKey));
//                       },
//                     )
//                   ],
//                 ),
//               );
//             }
//             if (state is TinStateeeeeeeeeeeeeeeeeeeeee) {
//               context
//                   .read<FirstBlocRedBus>()
//                   .add(TinEventsssssssssss(blockKey: blockKey));
//               return Text('Please wait ...');
//             }
//             if (state is TinGotDataStateeeeeeeeeee) {
//               //////////////
//               print('one person mathrammmm');
//               print(state.tin); //48XHSKVP
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.check_box,
//                     size: 75,
//                     color: Colors.green,
//                   ),
//                   Column(
//                     children: [
//                       Text('Succus'),
//                       Text('Please check email'),
//                     ],
//                   ),
//                   ElevatedButton(
//                     onPressed: state.tin.toString().characters.length.toInt() <=
//                             12
//                         ? () async {
//                             print('Less thab 12 ');
//                             // await Navigator.push(
//                             //   context,
//                             //   MaterialPageRoute(
//                             //       builder: (context) => TicketScrForOnePerson(
//                             //             tIn: state.tin,
//                             //           )),
//                             // );
//                             /////////////
//                             passengerCount == 1
//                                 ? await Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             TicketScrForOnePerson(
//                                               tIn: state.tin,
//                                             )),
//                                   )
//                                 : await Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => TicketScr(
//                                               tIn: state.tin,
//                                             )));
//                           }
//                         : () {
//                             context
//                                 .read<FirstBlocRedBus>()
//                                 .add(TinEventsssssssssss(blockKey: blockKey));
//                           },
//                     child: Text('View ticket'),
//                   ),
//                 ],
//               );
//             }
//             return Container(
//                 child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(),
//                   TextButton(
//                     child: Text('Refresh'),
//                     onPressed: () {
//                       context
//                           .read<FirstBlocRedBus>()
//                           .add(TinEventsssssssssss(blockKey: blockKey));
//                     },
//                   )
//                 ],
//               ),
//             ));
//           },
//         ),
//       ),
//     );
//   }
// }

// // class SuccusPageRedBus extends StatelessWidget {
// //   SuccusPageRedBus({Key? key, required this.tIns}) : super(key: key);
// //   String tIns;
// //   // var tinFromBlockkey =    await TinClass()
// //   //                     .getDataTin(blockKey: tIns);

// //   @override
// //   Widget build(BuildContext context) {
// //     context.read<FirstBlocRedBus>().add(TinEvent(blockKey: tIns));

// //     return Scaffold(body: BlocBuilder<FirstBlocRedBus, WalletBlocState>(
// //       builder: (context, state) {
// //         if (state is TinState) {
// //           return Center(
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 CircularProgressIndicator(),
// //                 TextButton(
// //                     onPressed: () {
// //                       context
// //                           .read<FirstBlocRedBus>()
// //                           .add(TinEvent(blockKey: tIns));
// //                     },
// //                     child: Text('Refresh'))
// //               ],
// //             ),
// //           );
// //         }
// //         if (state is TinErrorState) {
// //           return Text(state.error);
// //         }
// //         if (state is TinGotDataState) {
// //           print('66666666666666666666666666666666666666666666666666');
// //           print(state.tin);
// //           return SafeArea(
// //             child: Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: Container(
// //                 decoration: BoxDecoration(
// //                   border: Border.all(
// //                     color: Colors.black,
// //                     width: 1,
// //                   ),
// //                   borderRadius: BorderRadius.circular(5),
// //                 ),
// //                 child: Center(
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       Icon(
// //                         Icons.check_box,
// //                         size: 75,
// //                         color: Colors.green,
// //                       ),
// //                       Text('Succus'),
// //                       ElevatedButton(
// //                           onPressed: () async {
// //                             await Navigator.push(
// //                               context,
// //                               MaterialPageRoute(
// //                                   builder: (context) => TicketScr(
// //                                         tIn: tIns,
// //                                       )),
// //                             );
// //                           },
// //                           child: Text('View ticket')),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           );
// //         }
// //         print('tiennnnnnstate');

// //         return Container();
// //       },
// //     ));
//     // return Scaffold(
//     //   appBar: AppBar(
//     //     title: Text('Success'),
//     //   ),
//     //   body: Center(
//     //     child: Column(
//     //       // crossAxisAlignment: CrossAxisAlignment.center,
//     //       mainAxisAlignment: MainAxisAlignment.center,
//     //       children: [
//     //         Icon(
//     //           Icons.check_box,
//     //           size: 75,
//     //           color: Colors.green,
//     //         ),
//     //         Text('Succus'),
//     //         ElevatedButton(
//     //             onPressed: () async {
//     //               // await TinClassBookTicket()
//     //               //     .getDataBLocTicket(blockKey: globalPostRedBus.blockKey);
//     //               await Navigator.push(
//     //                 context,
//     //                 MaterialPageRoute(
//     //                     builder: (context) => TicketScr(
//     //                           tIn: tIns,
//     //                         )),
//     //               );
//     //             },
//     //             child: Text('View ticket')),
//     //         // ElevatedButton(
//     //         //     onPressed: () async {
//     //         //       await Navigator.push(
//     //         //         context,
//     //         //         MaterialPageRoute(builder: (context) => TicketScr()),
//     //         //       );
//     //         //     },
//     //         //     child: Text('Cancel ticket'))
//     //       ],
//     //     ),
//     //   ),
//     // );
// //   }
// // }
