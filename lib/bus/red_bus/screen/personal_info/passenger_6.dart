// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:maaxusminihub/screen/red_bus/infrastructure/block_ticket.dart';
// import 'package:maaxusminihub/screen/red_bus/screen/personal_info/passenger_details_page.dart';
// import 'package:maaxusminihub/screen/red_bus/screen/ride_choose/seat_layout.dart';

// import '../../../insurance/screen/pages/2whlr_quik2/new_widget.dart';
// import '../../domain/data_post_redBus.dart';
// import '../../infrastructure/checkwalletbalance.dart';
// import '../ticket/save_file_mobile.dart';

// class PssengerBookingDetailPage6 extends StatefulWidget {
//   PssengerBookingDetailPage6({
//     Key? key,
//     required this.tripId,
//     required this.listSeat,
//     required this.bPid,
//     required this.tripIdees,
//     required this.bpName,
//     required this.dpName,
//   }) : super(key: key);
//   String tripId, bpName, dpName;
//   List<ListOfSeatClass> listSeat;
//   String bPid;
//   String tripIdees;

//   @override
//   State<PssengerBookingDetailPage6> createState() =>
//       _PssengerBookingDetailPage6State();
// }

// class _PssengerBookingDetailPage6State
//     extends State<PssengerBookingDetailPage6> {
//   String _temMaleOrFema1 = 'MALE';
//   bool _isSelected11 = true;
//   bool _isSelected12 = false;
//   String _temMaleOrFema2 = 'MALE';
//   bool _isSelected21 = true;
//   bool _isSelected22 = false;
//   String _temMaleOrFema3 = 'MALE';
//   bool _isSelected31 = true;
//   bool _isSelected32 = false;
//   String _temMaleOrFema4 = 'MALE';
//   bool _isSelected41 = true;
//   bool _isSelected42 = false;
//   String _temMaleOrFema5 = 'MALE';
//   bool _isSelected51 = true;
//   bool _isSelected52 = false;
//   String _temMaleOrFema6 = 'MALE';
//   bool _isSelected61 = true;
//   bool _isSelected62 = false;
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _controllerName11 = TextEditingController();
//   TextEditingController _controllerAge11 = TextEditingController();
//   TextEditingController _controllerName2 = TextEditingController();
//   TextEditingController _controllerAge2 = TextEditingController();
//   TextEditingController _controllerName3 = TextEditingController();
//   TextEditingController _controllerAge3 = TextEditingController();
//   TextEditingController _controllerName4 = TextEditingController();
//   TextEditingController _controllerAge4 = TextEditingController();
//   TextEditingController _controllerName5 = TextEditingController();
//   TextEditingController _controllerAge5 = TextEditingController();
//   TextEditingController _controllerName6 = TextEditingController();
//   TextEditingController _controllerAge6 = TextEditingController();
//   TextEditingController _controllerEmail = TextEditingController();
//   TextEditingController _controllerMobile = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     double price1 = double.parse(widget.listSeat[0].fareSeat);
//     double price2 = double.parse(widget.listSeat[1].fareSeat);
//     double price3 = double.parse(widget.listSeat[2].fareSeat);
//     double price4 = double.parse(widget.listSeat[3].fareSeat);
//     double price5 = double.parse(widget.listSeat[4].fareSeat);
//     double price6 = double.parse(widget.listSeat[5].fareSeat);
//     var finalPrice = price1 + price2 + price3 + price4 + price5 + price6;
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
//                                         _isSelected12 = newValue2;
//                                         _isSelected11 = !newValue2;
//                                         _isSelected11 == true
//                                             ? _temMaleOrFema1 = 'MALE'
//                                             : _temMaleOrFema1 = 'FEMALE';
//                                         print(_temMaleOrFema1);
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
//                                         _isSelected21 = newValue1;
//                                         _isSelected22 = !newValue1;
//                                         _isSelected22 == true
//                                             ? _temMaleOrFema2 = 'FEMALE'
//                                             : _temMaleOrFema2 = 'MALE';
//                                         print(_temMaleOrFema2);
//                                       });
//                                     },
//                                     value: _isSelected21,
//                                   ),
//                                   Text('Male'),
//                                   LabeledCheckRedBus(
//                                     onChanged: (bool newValue2) {
//                                       setState(() {
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
//                               'Passenger 3 | ${widget.listSeat[2].name} |  \u{20B9}${widget.listSeat[2].fareSeat}'),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: TextFormField(
//                             controller: _controllerName3,
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
//                                         _isSelected31 = newValue1;
//                                         _isSelected32 = !newValue1;
//                                         _isSelected31 == false
//                                             ? _temMaleOrFema3 = 'FEMALE'
//                                             : _temMaleOrFema3 = 'MALE';
//                                         print(_temMaleOrFema3);
//                                       });
//                                     },
//                                     value: _isSelected31,
//                                   ),
//                                   Text('Male'),
//                                   LabeledCheckRedBus(
//                                     onChanged: (bool newValue2) {
//                                       setState(() {
//                                         _isSelected32 = newValue2;
//                                         _isSelected31 = !newValue2;
//                                         _isSelected31 == false
//                                             ? _temMaleOrFema3 = 'FEMALE'
//                                             : _temMaleOrFema3 = 'MALE';
//                                         print(_temMaleOrFema3);
//                                       });
//                                     },
//                                     value: _isSelected32,
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
//                                           controller: _controllerAge3,
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
//                               'Passenger 4 | ${widget.listSeat[3].name} |  \u{20B9}${widget.listSeat[3].fareSeat}'),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: TextFormField(
//                             controller: _controllerName4,
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
//                                         _isSelected41 = newValue1;
//                                         _isSelected42 = !newValue1;
//                                         _isSelected41 == false
//                                             ? _temMaleOrFema4 = 'FEMALE'
//                                             : _temMaleOrFema4 = 'MALE';
//                                         print(_temMaleOrFema4);
//                                       });
//                                     },
//                                     value: _isSelected41,
//                                   ),
//                                   Text('Male'),
//                                   LabeledCheckRedBus(
//                                     onChanged: (bool newValue2) {
//                                       setState(() {
//                                         _isSelected42 = newValue2;
//                                         _isSelected41 = !newValue2;
//                                         _isSelected41 == false
//                                             ? _temMaleOrFema4 = 'FEMALE'
//                                             : _temMaleOrFema4 = 'MALE';
//                                         print(_temMaleOrFema4);
//                                       });
//                                     },
//                                     value: _isSelected42,
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
//                                           controller: _controllerAge4,
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
//                               'Passenger 5 | ${widget.listSeat[4].name} |  \u{20B9}${widget.listSeat[4].fareSeat}'),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: TextFormField(
//                             controller: _controllerName5,
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
//                                         _isSelected51 = newValue1;
//                                         _isSelected52 = !newValue1;
//                                         _isSelected51 == false
//                                             ? _temMaleOrFema5 = 'FEMALE'
//                                             : _temMaleOrFema5 = 'MALE';
//                                         print(_temMaleOrFema5);
//                                       });
//                                     },
//                                     value: _isSelected51,
//                                   ),
//                                   Text('Male'),
//                                   LabeledCheckRedBus(
//                                     onChanged: (bool newValue2) {
//                                       setState(() {
//                                         _isSelected52 = newValue2;
//                                         _isSelected51 = !newValue2;
//                                         _isSelected51 == false
//                                             ? _temMaleOrFema5 = 'FEMALE'
//                                             : _temMaleOrFema5 = 'MALE';
//                                         print(_temMaleOrFema5);
//                                       });
//                                     },
//                                     value: _isSelected52,
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
//                                           controller: _controllerAge5,
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
//                               'Passenger 6 | ${widget.listSeat[5].name} |  \u{20B9}${widget.listSeat[5].fareSeat}'),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: TextFormField(
//                             controller: _controllerName6,
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
//                                         _isSelected61 = newValue1;
//                                         _isSelected62 = !newValue1;
//                                         _isSelected61 == false
//                                             ? _temMaleOrFema6 = 'FEMALE'
//                                             : _temMaleOrFema6 = 'MALE';
//                                         print(_temMaleOrFema6);
//                                       });
//                                     },
//                                     value: _isSelected61,
//                                   ),
//                                   Text('Male'),
//                                   LabeledCheckRedBus(
//                                     onChanged: (bool newValue2) {
//                                       setState(() {
//                                         _isSelected62 = newValue2;
//                                         _isSelected61 = !newValue2;
//                                         _isSelected61 == false
//                                             ? _temMaleOrFema6 = 'FEMALE'
//                                             : _temMaleOrFema6 = 'MALE';
//                                         print(_temMaleOrFema6);
//                                       });
//                                     },
//                                     value: _isSelected62,
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
//                                           controller: _controllerAge6,
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
//                   //       print('onTap');
//                   // String walletbalance = await checkwalletbalance();
//                   // final doubLeWalletBalance = double.parse(walletbalance);
//                   // print(doubLeWalletBalance);

