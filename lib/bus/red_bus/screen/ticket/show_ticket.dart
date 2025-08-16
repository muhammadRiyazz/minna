// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:maaxusminihub/screen/insurance/screen/pages/2whlr_quik2/new_widget.dart';

// import '../../application/first_bloc/bloc/bloc/wallet_bloc_bloc.dart';

// import 'dart:io';
// import 'dart:typed_data';

// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:permission_handler/permission_handler.dart';

// class TicketScrForOnePerson extends StatelessWidget {
//   TicketScrForOnePerson({
//     Key? key,
//     required this.tIn,
//   }) : super(key: key);
//   String tIn;
//   @override
//   Widget build(BuildContext context) {
//     print('ticker for one person');
//     print(tIn);
//     context
//         .read<FirstBlocRedBus>()
//         .add(PassengerDetailsOnlyOnePeronEvent(tIn: tIn));
//     return Scaffold(body: BlocBuilder<FirstBlocRedBus, WalletBlocState>(
//       builder: (context, state) {
//         if (state is PassengerDetailsOnlyOnePeronState) {
//           print('state');
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // CircularProgressIndicator(),
//                 // TextButton(
//                 //     onPressed: () {
//                 //       print('refresshhh');
//                 //       context
//                 //           .read<FirstBlocRedBus>()
//                 //           .add(PassengerDetailsOnlyOnePeronEvent(tIn: tIn));
//                 //     },
//                 //     child: Text('Refresh'))
//                 Text('Loading...'),
//                 Text('Please wait')
//               ],
//             ),
//           );
//         }
//         if (state is PassengerDetailsOnlyOneErrorState) {
//           return Center(
//               child: TextButton(
//             child: Text(state.error),
//             onPressed: () {
//               context
//                   .read<FirstBlocRedBus>()
//                   .add(PassengerDetailsOnlyOnePeronEvent(tIn: tIn));
//             },
//           ));
//         }
//         if (state is PassengerDetailsOnlyOneGotState)
//           return SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.black,
//                     width: 1,
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Text19Black(test: 'Name of passengers'),
//                     Container(
//                       // color: Colors.blue,
//                       width: double.infinity,

//                       child: Text19Black(
//                         test: state.ticketModel.inventoryItems.passenger.name,
//                       ),

