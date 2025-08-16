// import 'dart:developer';

// import 'package:minna/bus/presendation/widgets/error_widget.dart';
// import 'package:minna/bus/presendation/widgets/loading_widget.dart';
// import 'package:minna/bus/domain/profile%20modal/profile_modal.dart';
// import 'package:minna/bus/infrastructure/fetch%20ticket%20details/fetch_ticket_details.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:minna/comman/pages/main%20home/home.dart';

// import '../../domain/Ticket details/ticket_details_1.dart';
// import '../../domain/Ticket details/ticket_details_more1.dart';
// import '../../infrastructure/fareCalculation/fare_calculation.dart';
// import '../../infrastructure/fetch profile/fetch_profile.dart';
// import '../screen pdf/screen_pdf.dart';

// class ScreenViewTicket extends StatefulWidget {
//   const ScreenViewTicket({
//     Key? key,
//     required this.tinid,
//     required this.passengercount,
//   }) : super(key: key);
//   final String tinid;
//   final int passengercount;

//   @override
//   State<ScreenViewTicket> createState() => _ScreenViewTicketState();
// }

// class _ScreenViewTicketState extends State<ScreenViewTicket> {
//   void initState() {
//     super.initState();

//     fetchTicketData(tinid: widget.tinid);
//   }


//   //Ticketinfo? ticketdata;
//   TicketinfoMore? ticketmoredata;
//   // bool? countvalue;
//   bool iserror = true;
//   bool isloading = false;
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
//           builder: (context) {
//             return HomePage();
//           },
//         ), (route) => false);
//         return false;
//       },
//       child: Scaffold(
//         body: isloading
//             ? LoadingIcon()
//             : iserror
//             ? Erroricon(
//                 ontap: () {
//                   fetchTicketData(tinid: widget.tinid);
//                 },
//               )
//             : SafeArea(
//                 child: Center(
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10),
//                           child: ListView(
//                             children: [
                            
