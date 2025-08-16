// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../insurance/screen/pages/2whlr_quik2/new_widget.dart';
// import '../../application/first_bloc/bloc/bloc/wallet_bloc_bloc.dart';

// class TicketScrOnePerson extends StatelessWidget {
//   TicketScrOnePerson({Key? key, required this.tIn}) : super(key: key);
//   String tIn;
//   @override
//   Widget build(BuildContext context) {
//     print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
//     print(tIn);
//     context
//         .read<FirstBlocRedBus>()
//         .add(PassengerDetailsOnlyOnePeronEvent(tIn: tIn));
//     return Scaffold(body: BlocBuilder<FirstBlocRedBus, WalletBlocState>(
//       builder: (context, state) {
//         if (state is PassengerDetailsOnlyOnePeronState) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CircularProgressIndicator(),
//                 TextButton(
//                     onPressed: () {
//                       context
//                           .read<FirstBlocRedBus>()
//                           .add(TicketDetailsEvent(tin: tIn));
//                     },
//                     child: Text('Refresh'))
//               ],
//             ),
//           );
//         }
//         if (state is PassengerDetailsOnlyOneErrorState) {
//           return Text(state.error);
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
//                     // Container(
//                     //   // color: Colors.blue,
//                     //   width: double.infinity,
//                     //   height: 200,

//                     //   child: ListView.builder(
//                     //       itemCount: state.ticketModel.inventoryItems.,
//                     //       itemBuilder: (c, i) {
//                     //         return Text19Black(
//                     //           test: state
//                     //               .ticketModel.inventoryItems[i].passenger.name,
//                     //         );
//                     //       }),
//                     // ),
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
//                     Text19Black(test:'Travel details'),
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
//                         // await CreatePdfNew().createPdfNew(
//                         //   // name: state.ticketModel.inventoryItems.passenger.name,
//                         //   // phone:
//                         //   //     state.ticketModel.inventoryItems.passenger.mobile,
//                         //   busType: state.ticketModel.busType,
//                         //   dateIssue: state.ticketModel.dateOfIssue
//                         //       .toString()
//                         //       .characters
//                         //       .take(10)
//                         //       .string,
//                         //   dateJourny: state.ticketModel.doj
//                         //       .toString()
//                         //       .characters
//                         //       .take(10)
//                         //       .string,
//                         //   // email:
//                         //   //     state.ticketModel.inventoryItems.passenger.email,
//                         //   // fare: state.ticketModel.inventoryItems.fare,
//                         //   pickupTime: state.ticketModel.pickupTime,
//                         //   picupLocations: state.ticketModel.pickupLocation,
//                         //   pnr: state.ticketModel.pnr,
//                         //   // seatName: state.ticketModel.inventoryItems.seatName,
//                         //   // serviceCharge: state
//                         //   //     .ticketModel.inventoryItems.operatorServiceCharge,
//                         //   status: state.ticketModel.status,
//                         //   tin: state.ticketModel.tin,
//                         //   travels: state.ticketModel.travels,
//                         // );
//                         // await Fluttertoast.showToast(
//                         //     msg: 'Downloaded succusfully');
//                       },
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         return Container();
//       },
//     ));
//   }
// }
