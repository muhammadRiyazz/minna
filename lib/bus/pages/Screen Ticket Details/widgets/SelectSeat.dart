// import 'dart:developer';

// import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../../application/CancelSeatSelection/seat_select_bloc.dart';
// import '../../../../../infrastructure/ticket cancel/ticket_cancel.dart';
// import '../../../domain/Ticket details/ticket_details_more1.dart';
// import '../../../domain/cancel succes modal/cancel_succes_modal.dart';
// import '../../../infrastructure/cancelTicket/conform_cancel_seat.dart';
// import '../../Screen cancel Succes/screen_cancel_succes.dart';

// class SelectDeletionSeat extends StatefulWidget {
//   const SelectDeletionSeat({Key? key, required this.items, required this.tin})
//       : super(key: key);
//   final List<InventoryItem> items;
//   final String tin;
//   @override
//   State<SelectDeletionSeat> createState() => _SelectDeletionSeatState();
// }

// List<String> selectedSeats = [];
// final List<String> seats = [];

// class _SelectDeletionSeatState extends State<SelectDeletionSeat> {
//   @override
//   bool isloading = true;
//   bool iserror = false;
//   CancelSuccesModal? cancelSuccesData;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 10),
//       height: 170,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20), topRight: Radius.circular(20))),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           SizedBox(
//             height: 4,
//           ),
//           ChipsChoice<String>.multiple(
//             value: selectedSeats,
//             onChanged: (val) {
//               setState(() {
//                 selectedSeats = val;
//               });
//               log(selectedSeats.length.toString());
//             },
//             choiceItems: C2Choice.listFrom(
//               source: seats,
//               value: (i, v) {
//                 return v.toString();
//               },
//               label: (i, v) {
//                 return v.toString();
//               },
//             ),
//             choiceActiveStyle: C2ChoiceStyle(
//               backgroundColor: Colors.red,
//               padding: EdgeInsets.all(15),
//               color: Colors.white,
//               //  borderColor: Colors.,
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//             ),
//             choiceStyle: C2ChoiceStyle(
//               padding: EdgeInsets.all(15),
//               color: Colors.red,
//               backgroundColor: Colors.white,
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: InkWell(
//               onTap: () {
//                 cancelSeats(tin: widget.tin, seats: selectedSeats);
//                 Navigator.pop(context);
//               },
//               child: Container(
//                 height: 45,
//                 decoration: BoxDecoration(
//                     color: Colors.red, borderRadius: BorderRadius.circular(10)),
//                 width: double.infinity,
//                 child: Center(
//                     child: Text(
//                   'Conform',
//                   style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500),
//                 )),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 4,
//           ),
//         ],
//       ),
//     );
//   }

//   callApi() async {
//     setState(() {
//       isloading = true;
//       iserror = false;
//     });
//     try {
//       final data = await cancelSeats(tin: widget.tin, seats: selectedSeats);

//       log(data.body);
//       if (data.statusCode == 200 &&
//           data.body !=
//               'Error: Authorization failed please send valid consumer key and secret in the api request.') {
//         cancelSuccesData = cancelSuccesModalFromJson(data.body);

//         Navigator.push(context, MaterialPageRoute(
//           builder: (context) {
//             return ScreenCancelSucces(
//               cancelSuccesdata: cancelSuccesData!,
//             );
//           },
//         ));
//       } else if (data.body ==
//           'Error: Authorization failed please send valid consumer key and secret in the api request.') {
//         callApi();
//       }
//     } catch (e) {
//       setState(() {
//         isloading = false;
//         iserror = true;
//       });
//     }
//   }
// }