//                               SizedBox(height: 10),
//                               Container(
//                                 padding: EdgeInsets.all(10),
//                                 // height: 250,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                     color: Color.fromARGB(255, 192, 178, 178),
//                                   ),
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           'Ticket No   :',
//                                           style: const TextStyle(fontSize: 17),
//                                         ),
//                                         Text(
//                                           ticketmoredata!.pnr,
//                                           style: const TextStyle(
//                                             fontSize: 19,
//                                             color: Colors.red,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           'Date            :',
//                                           style: const TextStyle(fontSize: 17),
//                                         ),
//                                         Text(
//                                           DateFormat('yyyy-MM-dd').format(
//                                             ticketmoredata!.doj.toLocal(),
//                                           ),
//                                           style: const TextStyle(
//                                             fontSize: 16,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           ticketmoredata!.sourceCity,
//                                           style: const TextStyle(fontSize: 17),
//                                         ),
//                                         Icon(Icons.arrow_right_alt_sharp),
//                                         Text(
//                                           ticketmoredata!.destinationCity,
//                                           style: const TextStyle(fontSize: 17),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(height: 10),
//                               Container(
//                                 width: double.infinity,
//                                 padding: EdgeInsets.all(5),
//                                 decoration: BoxDecoration(
//                                   color: Color.fromARGB(255, 239, 103, 93),
//                                 ),
//                                 child: Text(
//                                   'Passanger Details',
//                                   style: TextStyle(
//                                     fontSize: 17,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: 10),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                   vertical: 7,
//                                 ),
//                                 color: Color.fromARGB(255, 229, 222, 222),
//                                 child: Row(
//                                   children: List.generate(3, (index) {
//                                     return Expanded(
//                                       child: SizedBox(
//                                         child: index == 0
//                                             ? Text(
//                                                 'Name',
//                                                 style: const TextStyle(
//                                                   fontSize: 16,
//                                                 ),
//                                               )
//                                             : index == 1
//                                             ? Text(
//                                                 'Seat No',
//                                                 style: const TextStyle(
//                                                   fontSize: 16,
//                                                 ),
//                                               )
//                                             : Text(
//                                                 'Gender',
//                                                 style: const TextStyle(
//                                                   fontSize: 16,
//                                                 ),
//                                               ),
//                                       ),
//                                     );
//                                   }),
//                                 ),
//                               ),
//                               Column(
//                                 children: List.generate(
//                                   ticketmoredata!.inventoryItems.length,
//                                   (index) {
//                                     return Padding(
//                                       padding: EdgeInsets.only(bottom: 8),
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                           horizontal: 10,
//                                           vertical: 5,
//                                         ),
//                                         color: Color.fromARGB(
//                                           255,
//                                           246,
//                                           246,
//                                           246,
//                                         ),
//                                         child: Row(
//                                           children: [
//                                             Expanded(
//                                               child: SizedBox(
//                                                 child: Text(
//                                                   ticketmoredata!
//                                                       .inventoryItems[index]
//                                                       .passenger
//                                                       .name,
//                                                 ),
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: SizedBox(
//                                                 child: Text(
//                                                   ticketmoredata!
//                                                       .inventoryItems[index]
//                                                       .seatName,
//                                                 ),
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: SizedBox(
//                                                 child: Text(
//                                                   ticketmoredata!
//                                                       .inventoryItems[index]
//                                                       .passenger
//                                                       .gender,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.all(5),
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                   color: Color.fromARGB(255, 239, 103, 93),
//                                 ),
//                                 child: Text(
//                                   'Travel Details',
//                                   style: TextStyle(
//                                     fontSize: 17,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                   vertical: 10,
//                                 ),
//                                 width: double.infinity,
//                                 color: Color.fromARGB(255, 237, 231, 231),
//                                 child: Text(
//                                   'Bus Operator',
//                                   style: const TextStyle(fontSize: 16),
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                   vertical: 10,
//                                 ),
//                                 width: double.infinity,
//                                 color: Color.fromARGB(255, 246, 246, 246),
//                                 child: Text(ticketmoredata!.travels),
//                               ),
//                               SizedBox(height: 15),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                   vertical: 10,
//                                 ),
//                                 width: double.infinity,
//                                 color: Color.fromARGB(255, 237, 231, 231),
//                                 child: Text(
//                                   'Bus Type',
//                                   style: const TextStyle(fontSize: 16),
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                   vertical: 10,
//                                 ),
//                                 width: double.infinity,
//                                 color: Color.fromARGB(255, 246, 246, 246),
//                                 child: Text(ticketmoredata!.busType),
//                               ),
//                               SizedBox(height: 15),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                   vertical: 10,
//                                 ),
//                                 //height: 30,
//                                 width: double.infinity,
//                                 color: Color.fromARGB(255, 237, 231, 231),
//                                 child: Text(
//                                   'Dropding Point Address',
//                                   style: const TextStyle(fontSize: 16),
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                   vertical: 10,
//                                 ),
//                                 //height: 50,
//                                 color: Color.fromARGB(255, 246, 246, 246),
//                                 child: Row(
//                                   children: [
//                                     Text('Location      :  '),
//                                     Text(ticketmoredata!.dropLocation),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(height: 10),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                   vertical: 10,
//                                 ),
//                                 //height: 30,
//                                 width: double.infinity,
//                                 color: Color.fromARGB(255, 237, 231, 231),
//                                 child: Text(
//                                   'Pickup Point Address',
//                                   style: const TextStyle(fontSize: 16),
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                   vertical: 10,
//                                 ),
//                                 //height: 50,
//                                 color: Color.fromARGB(255, 246, 246, 246),
//                                 child: Row(
//                                   children: [
//                                     Text('Location      :  '),
//                                     Text(ticketmoredata!.pickupLocation),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                   vertical: 10,
//                                 ),
//                                 //height: 50,
//                                 color: Color.fromARGB(255, 246, 246, 246),
//                                 child: Row(
//                                   children: [
//                                     Text('Landmark    :  '),
//                                     Text(
//                                       ticketmoredata!.pickupLocationLandmark,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(height: 10),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                   vertical: 10,
//                                 ),
//                                 color: Color.fromARGB(255, 237, 231, 231),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: SizedBox(
//                                         child: Text(
//                                           'PickUp Time',
//                                           style: const TextStyle(fontSize: 16),
//                                         ),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: SizedBox(
//                                         child: Text(
//                                           'Drop Time',
//                                           style: const TextStyle(fontSize: 16),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                   vertical: 10,
//                                 ),
//                                 color: Color.fromARGB(255, 246, 246, 246),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: SizedBox(
//                                         child: Text(
//                                           changetime(
//                                             time: ticketmoredata!.pickupTime,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: SizedBox(
//                                         child: Text(
//                                           changetime(
//                                             time: ticketmoredata!.dropTime,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   vertical: 10,
//                                   horizontal: 10,
//                                 ),
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                   color: Color.fromARGB(255, 239, 103, 93),
//                                 ),
//                                 child: Text(
//                                   'Payment Details',
//                                   style: TextStyle(
//                                     fontSize: 17,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                   vertical: 10,
//                                 ),
//                                 //height: 30,
//                                 width: double.infinity,
//                                 color: Color.fromARGB(255, 246, 246, 246),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       'Total BaseFare',
//                                       style: const TextStyle(fontSize: 16),
//                                     ),
//                                     Text(
//                                       totalbasefare(
//                                         seats: ticketmoredata!.inventoryItems,
//                                       ).toStringAsFixed(2),
//                                       style: const TextStyle(fontSize: 16),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                   vertical: 10,
//                                 ),
//                                 //height: 30,
//                                 width: double.infinity,
//                                 color: Color.fromARGB(255, 246, 246, 246),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       'Other Tax and Fees',
//                                       style: const TextStyle(fontSize: 16),
//                                     ),
//                                     Text(
//                                       ' ${(totalfare(seats: ticketmoredata!.inventoryItems) - totalbasefare(seats: ticketmoredata!.inventoryItems)).toStringAsFixed(2)}',
//                                       style: const TextStyle(fontSize: 16),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(height: 5),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                   vertical: 10,
//                                 ),
//                                 //height: 30,
//                                 width: double.infinity,
//                                 color: Color.fromARGB(255, 237, 231, 231),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       'Gross Total',
//                                       style: const TextStyle(fontSize: 16),
//                                     ),
//                                     Text(
//                                       totalfare(
//                                         seats: ticketmoredata!.inventoryItems,
//                                       ).toStringAsFixed(2),
//                                       style: TextStyle(
//                                         fontSize: 17,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () async {
                         

//                           // Navigator.pushAndRemoveUntil(context,
//                           //     MaterialPageRoute(
//                           //   builder: (context) {
//                           //     return HomePage();
//                           //   },
//                           // ), (route) => false);
//                         },
//                         child: Container(
//                           height: 55,
//                           width: double.infinity,
//                           decoration: BoxDecoration(color: Colors.red),
//                           child: Center(
//                             child: Text(
//                               'SAVE PDF AND GO HOME',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }

//   fetchTicketData({required String tinid}) async {
//     setState(() {
//       isloading = true;
//       iserror = false;
//     });
//     profildata = await fetchProfileData();

//     try {
//       log('widget.passengercount.toString()');

//       log(widget.passengercount.toString());

//       final data = await getTicketData(tIn: tinid);

//       if (data.statusCode == 200 &&
//           data.body !=
//               'Error: Authorization failed please send valid consumer key and secret in the api request.') {
//         ticketmoredata = ticketinfoMoreFromJson(data.body);

//         // if (widget.passengercount == 1) {
//         //   log('message');
//         //   log(widget.passengercount.toString());
//         //   ticketdata = ticketinfoFromJson(data.body);
//         //   countvalue = false;
//         // } else {
//         //   ticketmoredata = ticketinfoMoreFromJson(data.body);
//         //   countvalue = true;
//         // }

//         log(data.body);
//         setState(() {
//           isloading = false;
//           iserror = false;
//         });
//       } else if (data.body ==
//           'Error: Authorization failed please send valid consumer key and secret in the api request.') {
//         fetchTicketData(tinid: tinid);

//         // setState(() {
//         //   isloading = false;
//         //   iserror = true;
//         // });
//       }
//     } catch (e) {
//       log(e.toString());
//       log('catch');
//       setState(() {
//         iserror = true;
//         isloading = false;
//       });
//     }
//   }
// }

// String changetime({required String time}) {
//   final double count = int.parse(time) / 60;
//   int decimalPart = ((count - count.floor()) * 100).toInt();

//   final hour = count.toInt() % 24;

//   String time24 = '$hour:$decimalPart';

//   DateFormat format24 = DateFormat('HH:mm');
//   DateFormat format12 = DateFormat('h:mm a');

//   DateTime dateTime = format24.parse(time24);
//   String time12 = format12.format(dateTime);
//   return time12;
// }
