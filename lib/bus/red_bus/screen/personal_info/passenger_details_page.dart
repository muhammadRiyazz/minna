// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// import 'package:maaxusminihub/screen/insurance/screen/pages/2whlr_quik2/new_widget.dart';
// import 'package:maaxusminihub/screen/red_bus/domain/data_post_redBus.dart';
// import 'package:maaxusminihub/screen/red_bus/screen/ride_choose/seat_layout.dart';

// import '../../infrastructure/block_ticket.dart';
// import '../../infrastructure/checkwalletbalance.dart';
// import '../ticket/save_file_mobile.dart';

// class PssengerBookingDetailPage1 extends StatefulWidget {
//   PssengerBookingDetailPage1({
//     Key? key,
//     required this.tripId,
//     required this.listSeat,
//     required this.bPid,
//     required this.tripIdees,
//     required this.passerngerCount,
//     required this.droppingPointIdee,
//   }) : super(key: key);

//   List<ListOfSeatClass> listSeat;
//   String tripId, bPid, tripIdees, droppingPointIdee;
//   int passerngerCount;

//   @override
//   State<PssengerBookingDetailPage1> createState() =>
//       _PssengerBookingDetailPage1State();
// }

// class _PssengerBookingDetailPage1State
//     extends State<PssengerBookingDetailPage1> {
//   bool _isSelected1 = true;

//   // bool _temp = _isSelected1;
//   bool _isSelected2 = false;
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _controllerName1 = TextEditingController();
//   TextEditingController _controllerAge1 = TextEditingController();
//   TextEditingController _controllerEmail = TextEditingController();
//   TextEditingController _controllerMobile = TextEditingController();
//   TextEditingController _controllerMaleFemale1 = TextEditingController();
//   TextEditingController _controllerFemale1 = TextEditingController();

//   bool isloading = false;
//   bool iserror = false;

//   @override
//   Widget build(BuildContext context) {
//     print('ladiees seat');
//     print(widget.listSeat[0].ladies);
//     print(widget.listSeat[0]);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Passenger'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: ListView(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.black,
//                     width: 1,
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.green.withOpacity(0.1),
//                       spreadRadius: 3,
//                       blurRadius: 7,
//                       offset: Offset(0, 3), // changes position of shadow
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 5),
//                       child: Text(
//                           'Passenger 1 | ${widget.listSeat[0].name} |  \u{20B9}${widget.listSeat[0].fareSeat}'),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextFormField(
//                         controller: _controllerName1,
//                         decoration:
//                             InputDecoration(labelText: 'Passenger name'),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter name';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 8),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               LabeledCheckRedBus(
//                                 onChanged: (bool newValue1) {
//                                   setState(() {
//                                     // globalPostModal = globalPostModal.copyWith(
//                                     //     partsDepreciationCover: newValue1);
//                                     _isSelected1 = newValue1;
//                                     _isSelected2 = !newValue1;
//                                     globalPostRedBus = globalPostRedBus
//                                         .copyWith(seatOne: "MALE");
//                                     // print('77777777777777777777777777');
//                                     // print(newValue1);
//                                     // print(_isSelected1);
//                                     // print(_isSelected2);
//                                     print(globalPostRedBus.seatOne);
//                                   });
//                                 },
//                                 value: _isSelected1,
//                               ),
//                               Text('Male'),
//                               LabeledCheckRedBus(
//                                 onChanged: (bool newValue2) {
//                                   setState(() {
//                                     _isSelected2 = newValue2;
//                                     _isSelected1 = !newValue2;

//                                     globalPostRedBus = globalPostRedBus
//                                         .copyWith(seatOne: "FEMALE");
//                                     print(globalPostRedBus.seatOne);
//                                   });
//                                 },
//                                 value: _isSelected2,
//                               ),
//                               Text('Female'),
//                             ],
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(right: 8),
//                             child: Row(
//                               children: [
//                                 Text('Age'),
//                                 Container(
//                                   height: 50,
//                                   width: 50,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: TextFormField(
//                                       controller: _controllerAge1,
//                                       keyboardType: TextInputType.number,
//                                       validator: (value) {
//                                         if (value == null || value.isEmpty) {
//                                           return 'Age required';
//                                         }
//                                         return null;
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.black,
//                     width: 1,
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.red.withOpacity(0.1),
//                       spreadRadius: 3,
//                       blurRadius: 7,
//                       offset: Offset(0, 3), // changes position of shadow
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 5),
//                       child: Column(
//                         children: [
//                           Text('Contact Details'),
//                           Text('Your ticket will be sent to this details'),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           TextFormField(
//                             controller: _controllerEmail,
//                             decoration:
//                                 InputDecoration(labelText: 'Email Address'),
//                             validator: (value) {
//                               if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value!)) {
//                                 return "Please enter a valid email address";
//                               }