//                       // child: ListView.builder(
//                       //     itemCount: state.ticketModel.inventoryItems.length,
//                       //     itemBuilder: (c, i) {
//                       //       return Text19Black(
//                       //         test: state
//                       //             .ticketModel.inventoryItems[i].passenger.name,
//                       //       );
//                       //     }),
//                     ),
//                     Divider(
//                       thickness: 1,
//                     ),
//                     // RowBetween(
//                     //   testCol1: 'Name ',
//                     //   testCol2: state.ticketModel.inventoryItems.passenger.name,
//                     // ),
//                     // RowBetween(
//                     //   testCol1: 'Mobile ',
//                     //   testCol2:
//                     //       state.ticketModel.inventoryItems.passenger.mobile,
//                     // ),
//                     // RowBetween(
//                     //   testCol1: 'Email ',
//                     //   testCol2:
//                     //       state.ticketModel.inventoryItems.passenger.email,
//                     // ),
//                     Divider(
//                       thickness: 1,
//                     ),
//                     Text19Black(test: 'Ticket Details'),
//                     Divider(
//                       thickness: 1,
//                     ),
//                     RowBetween(
//                         testCol1: 'Status', testCol2: state.ticketModel.status),
//                     RowBetween(
//                       testCol1: 'Ticket Number ',
//                       testCol2: state.ticketModel.tin,
//                     ),
//                     // RowBetween(
//                     //   testCol1: 'Fare ',
//                     //   testCol2: state.ticketModel.inventoryItems.fare,
//                     // ),
//                     // RowBetween(
//                     //   testCol1: 'Serviece charge ',
//                     //   testCol2: state
//                     //       .ticketModel.inventoryItems.operatorServiceCharge,
//                     // ),
//                     RowBetween(
//                       testCol1: 'Date of issue ',
//                       testCol2: state.ticketModel.dateOfIssue
//                           .toString()
//                           .characters
//                           .take(10)
//                           .string,
//                     ),
//                     Divider(
//                       thickness: 1,
//                     ),
//                     Text19Black(test: 'Travel Details'),
//                     Divider(
//                       thickness: 1,
//                     ),
//                     // RowBetween(
//                     //     testCol1: 'Seat name',
//                     //     testCol2: state.ticketModel.inventoryItems.seatName),
//                     // RowBetween(
//                     //     testCol1: 'Bus type',
//                     //     testCol2: state.ticketModel.busType),
//                     RowBetween(
//                       testCol1: 'Date of journey',
//                       testCol2: state.ticketModel.doj
//                           .toString()
//                           .characters
//                           .take(10)
//                           .string,
//                     ),
//                     // RowBetween(
//                     //     testCol1: 'Pick up time',
//                     //     testCol2: state.ticketModel.pickupTime),
//                     RowBetween(
//                         testCol1: 'Travels',
//                         testCol2: state.ticketModel.travels),
//                     RowBetween(
//                         testCol1: 'PNR', testCol2: state.ticketModel.pnr),
//                     RowBetween(
//                         testCol1: 'Pickup locattion',
//                         testCol2: state.ticketModel.pickupLocation),
//                     TextButton(
//                       child: Text('Download pdf'),
//                       onPressed: () async {
//                         await CreatePdfNew().createPdfNew(
//                           // name: state.ticketModel.inventoryItems.passenger.name,
//                           // phone:
//                           //     state.ticketModel.inventoryItems.passenger.mobile,
//                           busType: state.ticketModel.busType,
//                           dateIssue: state.ticketModel.dateOfIssue
//                               .toString()
//                               .characters
//                               .take(10)
//                               .string,
//                           dateJourny: state.ticketModel.doj
//                               .toString()
//                               .characters
//                               .take(10)
//                               .string,
//                           // email:
//                           //     state.ticketModel.inventoryItems.passenger.email,
//                           // fare: state.ticketModel.inventoryItems.fare,
//                           pickupTime: state.ticketModel.pickupTime,
//                           picupLocations: state.ticketModel.pickupLocation,
//                           pnr: state.ticketModel.pnr,
//                           // seatName: state.ticketModel.inventoryItems.seatName,
//                           // serviceCharge: state
//                           //     .ticketModel.inventoryItems.operatorServiceCharge,
//                           status: state.ticketModel.status,
//                           tin: state.ticketModel.tin,
//                           travels: state.ticketModel.travels,
//                         );
//                         await Fluttertoast.showToast(
//                             msg: 'Downloaded succusfully');
//                       },
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         return Container(
//           child: Center(
//             child: ElevatedButton(
//               child: Text(' Refresh '),
//               onPressed: () {
//                 context
//                     .read<FirstBlocRedBus>()
//                     .add(PassengerDetailsOnlyOnePeronEvent(tIn: tIn));
//               },
//             ),
//           ),
//         );
//       },
//     ));
//   }
// }

// class TicketScr extends StatelessWidget {
//   TicketScr({
//     Key? key,
//     required this.tIn,
//   }) : super(key: key);
//   String tIn;
//   @override
//   Widget build(BuildContext context) {
//     print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
//     print(tIn);
//     context.read<FirstBlocRedBus>().add(TicketDetailsEvent(tin: tIn));
//     return Scaffold(body: BlocBuilder<FirstBlocRedBus, WalletBlocState>(
//       builder: (context, state) {
//         if (state is TicketState) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // CircularProgressIndicator(),
//                 // TextButton(
//                 //     onPressed: () {
//                 //       context
//                 //           .read<FirstBlocRedBus>()
//                 //           .add(TicketDetailsEvent(tin: tIn));
//                 //     },
//                 //     child: Text('Refresh'))
//                 Text('Loading..'),
//                 Text('Please wait')
//               ],
//             ),
//           );
//         }
//         if (state is TicketErrorState) {
//           return Center(
//               child: TextButton(
//             child: Text(state.error),
//             onPressed: () {
//               context.read<FirstBlocRedBus>().add(TicketDetailsEvent(tin: tIn));
//             },
//           ));
//         }
//         if (state is TicketGotDataState)
//           return SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.black,
//                     width: 1,
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Text19Black(test: 'Name of passengers'),
//                     Divider(
//                       thickness: 1,
//                     ),
//                     Container(
//                       // color: Colors.blue,
//                       width: double.infinity,
//                       height: 200,

//                       child: ListView.builder(
//                           itemCount: state.ticketModel.inventoryItems.length,
//                           itemBuilder: (c, i) {
//                             return Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text19Black(
//                                 test: state.ticketModel.inventoryItems[i]
//                                     .passenger.name,
//                               ),
//                             );
//                           }),
//                     ),
//                     Divider(
//                       thickness: 1,
//                     ),
//                     // RowBetween(
//                     //   testCol1: 'Name ',
//                     //   testCol2: state.ticketModel.inventoryItems.passenger.name,
//                     // ),
//                     // RowBetween(
//                     //   testCol1: 'Mobile ',
//                     //   testCol2:
//                     //       state.ticketModel.inventoryItems.passenger.mobile,
//                     // ),
//                     // RowBetween(
//                     //   testCol1: 'Email ',
//                     //   testCol2:
//                     //       state.ticketModel.inventoryItems.passenger.email,
//                     // ),
//                     Divider(
//                       thickness: 1,
//                     ),
//                     Text19Black(test: 'Ticket Details'),
//                     Divider(
//                       thickness: 1,
//                     ),
//                     RowBetween(
//                         testCol1: 'Status', testCol2: state.ticketModel.status),
//                     RowBetween(
//                       testCol1: 'Ticket Number ',
//                       testCol2: state.ticketModel.tin,
//                     ),
//                     // RowBetween(
//                     //   testCol1: 'Fare ',
//                     //   testCol2: state.ticketModel.inventoryItems.fare,
//                     // ),
//                     // RowBetween(
//                     //   testCol1: 'Serviece charge ',
//                     //   testCol2: state
//                     //       .ticketModel.inventoryItems.operatorServiceCharge,
//                     // ),
//                     RowBetween(
//                       testCol1: 'Date of issue ',
//                       testCol2: state.ticketModel.dateOfIssue
//                           .toString()
//                           .characters
//                           .take(10)
//                           .string,
//                     ),
//                     Divider(
//                       thickness: 1,
//                     ),
//                     Text19Black(test: 'Travel Details'),
//                     Divider(
//                       thickness: 1,
//                     ),
//                     // RowBetween(
//                     //     testCol1: 'Seat name',
//                     //     testCol2: state.ticketModel.inventoryItems.seatName),
//                     // RowBetween(
//                     //     testCol1: 'Bus type',
//                     //     testCol2: state.ticketModel.busType),
//                     RowBetween(
//                         testCol1: 'Date of journey',
//                         testCol2: state.ticketModel.doj
//                             .toString()
//                             .characters
//                             .take(10)
//                             .string),
//                     RowBetween(
//                         testCol1: 'Pick up time',
//                         testCol2: state.ticketModel.pickupTime),
//                     RowBetween(
//                         testCol1: 'Travels',
//                         testCol2: state.ticketModel.travels),
//                     RowBetween(
//                         testCol1: 'PNR', testCol2: state.ticketModel.pnr),
//                     RowBetween(
//                         testCol1: 'Pickup locattion',
//                         testCol2: state.ticketModel.pickupLocation),
//                     TextButton(
//                       child: Text('Download pdf'),
//                       onPressed: () async {
//                         await CreatePdfNew().createPdfNew(
//                           // name: state.ticketModel.inventoryItems.passenger.name,
//                           // phone:
//                           //     state.ticketModel.inventoryItems.passenger.mobile,
//                           busType: state.ticketModel.busType,
//                           dateIssue: state.ticketModel.dateOfIssue
//                               .toString()
//                               .characters
//                               .take(10)
//                               .string,
//                           dateJourny: state.ticketModel.doj
//                               .toString()
//                               .characters
//                               .take(10)
//                               .string,
//                           // email:
//                           //     state.ticketModel.inventoryItems.passenger.email,
//                           // fare: state.ticketModel.inventoryItems.fare,
//                           pickupTime: state.ticketModel.pickupTime,
//                           picupLocations: state.ticketModel.pickupLocation,
//                           pnr: state.ticketModel.pnr,
//                           // seatName: state.ticketModel.inventoryItems.seatName,
//                           // serviceCharge: state
//                           //     .ticketModel.inventoryItems.operatorServiceCharge,
//                           status: state.ticketModel.status,
//                           tin: state.ticketModel.tin,
//                           travels: state.ticketModel.travels,
//                         );
//                         await Fluttertoast.showToast(
//                             msg: 'Downloaded succusfully');
//                       },
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         return Container(
//             child: Center(
//                 child: TextButton(
//           child: Text('Refresh'),
//           onPressed: () {
//             context.read<FirstBlocRedBus>().add(TicketDetailsEvent(tin: tIn));
//           },
//         )));
//       },
//     ));
//   }
// }

// class CreatePdfNew {
//   createPdfNew({
//     // required name,
//     // required phone,
//     // required email,
//     required status,
//     required tin,
//     // required fare,
//     // required serviceCharge,
//     required dateIssue,
//     // required seatName,
//     required busType,
//     required dateJourny,
//     required pickupTime,
//     required travels,
//     required pnr,
//     required picupLocations,
//   }) async {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         build: (pw.Context context) {
//           //pdf formating
//           return pw.Column(
//             children: [
//               pw.Row(
//                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                 children: [
//                   pw.Text('mBus',
//                       style: pw.TextStyle(
//                           fontWeight: pw.FontWeight.bold, fontSize: 30)),
//                   pw.Text(
//                     '${dateIssue}',
//                     style: const pw.TextStyle(fontSize: 20),
//                   )
//                 ],
//               ),
//               pw.SizedBox(height: 25),
//               pw.Row(
//                 mainAxisAlignment: pw.MainAxisAlignment.start,
//                 children: [
//                   pw.Column(
//                     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                     children: [
//                       // pw.Text("Name", style: const pw.TextStyle(fontSize: 21)),
//                       // pw.Text("Mobile",
//                       //     style: const pw.TextStyle(fontSize: 21)),
//                       // pw.Text("Email", style: const pw.TextStyle(fontSize: 21)),
//                       pw.Text("Ticket number",
//                           style: const pw.TextStyle(fontSize: 21)),
//                       // pw.Text("Fare(Rs)",
//                       //     style: const pw.TextStyle(fontSize: 21)),
//                       // pw.Text("Service charge(Rs)",
//                       //     style: const pw.TextStyle(fontSize: 21)),
//                       pw.Text("Date of issue",
//                           style: const pw.TextStyle(fontSize: 21)),
//                       // pw.Text("Booked seats",
//                       //     style: const pw.TextStyle(fontSize: 21)),
//                     ],
//                   ),
//                   pw.Column(
//                     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                     children: [
//                       // pw.Text(' : ${name}',
//                       //     style: const pw.TextStyle(fontSize: 21)),
//                       // pw.Text(' : ${phone}',
//                       //     style: const pw.TextStyle(fontSize: 21)),
//                       // pw.Text(' : ${email}',
//                       //     style: const pw.TextStyle(fontSize: 21)),
//                       pw.Text(' : ${tin}',
//                           style: const pw.TextStyle(fontSize: 21)),
//                       // pw.Text(' : ${fare}',
//                       //     style: const pw.TextStyle(fontSize: 21)),
//                       // pw.Text(' : ${serviceCharge}',
//                       //     style: const pw.TextStyle(fontSize: 21)),
//                       pw.Text(' : ${dateIssue}',
//                           style: const pw.TextStyle(fontSize: 21)),
//                       // pw.Text(' : ${seatName}',
//                       //     style: const pw.TextStyle(fontSize: 21)),
//                     ],
//                   )
//                 ],
//               ),
//             ],
//           );
//         },
//       ),
//     );
//     var fileName = '${tin}';
//     var byteList = await pdf.save();
//     var status = await Permission.storage.status;
//     await Permission.storage.request();
//     await Permission.manageExternalStorage.request();
//     if (!status.isGranted) {
//       await Permission.storage.request();
//     }
//     // final directory = await getTemporaryDirectory();
//     var directory = Directory('/storage/emulated/0/Download');
//     var filePath = "${directory.path}/$fileName.pdf";
//     print(filePath);
//     final file = File(filePath);

//     var finalfile = await file.writeAsBytes(byteList);
//     print(finalfile);
//   }
// }

// // Future<void> savePdfFile(String fileName, Uint8List byteList) async {
// //   var status = await Permission.storage.status;
// //   if (!status.isGranted) {
// //     await Permission.storage.request();
// //   }
// //   // final directory = await getTemporaryDirectory();
// //   var directory = Directory('/storage/emulated/0/Download');
// //   var filePath = "${directory.path}/$fileName.pdf";
// //   print(filePath);
// //   final file = File(filePath);
// //   await file.writeAsBytes(byteList);
// // }
