// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:maaxusminihub/screen/insurance/domain/2whlr_Q_requestModel/instance_of_post.dart';
// import 'package:maaxusminihub/screen/red_bus/screen/personal_info/passenger_details_page.dart';
// import 'package:maaxusminihub/screen/red_bus/screen/ticket/save_file_mobile.dart';

// import '../../../insurance/screen/pages/2whlr_quik2/new_widget.dart';
// import '../../domain/data_post_redBus.dart';
// import '../../infrastructure/block_ticket.dart';
// import '../../infrastructure/checkwalletbalance.dart';
// import '../ride_choose/seat_layout.dart';

// class PssengerBookingDetailPage2 extends StatefulWidget {
//   PssengerBookingDetailPage2(
//       {Key? key,
//       required this.tripId,
//       required this.listSeat,
//       required this.bPid,
//       required this.tripIdees,
//       required this.bpName,
//       required this.dpName})
//       : super(key: key);
//   String tripId, bpName, dpName;
//   List<ListOfSeatClass> listSeat;
//   String bPid;
//   String tripIdees;

//   // var totalPrice;

//   @override
//   State<PssengerBookingDetailPage2> createState() =>
//       _PssengerBookingDetailPage2State();
// }

// class _PssengerBookingDetailPage2State
//     extends State<PssengerBookingDetailPage2> {
//   String _temMaleOrFema1 = 'MALE';
//   bool _isSelected11 = true;
//   bool _isSelected12 = false;
//   String _temMaleOrFema2 = 'MALE';
//   bool _isSelected21 = true;
//   bool _isSelected22 = false;

//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _controllerName11 = TextEditingController();
//   TextEditingController _controllerAge11 = TextEditingController();
//   TextEditingController _controllerName2 = TextEditingController();
//   TextEditingController _controllerAge2 = TextEditingController();
//   TextEditingController _controllerEmail = TextEditingController();
//   TextEditingController _controllerMobile = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     double price1 = double.parse(widget.listSeat[0].fareSeat);
//     double price2 = double.parse(widget.listSeat[1].fareSeat);

//     var finalPrice = price1 + price2;
//     print('******************************************');
//     print(finalPrice);
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
//               child: Column(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.black,
//                         width: 1,
//                       ),
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.green.withOpacity(0.1),
//                           spreadRadius: 3,
//                           blurRadius: 7,
//                           offset: Offset(0, 3), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(top: 5),
//                           child: Text(
//                               'Passenger 1 | ${widget.listSeat[0].name} |  \u{20B9}${widget.listSeat[0].fareSeat}'),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: TextFormField(
//                             controller: _controllerName11,
//                             decoration:
//                                 InputDecoration(labelText: 'Passenger name'),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter name';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 8),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   LabeledCheckRedBus(
//                                     onChanged: (bool newValue1) {
//                                       setState(() {
//                                         // globalPostModal = globalPostModal.copyWith(
//                                         //     partsDepreciationCover: newValue1);
//                                         _isSelected11 = newValue1;
//                                         _isSelected12 = !newValue1;
//                                         _isSelected12 == true
//                                             ? _temMaleOrFema1 = 'FEMALE'
//                                             : _temMaleOrFema1 = 'MALE';
//                                         print(_temMaleOrFema1);
//                                       });
//                                     },
//                                     value: _isSelected11,
//                                   ),
//                                   Text('Male'),
//                                   LabeledCheckRedBus(
//                                     onChanged: (bool newValue2) {
//                                       setState(() {
//                                         // globalPostModal = globalPostModal.copyWith(
//                                         //     partsDepreciationCover: newValue1);
//                                         _isSelected12 = newValue2;
//                                         _isSelected11 = !newValue2;

//                                         _isSelected11 == true
//                                             ? _temMaleOrFema1 = 'MALE'
//                                             : _temMaleOrFema1 = 'FEMALE';
//                                         print(_temMaleOrFema1);