//                   // print(walletbalance);
//                   // final fareSeat = double.parse(widget.listSeat[0].fareSeat);
//                   // print(fareSeat);
//                   if (_formKey.currentState!.validate()) {
//                     var _resPonse6 =
//                         await BlocTicketEvetApiClass().getDataBLocTicket6(
//                       // extra for backend
//                       boardingPointName: widget.bpName,
//                       destinationName: globalPostRedBus.toLocation,
//                       droppingPointName: widget.dpName,
//                       sourceName: globalPostRedBus.fromLocation,

//                       ///general
//                       tripId: widget.tripId,
//                       bPIdee: widget.bPid,
//                       destIdee: globalPostRedBus.idToLocation,
//                       source: globalPostRedBus.idFromLocation,
//                       //passenger contact details
//                       mobPassenger: _controllerMobile.text,
//                       emailPassenger: _controllerEmail.text,
//                       //passenger 1
//                       name1: _controllerName11.text,
//                       gender1: _temMaleOrFema1,
//                       age1: _controllerAge11.text,
//                       seatName1: widget.listSeat[0].name,
//                       fare1: widget.listSeat[0].fareSeat,
//                       ladiesSeat1: widget.listSeat[0].ladies,

//                       //passenger 2
//                       name2: _controllerName2.text,
//                       gender2: _temMaleOrFema2,
//                       age2: _controllerAge2.text,
//                       seatName2: widget.listSeat[1].name,
//                       fare2: widget.listSeat[1].fareSeat,
//                       ladiesSeat2: widget.listSeat[1].ladies,
//                       // passenger 3
//                       name3: _controllerName3.text,
//                       gender3: _temMaleOrFema3,
//                       age3: _controllerAge3.text,
//                       seatName3: widget.listSeat[2].name,
//                       fare3: widget.listSeat[2].fareSeat,
//                       ladiesSeat3: widget.listSeat[2].ladies,
//                       // passenger 4
//                       name4: _controllerName4.text,
//                       gender4: _temMaleOrFema4,
//                       age4: _controllerAge4.text,
//                       seatName4: widget.listSeat[3].name,
//                       fare4: widget.listSeat[3].fareSeat,
//                       ladiesSeat4: widget.listSeat[3].ladies,
//                       // passenger 5
//                       name5: _controllerName5.text,
//                       gender5: _temMaleOrFema5,
//                       age5: _controllerAge5.text,
//                       seatName5: widget.listSeat[4].name,
//                       fare5: widget.listSeat[4].fareSeat,
//                       ladiesSeat5: widget.listSeat[4].ladies,
//                       // passenger 6
//                       name6: _controllerName6.text,
//                       gender6: _temMaleOrFema6,
//                       age6: _controllerAge6.text,
//                       seatName6: widget.listSeat[5].name,
//                       fare6: widget.listSeat[5].fareSeat,
//                       ladiesSeat6: widget.listSeat[5].ladies,
//                     );

//                     _resPonse6.toString().characters.length.toInt() <= 12
//                         ? await Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => SuccusViewTicketScreen(
//                                       passengerCount: 6,
//                                       blockKey: '${_resPonse6}',
//                                     )),
//                           )
//                         : await Fluttertoast.showToast(
//                             msg: 'Please try again! Do not press back button',
//                             gravity: ToastGravity.CENTER);
//                   } else {
//                     print('ontaaaaaaaappppppp');

//                     print(widget.tripId);
//                     print(widget.listSeat);
//                     print(widget.bPid);
//                     print(widget.tripIdees);
//                   }
//                 },
//                 child:
//                     TextSize17BoldWhite(test: '\u{20B9}${finalPrice}  Total '),
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
