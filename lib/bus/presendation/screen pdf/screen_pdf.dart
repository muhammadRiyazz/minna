// import 'dart:developer';
// import 'dart:io';

// import 'package:minna/bus/presendation/screen%20view%20ticket/screen_view_ticket.dart';
// import 'package:minna/bus/domain/profile%20modal/profile_modal.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl/intl.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

// import 'package:permission_handler/permission_handler.dart';

// import '../../domain/Ticket details/ticket_details_1.dart';
// import '../../domain/Ticket details/ticket_details_more1.dart';
// import '../../infrastructure/fareCalculation/fare_calculation.dart';

// createPdfNew({
//   TicketinfoMore? ticketmoredata,
//   required ProfileModal profiledata,
// }) async {
//   final pdf = pw.Document();
//   final ByteData image = await rootBundle.load(
//     'asset/maaxusdigitalhublogo.png',
//   );
//   Uint8List imageData = (image).buffer.asUint8List();

//   pdf.addPage(
//     pw.Page(
//       pageFormat: PdfPageFormat.a4,
//       build: (pw.Context context) {
//         return pw.Padding(
//           padding: pw.EdgeInsets.all(0),
//           child: pw.Container(
//             decoration: pw.BoxDecoration(border: pw.Border.all()),
//             padding: pw.EdgeInsets.all(12),
//             child: pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Container(
//                   height: 80,
//                   color: PdfColors.grey100,
//                   child: pw.Row(
//                     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                     children: [
//                       pw.Padding(
//                         padding: pw.EdgeInsets.all(20),
//                         child: pw.Image(pw.MemoryImage(imageData)),
//                       ),
//                       pw.Padding(
//                         padding: const pw.EdgeInsets.all(4.0),
//                         child: pw.Container(
//                           // color: Colors.orange,
//                           width: 140,
//                           child: pw.Column(
//                             mainAxisAlignment: pw.MainAxisAlignment.end,
//                             crossAxisAlignment: pw.CrossAxisAlignment.start,
//                             children: [
//                               pw.Text(
//                                 profiledata.name,
//                                 style: pw.TextStyle(fontSize: 10),
//                               ),
//                               pw.Text(
//                                 profiledata.phone,
//                                 style: pw.TextStyle(fontSize: 8),
//                               ),
//                               pw.Text(
//                                 profiledata.email,
//                                 style: pw.TextStyle(fontSize: 8),
//                               ),
//                               pw.Text(
//                                 profiledata.address,
//                                 style: pw.TextStyle(fontSize: 7),
//                               ),
//                               pw.SizedBox(height: 5),
//                               pw.Text(
//                                 DateFormat(
//                                   'yyyy-MM-dd',
//                                 ).format(ticketmoredata!.dateOfIssue.toLocal()),
//                                 style: pw.TextStyle(fontSize: 10),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 pw.SizedBox(height: 10),
//                 pw.Container(
//                   padding: pw.EdgeInsets.all(10),
//                   // height: 250,
//                   decoration: pw.BoxDecoration(border: pw.Border.all()),
//                   child: pw.Column(
//                     children: [
//                       pw.Row(
//                         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                         children: [
//                           pw.Text(
//                             'Ticket No',
//                             style: const pw.TextStyle(fontSize: 17),
//                           ),
//                           pw.Text(
//                             ticketmoredata.pnr,
//                             style: const pw.TextStyle(
//                               fontSize: 19,
//                               color: PdfColors.red,
//                             ),
//                           ),
//                         ],
//                       ),
//                       pw.Row(
//                         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                         children: [
//                           pw.Text(
//                             'Date',
//                             style: const pw.TextStyle(fontSize: 17),
//                           ),
//                           pw.Text(
//                             DateFormat(
//                               'yyyy-MM-dd',
//                             ).format(ticketmoredata.doj.toLocal()),
//                             style: const pw.TextStyle(
//                               fontSize: 16,
//                               color: PdfColors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                       pw.Row(
//                         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                         children: [
//                           pw.Text(
//                             'Contact',
//                             style: const pw.TextStyle(fontSize: 17),
//                           ),
//                           pw.Text(
//                             ticketmoredata.pickUpContactNo,
//                             style: const pw.TextStyle(fontSize: 19),
//                           ),
//                         ],
//                       ),
//                       pw.Row(
//                         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                         children: [
//                           pw.Text(
//                             ticketmoredata.sourceCity,
//                             style: const pw.TextStyle(fontSize: 17),
//                           ),
//                           pw.Text(
//                             'to',
//                             style: const pw.TextStyle(
//                               fontSize: 15,
//                               color: PdfColors.grey500,
//                             ),
//                           ),
//                           //   pw.   Icon(Icons.arrow_right_alt_sharp as pw.IconData),
//                           pw.Text(
//                             ticketmoredata.destinationCity,
//                             style: const pw.TextStyle(fontSize: 17),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 pw.SizedBox(height: 10),
//                 pw.Container(
//                   width: double.infinity,
//                   padding: pw.EdgeInsets.all(5),
//                   decoration: pw.BoxDecoration(color: PdfColors.red200),
//                   child: pw.Text(
//                     'Passanger Details',
//                     style: pw.TextStyle(
//                       fontSize: 17,
//                       fontWeight: pw.FontWeight.bold,
//                       color: PdfColors.white,
//                     ),
//                   ),
//                 ),
//                 pw.SizedBox(height: 10),
//                 pw.Container(
//                   padding: pw.EdgeInsets.symmetric(horizontal: 10, vertical: 7),
//                   color: PdfColors.grey200,
//                   child: pw.Row(
//                     children: List.generate(3, (index) {
//                       return pw.Expanded(
//                         child: pw.SizedBox(
//                           child: index == 0
//                               ? pw.Text(
//                                   'Name',
//                                   style: const pw.TextStyle(fontSize: 16),
//                                 )
//                               : index == 1
//                               ? pw.Text(
//                                   'Seat No',
//                                   style: const pw.TextStyle(fontSize: 16),
//                                 )
//                               : pw.Text(
//                                   'Gender',
//                                   style: const pw.TextStyle(fontSize: 16),
//                                 ),
//                         ),
//                       );
//                     }),
//                   ),
//                 ),
//                 pw.Column(
//                   children: List.generate(
//                     ticketmoredata.inventoryItems.length,
//                     (index) {
//                       return pw.Padding(
//                         padding: pw.EdgeInsets.only(bottom: 8),
//                         child: pw.Container(
//                           padding: pw.EdgeInsets.symmetric(
//                             horizontal: 10,
//                             vertical: 5,
//                           ),
//                           color: PdfColors.grey50,
//                           child: pw.Row(
//                             children: [
//                               pw.Expanded(
//                                 child: pw.SizedBox(
//                                   child: pw.Text(
//                                     ticketmoredata
//                                         .inventoryItems[index]
//                                         .passenger
//                                         .name,
//                                   ),
//                                 ),
//                               ),
//                               pw.Expanded(
//                                 child: pw.SizedBox(
//                                   child: pw.Text(
//                                     ticketmoredata
//                                         .inventoryItems[index]
//                                         .seatName,
//                                   ),
//                                 ),
//                               ),
//                               pw.Expanded(
//                                 child: pw.SizedBox(
//                                   child: pw.Text(
//                                     ticketmoredata
//                                         .inventoryItems[index]
//                                         .passenger
//                                         .gender,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 pw.Container(
//                   padding: pw.EdgeInsets.all(5),
//                   width: double.infinity,
//                   decoration: pw.BoxDecoration(color: PdfColors.red200),
//                   child: pw.Text(
//                     'Travel Details',
//                     style: pw.TextStyle(
//                       fontSize: 17,
//                       fontWeight: pw.FontWeight.bold,
//                       color: PdfColors.white,
//                     ),
//                   ),
//                 ),
//                 pw.Container(
//                   padding: pw.EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 10,
//                   ),
//                   width: double.infinity,
//                   color: PdfColors.grey200,
//                   child: pw.Text(
//                     'Bus Operator',
//                     style: const pw.TextStyle(fontSize: 16),
//                   ),
//                 ),
//                 pw.Container(
//                   padding: pw.EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 10,
//                   ),
//                   width: double.infinity,
//                   color: PdfColors.grey100,
//                   child: pw.Text(ticketmoredata.travels),
//                 ),
//                 pw.SizedBox(height: 15),
//                 pw.Container(
//                   padding: pw.EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 10,
//                   ),
//                   width: double.infinity,
//                   color: PdfColors.grey200,
//                   child: pw.Text(
//                     'Bus Type',
//                     style: const pw.TextStyle(fontSize: 16),
//                   ),
//                 ),
//                 pw.Container(
//                   padding: pw.EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 10,
//                   ),
//                   width: double.infinity,
//                   color: PdfColors.grey50,
//                   child: pw.Text(ticketmoredata.busType),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     ),
//   );
//   pdf.addPage(
//     pw.Page(
//       pageFormat: PdfPageFormat.a4,
//       build: (pw.Context context) {
//         return pw.Padding(
//           padding: pw.EdgeInsets.all(0),
//           child: pw.Container(
//             decoration: pw.BoxDecoration(border: pw.Border.all()),
//             padding: pw.EdgeInsets.all(12),
//             child: pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Container(
//                   padding: pw.EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 10,
//                   ),
//                   //height: 30,
//                   width: double.infinity,
//                   color: PdfColors.grey200,
//                   child: pw.Text(
//                     'Dropding Point Address',
//                     style: const pw.TextStyle(fontSize: 16),
//                   ),
//                 ),
//                 pw.Container(
//                   padding: pw.EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 10,
//                   ),
//                   //height: 50,
//                   color: PdfColors.grey50,
//                   child: pw.Row(
//                     children: [
//                       pw.Text('Location      :  '),
//                       pw.Text(
//                         ticketmoredata!.dropLocation.replaceAll('–', '-'),
//                       ),
//                     ],
//                   ),
//                 ),
//                 pw.SizedBox(height: 10),
//                 pw.Container(
//                   padding: pw.EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 10,
//                   ),
//                   //height: 30,
//                   width: double.infinity,
//                   color: PdfColors.grey200,
//                   child: pw.Text(
//                     'Pickup Point Address',
//                     style: const pw.TextStyle(fontSize: 16),
//                   ),
//                 ),
//                 pw.Container(
//                   padding: pw.EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 10,
//                   ),
//                   //height: 50,
//                   color: PdfColors.grey50,
//                   child: pw.Row(
//                     children: [
//                       pw.Text('Location      :  '),
//                       pw.Text(
//                         ticketmoredata.pickupLocation.replaceAll('–', '-'),
//                       ),
//                     ],
//                   ),
//                 ),
//                 pw.Container(
//                   padding: pw.EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 10,
//                   ),
//                   //height: 50,
//                   color: PdfColors.grey50,
//                   child: pw.Row(
//                     children: [
//                       pw.Text('Landmark    :  '),
//                       pw.Text(ticketmoredata.pickupLocationLandmark.toString()),
//                     ],
//                   ),
//                 ),
//                 pw.SizedBox(height: 10),
//                 pw.Container(
//                   padding: pw.EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 10,
//                   ),
//                   color: PdfColors.grey200,
//                   child: pw.Row(
//                     children: [
//                       pw.Expanded(
//                         child: pw.SizedBox(
//                           child: pw.Text(
//                             'PickUp Time',
//                             style: const pw.TextStyle(fontSize: 16),
//                           ),
//                         ),
//                       ),
//                       pw.Expanded(
//                         child: pw.SizedBox(
//                           child: pw.Text(
//                             'Drop Time',
//                             style: const pw.TextStyle(fontSize: 16),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 pw.Container(
//                   padding: pw.EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 10,
//                   ),
//                   color: PdfColors.grey50,
//                   child: pw.Row(
//                     children: [
//                       pw.Expanded(
//                         child: pw.SizedBox(
//                           child: pw.Text(
//                             changetime(time: ticketmoredata.pickupTime),
//                           ),
//                         ),
//                       ),
//                       pw.Expanded(
//                         child: pw.SizedBox(
//                           child: pw.Text(
//                             changetime(time: ticketmoredata.dropTime),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 pw.Container(
//                   padding: pw.EdgeInsets.symmetric(
//                     vertical: 10,
//                     horizontal: 10,
//                   ),
//                   width: double.infinity,
//                   decoration: pw.BoxDecoration(color: PdfColors.red200),
//                   child: pw.Text(
//                     'Payment Details',
//                     style: pw.TextStyle(
//                       fontSize: 17,
//                       fontWeight: pw.FontWeight.bold,
//                       color: PdfColors.white,
//                     ),
//                   ),
//                 ),
//                 pw.Container(
//                   padding: pw.EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 10,
//                   ),
//                   //height: 30,
//                   width: double.infinity,
//                   color: PdfColors.grey50,
//                   child: pw.Row(
//                     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                     children: [
//                       pw.Text(
//                         'Total BaseFare',
//                         style: const pw.TextStyle(fontSize: 16),
//                       ),
//                       pw.Text(
//                         totalbasefare(
//                           seats: ticketmoredata.inventoryItems,
//                         ).toStringAsFixed(2),
//                         style: const pw.TextStyle(fontSize: 16),
//                       ),
//                     ],
//                   ),
//                 ),
//                 pw.Container(
//                   padding: pw.EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 10,
//                   ),
//                   //height: 30,
//                   width: double.infinity,
//                   color: PdfColors.grey50,
//                   child: pw.Row(
//                     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                     children: [
//                       pw.Text(
//                         'Other Tax and Fees',
//                         style: const pw.TextStyle(fontSize: 16),
//                       ),
//                       pw.Text(
//                         ' ${(totalfare(seats: ticketmoredata.inventoryItems) - totalbasefare(seats: ticketmoredata.inventoryItems)).toStringAsFixed(2)}',
//                         style: const pw.TextStyle(fontSize: 16),
//                       ),
//                     ],
//                   ),
//                 ),
//                 pw.SizedBox(height: 5),
//                 pw.Container(
//                   padding: pw.EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 10,
//                   ),
//                   //height: 30,
//                   width: double.infinity,
//                   color: PdfColors.grey200,
//                   child: pw.Row(
//                     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                     children: [
//                       pw.Text(
//                         'Gross Total',
//                         style: const pw.TextStyle(fontSize: 16),
//                       ),
//                       pw.Text(
//                         totalfare(
//                           seats: ticketmoredata.inventoryItems,
//                         ).toStringAsFixed(2),
//                         style: pw.TextStyle(
//                           fontSize: 17,
//                           fontWeight: pw.FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 pw.Divider(),