//                                         // print(newValue2);
//                                       });
//                                     },
//                                     value: _isSelected12,
//                                   ),
//                                   Text('Female'),
//                                 ],
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 8),
//                                 child: Row(
//                                   children: [
//                                     Text('Age'),
//                                     Container(
//                                       // decoration: BoxDecoration(
//                                       //   border: Border.all(
//                                       //     color: Colors.black,
//                                       //     width: 1,
//                                       //   ),
//                                       //   borderRadius: BorderRadius.circular(12),
//                                       // ),
//                                       height: 50,
//                                       width: 50,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: TextFormField(
//                                           controller: _controllerAge11,
//                                           keyboardType: TextInputType.number,
//                                           validator: (value) {
//                                             if (value == null ||
//                                                 value.isEmpty) {
//                                               return 'Age required';
//                                             }
//                                             return null;
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.black,
//                         width: 1,
//                       ),
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.green.withOpacity(0.1),
//                           spreadRadius: 3,
//                           blurRadius: 7,
//                           offset: Offset(0, 3), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(top: 5),
//                           child: Text(
//                               'Passenger 2 | ${widget.listSeat[1].name} |  \u{20B9}${widget.listSeat[1].fareSeat}'),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: TextFormField(
//                             controller: _controllerName2,
//                             decoration:
//                                 InputDecoration(labelText: 'Passenger name'),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter name';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 8),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   LabeledCheckRedBus(
//                                     onChanged: (bool newValue1) {
//                                       setState(() {
//                                         // globalPostModal = globalPostModal.copyWith(
//                                         //     partsDepreciationCover: newValue1);
//                                         _isSelected21 = newValue1;
//                                         _isSelected22 = !newValue1;
//                                       });
//                                       _isSelected22 == true
//                                           ? _temMaleOrFema2 = 'FEMALE'
//                                           : _temMaleOrFema2 = 'MALE';
//                                       print(_temMaleOrFema2);
//                                     },
//                                     value: _isSelected21,
//                                   ),
//                                   Text('Male'),
//                                   LabeledCheckRedBus(
//                                     onChanged: (bool newValue2) {
//                                       setState(() {
//                                         // globalPostModal = globalPostModal.copyWith(
//                                         //     partsDepreciationCover: newValue1);
//                                         _isSelected22 = newValue2;
//                                         _isSelected21 = !newValue2;
//                                         _isSelected22 == true
//                                             ? _temMaleOrFema2 = 'FEMALE'
//                                             : _temMaleOrFema2 = 'MALE';
//                                         print(_temMaleOrFema2);
//                                       });
//                                     },
//                                     value: _isSelected22,
//                                   ),
//                                   Text('Female'),
//                                 ],
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 8),
//                                 child: Row(
//                                   children: [
//                                     Text('Age'),
//                                     Container(
//                                       // decoration: BoxDecoration(
//                                       //   border: Border.all(
//                                       //     color: Colors.black,
//                                       //     width: 1,
//                                       //   ),
//                                       //   borderRadius: BorderRadius.circular(12),
//                                       // ),
//                                       height: 50,
//                                       width: 50,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: TextFormField(
//                                           controller: _controllerAge2,
//                                           keyboardType: TextInputType.number,
//                                           validator: (value) {
//                                             if (value == null ||
//                                                 value.isEmpty) {
//                                               return 'Age required';
//                                             }
//                                             return null;
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
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
//             //         //
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ElevatedButton(
//                 onPressed: () async {
//                   print('onTap');
//                  // String walletbalance = await checkwalletbalance();
//                //   final doubLeWalletBalance = double.parse(walletbalance);
//                 //  print(doubLeWalletBalance);

//                  // print(walletbalance);
//                   final fareSeat = double.parse(widget.listSeat[0].fareSeat);
//                  // print(fareSeat);
//                   if (100 > fareSeat) {
//                     if (_formKey.currentState!.validate()) {
//                       var _resPonse2 =
//                           await BlocTicketEvetApiClass().getDataBLocTicket2(
//                         boardingPointName: widget.bpName,
//                         destinationName: globalPostRedBus.toLocation,
//                         droppingPointName: widget.dpName,
//                         sourceName: globalPostRedBus.fromLocation,

//                         ///general
//                         tripId: widget.tripId,
//                         bPIdee: widget.bPid,
//                         destIdee: globalPostRedBus.idToLocation,
//                         source: globalPostRedBus.idFromLocation,
//                         //passenger contact details
//                         mobPassenger: _controllerMobile.text,
//                         emailPassenger: _controllerEmail.text,
//                         //passenger 1
//                         name1: _controllerName11.text,
//                         gender1: _temMaleOrFema1,
//                         age1: _controllerAge11.text,
//                         seatName1: widget.listSeat[0].name,
//                         fare1: widget.listSeat[0].fareSeat,
//                         ladiesSeat1: widget.listSeat[0].ladies,

//                         //passenger 2
//                         name2: _controllerName2.text,
//                         gender2: _temMaleOrFema2,
//                         age2: _controllerAge2.text,
//                         seatName2: widget.listSeat[1].name,
//                         fare2: widget.listSeat[1].fareSeat,
//                         ladiesSeat2: widget.listSeat[1].ladies,
//                       );

//                       _resPonse2.toString().characters.length.toInt() <= 12
//                           ? await Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => SuccusViewTicketScreen(
//                                         passengerCount: 2,
//                                         blockKey: '${_resPonse2}',
//                                       )),
//                             )
//                           : await Fluttertoast.showToast(
//                               msg: 'Please try again! Do not press back button',
//                               gravity: ToastGravity.CENTER);
//                       setState(() {});
//                     } else {
//                       print('ontaaaaaaaappppppp');
//                     }
//                   } else {
//                     await Fluttertoast.showToast(
//                         msg: 'Insufficient balance',
//                         gravity: ToastGravity.CENTER);
//                   }
//                   //int.parse(5.toString()).toS
//                 },
//                 child: TextSize17BoldWhite(
//                     test: "\u{20B9} ${finalPrice.toString()} Pay now"
//                     //  int.parse(widget.listSeat[1].fareSeat.toString() +
//                     //         widget.listSeat[0].fareSeat.toString())

//                     ),
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