//                               return null;
//                             },
//                           ),
//                           TextFormField(
//                             controller: _controllerMobile,
//                             keyboardType: TextInputType.number,
//                             maxLength: 10,
//                             decoration: InputDecoration(
//                               labelText: 'Phone Number',
//                               border: InputBorder.none,
//                             ),
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return "Please Enter a Phone Number";
//                               } else if (!RegExp(
//                                       r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
//                                   .hasMatch(value)) {
//                                 return "Please Enter a Valid Phone Number";
//                               }
//                               return null;
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             //      is   //
//             // isloading
//             //     ? Container(
//             //         height: 30,
//             //         child: Center(child: Text('is Loading..')),
//             //       )
//             //     : iserror
//             //         ? Container(child: Text('error'))
//             //         :
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ElevatedButton(
//                 onPressed: () async {
//                   print('onTap');
//                   //    String walletbalance = await checkwalletbalance();
//                   // final doubLeWalletBalance = double.parse(walletbalance);
//                   // print(doubLeWalletBalance);

//                   //       print(walletbalance);
//                   final fareSeat = double.parse(widget.listSeat[0].fareSeat);
//                   print(fareSeat);

//                   if (_formKey.currentState!.validate()) {
//                     print('object');
//                     // doubLeWalletBalance > fareSeat
//                     //     ? print('true')
//                     //     : print('false');
//                     if (100 < fareSeat) {
//                       final respBlockKey =
//                           await BlocTicketEvetApiClass().getDataBLocTicket1(
//                         destinationName: globalPostRedBus.toLocation,
//                         sourceName: globalPostRedBus.fromLocation,
//                         droppingPointId: widget.droppingPointIdee,
//                         tripId: widget.tripId,
//                         bPIdee: widget.bPid,
//                         destIdee: globalPostRedBus.idToLocation,
//                         source: globalPostRedBus.idFromLocation,
//                         mobPassenger: _controllerMobile.text,
//                         emailPassenger: _controllerEmail.text,
//                         seatName1: widget.listSeat[0].name,
//                         fare1: widget.listSeat[0].fareSeat,
//                         ladiesSeat1: widget.listSeat[0].ladies,
//                         age1: _controllerAge1.text,
//                         gender1: globalPostRedBus.seatOne,
//                         name1: _controllerName1.text,
//                       );
//                       print('********************');
//                       print(respBlockKey);
//                       respBlockKey.toString().characters.length.toInt() <= 12
//                           ? await Fluttertoast.showToast(msg: respBlockKey)
//                           : await Fluttertoast.showToast(msg: respBlockKey);

//                       respBlockKey.toString().characters.length.toInt() <= 12
//                           ? await Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => SuccusViewTicketScreen(
//                                         passengerCount: 1,
//                                         blockKey: '$respBlockKey',
//                                       )),
//                             )
//                           : await Fluttertoast.showToast(
//                               msg: 'Please try again! Do not press back button',
//                               gravity: ToastGravity.CENTER);

//                       if (respBlockKey.toString().characters.length.toInt() <=
//                           12) {
//                         await Fluttertoast.showToast(
//                             msg: 'Please wait, do not press backbutton');
//                       }
//                     }
//                   } else {
//                     log('message ccccccccc');
//                     await Fluttertoast.showToast(
//                         msg: 'Insufficient balance',
//                         gravity: ToastGravity.CENTER);
//                   }
//                 },
//                 child: TextSize17BoldWhite(
//                     test: '\u{20B9}${widget.listSeat[0].fareSeat} Pay now '),
//                 style: ButtonStyle(
//                     backgroundColor: MaterialStatePropertyAll(Colors.red)),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class LabeledCheckRedBus extends StatelessWidget {
//   LabeledCheckRedBus({
//     Key? key,

//     // required this.padding,
//     required this.value,
//     required this.onChanged,
//   }) : super(key: key);

//   // final EdgeInsets padding;
//   final bool value;
//   final ValueChanged<bool> onChanged;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         onChanged(!value);
//       },
//       child: Row(
//         children: <Widget>[
//           Checkbox(
//             value: value,
//             onChanged: (bool? newValue) {
//               onChanged(newValue!);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