//                 ///
//                 // pw.Text('redBus',style: pw.TextStyle(color: PdfColors.red,fontSize: 17,fontWeight: pw.FontWeight.bold)),
//                 //                 pw.Text('Customer  No ',
//                 //     style: pw.TextStyle(
//                 //         color: PdfColors.red,
//                 //         fontSize: 17,
//                 //         fontWeight: pw.FontWeight.bold)),
//                 pw.UrlLink(
//                   child: pw.Text(
//                     'Terms and conditions',
//                     style: const pw.TextStyle(
//                       fontSize: 20,
//                       color: PdfColors.blue400,
//                     ),
//                   ),
//                   destination:
//                       'https://api.maaxusdigitalhub.com/bus/assets/terms.pdf',
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     ),
//   );
//   var fileName = 'Ticket booking pdf TIN- ${ticketmoredata!.tin}';
//   var byteList = await pdf.save();
//   var status = await Permission.storage.status;
//   await Permission.storage.request();
//   await Permission.manageExternalStorage.request();
//   if (!status.isGranted) {
//     await Permission.storage.request();
//   }
//   var directory = Directory('/storage/emulated/0/Download');
//   var filePath = "${directory.path}/$fileName.pdf";
//   log(filePath);
//   final file = File(filePath);

//   var finalfile = await file.writeAsBytes(byteList);
//   await Fluttertoast.showToast(msg: '  Saved $finalfile  ');

//   log(finalfile.toString());
// }
