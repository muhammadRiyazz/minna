// import 'dart:convert';

// import 'package:flutter/material.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:maaxusminihub/screen/insurance/screen/pages/2whlr_quik2/new_widget.dart';
// import 'package:maaxusminihub/screen/red_bus/application/first_bloc/bloc/bloc/wallet_bloc_bloc.dart';
// import 'package:maaxusminihub/screen/red_bus/domain/data_post_redBus.dart';

// import 'package:maaxusminihub/screen/red_bus/screen/ride_choose/boarding_drop.dart';

// import '../../domain/model_bus_seats/model_bus_seats.dart';
// import '../../domain/model_bus_seats/test_model.dart';

// class SeatLayOutPage extends StatefulWidget {
//   SeatLayOutPage({Key? key, required this.tripId}) : super(key: key);
//   String tripId;
//   @override
//   State<SeatLayOutPage> createState() =>
//       _SeatLayOutPageState(tripId: this.tripId);
// }

// class _SeatLayOutPageState extends State<SeatLayOutPage> {
//   _SeatLayOutPageState({required this.tripId});
//   String tripId;

//   List<ListOfSeatClass> listSeatNameClass = [];

//   //////////////////
//   String seat1 = '';
//   String seat2 = '';
//   bool _upAndDownButtonBool = false;
//   //

//   ///Avaialble colour change when tapping
//   bool _ontapRow0Column0Index0 = true;
//   bool _ontapRow1Column0Index0 = true;
//   bool _ontapRow2Column0Index0 = true;
//   bool _ontapRow3Column0Index0 = true;
//   bool _ontapRow4Column0Index0 = true;

//   bool _ontapRow0Column1Index0 = true;
//   bool _ontapRow1Column1Index0 = true;
//   bool _ontapRow2Column1Index0 = true;
//   bool _ontapRow3Column1Index0 = true;
//   bool _ontapRow4Column1Index0 = true;

//   /// column 222222222222
//   bool _ontapRow0Column2Index0 = true;
//   bool _ontapRow1Column2Index0 = true;
//   bool _ontapRow2Column2Index0 = true;
//   bool _ontapRow3Column2Index0 = true;
//   bool _ontapRow4Column2Index0 = true;

//   /// column 333
//   bool _ontapRow0Column3Index0 = true;
//   bool _ontapRow1Column3Index0 = true;
//   bool _ontapRow2Column3Index0 = true;
//   bool _ontapRow3Column3Index0 = true;
//   bool _ontapRow4Column3Index0 = true;
//   //
//   bool _ontapRow0Column4Index0 = true;
//   bool _ontapRow1Column4Index0 = true;
//   bool _ontapRow2Column4Index0 = true;
//   bool _ontapRow3Column4Index0 = true;
//   bool _ontapRow4Column4Index0 = true;
// //
//   bool _ontapRow0Column5Index0 = true;
//   bool _ontapRow1Column5Index0 = true;
//   bool _ontapRow2Column5Index0 = true;
//   bool _ontapRow3Column5Index0 = true;
//   bool _ontapRow4Column5Index0 = true;
//   //
//   bool _ontapRow0Column6Index0 = true;
//   bool _ontapRow1Column6Index0 = true;
//   bool _ontapRow2Column6Index0 = true;
//   bool _ontapRow3Column6Index0 = true;
//   bool _ontapRow4Column6Index0 = true;
//   //
//   bool _ontapRow0Column7Index0 = true;
//   bool _ontapRow1Column7Index0 = true;
//   bool _ontapRow2Column7Index0 = true;
//   bool _ontapRow3Column7Index0 = true;
//   bool _ontapRow4Column7Index0 = true;
//   //
//   bool _ontapRow0Column8Index0 = true;
//   bool _ontapRow1Column8Index0 = true;
//   bool _ontapRow2Column8Index0 = true;
//   bool _ontapRow3Column8Index0 = true;
//   bool _ontapRow4Column8Index0 = true;
//   //
//   bool _ontapRow0Column9Index0 = true;
//   bool _ontapRow1Column9Index0 = true;
//   bool _ontapRow2Column9Index0 = true;
//   bool _ontapRow3Column9Index0 = true;
//   bool _ontapRow4Column9Index0 = true;
//   //
//   bool _ontapRow0Column10Index0 = true;
//   bool _ontapRow1Column10Index0 = true;
//   bool _ontapRow2Column10Index0 = true;
//   bool _ontapRow3Column10Index0 = true;
//   bool _ontapRow4Column10Index0 = true;
//   //
//   bool _ontapRow0Column11Index0 = true;
//   bool _ontapRow1Column11Index0 = true;
//   bool _ontapRow2Column11Index0 = true;
//   bool _ontapRow3Column11Index0 = true;
//   bool _ontapRow4Column11Index0 = true;
//   //
//   bool _ontapRow0Column12Index0 = true;
//   bool _ontapRow1Column12Index0 = true;
//   bool _ontapRow2Column12Index0 = true;
//   bool _ontapRow3Column12Index0 = true;
//   bool _ontapRow4Column12Index0 = true;
//   //
//   bool _ontapRow0Column13Index0 = true;
//   bool _ontapRow1Column13Index0 = true;
//   bool _ontapRow2Column13Index0 = true;
//   bool _ontapRow3Column13Index0 = true;
//   bool _ontapRow4Column13Index0 = true;

//   List<Seat> downSeatList = [];
//   List row0col0in0 = [];
//   List row1col0in0 = [];
//   List row2col0in0 = [];
//   List row3col0in0 = [];
//   List row4col0in0 = [];
//   //
//   List row0col1in0 = [];
//   List row1col1in0 = [];
//   List row2col1in0 = [];
//   List row3col1in0 = [];
//   List row4col1in0 = [];
//   //
//   List row0col2in0 = [];
//   List row1col2in0 = [];
//   List row2col2in0 = [];
//   List row3col2in0 = [];
//   List row4col2in0 = [];
//   //
//   List row0col3in0 = [];
//   List row1col3in0 = [];
//   List row2col3in0 = [];
//   List row3col3in0 = [];
//   List row4col3in0 = [];
//   //
//   List row0col4in0 = [];
//   List row1col4in0 = [];
//   List row2col4in0 = [];
//   List row3col4in0 = [];
//   List row4col4in0 = [];
//   //
//   List row0col5in0 = [];
//   List row1col5in0 = [];
//   List row2col5in0 = [];
//   List row3col5in0 = [];
//   List row4col5in0 = [];
//   //
//   List row0col6in0 = [];
//   List row1col6in0 = [];
//   List row2col6in0 = [];
//   List row3col6in0 = [];
//   List row4col6in0 = [];
//   //
//   List row0col7in0 = [];
//   List row1col7in0 = [];
//   List row2col7in0 = [];
//   List row3col7in0 = [];
//   List row4col7in0 = [];
//   //
//   List row0col8in0 = [];
//   List row1col8in0 = [];
//   List row2col8in0 = [];
//   List row3col8in0 = [];
//   List row4col8in0 = [];
//   //
//   List row0col9in0 = [];
//   List row1col9in0 = [];
//   List row2col9in0 = [];
//   List row3col9in0 = [];
//   List row4col9in0 = [];
//   //
//   List row0col10in0 = [];
//   List row1col10in0 = [];
//   List row2col10in0 = [];
//   List row3col10in0 = [];
//   List row4col10in0 = [];
//   //
//   List row0col11in0 = [];
//   List row1col11in0 = [];
//   List row2col11in0 = [];
//   List row3col11in0 = [];
//   List row4col11in0 = [];
//   //
//   List row0col12in0 = [];
//   List row1col12in0 = [];
//   List row2col12in0 = [];
//   List row3col12in0 = [];
//   List row4col12in0 = [];
//   //
//   List row0col13in0 = [];
//   List row1col13in0 = [];
//   List row2col13in0 = [];
//   List row3col13in0 = [];
//   List row4col13in0 = [];
//   //
//   List row0col14in0 = [];
//   List row1col14in0 = [];
//   List row2col14in0 = [];
//   List row3col14in0 = [];
//   List row4col14in0 = [];
//   //

//   //////////////////////////////// Upper birth
//   ///Avaialble colur change when tapping
//   bool _ontapRow0Column0Index1 = true;
//   bool _ontapRow1Column0Index1 = true;
//   bool _ontapRow2Column0Index1 = true;
//   bool _ontapRow3Column0Index1 = true;
//   bool _ontapRow4Column0Index1 = true;
//   bool _ontapRow5Column0Index1 = true;
//   //
//   bool _ontapRow0Column1Index1 = true;
//   bool _ontapRow1Column1Index1 = true;
//   bool _ontapRow2Column1Index1 = true;
//   bool _ontapRow3Column1Index1 = true;
//   bool _ontapRow4Column1Index1 = true;
//   bool _ontapRow5Column1Index1 = true;

//   /// column 222222222221
//   bool _ontapRow0Column2Index1 = true;
//   bool _ontapRow1Column2Index1 = true;
//   bool _ontapRow2Column2Index1 = true;
//   bool _ontapRow3Column2Index1 = true;
//   bool _ontapRow4Column2Index1 = true;
//   bool _ontapRow5Column2Index1 = true;

//   /// column 331
//   bool _ontapRow0Column3Index1 = true;
//   bool _ontapRow1Column3Index1 = true;
//   bool _ontapRow2Column3Index1 = true;
//   bool _ontapRow3Column3Index1 = true;
//   bool _ontapRow4Column3Index1 = true;
//   bool _ontapRow5Column3Index1 = true;
// ////
//   bool _ontapRow0Column4Index1 = true;
//   bool _ontapRow1Column4Index1 = true;
//   bool _ontapRow2Column4Index1 = true;
//   bool _ontapRow3Column4Index1 = true;
//   bool _ontapRow4Column4Index1 = true;
//   bool _ontapRow5Column4Index1 = true;
// //
//   bool _ontapRow0Column5Index1 = true;
//   bool _ontapRow1Column5Index1 = true;
//   bool _ontapRow2Column5Index1 = true;
//   bool _ontapRow3Column5Index1 = true;
//   bool _ontapRow4Column5Index1 = true;
//   bool _ontapRow5Column5Index1 = true;
// //
//   bool _ontapRow0Column6Index1 = true;
//   bool _ontapRow1Column6Index1 = true;
//   bool _ontapRow2Column6Index1 = true;
//   bool _ontapRow3Column6Index1 = true;
//   bool _ontapRow4Column6Index1 = true;
//   bool _ontapRow5Column6Index1 = true;
// //
//   bool _ontapRow0Column7Index1 = true;
//   bool _ontapRow1Column7Index1 = true;
//   bool _ontapRow2Column7Index1 = true;
//   bool _ontapRow3Column7Index1 = true;
//   bool _ontapRow4Column7Index1 = true;
//   bool _ontapRow5Column7Index1 = true;
// //
//   bool _ontapRow0Column8Index1 = true;
//   bool _ontapRow1Column8Index1 = true;
//   bool _ontapRow2Column8Index1 = true;
//   bool _ontapRow3Column8Index1 = true;
//   bool _ontapRow4Column8Index1 = true;
//   bool _ontapRow5Column8Index1 = true;
// //
//   bool _ontapRow0Column9Index1 = true;
//   bool _ontapRow1Column9Index1 = true;
//   bool _ontapRow2Column9Index1 = true;
//   bool _ontapRow3Column9Index1 = true;

//   bool _ontapRow4Column9Index1 = true;
//   bool _ontapRow5Column9Index1 = true;
//   //
//   bool _ontapRow0Column10Index1 = true;
//   bool _ontapRow1Column10Index1 = true;
//   bool _ontapRow2Column10Index1 = true;
//   bool _ontapRow3Column10Index1 = true;
//   bool _ontapRow4Column10Index1 = true;
//   bool _ontapRow5Column10Index1 = true;
// //
//   bool _ontapRow0Column11Index1 = true;
//   bool _ontapRow1Column11Index1 = true;
//   bool _ontapRow2Column11Index1 = true;
//   bool _ontapRow3Column11Index1 = true;
//   bool _ontapRow4Column11Index1 = true;
//   bool _ontapRow5Column11Index1 = true;
// //
//   bool _ontapRow0Column12Index1 = true;
//   bool _ontapRow1Column12Index1 = true;
//   bool _ontapRow2Column12Index1 = true;
//   bool _ontapRow3Column12Index1 = true;
//   bool _ontapRow4Column12Index1 = true;
//   bool _ontapRow5Column12Index1 = true;
// //
//   bool _ontapRow0Column13Index1 = true;
//   bool _ontapRow1Column13Index1 = true;
//   bool _ontapRow2Column13Index1 = true;
//   bool _ontapRow3Column13Index1 = true;
//   bool _ontapRow4Column13Index1 = true;
//   bool _ontapRow5Column13Index1 = true;
// //
//   List<Seat> upSeatList = [];

//   List row0col0in1 = [];
//   List row1col0in1 = [];
//   List row2col0in1 = [];
//   List row3col0in1 = [];
//   List row4col0in1 = [];
//   List row5col0in1 = [];
// //
//   List row0col1in1 = [];
//   List row1col1in1 = [];
//   List row2col1in1 = [];
//   List row3col1in1 = [];
//   List row4col1in1 = [];
//   List row5col1in1 = [];
// //
//   List row0col2in1 = [];
//   List row1col2in1 = [];
//   List row2col2in1 = [];
//   List row3col2in1 = [];
//   List row4col2in1 = [];
//   List row5col2in1 = [];
// //
//   List row0col3in1 = [];
//   List row1col3in1 = [];
//   List row2col3in1 = [];
//   List row3col3in1 = [];
//   List row4col3in1 = [];
//   List row5col3in1 = [];
//   //

//   List row0col4in1 = [];
//   List row1col4in1 = [];
//   List row2col4in1 = [];
//   List row3col4in1 = [];
//   List row4col4in1 = [];
//   List row5col4in1 = [];
// //
//   List row0col5in1 = [];
//   List row1col5in1 = [];
//   List row2col5in1 = [];
//   List row3col5in1 = [];
//   List row4col5in1 = [];
//   List row5col5in1 = [];
// //
//   List row0col6in1 = [];
//   List row1col6in1 = [];
//   List row2col6in1 = [];
//   List row3col6in1 = [];
//   List row4col6in1 = [];
//   List row5col6in1 = [];
// //
//   List row0col7in1 = [];
//   List row1col7in1 = [];
//   List row2col7in1 = [];
//   List row3col7in1 = [];
//   List row4col7in1 = [];
//   List row5col7in1 = [];
// //
//   List row0col8in1 = [];
//   List row1col8in1 = [];
//   List row2col8in1 = [];
//   List row3col8in1 = [];
//   List row4col8in1 = [];
//   List row5col8in1 = [];
// //
//   List row0col9in1 = [];
//   List row1col9in1 = [];
//   List row2col9in1 = [];
//   List row3col9in1 = [];
//   List row4col9in1 = [];
//   List row5col9in1 = [];
//   // row0col10in1
//   List row0col10in1 = [];
//   List row1col10in1 = [];
//   List row2col10in1 = [];
//   List row3col10in1 = [];
//   List row4col10in1 = [];
//   List row5col10in1 = [];
//   //
//   List row0col11in1 = [];
//   List row1col11in1 = [];
//   List row2col11in1 = [];
//   List row3col11in1 = [];
//   List row4col11in1 = [];
//   List row5col11in1 = [];

//   //
//   List row0col12in1 = [];
//   List row1col12in1 = [];
//   List row2col12in1 = [];
//   List row3col12in1 = [];
//   List row4col12in1 = [];
//   List row5col12in1 = [];
//   //
//   List row0col13in1 = [];
//   List row1col13in1 = [];
//   List row2col13in1 = [];
//   List row3col13in1 = [];
//   List row4col13in1 = [];
//   List row5col13in1 = [];
//   //
//   List row0col14in1 = [];
//   List row1col14in1 = [];
//   List row2col14in1 = [];
//   List row3col14in1 = [];
//   List row4col14in1 = [];
//   List row5col14in1 = [];
//   //

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       context.read<FirstBlocRedBus>().add(SeatsAvailableEvent(tripIde: tripId));
//     });

//     return Scaffold(
//       appBar: AppBar(
//         title: TextSize17(test: ' Seats '),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//           onPressed:
//               listSeatNameClass.length == 0 || listSeatNameClass.length > 6
//                   ? () async {
//                       listSeatNameClass.length == 0
//                           ? Fluttertoast.showToast(msg: 'Select seat')
//                           : Fluttertoast.showToast(
//                               msg: 'Maximum number of seat is 6');
//                     }
//                   : () async {
//                       await Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => BoardDropScreenNew(
//                                   noPerson: listSeatNameClass.length.toString(),
//                                   listFare: listSeatNameClass,
//                                   tripId: tripId,
//                                 )
//                             //  BoardingPointScrnn()

//                             ),
//                       );
//                       setState(() {});
//                     },
//           label: Text('${listSeatNameClass.length} Book Now ')),
//       persistentFooterButtons: [
//         Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 SmallContainers(
//                     backColor: Colors.white, borderColor: Colors.black),
//                 TextSize17(
//                   test: 'Available',
//                 ),
//                 SmallContainers(
//                     backColor: Colors.grey, borderColor: Colors.black),
//                 TextSize17(
//                   test: 'Unavailable',
//                 ),
//                 SmallContainers(
//                     backColor: Colors.white, borderColor: Colors.pink),
//                 TextSize17(
//                   test: 'Female',
//                 )
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 SmallContainers(
//                     backColor: Colors.green, borderColor: Colors.black),
//                 TextSize17(
//                   test: 'Selected',
//                 ),
//                 SmallContainers(
//                     backColor: Colors.pink, borderColor: Colors.black),
//                 TextSize17(
//                   test: 'Unavailable',
//                 ),
//               ],
//             ),
//           ],
//         )
//       ],
//       body: SafeArea(
//         child: BlocBuilder<FirstBlocRedBus, WalletBlocState>(
//           builder: (context, state) {
//             if (state is GettingBusSeats) {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Center(
//                     child: Column(
//                       children: [
//                         CircularProgressIndicator(
//                           color: Colors.red,
//                         ),
//                         Text('Loading '),
//                         Text('Please wait! ')
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             }
//             if (state is NetworkErrorBusSeatState) {
//                context.read<FirstBlocRedBus>().add(SeatsAvailableEvent(tripIde: tripId));
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Center(
//                     child: TextButton(
//                       onPressed: () {
//                         context
//                             .read<FirstBlocRedBus>()
//                             .add(SeatsAvailableEvent(tripIde: tripId));
//                       },
//                       child: Text(' Refresh '),
//                     ),
//                   ),
//                 ],
//               );
//             }
//             if (state is GotDataBusSeatState) {
//               _upAndDownButtonBool == false
//                   ? downSeatList = state.modelListofSeats.seats
//                   : downSeatList = [];

//               _upAndDownButtonBool == true
//                   ? upSeatList = state.modelListofSeats.seats
//                   : upSeatList = [];

//               ///Column 000
//               row0col0in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '0' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '0')
//                   .toList();

//               row1col0in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '0' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '0')
//                   .toList();

//               print(row1col0in0);
//               row2col0in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '0' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row3col0in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '0' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row4col0in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '0' &&
//                       seat.row == '4' &&
//                       seat.zIndex == '0')
//                   .toList();
//               ///////Column 11111

//               row0col1in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '1' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '0')
//                   .toList();

//               row1col1in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '1' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '0')
//                   .toList();

//               row2col1in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '1' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '0')
//                   .toList();

//               row3col1in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '1' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '0')
//                   .toList();

//               row4col1in0 = downSeatList
//                   .where(
//                     (seat) =>
//                         seat.column == '1' &&
//                         seat.row == '4' &&
//                         seat.zIndex == '0',
//                   )
//                   .toList();

//               //////Column222
//               row0col2in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '2' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '0')
//                   .toList();

//               row1col2in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '2' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '0')
//                   .toList();

//               row2col2in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '2' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row3col2in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '2' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row4col2in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '2' &&
//                       seat.row == '4' &&
//                       seat.zIndex == '0')
//                   .toList();

//               ////3333333
//               row0col3in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '3' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '0')
//                   .toList();

//               row1col3in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '3' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '0')
//                   .toList();

//               row2col3in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '3' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row3col3in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '3' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row4col3in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '3' &&
//                       seat.row == '4' &&
//                       seat.zIndex == '0')
//                   .toList();

//               ///444444
//               row0col4in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '4' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '0')
//                   .toList();

//               row1col4in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '4' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '0')
//                   .toList();

//               row2col4in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '4' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row3col4in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '4' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row4col4in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '4' &&
//                       seat.row == '4' &&
//                       seat.zIndex == '0')
//                   .toList();
// ////////////////5555555555555
//               row0col5in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '5' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row1col5in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '5' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row2col5in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '5' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row3col5in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '5' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row4col5in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '5' &&
//                       seat.row == '4' &&
//                       seat.zIndex == '0')
//                   .toList();
//               ////////6666666666666
//               row0col6in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '6' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '0')
//                   .toList();

//               row1col6in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '6' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '0')
//                   .toList();

//               row2col6in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '6' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row3col6in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '6' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row4col6in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '6' &&
//                       seat.row == '4' &&
//                       seat.zIndex == '0')
//                   .toList();

//               ////// 777777777  \\///\\//\
//               row0col7in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '7' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '0')
//                   .toList();

//               row1col7in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '7' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '0')
//                   .toList();

//               row2col7in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '7' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row3col7in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '7' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row4col7in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '7' &&
//                       seat.row == '4' &&
//                       seat.zIndex == '0')
//                   .toList();
//               //////8888888888
//               row0col8in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '8' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '0')
//                   .toList();

//               row1col8in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '8' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '0')
//                   .toList();

//               row2col8in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '8' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row3col8in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '8' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row4col8in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '8' &&
//                       seat.row == '4' &&
//                       seat.zIndex == '0')
//                   .toList();
//               /////99999
//               ///99999
//               row0col9in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '9' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '0')
//                   .toList();

//               row1col9in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '9' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '0')
//                   .toList();

//               row2col9in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '9' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row3col9in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '9' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row4col9in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '9' &&
//                       seat.row == '4' &&
//                       seat.zIndex == '0')
//                   .toList();
//               //10
//               ////
//               row0col10in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '10' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '0')
//                   .toList();

//               row1col10in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '10' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '0')
//                   .toList();

//               row2col10in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '10' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row3col10in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '10' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row4col10in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '10' &&
//                       seat.row == '4' &&
//                       seat.zIndex == '0')
//                   .toList();
//               //
//               //1111111111111
//               row0col11in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '11' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '0')
//                   .toList();

//               row1col11in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '11' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '0')
//                   .toList();

//               row2col11in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '11' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row3col11in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '11' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row4col11in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '11' &&
//                       seat.row == '4' &&
//                       seat.zIndex == '0')
//                   .toList();
//               //12
//               ////1111122222222
//               row0col12in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '12' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '0')
//                   .toList();

//               row1col12in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '12' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '0')
//                   .toList();

//               row2col12in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '12' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row3col12in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '12' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row4col12in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '12' &&
//                       seat.row == '4' &&
//                       seat.zIndex == '0')
//                   .toList();

//               //13
//               //1111111113333333333
//               row0col13in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '13' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '0')
//                   .toList();

//               row1col13in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '13' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '0')
//                   .toList();

//               row2col13in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '13' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row3col13in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '13' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '0')
//                   .toList();
//               row4col13in0 = downSeatList
//                   .where((seat) =>
//                       seat.column == '13' &&
//                       seat.row == '4' &&
//                       seat.zIndex == '0')
//                   .toList();
//               ////UUUUUUUUUUUUUUPPPPPPPPPPPPPPPPPPEEEEEEEEEEEEEERRRRRRRRRRRRRRRRRRR

//               row0col0in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '0' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '1')
//                   .toList();
//               print(row0col0in0.toString() == '[]' ? 'true' : 'false');
//               row1col0in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '0' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '1')
//                   .toList();

//               print(row1col0in0);
//               row2col0in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '0' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row3col0in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '0' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row4col0in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '0' &&
//                       seat.row == '4' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row5col0in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '0' &&
//                       seat.row == '5' &&
//                       seat.zIndex == '1')
//                   .toList();
//               print('777777777777777777777777777777777');

//               print(row5col0in1);
//               ///////Column 11111

//               row0col1in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '1' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '1')
//                   .toList();
//               print('column 2');

//               row1col1in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '1' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '1')
//                   .toList();

//               row2col1in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '1' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '1')
//                   .toList();

//               row3col1in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '1' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '1')
//                   .toList();

//               row4col1in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '1' &&
//                       seat.row == '4' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row5col1in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '1' &&
//                       seat.row == '5' &&
//                       seat.zIndex == '1')
//                   .toList();

//               //////Column222
//               row0col2in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '2' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '1')
//                   .toList();

//               row1col2in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '2' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '1')
//                   .toList();

//               row2col2in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '2' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row3col2in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '2' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row4col2in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '2' &&
//                       seat.row == '4' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row5col2in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '2' &&
//                       seat.row == '5' &&
//                       seat.zIndex == '1')
//                   .toList();

//               ////3333333
//               row0col3in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '3' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '1')
//                   .toList();

//               row1col3in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '3' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '1')
//                   .toList();

//               row2col3in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '3' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row3col3in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '3' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row4col3in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '3' &&
//                       seat.row == '4' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row5col3in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '3' &&
//                       seat.row == '5' &&
//                       seat.zIndex == '1')
//                   .toList();

//               ///444444
//               row0col4in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '4' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '1')
//                   .toList();

//               row1col4in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '4' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '1')
//                   .toList();

//               row2col4in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '4' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row3col4in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '4' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row4col4in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '4' &&
//                       seat.row == '4' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row5col4in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '4' &&
//                       seat.row == '5' &&
//                       seat.zIndex == '1')
//                   .toList();

// // ////////////////5555555555555
//               row0col5in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '5' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '1')
//                   .toList();

//               row1col5in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '5' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '1')
//                   .toList();

//               row2col5in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '5' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row3col5in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '5' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row4col5in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '5' &&
//                       seat.row == '4' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row5col5in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '5' &&
//                       seat.row == '5' &&
//                       seat.zIndex == '1')
//                   .toList();
// //               ////////6666666666666
//               row0col6in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '6' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '1')
//                   .toList();

//               row1col6in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '6' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '1')
//                   .toList();

//               row2col6in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '6' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row3col6in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '6' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row4col6in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '6' &&
//                       seat.row == '4' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row5col6in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '6' &&
//                       seat.row == '5' &&
//                       seat.zIndex == '1')
//                   .toList();

//               ////// 777777777  /////\\\\\
//               row0col7in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '7' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '1')
//                   .toList();

//               row1col7in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '7' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '1')
//                   .toList();

//               row2col7in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '7' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row3col7in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '7' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row4col7in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '7' &&
//                       seat.row == '4' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row5col7in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '7' &&
//                       seat.row == '5' &&
//                       seat.zIndex == '1')
//                   .toList();
//               //////8888888888
//               row0col8in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '8' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '1')
//                   .toList();

//               row1col8in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '8' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '1')
//                   .toList();

//               row2col8in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '8' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row3col8in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '8' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row4col8in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '8' &&
//                       seat.row == '4' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row5col8in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '8' &&
//                       seat.row == '5' &&
//                       seat.zIndex == '1')
//                   .toList();
//               /////99999
//               ///99999
//               row0col9in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '9' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '1')
//                   .toList();

//               row1col9in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '9' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '1')
//                   .toList();

//               row2col9in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '9' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row3col9in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '9' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row4col9in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '9' &&
//                       seat.row == '4' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row5col9in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '9' &&
//                       seat.row == '5' &&
//                       seat.zIndex == '1')
//                   .toList();
//               //10
//               ////
//               row0col10in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '10' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '1')
//                   .toList();

//               row1col10in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '10' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '1')
//                   .toList();

//               row2col10in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '10' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row3col10in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '10' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row4col10in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '10' &&
//                       seat.row == '4' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row5col10in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '10' &&
//                       seat.row == '5' &&
//                       seat.zIndex == '1')
//                   .toList();
//               //
//               //1111111111111
//               row0col11in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '11' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '1')
//                   .toList();

//               row1col11in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '11' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '1')
//                   .toList();

//               row2col11in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '11' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row3col11in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '11' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row4col11in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '11' &&
//                       seat.row == '4' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row5col11in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '11' &&
//                       seat.row == '5' &&
//                       seat.zIndex == '1')
//                   .toList();
//               //12
//               ////1111122222222
//               row0col12in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '12' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '1')
//                   .toList();

//               row1col12in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '12' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '1')
//                   .toList();

//               row2col12in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '12' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row3col12in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '12' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row4col12in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '12' &&
//                       seat.row == '4' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row5col12in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '12' &&
//                       seat.row == '5' &&
//                       seat.zIndex == '1')
//                   .toList();

//               //13
//               //1111111113333333333
//               row0col13in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '13' &&
//                       seat.row == '0' &&
//                       seat.zIndex == '1')
//                   .toList();

//               row1col13in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '13' &&
//                       seat.row == '1' &&
//                       seat.zIndex == '1')
//                   .toList();

//               row2col13in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '13' &&
//                       seat.row == '2' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row3col13in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '13' &&
//                       seat.row == '3' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row4col13in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '13' &&
//                       seat.row == '4' &&
//                       seat.zIndex == '1')
//                   .toList();
//               row5col13in1 = upSeatList
//                   .where((seat) =>
//                       seat.column == '13' &&
//                       seat.row == '5' &&
//                       seat.zIndex == '1')
//                   .toList();

//               print('************************************${listSeatNameClass}');
//               return ListView(children: [
//                 Padding(
//                   padding:
//                       const EdgeInsets.only(left: 110, right: 110, top: 15),
//                   child: Container(
//                     height: 35,
//                     decoration: BoxDecoration(
//                       border: Border.all(width: 1.1, color: Colors.black),
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         OutlinedButton(
//                           style: OutlinedButton.styleFrom(
//                             backgroundColor: _upAndDownButtonBool == false
//                                 ? Colors.black
//                                 : Colors.white,
//                             shape: const RoundedRectangleBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(25))),
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _upAndDownButtonBool = !_upAndDownButtonBool;
//                             });
//                           },
//                           child: Text(
//                             'Down',
//                             style: TextStyle(
//                               color: _upAndDownButtonBool == false
//                                   ? Colors.white
//                                   : Colors.black,
//                             ),
//                           ),
//                         ),
//                         OutlinedButton(
//                           style: OutlinedButton.styleFrom(
//                             backgroundColor: _upAndDownButtonBool == true
//                                 ? Colors.black
//                                 : Colors.white,
//                             shape: const RoundedRectangleBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(25))),
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _upAndDownButtonBool = !_upAndDownButtonBool;
//                             });
//                           },
//                           child: Text(
//                             'Up',
//                             style: TextStyle(
//                               color: _upAndDownButtonBool == true
//                                   ? Colors.white
//                                   : Colors.black,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 _upAndDownButtonBool == true
//                     ? Padding(
//                         padding: const EdgeInsets.only(
//                             right: 25, left: 25, top: 10, bottom: 50),
//                         child: Container(
//                           child: Column(
//                             children: [
//                               // SeatContainerModel(
//                               //   color: Colors.green,
//                               //   ladiesColor: Colors.yellow,
//                               //   length: row1col1in0[0].length,
//                               //   listObj: row1col1in0[0].name,
//                               //   onTap: () {},
//                               // ),
//                               // column 0000000000000000000000
//                               Row(
//                                 children: [
//                                   row5col0in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row5col0in1[0].length,
//                                           ladiesColor:
//                                               row5col0in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row5col0in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow5Column0Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row5col0in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row5col0in1[0]
//                                                                       .name,
//                                                               ladies: row5col0in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row5col0in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow5Column0Index1 =
//                                                         !_ontapRow5Column0Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow5Column0Index1 == true
//                                               ? row5col0in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row5col0in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row5col0in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row5col0in1[0].name,
//                                         ),
//                                   row4col0in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row4col0in1[0].length,
//                                           ladiesColor:
//                                               row4col0in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row4col0in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow4Column0Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col0in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col0in1[0]
//                                                                       .name,
//                                                               ladies: row4col0in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row4col0in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow4Column0Index1 =
//                                                         !_ontapRow4Column0Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow4Column0Index1 == true
//                                               ? row4col0in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col0in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col0in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col0in1[0].name,
//                                         ),
//                                   row3col0in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row3col0in1[0].length,
//                                           ladiesColor:
//                                               row3col0in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row3col0in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow3Column0Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row3col0in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row3col0in1[0]
//                                                                       .name,
//                                                               ladies: row3col0in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row3col0in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow3Column0Index1 =
//                                                         !_ontapRow3Column0Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow3Column0Index1 == true
//                                               ? row3col0in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row3col0in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row3col0in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row3col0in1[0].name,
//                                         ),
//                                   row2col0in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row2col0in1[0].length,
//                                           ladiesColor:
//                                               row2col0in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row2col0in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow2Column0Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row2col0in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row2col0in1[0]
//                                                                       .name,
//                                                               ladies: row2col0in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row2col0in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow2Column0Index1 =
//                                                         !_ontapRow2Column0Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow2Column0Index1 == true
//                                               ? row2col0in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row2col0in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row2col0in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row2col0in1[0].name,
//                                         ),
//                                   row1col0in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row1col0in1[0].length,
//                                           ladiesColor:
//                                               row1col0in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row1col0in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow1Column0Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row1col0in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row1col0in1[0]
//                                                                       .name,
//                                                               ladies: row1col0in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row1col0in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow1Column0Index1 =
//                                                         !_ontapRow1Column0Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow1Column0Index1 == true
//                                               ? row1col0in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row5col0in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row1col0in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row1col0in1[0].name,
//                                         ),
//                                   row0col0in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col0in1[0].length,
//                                           ladiesColor:
//                                               row0col0in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row0col0in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow0Column0Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col0in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col0in1[0]
//                                                                       .name,
//                                                               ladies: row0col0in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row0col0in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow0Column0Index1 =
//                                                         !_ontapRow0Column0Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow0Column0Index1 == true
//                                               ? row0col0in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col0in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col0in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col0in1[0].name,
//                                         ),
//                                 ],
//                               ),
//                               /////////////////////////////// column 111111111111111
//                               Row(
//                                 children: [
//                                   row5col1in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row5col1in1[0].length,
//                                           ladiesColor:
//                                               row5col1in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row5col1in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow5Column1Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row5col1in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row5col1in1[0]
//                                                                       .name,
//                                                               ladies: row5col1in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row5col1in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow5Column1Index1 =
//                                                         !_ontapRow5Column1Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow5Column1Index1 == true
//                                               ? row5col1in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row5col1in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row5col1in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row5col1in1[0].name,
//                                         ),
//                                   row4col1in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row4col1in1[0].length,
//                                           ladiesColor:
//                                               row4col1in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row4col1in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow4Column1Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col1in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col1in1[0]
//                                                                       .name,
//                                                               ladies: row4col1in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row4col1in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow4Column1Index1 =
//                                                         !_ontapRow4Column1Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow4Column1Index1 == true
//                                               ? row4col1in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col1in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col1in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col1in1[0].name,
//                                         ),
//                                   row3col1in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row3col1in1[0].length,
//                                           ladiesColor:
//                                               row3col1in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row3col1in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow3Column1Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row3col1in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row3col1in1[0]
//                                                                       .name,
//                                                               ladies: row3col1in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row3col1in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow3Column1Index1 =
//                                                         !_ontapRow3Column1Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow3Column1Index1 == true
//                                               ? row3col1in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row3col1in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row3col1in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row3col1in1[0].name,
//                                         ),
//                                   row2col1in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row2col1in1[0].length,
//                                           ladiesColor:
//                                               row2col1in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row2col1in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow2Column1Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row2col1in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row2col1in1[0]
//                                                                       .name,
//                                                               ladies: row2col1in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row2col1in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow2Column1Index1 =
//                                                         !_ontapRow2Column1Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow2Column1Index1 == true
//                                               ? row2col1in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row2col1in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row2col1in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row2col1in1[0].name,
//                                         ),
//                                   row1col1in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row1col1in1[0].length,
//                                           ladiesColor:
//                                               row1col1in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row1col1in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow1Column1Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row1col1in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row1col1in1[0]
//                                                                       .name,
//                                                               ladies: row1col1in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row1col1in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow1Column1Index1 =
//                                                         !_ontapRow1Column1Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow1Column1Index1 == true
//                                               ? row1col1in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row1col1in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row1col1in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row1col1in1[0].name,
//                                         ),
//                                   row0col1in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col1in1[0].length,
//                                           ladiesColor:
//                                               row0col1in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row0col1in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow0Column1Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col1in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col1in1[0]
//                                                                       .name,
//                                                               ladies: row0col1in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row0col1in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow0Column1Index1 =
//                                                         !_ontapRow0Column1Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow0Column1Index1 == true
//                                               ? row0col1in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col1in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col1in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col1in1[0].name,
//                                         ),
//                                 ],
//                               ),
//                               ///////////  /////////////////////////////// column 22222222222222222
//                               Row(
//                                 children: [
//                                   row5col2in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row5col2in1[0].length,
//                                           ladiesColor:
//                                               row5col2in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row5col2in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow5Column2Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row5col2in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row5col2in1[0]
//                                                                       .name,
//                                                               ladies: row5col2in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row5col2in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow5Column2Index1 =
//                                                         !_ontapRow5Column2Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow5Column2Index1 == true
//                                               ? row5col2in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row5col2in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row5col2in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row5col2in1[0].name,
//                                         ),
//                                   row4col2in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row4col2in1[0].length,
//                                           ladiesColor:
//                                               row4col2in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row4col2in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow4Column2Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col2in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col2in1[0]
//                                                                       .name,
//                                                               ladies: row4col2in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row4col2in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow4Column2Index1 =
//                                                         !_ontapRow4Column2Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow4Column2Index1 == true
//                                               ? row4col2in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col2in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col2in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col2in1[0].name,
//                                         ),
//                                   row3col2in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row3col2in1[0].length,
//                                           ladiesColor:
//                                               row3col2in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row3col2in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow3Column2Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row3col2in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row3col2in1[0]
//                                                                       .name,
//                                                               ladies: row3col2in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row3col2in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow3Column2Index1 =
//                                                         !_ontapRow3Column2Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow3Column2Index1 == true
//                                               ? row3col2in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row3col2in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row3col2in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row3col2in1[0].name,
//                                         ),
//                                   row2col2in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row2col2in1[0].length,
//                                           ladiesColor:
//                                               row2col2in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row2col2in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow2Column2Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row2col2in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row2col2in1[0]
//                                                                       .name,
//                                                               ladies: row2col2in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row2col2in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow2Column2Index1 =
//                                                         !_ontapRow2Column2Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow2Column2Index1 == true
//                                               ? row2col2in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row2col2in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row2col2in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row2col2in1[0].name,
//                                         ),
//                                   row1col2in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row1col2in1[0].length,
//                                           ladiesColor:
//                                               row1col2in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row1col2in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow1Column2Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row1col2in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row1col2in1[0]
//                                                                       .name,
//                                                               ladies: row1col2in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row1col2in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow1Column2Index1 =
//                                                         !_ontapRow1Column2Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow1Column2Index1 == true
//                                               ? row1col2in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row1col2in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row1col2in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row1col2in1[0].name,
//                                         ),
//                                   row0col2in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col2in1[0].length,
//                                           ladiesColor:
//                                               row0col2in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row0col2in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow0Column2Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col2in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col2in1[0]
//                                                                       .name,
//                                                               ladies: row0col2in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row0col2in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow0Column2Index1 =
//                                                         !_ontapRow0Column2Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow0Column2Index1 == true
//                                               ? row0col2in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col2in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col2in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col2in1[0].name,
//                                         ),
//                                 ],
//                               ),
//                               ///////////////////// 3333333333333333333333333333333
//                               Row(
//                                 children: [
//                                   row5col3in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row5col3in1[0].length,
//                                           ladiesColor:
//                                               row5col3in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row5col3in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow5Column3Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row5col3in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row5col3in1[0]
//                                                                       .name,
//                                                               ladies: row5col3in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row5col3in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow5Column3Index1 =
//                                                         !_ontapRow5Column3Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow5Column3Index1 == true
//                                               ? row5col3in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row5col3in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row5col3in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row5col3in1[0].name,
//                                         ),
//                                   row4col3in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row4col3in1[0].length,
//                                           ladiesColor:
//                                               row4col3in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row4col3in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow4Column3Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col3in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col3in1[0]
//                                                                       .name,
//                                                               ladies: row4col3in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row4col3in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow4Column3Index1 =
//                                                         !_ontapRow4Column3Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow4Column3Index1 == true
//                                               ? row4col3in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col3in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col3in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col3in1[0].name,
//                                         ),
//                                   row3col3in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row3col3in1[0].length,
//                                           ladiesColor:
//                                               row3col3in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row3col3in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow3Column3Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row3col3in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row3col3in1[0]
//                                                                       .name,
//                                                               ladies: row3col3in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row3col3in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow3Column3Index1 =
//                                                         !_ontapRow3Column3Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow3Column3Index1 == true
//                                               ? row3col3in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row3col3in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row3col3in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row3col3in1[0].name,
//                                         ),
//                                   row2col3in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row2col3in1[0].length,
//                                           ladiesColor:
//                                               row2col3in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row2col3in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow2Column3Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row2col3in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row2col3in1[0]
//                                                                       .name,
//                                                               ladies: row2col3in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row2col3in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow2Column3Index1 =
//                                                         !_ontapRow2Column3Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow2Column3Index1 == true
//                                               ? row2col3in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row2col3in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row2col3in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row2col3in1[0].name,
//                                         ),
//                                   row1col3in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row1col3in1[0].length,
//                                           ladiesColor:
//                                               row1col3in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row1col3in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow1Column3Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row1col3in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row1col3in1[0]
//                                                                       .name,
//                                                               ladies: row1col3in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row1col3in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow1Column3Index1 =
//                                                         !_ontapRow1Column3Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow1Column3Index1 == true
//                                               ? row1col3in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row1col3in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row1col3in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row1col3in1[0].name,
//                                         ),
//                                   row0col3in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col3in1[0].length,
//                                           ladiesColor:
//                                               row0col3in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row0col3in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow0Column3Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col3in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col3in1[0]
//                                                                       .name,
//                                                               ladies: row0col3in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row0col3in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow0Column3Index1 =
//                                                         !_ontapRow0Column3Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow0Column3Index1 == true
//                                               ? row0col3in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col3in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col3in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col3in1[0].name,
//                                         ),
//                                 ],
//                               ),
//                               ////////////// 44444444444444444444444444444444 /////////////
//                               Row(
//                                 children: [
//                                   row5col4in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row5col4in1[0].length,
//                                           ladiesColor:
//                                               row5col4in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row5col4in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow5Column4Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row5col4in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row5col4in1[0]
//                                                                       .name,
//                                                               ladies: row5col4in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row5col4in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow5Column4Index1 =
//                                                         !_ontapRow5Column4Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow5Column4Index1 == true
//                                               ? row5col4in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row5col4in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row5col4in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row5col4in1[0].name,
//                                         ),
//                                   row4col4in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row4col4in1[0].length,
//                                           ladiesColor:
//                                               row4col4in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row4col4in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow4Column4Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col4in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col4in1[0]
//                                                                       .name,
//                                                               ladies: row4col4in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row4col4in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow4Column4Index1 =
//                                                         !_ontapRow4Column4Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow4Column4Index1 == true
//                                               ? row4col4in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col4in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col4in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col4in1[0].name,
//                                         ),
//                                   row3col4in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row3col4in1[0].length,
//                                           ladiesColor:
//                                               row3col4in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row3col4in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow3Column4Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row3col4in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row3col4in1[0]
//                                                                       .name,
//                                                               ladies: row3col4in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row3col4in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow3Column4Index1 =
//                                                         !_ontapRow3Column4Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow3Column4Index1 == true
//                                               ? row3col4in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row3col4in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row3col4in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row3col4in1[0].name,
//                                         ),
//                                   row2col4in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       :

//                                       //  Padding(
//                                       //     padding: const EdgeInsets.all(4.0),
//                                       //     child: GestureDetector(
//                                       //       onTap: row2col4in1[0].available ==
//                                       //               'true'
//                                       //           ? () {
//                                       //               print('onTap');
//                                       //               setState(() {
//                                       //                 _ontapRow2Column4Index1 =
//                                       //                     !_ontapRow2Column4Index1;
//                                       //               });
//                                       //             }
//                                       //           : () {},
//                                       //       child: Container(
//                                       //         decoration: BoxDecoration(
//                                       //           color: _ontapRow2Column4Index1 ==
//                                       //                   true
//                                       //               ? row2col4in1[0].ladiesSeat ==
//                                       //                           'true' &&
//                                       //                       row2col4in1[0]
//                                       //                               .available ==
//                                       //                           'false'
//                                       //                   ? Colors.pink
//                                       //                   : row2col4in1[0]
//                                       //                               .available ==
//                                       //                           'false'
//                                       //                       ? Colors.grey
//                                       //                       : Colors.white
//                                       //               : Colors.green,
//                                       //           border: Border.all(
//                                       //             width: 1.1,
//                                       //             color: row2col4in1[0]
//                                       //                         .ladiesSeat ==
//                                       //                     'true'
//                                       //                 ? Colors.pink
//                                       //                 : Colors.black,
//                                       //           ),
//                                       //           borderRadius:
//                                       //               BorderRadius.circular(5),
//                                       //         ),
//                                       //         height: 44.5 *
//                                       //             double.parse(
//                                       //                 row2col4in1[0].length),
//                                       //         width: 51,
//                                       //         child: Column(
//                                       //           mainAxisAlignment:
//                                       //               MainAxisAlignment.center,
//                                       //           children: [
//                                       //             Text(
//                                       //               row2col4in1[0].name,
//                                       //               style: TextStyle(
//                                       //                   fontWeight:
//                                       //                       FontWeight.bold),
//                                       //             ),
//                                       //           ],
//                                       //         ),
//                                       //       ),
//                                       //     ),
//                                       //   ),
//                                       SeatContainerModelLength(
//                                           length: row2col4in1[0].length,
//                                           ladiesColor:
//                                               row2col4in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row2col4in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow2Column4Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row2col4in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row2col4in1[0]
//                                                                       .name,
//                                                               ladies: row2col4in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row2col4in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow2Column4Index1 =
//                                                         !_ontapRow2Column4Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow2Column4Index1 == true
//                                               ? row2col4in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row2col4in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row2col4in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row2col4in1[0].name,
//                                         ),
//                                   row1col4in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row1col4in1[0].length,
//                                           ladiesColor:
//                                               row1col4in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row1col4in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow1Column4Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row1col4in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row1col4in1[0]
//                                                                       .name,
//                                                               ladies: row1col4in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row1col4in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow1Column4Index1 =
//                                                         !_ontapRow1Column4Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow1Column4Index1 == true
//                                               ? row1col4in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row1col4in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row1col4in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row1col4in1[0].name,
//                                         ),
//                                   row0col4in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col4in1[0].length,
//                                           ladiesColor:
//                                               row0col4in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row0col4in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow0Column4Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col4in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col4in1[0]
//                                                                       .name,
//                                                               ladies: row0col4in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row0col4in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow0Column4Index1 =
//                                                         !_ontapRow0Column4Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow0Column4Index1 == true
//                                               ? row0col4in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col4in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col4in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col4in1[0].name,
//                                         ),
//                                 ],
//                               ),
//                               ///////////////// 55555555555555555555555
//                               Row(
//                                 children: [
//                                   row5col5in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row5col5in1[0].length,
//                                           ladiesColor:
//                                               row5col5in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row5col5in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow5Column5Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row5col5in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row5col5in1[0]
//                                                                       .name,
//                                                               ladies: row5col5in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row5col5in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow5Column5Index1 =
//                                                         !_ontapRow5Column5Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow5Column5Index1 == true
//                                               ? row5col5in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row5col5in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row5col5in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row5col5in1[0].name,
//                                         ),
//                                   row4col5in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row4col5in1[0].length,
//                                           ladiesColor:
//                                               row4col5in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row4col5in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow4Column5Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col5in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col5in1[0]
//                                                                       .name,
//                                                               ladies: row4col5in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row4col5in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow4Column5Index1 =
//                                                         !_ontapRow4Column5Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow4Column5Index1 == true
//                                               ? row4col5in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col5in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col5in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col5in1[0].name,
//                                         ),
//                                   row3col5in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row3col5in1[0].length,
//                                           ladiesColor:
//                                               row3col5in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row3col5in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow3Column5Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row3col5in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row3col5in1[0]
//                                                                       .name,
//                                                               ladies: row3col5in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row3col5in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow3Column5Index1 =
//                                                         !_ontapRow3Column5Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow3Column5Index1 == true
//                                               ? row3col5in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row3col5in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row3col5in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row3col5in1[0].name,
//                                         ),
//                                   row2col5in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row2col5in1[0].length,
//                                           ladiesColor:
//                                               row2col5in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row2col5in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow2Column5Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row2col5in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row2col5in1[0]
//                                                                       .name,
//                                                               ladies: row2col5in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row2col5in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow2Column5Index1 =
//                                                         !_ontapRow2Column5Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow2Column5Index1 == true
//                                               ? row2col5in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row2col5in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row2col5in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row2col5in1[0].name,
//                                         ),
//                                   row1col5in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row1col5in1[0].length,
//                                           ladiesColor:
//                                               row1col5in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row1col5in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow1Column5Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row1col5in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row1col5in1[0]
//                                                                       .name,
//                                                               ladies: row1col5in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row1col5in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow1Column5Index1 =
//                                                         !_ontapRow1Column5Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow1Column5Index1 == true
//                                               ? row1col5in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row1col5in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row1col5in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row1col5in1[0].name,
//                                         ),
//                                   row0col5in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col5in1[0].length,
//                                           ladiesColor:
//                                               row0col5in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row0col5in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow0Column5Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col5in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col5in1[0]
//                                                                       .name,
//                                                               ladies: row0col5in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row0col5in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow0Column5Index1 =
//                                                         !_ontapRow0Column5Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow0Column5Index1 == true
//                                               ? row0col5in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col5in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col5in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col5in1[0].name,
//                                         ),
//                                 ],
//                               ),
//                               //////////////666666666666666666666666
//                               Row(
//                                 children: [
//                                   row5col6in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row5col6in1[0].length,
//                                           ladiesColor:
//                                               row5col6in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row5col6in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow5Column6Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row5col6in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row5col6in1[0]
//                                                                       .name,
//                                                               ladies: row5col6in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row5col6in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow5Column6Index1 =
//                                                         !_ontapRow5Column6Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow5Column6Index1 == true
//                                               ? row5col6in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row5col6in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row5col6in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row5col6in1[0].name,
//                                         ),
//                                   row4col6in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row4col6in1[0].length,
//                                           ladiesColor:
//                                               row4col6in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row4col6in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow4Column6Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col6in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col6in1[0]
//                                                                       .name,
//                                                               ladies: row4col6in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row4col6in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow4Column6Index1 =
//                                                         !_ontapRow4Column6Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow4Column6Index1 == true
//                                               ? row4col6in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col6in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col6in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col6in1[0].name,
//                                         ),
//                                   row3col6in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row3col6in1[0].length,
//                                           ladiesColor:
//                                               row3col6in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row3col6in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow3Column6Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row3col6in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row3col6in1[0]
//                                                                       .name,
//                                                               ladies: row3col6in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row3col6in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow3Column6Index1 =
//                                                         !_ontapRow3Column6Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow3Column6Index1 == true
//                                               ? row3col6in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row3col6in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row3col6in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row3col6in1[0].name,
//                                         ),
//                                   row2col6in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row2col6in1[0].length,
//                                           ladiesColor:
//                                               row2col6in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row2col6in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow2Column6Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row2col6in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row2col6in1[0]
//                                                                       .name,
//                                                               ladies: row2col6in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row2col6in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow2Column6Index1 =
//                                                         !_ontapRow2Column6Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow2Column6Index1 == true
//                                               ? row2col6in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row2col6in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row2col6in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row2col6in1[0].name,
//                                         ),
//                                   row1col6in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row1col6in1[0].length,
//                                           ladiesColor:
//                                               row1col6in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row1col6in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow1Column6Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row1col6in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row1col6in1[0]
//                                                                       .name,
//                                                               ladies: row1col6in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row1col6in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow1Column6Index1 =
//                                                         !_ontapRow1Column6Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow1Column6Index1 == true
//                                               ? row1col6in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row1col6in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row1col6in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row1col6in1[0].name,
//                                         ),
//                                   row0col6in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col6in1[0].length,
//                                           ladiesColor:
//                                               row0col6in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row0col6in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow0Column6Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col6in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col6in1[0]
//                                                                       .name,
//                                                               ladies: row0col6in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row0col6in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow0Column6Index1 =
//                                                         !_ontapRow0Column6Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow0Column6Index1 == true
//                                               ? row0col6in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col6in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col6in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col6in1[0].name,
//                                         ),
//                                 ],
//                               ),
//                               /////////////////77777777777777777777777777
//                               Row(
//                                 children: [
//                                   row5col7in1.toString() == '[]'
//                                       ? Text19Black(test: '')
//                                       : SeatContainerModelLength(
//                                           length: row5col7in1[0].length,
//                                           ladiesColor:
//                                               row5col7in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row5col7in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow5Column7Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row5col7in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row5col7in1[0]
//                                                                       .name,
//                                                               ladies: row5col7in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row5col7in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow5Column7Index1 =
//                                                         !_ontapRow5Column7Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow5Column7Index1 == true
//                                               ? row5col7in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row5col7in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row5col7in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row5col7in1[0].name,
//                                         ),
//                                   row4col7in1.toString() == '[]'
//                                       ? Text19Black(test: '')
//                                       : SeatContainerModelLength(
//                                           length: row4col7in1[0].length,
//                                           ladiesColor:
//                                               row4col7in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row4col7in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow4Column7Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col7in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col7in1[0]
//                                                                       .name,
//                                                               ladies: row4col7in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row4col7in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow4Column7Index1 =
//                                                         !_ontapRow4Column7Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow4Column7Index1 == true
//                                               ? row4col7in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col7in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col7in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col7in1[0].name,
//                                         ),
//                                   row3col7in1.toString() == '[]'
//                                       ? Text19Black(test: '')
//                                       : SeatContainerModelLength(
//                                           length: row3col7in1[0].length,
//                                           ladiesColor:
//                                               row3col7in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row3col7in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow3Column7Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row3col7in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row3col7in1[0]
//                                                                       .name,
//                                                               ladies: row3col7in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row3col7in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow3Column7Index1 =
//                                                         !_ontapRow3Column7Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow3Column7Index1 == true
//                                               ? row3col7in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row3col7in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row3col7in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row3col7in1[0].name,
//                                         ),
//                                   row2col7in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row2col7in1[0].length,
//                                           ladiesColor:
//                                               row2col7in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row2col7in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow2Column7Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row2col7in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row2col7in1[0]
//                                                                       .name,
//                                                               ladies: row2col7in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row2col7in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow2Column7Index1 =
//                                                         !_ontapRow2Column7Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow2Column7Index1 == true
//                                               ? row2col7in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row2col7in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row2col7in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row2col7in1[0].name,
//                                         ),
//                                   row1col7in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row1col7in1[0].length,
//                                           ladiesColor:
//                                               row1col7in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row1col7in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow1Column7Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row1col7in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row1col7in1[0]
//                                                                       .name,
//                                                               ladies: row1col7in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row1col7in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow1Column7Index1 =
//                                                         !_ontapRow1Column7Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow1Column7Index1 == true
//                                               ? row1col7in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row1col7in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row1col7in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row1col7in1[0].name,
//                                         ),
//                                   row0col7in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col7in1[0].length,
//                                           ladiesColor:
//                                               row0col7in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row0col7in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow0Column7Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col7in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col7in1[0]
//                                                                       .name,
//                                                               ladies: row0col7in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row0col7in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow0Column7Index1 =
//                                                         !_ontapRow0Column7Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow0Column7Index1 == true
//                                               ? row0col7in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col7in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col7in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col7in1[0].name,
//                                         ),
//                                 ],
//                               ),

//                               ///
//                               /////
//                               /////8888888888888888888888888888888888888888888888888
//                               Row(
//                                 children: [
//                                   row5col8in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row5col8in1[0].length,
//                                           ladiesColor:
//                                               row5col8in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row5col8in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow5Column8Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row5col8in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row5col8in1[0]
//                                                                       .name,
//                                                               ladies: row5col8in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row5col8in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow5Column8Index1 =
//                                                         !_ontapRow5Column8Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow5Column8Index1 == true
//                                               ? row5col8in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row5col8in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row5col8in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row5col8in1[0].name,
//                                         ),
//                                   row4col8in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row4col8in1[0].length,
//                                           ladiesColor:
//                                               row4col8in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row4col8in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow4Column8Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col8in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col8in1[0]
//                                                                       .name,
//                                                               ladies: row4col8in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row4col8in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow4Column8Index1 =
//                                                         !_ontapRow4Column8Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow4Column8Index1 == true
//                                               ? row4col8in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col8in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col8in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col8in1[0].name,
//                                         ),
//                                   row3col8in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row3col8in1[0].length,
//                                           ladiesColor:
//                                               row3col8in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row3col8in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow3Column8Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row3col8in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row3col8in1[0]
//                                                                       .name,
//                                                               ladies: row3col8in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row3col8in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow3Column8Index1 =
//                                                         !_ontapRow3Column8Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow3Column8Index1 == true
//                                               ? row3col8in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row3col8in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row3col8in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row3col8in1[0].name,
//                                         ),
//                                   row2col8in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row2col8in1[0].length,
//                                           ladiesColor:
//                                               row2col8in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row2col8in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow2Column8Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row2col8in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row2col8in1[0]
//                                                                       .name,
//                                                               ladies: row2col8in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row2col8in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow2Column8Index1 =
//                                                         !_ontapRow2Column8Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow2Column8Index1 == true
//                                               ? row2col8in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row2col8in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row2col8in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row2col8in1[0].name,
//                                         ),
//                                   row1col8in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row1col8in1[0].length,
//                                           ladiesColor:
//                                               row1col8in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row1col8in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow1Column8Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row1col8in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row1col8in1[0]
//                                                                       .name,
//                                                               ladies: row1col8in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row1col8in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow1Column8Index1 =
//                                                         !_ontapRow1Column8Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow1Column8Index1 == true
//                                               ? row1col8in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row1col8in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row1col8in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row1col8in1[0].name,
//                                         ),
//                                   row0col8in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col8in1[0].length,
//                                           ladiesColor:
//                                               row0col8in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row0col8in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow0Column8Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col8in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col8in1[0]
//                                                                       .name,
//                                                               ladies: row0col8in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row0col8in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow0Column8Index1 =
//                                                         !_ontapRow0Column8Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow0Column8Index1 == true
//                                               ? row0col8in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col8in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col8in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col8in1[0].name,
//                                         ),
//                                 ],
//                               ),
//                               /////////////
//                               ///
//                               /// Rowww 99999999999999999999999999999999
//                               Row(
//                                 children: [
//                                   row5col9in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row5col9in1[0].length,
//                                           ladiesColor:
//                                               row5col9in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row5col9in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow5Column9Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row5col9in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row5col9in1[0]
//                                                                       .name,
//                                                               ladies: row5col9in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row5col9in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow5Column9Index1 =
//                                                         !_ontapRow5Column9Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow5Column9Index1 == true
//                                               ? row5col9in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row5col9in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row5col9in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row5col9in1[0].name,
//                                         ),
//                                   row4col9in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row4col9in1[0].length,
//                                           ladiesColor:
//                                               row4col9in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row4col9in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow4Column9Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col9in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col9in1[0]
//                                                                       .name,
//                                                               ladies: row4col9in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row4col9in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow4Column9Index1 =
//                                                         !_ontapRow4Column9Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow4Column9Index1 == true
//                                               ? row4col9in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col9in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col9in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col9in1[0].name,
//                                         ),
//                                   row3col9in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row3col9in1[0].length,
//                                           ladiesColor:
//                                               row3col9in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row3col9in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow3Column9Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row3col9in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row3col9in1[0]
//                                                                       .name,
//                                                               ladies: row3col9in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row3col9in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow3Column9Index1 =
//                                                         !_ontapRow3Column9Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow3Column9Index1 == true
//                                               ? row3col9in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row3col9in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row3col9in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row3col9in1[0].name,
//                                         ),
//                                   row2col9in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row2col9in1[0].length,
//                                           ladiesColor:
//                                               row2col9in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row2col9in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow2Column9Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row2col9in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row2col9in1[0]
//                                                                       .name,
//                                                               ladies: row2col9in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row2col9in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow2Column9Index1 =
//                                                         !_ontapRow2Column9Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow2Column9Index1 == true
//                                               ? row2col9in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row2col9in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row2col9in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row2col9in1[0].name,
//                                         ),
//                                   row1col9in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row1col9in1[0].length,
//                                           ladiesColor:
//                                               row1col9in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row1col9in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow1Column9Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row1col9in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row1col9in1[0]
//                                                                       .name,
//                                                               ladies: row1col9in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row1col9in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow1Column9Index1 =
//                                                         !_ontapRow1Column9Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow1Column9Index1 == true
//                                               ? row1col9in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row1col9in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row1col9in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row1col9in1[0].name,
//                                         ),
//                                   row0col9in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col9in1[0].length,
//                                           ladiesColor:
//                                               row0col9in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row0col9in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow0Column9Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col9in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col9in1[0]
//                                                                       .name,
//                                                               ladies: row0col9in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row0col9in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow0Column9Index1 =
//                                                         !_ontapRow0Column9Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow0Column9Index1 == true
//                                               ? row0col9in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col9in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col9in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col9in1[0].name,
//                                         ),
//                                 ],
//                               ),
//                               //1111111111110000000000000000000
//                               Row(
//                                 children: [
//                                   row5col10in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row5col10in1[0].length,
//                                           ladiesColor:
//                                               row5col10in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row5col10in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow5Column10Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row5col10in1[
//                                                                           0]
//                                                                       .fare,
//                                                               name:
//                                                                   row5col9in1[0]
//                                                                       .name,
//                                                               ladies: row5col10in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row5col10in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow5Column10Index1 =
//                                                         !_ontapRow5Column10Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow5Column10Index1 ==
//                                                   true
//                                               ? row5col10in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row5col10in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row5col10in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row5col10in1[0].name,
//                                         ),
//                                   row4col10in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row4col10in1[0].length,
//                                           ladiesColor:
//                                               row4col10in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row4col10in1[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   _ontapRow4Column10Index1 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col10in1[
//                                                                           0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col9in1[0]
//                                                                       .name,
//                                                               ladies: row4col10in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row4col10in1[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow4Column10Index1 =
//                                                         !_ontapRow4Column10Index1;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow4Column10Index1 ==
//                                                   true
//                                               ? row4col10in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col10in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col10in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col10in1[0].name,
//                                         ),
//                                   row3col10in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : row3col10in1[0].length == '2'
//                                           ? SeatContainerModelLength(
//                                               length: row3col10in1[0].length,
//                                               ladiesColor:
//                                                   row3col10in1[0].ladiesSeat ==
//                                                           'true'
//                                                       ? Colors.pink
//                                                       : Colors.black,
//                                               onTap:
//                                                   row5col10in1[0].available ==
//                                                           'true'
//                                                       ? () {
//                                                           _ontapRow3Column10Index1 ==
//                                                                   true
//                                                               ? listSeatNameClass.add(ListOfSeatClass(
//                                                                   fareSeat:
//                                                                       row3col10in1[0]
//                                                                           .fare,
//                                                                   name:
//                                                                       row3col10in1[0]
//                                                                           .name,
//                                                                   ladies: row3col10in1[0]
//                                                                               .ladiesSeat ==
//                                                                           'true'
//                                                                       ? 'true'
//                                                                       : 'false'))
//                                                               : listSeatNameClass
//                                                                   .removeWhere((item) =>
//                                                                       item.name ==
//                                                                       row3col10in1[
//                                                                               0]
//                                                                           .name);

//                                                           setState(() {
//                                                             _ontapRow3Column10Index1 =
//                                                                 !_ontapRow3Column10Index1;
//                                                           });
//                                                         }
//                                                       : () {},
//                                               color: _ontapRow3Column10Index1 ==
//                                                       true
//                                                   ? row3col10in1[0]
//                                                                   .ladiesSeat ==
//                                                               'true' &&
//                                                           row3col10in1[0]
//                                                                   .available ==
//                                                               'false'
//                                                       ? Colors.pink
//                                                       : row3col10in1[0]
//                                                                   .available ==
//                                                               'false'
//                                                           ? Colors.grey
//                                                           : Colors.white
//                                                   : Colors.green,
//                                               listObj: row3col10in1[0].name,
//                                             )
//                                           : SeatContainerModelWidth(
//                                               width: row3col10in1[0].width,
//                                               ladiesColor:
//                                                   row3col10in1[0].ladiesSeat ==
//                                                           'true'
//                                                       ? Colors.pink
//                                                       : Colors.black,
//                                               onTap:
//                                                   row3col10in1[0].available ==
//                                                           'true'
//                                                       ? () {
//                                                           _ontapRow3Column10Index1 ==
//                                                                   true
//                                                               ? listSeatNameClass.add(ListOfSeatClass(
//                                                                   fareSeat:
//                                                                       row3col10in1[0]
//                                                                           .fare,
//                                                                   name:
//                                                                       row3col10in1[0]
//                                                                           .name,
//                                                                   ladies: row3col10in1[0]
//                                                                               .ladiesSeat ==
//                                                                           'true'
//                                                                       ? 'true'
//                                                                       : 'false'))
//                                                               : listSeatNameClass
//                                                                   .removeWhere((item) =>
//                                                                       item.name ==
//                                                                       row3col10in1[
//                                                                               0]
//                                                                           .name);

//                                                           setState(() {
//                                                             _ontapRow3Column10Index1 =
//                                                                 !_ontapRow3Column10Index1;
//                                                           });
//                                                         }
//                                                       : () {},
//                                               color: _ontapRow3Column10Index1 ==
//                                                       true
//                                                   ? row3col10in1[0]
//                                                                   .ladiesSeat ==
//                                                               'true' &&
//                                                           row3col10in1[0]
//                                                                   .available ==
//                                                               'false'
//                                                       ? Colors.pink
//                                                       : row3col10in1[0]
//                                                                   .available ==
//                                                               'false'
//                                                           ? Colors.grey
//                                                           : Colors.white
//                                                   : Colors.green,
//                                               listObj: row3col10in1[0].name,
//                                             ),
//                                   row2col10in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row2col10in1[0].length,
//                                           ladiesColor:
//                                               row2col10in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row2col10in1[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       _ontapRow2Column10Index1 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row2col10in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row2col10in1[0]
//                                                                       .name,
//                                                               ladies: row2col10in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row2col10in1[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow2Column10Index1 =
//                                                             !_ontapRow2Column10Index1;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow2Column10Index1 ==
//                                                   true
//                                               ? row2col10in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row2col10in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row2col10in1[0].available ==
//                                                           'false' ///////////////////
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row2col10in1[0].name,
//                                         ),
//                                   row1col10in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row1col10in1[0].length,
//                                           ladiesColor:
//                                               row1col10in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row1col10in1[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       _ontapRow1Column10Index1 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row1col10in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row1col10in1[0]
//                                                                       .name,
//                                                               ladies: row1col10in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row1col10in1[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow1Column10Index1 =
//                                                             !_ontapRow1Column10Index1;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow1Column10Index1 ==
//                                                   true
//                                               ? row1col10in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row1col10in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row1col10in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row1col10in1[0].name,
//                                         ),
//                                   row0col10in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col10in1[0].length,
//                                           ladiesColor:
//                                               row0col10in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row0col10in1[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       _ontapRow5Column10Index1 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col10in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col10in1[0]
//                                                                       .name,
//                                                               ladies: row0col10in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row0col10in1[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow0Column10Index1 =
//                                                             !_ontapRow0Column10Index1;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow0Column10Index1 ==
//                                                   true
//                                               ? row0col10in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col10in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col10in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col10in1[0].name,
//                                         ),
//                                 ],
//                               ),
//                               //
//                               //111111111111111111111111111111111111111
//                               Row(
//                                 children: [
//                                   row5col11in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row5col11in1[0].length,
//                                           ladiesColor:
//                                               row5col11in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row5col11in1[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       _ontapRow5Column11Index1 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row5col11in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row5col11in1[0]
//                                                                       .name,
//                                                               ladies: row5col11in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row5col11in1[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow5Column11Index1 =
//                                                             !_ontapRow5Column11Index1;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow5Column11Index1 ==
//                                                   true
//                                               ? row5col11in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row5col11in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row5col11in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row5col11in1[0].name,
//                                         ),
//                                   row4col11in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row4col11in1[0].length,
//                                           ladiesColor:
//                                               row4col11in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row4col11in1[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       _ontapRow4Column11Index1 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col11in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col11in1[0]
//                                                                       .name,
//                                                               ladies: row4col11in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row4col11in1[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow4Column11Index1 =
//                                                             !_ontapRow4Column11Index1;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow4Column11Index1 ==
//                                                   true
//                                               ? row4col11in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col11in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col11in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col11in1[0].name,
//                                         ),
//                                   row3col11in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row3col11in1[0].length,
//                                           ladiesColor:
//                                               row3col11in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row3col11in1[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       _ontapRow3Column11Index1 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row3col11in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row3col11in1[0]
//                                                                       .name,
//                                                               ladies: row3col11in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row3col11in1[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow3Column11Index1 =
//                                                             !_ontapRow3Column11Index1;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow3Column11Index1 ==
//                                                   true
//                                               ? row3col11in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row3col11in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row3col11in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row3col11in1[0].name,
//                                         ),
//                                   row2col11in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row2col11in1[0].length,
//                                           ladiesColor:
//                                               row2col11in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row2col11in1[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       _ontapRow2Column11Index1 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row2col11in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row2col11in1[0]
//                                                                       .name,
//                                                               ladies: row2col11in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row2col11in1[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow2Column11Index1 =
//                                                             !_ontapRow2Column11Index1;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow2Column11Index1 ==
//                                                   true
//                                               ? row2col11in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row2col11in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row2col11in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row2col11in1[0].name,
//                                         ),
//                                   row1col11in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row1col11in1[0].length,
//                                           ladiesColor:
//                                               row1col11in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row1col11in1[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       _ontapRow1Column11Index1 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row1col11in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row1col11in1[0]
//                                                                       .name,
//                                                               ladies: row1col11in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row1col11in1[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow1Column11Index1 =
//                                                             !_ontapRow1Column11Index1;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow1Column11Index1 ==
//                                                   true
//                                               ? row1col11in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row1col11in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row1col11in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row1col11in1[0].name,
//                                         ),
//                                   row0col11in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col11in1[0].length,
//                                           ladiesColor:
//                                               row0col11in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row0col11in1[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       _ontapRow0Column11Index1 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col11in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col11in1[0]
//                                                                       .name,
//                                                               ladies: row0col11in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row0col11in1[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow0Column11Index1 =
//                                                             !_ontapRow0Column11Index1;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow0Column11Index1 ==
//                                                   true
//                                               ? row0col11in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col11in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col11in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col11in1[0].name,
//                                         ),
//                                 ],
//                               ),

//                               ///
//                               /////12
//                               Row(
//                                 children: [
//                                   row5col12in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row5col12in1[0].length,
//                                           ladiesColor:
//                                               row5col12in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row5col12in1[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       _ontapRow5Column12Index1 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row5col12in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row5col12in1[0]
//                                                                       .name,
//                                                               ladies: row5col12in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row5col12in1[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow5Column12Index1 =
//                                                             !_ontapRow5Column12Index1;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow5Column12Index1 ==
//                                                   true
//                                               ? row5col12in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row5col12in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row5col12in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row5col12in1[0].name,
//                                         ),
//                                   row4col12in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row4col12in1[0].length,
//                                           ladiesColor:
//                                               row4col12in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row4col12in1[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       _ontapRow4Column12Index1 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col12in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col12in1[0]
//                                                                       .name,
//                                                               ladies: row4col12in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row4col12in1[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow4Column12Index1 =
//                                                             !_ontapRow4Column12Index1;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow4Column12Index1 ==
//                                                   true
//                                               ? row4col12in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col12in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col12in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col12in1[0].name,
//                                         ),
//                                   row3col12in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row3col12in1[0].length,
//                                           ladiesColor:
//                                               row3col12in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row3col12in1[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       _ontapRow3Column12Index1 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row3col12in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row3col12in1[0]
//                                                                       .name,
//                                                               ladies: row3col12in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row3col12in1[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow3Column12Index1 =
//                                                             !_ontapRow3Column12Index1;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow3Column12Index1 ==
//                                                   true
//                                               ? row3col12in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row3col12in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row3col12in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row3col12in1[0].name,
//                                         ),
//                                   row2col12in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : row2col12in1[0].length == '2'
//                                           ? SeatContainerModelLength(
//                                               length: row2col12in1[0].length,
//                                               ladiesColor:
//                                                   row2col12in1[0].ladiesSeat ==
//                                                           'true'
//                                                       ? Colors.pink
//                                                       : Colors.black,
//                                               onTap:
//                                                   row2col12in1[0].available ==
//                                                           'true'
//                                                       ? () {
//                                                           _ontapRow2Column12Index1 ==
//                                                                   true
//                                                               ? listSeatNameClass.add(ListOfSeatClass(
//                                                                   fareSeat:
//                                                                       row2col12in1[0]
//                                                                           .fare,
//                                                                   name:
//                                                                       row2col12in1[0]
//                                                                           .name,
//                                                                   ladies: row2col12in1[0]
//                                                                               .ladiesSeat ==
//                                                                           'true'
//                                                                       ? 'true'
//                                                                       : 'false'))
//                                                               : listSeatNameClass
//                                                                   .removeWhere((item) =>
//                                                                       item.name ==
//                                                                       row2col12in1[
//                                                                               0]
//                                                                           .name);

//                                                           setState(() {
//                                                             _ontapRow2Column12Index1 =
//                                                                 !_ontapRow2Column12Index1;
//                                                           });
//                                                         }
//                                                       : () {},
//                                               color: _ontapRow2Column12Index1 ==
//                                                       true
//                                                   ? row2col12in1[0]
//                                                                   .ladiesSeat ==
//                                                               'true' &&
//                                                           row2col12in1[0]
//                                                                   .available ==
//                                                               'false'
//                                                       ? Colors.pink
//                                                       : row2col12in1[0]
//                                                                   .available ==
//                                                               'false'
//                                                           ? Colors.grey
//                                                           : Colors.white
//                                                   : Colors.green,
//                                               listObj: row2col12in1[0].name,
//                                             )
//                                           : SeatContainerModelWidth(
//                                               width: row2col12in1[0].width,
//                                               ladiesColor:
//                                                   row2col12in1[0].ladiesSeat ==
//                                                           'true'
//                                                       ? Colors.pink
//                                                       : Colors.black,
//                                               onTap:
//                                                   row2col12in1[0].available ==
//                                                           'true'
//                                                       ? () {
//                                                           _ontapRow2Column12Index1 ==
//                                                                   true
//                                                               ? listSeatNameClass.add(ListOfSeatClass(
//                                                                   fareSeat:
//                                                                       row2col12in1[0]
//                                                                           .fare,
//                                                                   name:
//                                                                       row2col12in1[0]
//                                                                           .name,
//                                                                   ladies: row2col12in1[0]
//                                                                               .ladiesSeat ==
//                                                                           'true'
//                                                                       ? 'true'
//                                                                       : 'false'))
//                                                               : listSeatNameClass
//                                                                   .removeWhere((item) =>
//                                                                       item.name ==
//                                                                       row2col12in1[
//                                                                               0]
//                                                                           .name);

//                                                           setState(() {
//                                                             _ontapRow2Column12Index1 =
//                                                                 !_ontapRow2Column12Index1;
//                                                           });
//                                                         }
//                                                       : () {},
//                                               color: _ontapRow2Column12Index1 ==
//                                                       true
//                                                   ? row2col12in1[0]
//                                                                   .ladiesSeat ==
//                                                               'true' &&
//                                                           row2col12in1[0]
//                                                                   .available ==
//                                                               'false'
//                                                       ? Colors.pink
//                                                       : row2col12in1[0]
//                                                                   .available ==
//                                                               'false'
//                                                           ? Colors.grey
//                                                           : Colors.white
//                                                   : Colors.green,
//                                               listObj: row2col12in1[0].name,
//                                             ),
//                                   row1col12in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row1col12in1[0].length,
//                                           ladiesColor:
//                                               row1col12in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row1col12in1[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       _ontapRow1Column12Index1 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row1col12in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row1col12in1[0]
//                                                                       .name,
//                                                               ladies: row1col12in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row1col12in1[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow1Column12Index1 =
//                                                             !_ontapRow1Column12Index1;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow3Column12Index1 ==
//                                                   true
//                                               ? row1col12in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row1col12in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row1col12in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row1col12in1[0].name,
//                                         ),
//                                   row0col12in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col12in1[0].length,
//                                           ladiesColor:
//                                               row0col12in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row0col12in1[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       _ontapRow0Column12Index1 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col12in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col12in1[0]
//                                                                       .name,
//                                                               ladies: row0col12in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row0col12in1[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow0Column12Index1 =
//                                                             !_ontapRow0Column12Index1;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow0Column12Index1 ==
//                                                   true
//                                               ? row0col12in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col12in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col12in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col12in1[0].name,
//                                         ),
//                                 ],
//                               ),
//                               ////////////////////////////////////////////////111111111333333333333333
//                               Row(
//                                 children: [
//                                   row5col13in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row5col13in1[0].length,
//                                           ladiesColor:
//                                               row5col13in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row5col13in1[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       _ontapRow5Column13Index1 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row5col13in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row5col13in1[0]
//                                                                       .name,
//                                                               ladies: row5col13in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row5col13in1[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow5Column13Index1 =
//                                                             !_ontapRow5Column13Index1;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow5Column13Index1 ==
//                                                   true
//                                               ? row5col13in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row5col13in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row5col13in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row5col13in1[0].name,
//                                         ),
//                                   row4col13in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row4col13in1[0].length,
//                                           ladiesColor:
//                                               row4col13in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row4col13in1[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       _ontapRow4Column13Index1 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col13in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col13in1[0]
//                                                                       .name,
//                                                               ladies: row4col13in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row4col13in1[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow4Column13Index1 =
//                                                             !_ontapRow4Column13Index1;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow4Column13Index1 ==
//                                                   true
//                                               ? row4col13in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col13in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col13in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col13in1[0].name,
//                                         ),
//                                   row3col13in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row3col13in1[0].length,
//                                           ladiesColor:
//                                               row3col13in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row3col13in1[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       _ontapRow3Column13Index1 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row3col13in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row3col13in1[0]
//                                                                       .name,
//                                                               ladies: row3col13in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row3col13in1[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow3Column13Index1 =
//                                                             !_ontapRow3Column13Index1;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow3Column13Index1 ==
//                                                   true
//                                               ? row3col13in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row3col13in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row3col13in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row3col13in1[0].name,
//                                         ),
//                                   row2col13in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : row2col13in1[0].length == '2'
//                                           ? SeatContainerModelLength(
//                                               length: row2col13in1[0].length,
//                                               ladiesColor:
//                                                   row2col13in1[0].ladiesSeat ==
//                                                           'true'
//                                                       ? Colors.pink
//                                                       : Colors.black,
//                                               onTap:
//                                                   row2col13in1[0].available ==
//                                                           'true'
//                                                       ? () {
//                                                           _ontapRow2Column13Index1 ==
//                                                                   true
//                                                               ? listSeatNameClass.add(ListOfSeatClass(
//                                                                   fareSeat:
//                                                                       row2col13in1[0]
//                                                                           .fare,
//                                                                   name:
//                                                                       row2col13in1[0]
//                                                                           .name,
//                                                                   ladies: row2col13in1[0]
//                                                                               .ladiesSeat ==
//                                                                           'true'
//                                                                       ? 'true'
//                                                                       : 'false'))
//                                                               : listSeatNameClass
//                                                                   .removeWhere((item) =>
//                                                                       item.name ==
//                                                                       row2col13in1[
//                                                                               0]
//                                                                           .name);

//                                                           setState(() {
//                                                             _ontapRow2Column13Index1 =
//                                                                 !_ontapRow2Column13Index1;
//                                                           });
//                                                         }
//                                                       : () {},
//                                               color: _ontapRow2Column13Index1 ==
//                                                       true
//                                                   ? row2col13in1[0]
//                                                                   .ladiesSeat ==
//                                                               'true' &&
//                                                           row2col13in1[0]
//                                                                   .available ==
//                                                               'false'
//                                                       ? Colors.pink
//                                                       : row2col13in1[0]
//                                                                   .available ==
//                                                               'false'
//                                                           ? Colors.grey
//                                                           : Colors.white
//                                                   : Colors.green,
//                                               listObj: row2col13in1[0].name,
//                                             )
//                                           : SeatContainerModelWidth(
//                                               width: row2col13in1[0].width,
//                                               ladiesColor:
//                                                   row2col13in1[0].ladiesSeat ==
//                                                           'true'
//                                                       ? Colors.pink
//                                                       : Colors.black,
//                                               onTap:
//                                                   row2col13in1[0].available ==
//                                                           'true'
//                                                       ? () {
//                                                           _ontapRow2Column13Index1 ==
//                                                                   true
//                                                               ? listSeatNameClass.add(ListOfSeatClass(
//                                                                   fareSeat:
//                                                                       row2col13in1[0]
//                                                                           .fare,
//                                                                   name:
//                                                                       row2col13in1[0]
//                                                                           .name,
//                                                                   ladies: row2col13in1[0]
//                                                                               .ladiesSeat ==
//                                                                           'true'
//                                                                       ? 'true'
//                                                                       : 'false'))
//                                                               : listSeatNameClass
//                                                                   .removeWhere((item) =>
//                                                                       item.name ==
//                                                                       row2col13in1[
//                                                                               0]
//                                                                           .name);

//                                                           setState(() {
//                                                             _ontapRow2Column13Index1 =
//                                                                 !_ontapRow2Column13Index1;
//                                                           });
//                                                         }
//                                                       : () {},
//                                               color: _ontapRow2Column13Index1 ==
//                                                       true
//                                                   ? row2col13in1[0]
//                                                                   .ladiesSeat ==
//                                                               'true' &&
//                                                           row2col13in1[0]
//                                                                   .available ==
//                                                               'false'
//                                                       ? Colors.pink
//                                                       : row2col13in1[0]
//                                                                   .available ==
//                                                               'false'
//                                                           ? Colors.grey
//                                                           : Colors.white
//                                                   : Colors.green,
//                                               listObj: row2col13in1[0].name,
//                                             ),
//                                   row1col13in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row1col13in1[0].length,
//                                           ladiesColor:
//                                               row1col13in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row1col13in1[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       _ontapRow1Column13Index1 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row1col13in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row1col13in1[0]
//                                                                       .name,
//                                                               ladies: row1col13in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row1col13in1[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow1Column13Index1 =
//                                                             !_ontapRow1Column13Index1;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow1Column13Index1 ==
//                                                   true
//                                               ? row1col13in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row1col13in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row1col13in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row1col13in1[0].name,
//                                         ),
//                                   row0col13in1.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col13in1[0].length,
//                                           ladiesColor:
//                                               row0col13in1[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row0col13in1[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       _ontapRow0Column13Index1 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col13in1[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col13in1[0]
//                                                                       .name,
//                                                               ladies: row0col13in1[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row0col13in1[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow0Column13Index1 =
//                                                             !_ontapRow0Column13Index1;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow0Column13Index1 ==
//                                                   true
//                                               ? row0col13in1[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col13in1[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col13in1[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col13in1[0].name,
//                                         ),
//                                 ],
//                               ),
//                             ], //
//                           ),
//                         ),
//                       )
//                     : Padding(
//                         padding: const EdgeInsets.only(
//                             right: 45, left: 45, top: 10, bottom: 50),
//                         child: Container(
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 111, top: 15, bottom: 7),
//                                 child: Icon(
//                                   Icons.support,
//                                   size: 35,
//                                 ),
//                               ),
//                               Divider(color: Colors.black, thickness: 1),
//                               // SeatContainerModel(
//                               //   color: Colors.green,
//                               //   ladiesColor: Colors.yellow,
//                               //   length: row1col1in0[0].length,
//                               //   listObj: row1col1in0[0].name,
//                               //   onTap: () {},
//                               // ),
//                               //0000000000000000000000000000000000000000000000000000000000000000000Lowerrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
//                               ///BIrtheeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
//                               Row(
//                                 children: [
//                                   row4col0in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row4col0in0[0].length,
//                                           ladiesColor:
//                                               row4col0in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row4col0in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss
//                                                   ///
//                                                   print(
//                                                       'seat Name${row4col0in0[0].name}');

//                                                   _ontapRow4Column0Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col0in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col0in0[0]
//                                                                       .name,
//                                                               ladies: row4col0in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row4col0in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow4Column0Index0 =
//                                                         !_ontapRow4Column0Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow4Column0Index0 == true
//                                               ? row4col0in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col0in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col0in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col0in0[0].name,
//                                         ),
//                                   row3col0in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row3col0in0[0].length,
//                                           ladiesColor:
//                                               row3col0in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row3col0in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss
//                                                   print(
//                                                       'seat Name${row3col0in0[0].name}');
//                                                   _ontapRow3Column0Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row3col0in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row3col0in0[0]
//                                                                       .name,
//                                                               ladies: row3col0in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row3col0in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow3Column0Index0 =
//                                                         !_ontapRow3Column0Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow3Column0Index0 == true
//                                               ? row3col0in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row3col0in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row3col0in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row3col0in0[0].name,
//                                         ),
//                                   row2col0in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row2col0in0[0].length,
//                                           ladiesColor:
//                                               row2col0in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row2col0in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss
//                                                   print(
//                                                       'seat Name${row2col0in0[0].name}');
//                                                   print(
//                                                       '1====${listSeatNameClass.length}');
//                                                   _ontapRow2Column0Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row2col0in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row2col0in0[0]
//                                                                       .name,
//                                                               ladies: row2col0in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row2col0in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow2Column0Index0 =
//                                                         !_ontapRow2Column0Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow2Column0Index0 == true
//                                               ? row2col0in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row2col0in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row2col0in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row2col0in0[0].name,
//                                         ),
//                                   row1col0in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row1col0in0[0].length,
//                                           ladiesColor:
//                                               row1col0in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row1col0in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss
//                                                   print(
//                                                       '********11111111111111************');
//                                                   print(
//                                                       'seat Name${row1col0in0[0].name}');
//                                                   print(
//                                                       '1===${listSeatNameClass.length}');

//                                                   _ontapRow1Column0Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row1col0in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row1col0in0[0]
//                                                                       .name,
//                                                               ladies: row1col0in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row1col0in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow1Column0Index0 =
//                                                         !_ontapRow1Column0Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow1Column0Index0 == true
//                                               ? row1col0in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row1col0in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row1col0in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row1col0in0[0].name,
//                                         ),
//                                   row0col0in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col0in0[0].length,
//                                           ladiesColor:
//                                               row0col0in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row0col0in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   print(
//                                                       '********00000000000000000000000************');
//                                                   print(
//                                                       'seat Name${row0col0in0[0].name}');
//                                                   print(
//                                                       '1${listSeatNameClass.length}');

//                                                   print(
//                                                       listSeatNameClass.length);

//                                                   //// addding seatss

//                                                   listSeatNameClass.length <= 2
//                                                       ? _ontapRow0Column0Index0 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col0in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col0in0[0]
//                                                                       .name,
//                                                               ladies: row0col0in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row0col0in0[0]
//                                                                       .name)
//                                                       : Fluttertoast.showToast(
//                                                           msg: 'Maximum seat is 6');

//                                                   setState(() {
//                                                     _ontapRow0Column0Index0 =
//                                                         !_ontapRow0Column0Index0;
//                                                   });
//                                                 }
//                                               : () {},

// //                                            () {
// //                                             print(
// //                                                 '*******************************************************');
// // ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// //                                             listSeatNameClass.add(
// //                                                 ListOfSeatClass(
// //                                                         name: row0col0in0[0].name,
// //                                                         ladies: 'true')
// //                                                     .toString());
// //                                           }

//                                           color: _ontapRow0Column0Index0 == true
//                                               ? row0col0in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col0in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col0in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col0in0[0].name,
//                                         ),
//                                 ],
//                               ),
//                               /////////////////////////////// column 111111111111111
//                               Row(
//                                 children: [
//                                   row4col1in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row4col1in0[0].length,
//                                           ladiesColor:
//                                               row4col1in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row4col1in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   print(
//                                                       '1111111111111111111111111111111111111');
//                                                   //// addding seatss

//                                                   _ontapRow4Column1Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col1in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col1in0[0]
//                                                                       .name,
//                                                               ladies: row4col1in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row4col1in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow4Column1Index0 =
//                                                         !_ontapRow4Column1Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow4Column1Index0 == true
//                                               ? row4col1in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col1in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col1in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col1in0[0].name,
//                                         ),
//                                   row3col1in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row3col1in0[0].length,
//                                           ladiesColor:
//                                               row3col1in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row3col1in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss
//                                                   print(
//                                                       '111111111113333333333');

//                                                   _ontapRow3Column1Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row3col1in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row3col1in0[0]
//                                                                       .name,
//                                                               ladies: row3col1in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row3col1in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow3Column1Index0 =
//                                                         !_ontapRow3Column1Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow3Column1Index0 == true
//                                               ? row3col1in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row3col1in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row3col1in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row3col1in0[0].name,
//                                         ),
//                                   row2col1in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row2col1in0[0].length,
//                                           ladiesColor:
//                                               row2col1in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row2col1in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss
//                                                   print(
//                                                       '111111111112222222222');
//                                                   _ontapRow2Column1Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row2col1in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row2col1in0[0]
//                                                                       .name,
//                                                               ladies: row2col1in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row2col1in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow2Column1Index0 =
//                                                         !_ontapRow2Column1Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow2Column1Index0 == true
//                                               ? row2col1in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row2col1in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row2col1in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row2col1in0[0].name,
//                                         ),
//                                   row1col1in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row1col1in0[0].length,
//                                           ladiesColor:
//                                               row1col1in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row1col1in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss
//                                                   print(
//                                                       '11111111111511111111111');
//                                                   _ontapRow1Column0Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row1col1in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row1col1in0[0]
//                                                                       .name,
//                                                               ladies: row1col1in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row1col1in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow1Column1Index0 =
//                                                         !_ontapRow1Column1Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow1Column1Index0 == true
//                                               ? row1col1in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row1col1in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row1col1in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row1col1in0[0].name,
//                                         ),
//                                   row0col1in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col1in0[0].length,
//                                           ladiesColor:
//                                               row0col1in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row0col1in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss
//                                                   print(
//                                                       '1111111111100000000000000');
//                                                   _ontapRow0Column1Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col1in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col1in0[0]
//                                                                       .name,
//                                                               ladies: row0col1in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row0col1in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow0Column1Index0 =
//                                                         !_ontapRow0Column1Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow0Column1Index0 == true
//                                               ? row0col1in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col1in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col1in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col1in0[0].name,
//                                         ),
//                                 ],
//                               ),
//                               ///////////  /////////////////////////////// column 22222222222222222
//                               Row(
//                                 children: [
//                                   row4col2in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row4col2in0[0].length,
//                                           ladiesColor:
//                                               row4col2in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row4col2in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss
//                                                   print('4444444422222222');
//                                                   _ontapRow4Column2Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col2in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col2in0[0]
//                                                                       .name,
//                                                               ladies: row4col2in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row4col2in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow4Column2Index0 =
//                                                         !_ontapRow4Column2Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow4Column2Index0 == true
//                                               ? row4col2in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col2in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col2in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col2in0[0].name,
//                                         ),
//                                   row3col2in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row3col2in0[0].length,
//                                           ladiesColor:
//                                               row3col2in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row3col2in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss
//                                                   print('333333322222222');
//                                                   _ontapRow3Column2Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row3col2in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row3col2in0[0]
//                                                                       .name,
//                                                               ladies: row3col2in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row3col2in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow3Column2Index0 =
//                                                         !_ontapRow3Column2Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow3Column2Index0 == true
//                                               ? row3col2in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row3col2in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row3col2in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row3col2in0[0].name,
//                                         ),
//                                   row2col2in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row2col2in0[0].length,
//                                           ladiesColor:
//                                               row2col2in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row2col2in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss
//                                                   print('22222222222222222222');
//                                                   _ontapRow2Column2Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row2col2in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row2col2in0[0]
//                                                                       .name,
//                                                               ladies: row2col2in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row2col2in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow2Column2Index0 =
//                                                         !_ontapRow2Column2Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow2Column2Index0 == true
//                                               ? row2col2in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row2col2in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row2col2in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row2col2in0[0].name,
//                                         ),
//                                   row1col2in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row1col2in0[0].length,
//                                           ladiesColor:
//                                               row1col2in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row1col2in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss
//                                                   print('11111111122222222');
//                                                   _ontapRow1Column2Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row1col2in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row1col2in0[0]
//                                                                       .name,
//                                                               ladies: row1col2in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row1col2in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow1Column2Index0 =
//                                                         !_ontapRow1Column2Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow1Column2Index0 == true
//                                               ? row1col2in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row1col2in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row1col2in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row1col2in0[0].name,
//                                         ),
//                                   row0col2in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col2in0[0].length,
//                                           ladiesColor:
//                                               row0col2in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row0col2in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss
//                                                   print('0000000022222222');
//                                                   _ontapRow0Column2Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col2in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col2in0[0]
//                                                                       .name,
//                                                               ladies: row0col2in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row0col2in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow0Column2Index0 =
//                                                         !_ontapRow0Column2Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow0Column2Index0 == true
//                                               ? row0col2in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col2in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col2in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col2in0[0].name,
//                                         ),
//                                 ],
//                               ),
//                               ///////////////////// 3333333333333333333333333333333
//                               Row(
//                                 children: [
//                                   row4col3in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row4col3in0[0].length,
//                                           ladiesColor:
//                                               row4col3in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row4col3in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow4Column3Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col3in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col3in0[0]
//                                                                       .name,
//                                                               ladies: row4col3in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row4col3in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow4Column3Index0 =
//                                                         !_ontapRow4Column3Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow4Column3Index0 == true
//                                               ? row4col3in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col3in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col3in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col3in0[0].name,
//                                         ),
//                                   row3col3in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row3col3in0[0].length,
//                                           ladiesColor:
//                                               row3col3in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row3col3in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow3Column3Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row3col3in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row3col3in0[0]
//                                                                       .name,
//                                                               ladies: row3col3in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row3col3in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow3Column3Index0 =
//                                                         !_ontapRow3Column3Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow3Column3Index0 == true
//                                               ? row3col3in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row3col3in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row3col3in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row3col3in0[0].name,
//                                         ),
//                                   row2col3in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row2col3in0[0].length,
//                                           ladiesColor:
//                                               row2col3in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row2col3in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow2Column3Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row2col3in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row2col3in0[0]
//                                                                       .name,
//                                                               ladies: row2col3in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row2col3in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow2Column3Index0 =
//                                                         !_ontapRow2Column3Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow2Column3Index0 == true
//                                               ? row2col3in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row2col3in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row2col3in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row2col3in0[0].name,
//                                         ),
//                                   row1col3in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row1col3in0[0].length,
//                                           ladiesColor:
//                                               row1col3in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row1col3in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow1Column3Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row1col3in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row1col3in0[0]
//                                                                       .name,
//                                                               ladies: row1col3in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row1col3in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow1Column3Index0 =
//                                                         !_ontapRow1Column3Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow1Column3Index0 == true
//                                               ? row1col3in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row1col3in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row1col3in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row1col3in0[0].name,
//                                         ),
//                                   row0col3in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col3in0[0].length,
//                                           ladiesColor:
//                                               row0col3in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row0col3in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow0Column3Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col3in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col3in0[0]
//                                                                       .name,
//                                                               ladies: row0col3in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row0col3in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow0Column3Index0 =
//                                                         !_ontapRow0Column3Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow0Column3Index0 == true
//                                               ? row0col3in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col3in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col3in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col3in0[0].name,
//                                         ),
//                                 ],
//                               ),
//                               ////////////////////////////////// 44444444444444444444444444444444/////////////////////////////////////////////////////////
//                               Row(
//                                 children: [
//                                   row4col4in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row4col4in0[0].length,
//                                           ladiesColor:
//                                               row4col4in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row4col4in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow4Column4Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col4in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col4in0[0]
//                                                                       .name,
//                                                               ladies: row4col4in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row4col4in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow4Column4Index0 =
//                                                         !_ontapRow4Column4Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow4Column4Index0 == true
//                                               ? row4col4in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col4in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col4in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col4in0[0].name,
//                                         ),
//                                   row3col4in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row3col4in0[0].length,
//                                           ladiesColor:
//                                               row3col4in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row3col4in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow3Column4Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row3col4in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row3col4in0[0]
//                                                                       .name,
//                                                               ladies: row3col4in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row3col4in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow3Column4Index0 =
//                                                         !_ontapRow3Column4Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow3Column4Index0 == true
//                                               ? row3col4in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row3col4in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row3col4in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row3col4in0[0].name,
//                                         ),

//                                   /////////////////////////////////////////////////////// issueeeeee
//                                   row2col4in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row2col4in0[0].length,
//                                           ladiesColor:
//                                               row2col4in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row2col4in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow2Column4Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row2col4in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row2col4in0[0]
//                                                                       .name,
//                                                               ladies: row2col4in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row2col4in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow2Column4Index0 =
//                                                         !_ontapRow2Column4Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow2Column4Index0 == true
//                                               ? row2col4in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row2col4in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row2col4in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row2col4in0[0].name,
//                                         ),
//                                   // SeatContainerModel(
//                                   //     ladiesColor: row2col4in0[0].ladiesSeat == 'true'
//                                   //         ? Colors.pink
//                                   //         : Colors.black,
//                                   //     onTap: () {
//                                   //       print('object');
//                                   //       print(row2col4in0[0].ladiesSeat);
//                                   //       print(row2col4in0[0].available);
//                                   //       print(row2col4in0[0].length);
//                                   //     },
//                                   //     color: row2col4in0[0].ladiesSeat == 'true' &&
//                                   //             row2col4in0[0].available == 'false'
//                                   //         ? Colors.pink
//                                   //         : row2col4in0[0].available == 'false'
//                                   //             ? Colors.grey
//                                   //             : Colors.white,
//                                   //     listObj: row2col4in0[0].name,
//                                   //   ),
//                                   row1col4in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row1col4in0[0].length,
//                                           ladiesColor:
//                                               row1col4in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row1col4in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow1Column4Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row1col4in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row1col4in0[0]
//                                                                       .name,
//                                                               ladies: row1col4in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row1col4in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow1Column4Index0 =
//                                                         !_ontapRow1Column4Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow1Column4Index0 == true
//                                               ? row1col4in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row1col4in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row1col4in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row1col4in0[0].name,
//                                         ),
//                                   row0col4in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col4in0[0].length,
//                                           ladiesColor:
//                                               row0col4in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row0col4in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow0Column4Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col4in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col4in0[0]
//                                                                       .name,
//                                                               ladies: row0col4in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row0col4in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow0Column4Index0 =
//                                                         !_ontapRow0Column4Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow0Column4Index0 == true
//                                               ? row0col4in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col4in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col4in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col4in0[0].name,
//                                         ),
//                                 ],
//                               ),
//                               ///////////////// 5555555555555555555555555555555555555555555555555555555555555555555555
//                               Row(
//                                 children: [
//                                   row4col5in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row4col5in0[0].length,
//                                           ladiesColor:
//                                               row4col5in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row4col5in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow4Column5Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col5in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col5in0[0]
//                                                                       .name,
//                                                               ladies: row4col5in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row4col5in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow4Column5Index0 =
//                                                         !_ontapRow4Column5Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow4Column5Index0 == true
//                                               ? row4col5in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col5in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col5in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col5in0[0].name,
//                                         ),
//                                   row3col5in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row3col5in0[0].length,
//                                           ladiesColor:
//                                               row3col5in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row3col5in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow3Column5Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row3col5in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row3col5in0[0]
//                                                                       .name,
//                                                               ladies: row3col5in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row3col5in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow3Column5Index0 =
//                                                         !_ontapRow3Column5Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow3Column5Index0 == true
//                                               ? row3col5in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row3col5in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row3col5in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row3col5in0[0].name,
//                                         ),
//                                   row2col5in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row2col5in0[0].length,
//                                           ladiesColor:
//                                               row2col5in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row2col5in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow2Column5Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row2col5in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row2col5in0[0]
//                                                                       .name,
//                                                               ladies: row2col5in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row2col5in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow2Column5Index0 =
//                                                         !_ontapRow2Column5Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow2Column5Index0 == true
//                                               ? row2col5in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row2col5in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row2col5in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row2col5in0[0].name,
//                                         ),
//                                   row1col5in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row1col5in0[0].length,
//                                           ladiesColor:
//                                               row1col5in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row1col5in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow1Column5Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row1col5in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row1col5in0[0]
//                                                                       .name,
//                                                               ladies: row1col5in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row1col5in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow1Column5Index0 =
//                                                         !_ontapRow1Column5Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow1Column5Index0 == true
//                                               ? row1col5in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row1col5in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row1col5in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row1col5in0[0].name,
//                                         ),
//                                   row0col5in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col5in0[0].length,
//                                           ladiesColor:
//                                               row0col5in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row0col5in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow0Column5Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col5in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col5in0[0]
//                                                                       .name,
//                                                               ladies: row0col5in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row0col5in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow0Column5Index0 =
//                                                         !_ontapRow0Column5Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow0Column5Index0 == true
//                                               ? row0col5in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col5in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col5in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col5in0[0].name,
//                                         ),
//                                 ],
//                               ),
//                               //////////////6666666666666666666666666666666666666666666666666666666
//                               Row(
//                                 children: [
//                                   row4col6in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row4col6in0[0].length,
//                                           ladiesColor:
//                                               row4col6in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row4col6in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow4Column6Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col6in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col6in0[0]
//                                                                       .name,
//                                                               ladies: row4col6in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row4col6in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow4Column6Index0 =
//                                                         !_ontapRow4Column6Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow4Column6Index0 == true
//                                               ? row4col6in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col6in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col6in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col6in0[0].name,
//                                         ),
//                                   row3col6in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row3col6in0[0].length,
//                                           ladiesColor:
//                                               row3col6in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row3col6in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow3Column6Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row3col6in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row3col6in0[0]
//                                                                       .name,
//                                                               ladies: row3col6in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row3col6in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow3Column6Index0 =
//                                                         !_ontapRow3Column6Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow3Column6Index0 == true
//                                               ? row3col6in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row3col6in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row3col6in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row3col6in0[0].name,
//                                         ),
//                                   row2col6in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row2col6in0[0].length,
//                                           ladiesColor:
//                                               row2col6in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row2col6in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow2Column6Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row2col6in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row2col6in0[0]
//                                                                       .name,
//                                                               ladies: row2col6in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row2col6in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow2Column6Index0 =
//                                                         !_ontapRow2Column6Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow2Column6Index0 == true
//                                               ? row2col6in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row2col6in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row2col6in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row2col6in0[0].name,
//                                         ),
//                                   row1col6in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row1col6in0[0].length,
//                                           ladiesColor:
//                                               row1col6in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row1col6in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow1Column6Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row1col6in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row1col6in0[0]
//                                                                       .name,
//                                                               ladies: row1col6in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row1col6in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow1Column6Index0 =
//                                                         !_ontapRow1Column6Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow1Column6Index0 == true
//                                               ? row1col6in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row1col6in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row1col6in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row1col6in0[0].name,
//                                         ),
//                                   row0col6in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col6in0[0].length,
//                                           ladiesColor:
//                                               row0col6in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row0col6in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow0Column6Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col6in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col6in0[0]
//                                                                       .name,
//                                                               ladies: row0col6in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row0col6in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow0Column6Index0 =
//                                                         !_ontapRow0Column6Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow0Column6Index0 == true
//                                               ? row0col6in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col6in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col6in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col6in0[0].name,
//                                         ),
//                                 ],
//                               ),
//                               /////////////////77777777777777777777777777777777777777777777777777777777777777777777777777
//                               Row(
//                                 children: [
//                                   row4col7in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row4col7in0[0].length,
//                                           ladiesColor:
//                                               row4col7in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row4col7in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow4Column7Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col7in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col7in0[0]
//                                                                       .name,
//                                                               ladies: row4col7in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row4col7in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow4Column7Index0 =
//                                                         !_ontapRow4Column7Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow4Column7Index0 == true
//                                               ? row4col7in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col7in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col7in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col7in0[0].name,
//                                         ),
//                                   row3col7in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row3col7in0[0].length,
//                                           ladiesColor:
//                                               row3col7in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row3col7in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow3Column7Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row3col7in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row3col7in0[0]
//                                                                       .name,
//                                                               ladies: row3col7in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row3col7in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow3Column7Index0 =
//                                                         !_ontapRow3Column7Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow3Column7Index0 == true
//                                               ? row3col7in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row3col7in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row3col7in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row3col7in0[0].name,
//                                         ),
//                                   row2col7in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row2col7in0[0].length,
//                                           ladiesColor:
//                                               row2col7in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row2col7in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow2Column7Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row2col7in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row2col7in0[0]
//                                                                       .name,
//                                                               ladies: row2col7in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row2col7in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow2Column7Index0 =
//                                                         !_ontapRow2Column7Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow2Column7Index0 == true
//                                               ? row2col7in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row2col7in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row2col7in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row2col7in0[0].name,
//                                         ),
//                                   row1col7in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row1col7in0[0].length,
//                                           ladiesColor:
//                                               row1col7in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row1col7in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow1Column7Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row1col7in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row1col7in0[0]
//                                                                       .name,
//                                                               ladies: row1col7in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row1col7in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow1Column7Index0 =
//                                                         !_ontapRow1Column7Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow1Column7Index0 == true
//                                               ? row1col7in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row1col7in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row1col7in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row1col7in0[0].name,
//                                         ),
//                                   row0col7in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col7in0[0].length,
//                                           ladiesColor:
//                                               row0col7in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row0col7in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow0Column7Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col7in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col7in0[0]
//                                                                       .name,
//                                                               ladies: row0col7in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row0col7in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow0Column7Index0 =
//                                                         !_ontapRow0Column7Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow0Column7Index0 == true
//                                               ? row0col7in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col7in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col7in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col7in0[0].name,
//                                         ),
//                                 ],
//                               ),

//                               ///
//                               /////
//                               /////8888888888
//                               Row(
//                                 children: [
//                                   row4col8in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row4col8in0[0].length,
//                                           ladiesColor:
//                                               row4col8in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row4col8in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow4Column8Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col8in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col8in0[0]
//                                                                       .name,
//                                                               ladies: row4col8in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row4col8in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow4Column8Index0 =
//                                                         !_ontapRow4Column8Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow4Column8Index0 == true
//                                               ? row4col8in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col8in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col8in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col8in0[0].name,
//                                         ),
//                                   row3col8in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row3col8in0[0].length,
//                                           ladiesColor:
//                                               row3col8in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row3col8in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow4Column8Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row3col8in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row3col8in0[0]
//                                                                       .name,
//                                                               ladies: row3col8in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row3col8in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow3Column8Index0 =
//                                                         !_ontapRow3Column8Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow3Column8Index0 == true
//                                               ? row3col8in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row3col8in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row3col8in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row3col8in0[0].name,
//                                         ),
//                                   row2col8in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row2col8in0[0].length,
//                                           ladiesColor:
//                                               row2col8in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row2col8in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow2Column8Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row2col8in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row2col8in0[0]
//                                                                       .name,
//                                                               ladies: row2col8in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row2col8in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow2Column8Index0 =
//                                                         !_ontapRow2Column8Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow2Column8Index0 == true
//                                               ? row2col8in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row2col8in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row2col8in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row2col8in0[0].name,
//                                         ),
//                                   row1col8in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row1col8in0[0].length,
//                                           ladiesColor:
//                                               row1col8in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row1col8in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow1Column8Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row1col8in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row1col8in0[0]
//                                                                       .name,
//                                                               ladies: row1col8in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row1col8in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow1Column8Index0 =
//                                                         !_ontapRow1Column8Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow1Column8Index0 == true
//                                               ? row1col8in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row1col8in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row1col8in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row1col8in0[0].name,
//                                         ),
//                                   row0col8in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col8in0[0].length,
//                                           ladiesColor:
//                                               row0col8in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row0col8in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow0Column8Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col8in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col8in0[0]
//                                                                       .name,
//                                                               ladies: row0col8in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row0col8in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow0Column8Index0 =
//                                                         !_ontapRow0Column8Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow0Column8Index0 == true
//                                               ? row0col8in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col8in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col8in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col8in0[0].name,
//                                         ),
//                                 ],
//                               ),
//                               ///////////////////////////////////////////////////////////////////////////////////////////////////////
//                               ///
//                               /// Rowww 9
//                               Row(
//                                 children: [
//                                   row4col9in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row4col9in0[0].length,
//                                           ladiesColor:
//                                               row4col9in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row4col9in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow4Column9Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col9in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col9in0[0]
//                                                                       .name,
//                                                               ladies: row4col9in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row4col9in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow4Column9Index0 =
//                                                         !_ontapRow4Column9Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow4Column9Index0 == true
//                                               ? row4col9in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col9in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col9in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col9in0[0].name,
//                                         ),
//                                   row3col9in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row3col9in0[0].length,
//                                           ladiesColor:
//                                               row3col9in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row3col9in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow3Column9Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row3col9in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row3col9in0[0]
//                                                                       .name,
//                                                               ladies: row3col9in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row3col9in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow3Column9Index0 =
//                                                         !_ontapRow3Column9Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow3Column9Index0 == true
//                                               ? row3col9in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row3col9in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row3col9in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row3col9in0[0].name,
//                                         ),
//                                   row2col9in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row2col9in0[0].length,
//                                           ladiesColor:
//                                               row2col9in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row2col9in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow2Column9Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row2col9in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row2col9in0[0]
//                                                                       .name,
//                                                               ladies: row2col9in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row2col9in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow2Column9Index0 =
//                                                         !_ontapRow2Column9Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow2Column9Index0 == true
//                                               ? row2col9in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row2col9in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row2col9in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row2col9in0[0].name,
//                                         ),
//                                   row1col9in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row1col9in0[0].length,
//                                           ladiesColor:
//                                               row1col9in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row1col9in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow1Column9Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row1col9in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row1col9in0[0]
//                                                                       .name,
//                                                               ladies: row1col9in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row1col9in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow1Column9Index0 =
//                                                         !_ontapRow1Column9Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow1Column9Index0 == true
//                                               ? row1col9in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row1col9in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row1col9in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row1col9in0[0].name,
//                                         ),
//                                   row0col9in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col9in0[0].length,
//                                           ladiesColor:
//                                               row0col9in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap: row0col9in0[0].available ==
//                                                   'true'
//                                               ? () {
//                                                   //// addding seatss

//                                                   _ontapRow0Column9Index0 ==
//                                                           true
//                                                       ? listSeatNameClass.add(
//                                                           ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col9in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col9in0[0]
//                                                                       .name,
//                                                               ladies: row0col9in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                       : listSeatNameClass
//                                                           .removeWhere((item) =>
//                                                               item.name ==
//                                                               row0col9in0[0]
//                                                                   .name);

//                                                   setState(() {
//                                                     _ontapRow0Column9Index0 =
//                                                         !_ontapRow0Column9Index0;
//                                                   });
//                                                 }
//                                               : () {},
//                                           color: _ontapRow0Column9Index0 == true
//                                               ? row0col9in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col9in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col9in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col9in0[0].name,
//                                         ),
//                                 ],
//                               ),
//                               //10
//                               Row(
//                                 children: [
//                                   row4col10in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row4col10in0[0].length,
//                                           ladiesColor:
//                                               row4col10in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row4col10in0[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       //// addding seatss

//                                                       _ontapRow4Column10Index0 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col10in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col10in0[0]
//                                                                       .name,
//                                                               ladies: row4col10in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row4col10in0[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow4Column10Index0 =
//                                                             !_ontapRow4Column10Index0;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow4Column10Index0 ==
//                                                   true
//                                               ? row4col10in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col10in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col10in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col10in0[0].name,
//                                         ),
//                                   row3col10in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row3col10in0[0].length,
//                                           ladiesColor:
//                                               row3col10in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row3col10in0[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       //// addding seatss

//                                                       _ontapRow3Column10Index0 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row3col10in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row3col10in0[0]
//                                                                       .name,
//                                                               ladies: row3col10in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row3col10in0[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow3Column10Index0 =
//                                                             !_ontapRow3Column10Index0;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow3Column10Index0 ==
//                                                   true
//                                               ? row3col10in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row3col10in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row3col10in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row3col10in0[0].name,
//                                         ),
//                                   row2col10in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row2col10in0[0].length,
//                                           ladiesColor:
//                                               row2col10in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row2col10in0[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       //// addding seatss

//                                                       _ontapRow2Column10Index0 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row2col10in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row2col10in0[0]
//                                                                       .name,
//                                                               ladies: row2col10in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row2col10in0[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow2Column10Index0 =
//                                                             !_ontapRow2Column10Index0;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow2Column10Index0 ==
//                                                   true
//                                               ? row2col10in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row2col10in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row2col10in0[0].available ==
//                                                           'false' ///////////////////
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row2col10in0[0].name,
//                                         ),
//                                   row1col10in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row1col10in0[0].length,
//                                           ladiesColor:
//                                               row1col10in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row1col10in0[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       //// addding seatss

//                                                       _ontapRow1Column10Index0 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row1col10in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row1col10in0[0]
//                                                                       .name,
//                                                               ladies: row1col10in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row1col10in0[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow1Column10Index0 =
//                                                             !_ontapRow1Column10Index0;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow1Column10Index0 ==
//                                                   true
//                                               ? row1col10in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row1col10in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row1col10in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row1col10in0[0].name,
//                                         ),
//                                   row0col10in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col10in0[0].length,
//                                           ladiesColor:
//                                               row0col10in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row0col10in0[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       //// addding seatss

//                                                       _ontapRow0Column10Index0 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col10in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col10in0[0]
//                                                                       .name,
//                                                               ladies: row0col10in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row0col10in0[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow0Column10Index0 =
//                                                             !_ontapRow0Column10Index0;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow0Column10Index0 ==
//                                                   true
//                                               ? row0col10in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col10in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col10in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col10in0[0].name,
//                                         ),
//                                 ],
//                               ),
//                               //
//                               //11
//                               Row(
//                                 children: [
//                                   row4col11in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row4col11in0[0].length,
//                                           ladiesColor:
//                                               row4col11in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row4col11in0[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       //// addding seatss

//                                                       _ontapRow4Column11Index0 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col11in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col11in0[0]
//                                                                       .name,
//                                                               ladies: row4col11in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row4col11in0[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow4Column11Index0 =
//                                                             !_ontapRow4Column11Index0;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow4Column11Index0 ==
//                                                   true
//                                               ? row4col11in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col11in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col11in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col11in0[0].name,
//                                         ),
//                                   row3col11in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row3col11in0[0].length,
//                                           ladiesColor:
//                                               row3col11in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row3col11in0[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       //// addding seatss

//                                                       _ontapRow3Column11Index0 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row3col11in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row3col11in0[0]
//                                                                       .name,
//                                                               ladies: row3col11in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row3col11in0[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow3Column11Index0 =
//                                                             !_ontapRow3Column11Index0;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow3Column11Index0 ==
//                                                   true
//                                               ? row3col11in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row3col11in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row3col11in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row3col11in0[0].name,
//                                         ),
//                                   row2col11in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row2col11in0[0].length,
//                                           ladiesColor:
//                                               row2col11in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row4col11in0[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       //// addding seatss

//                                                       _ontapRow4Column11Index0 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col11in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col11in0[0]
//                                                                       .name,
//                                                               ladies: row4col11in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row4col11in0[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow4Column11Index0 =
//                                                             !_ontapRow4Column11Index0;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow2Column11Index0 ==
//                                                   true
//                                               ? row2col11in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row2col11in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row2col11in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row2col11in0[0].name,
//                                         ),
//                                   row1col11in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row1col11in0[0].length,
//                                           ladiesColor:
//                                               row1col11in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row1col11in0[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       //// addding seatss

//                                                       _ontapRow1Column11Index0 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row1col11in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row1col11in0[0]
//                                                                       .name,
//                                                               ladies: row1col11in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row1col11in0[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow1Column11Index0 =
//                                                             !_ontapRow1Column11Index0;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow1Column11Index0 ==
//                                                   true
//                                               ? row1col11in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row1col11in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row1col11in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row1col11in0[0].name,
//                                         ),
//                                   row0col11in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col11in0[0].length,
//                                           ladiesColor:
//                                               row0col11in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row0col11in0[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       //// addding seatss

//                                                       _ontapRow0Column11Index0 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col11in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col11in0[0]
//                                                                       .name,
//                                                               ladies: row0col11in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row0col11in0[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow0Column11Index0 =
//                                                             !_ontapRow0Column11Index0;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow0Column11Index0 ==
//                                                   true
//                                               ? row0col11in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col11in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col11in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col11in0[0].name,
//                                         ),
//                                 ],
//                               ),

//                               ///
//                               /////12/////////////////////////////////////////////////////////////
//                               Row(
//                                 children: [
//                                   row4col12in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row4col12in0[0].length,
//                                           ladiesColor:
//                                               row4col12in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row4col12in0[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       //// addding seatss

//                                                       _ontapRow4Column12Index0 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col12in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col12in0[0]
//                                                                       .name,
//                                                               ladies: row4col12in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row4col12in0[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow4Column12Index0 =
//                                                             !_ontapRow4Column12Index0;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow4Column12Index0 ==
//                                                   true
//                                               ? row4col12in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col12in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col12in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col12in0[0].name,
//                                         ),
//                                   row3col12in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row3col12in0[0].length,
//                                           ladiesColor:
//                                               row3col12in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row3col12in0[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       //// addding seatss

//                                                       _ontapRow3Column12Index0 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row3col12in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row3col12in0[0]
//                                                                       .name,
//                                                               ladies: row3col12in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row3col12in0[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow3Column12Index0 =
//                                                             !_ontapRow3Column12Index0;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow3Column12Index0 ==
//                                                   true
//                                               ? row3col12in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row3col12in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row3col12in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row3col12in0[0].name,
//                                         ),
//                                   row2col12in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row2col12in0[0].length,
//                                           ladiesColor:
//                                               row2col12in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row2col12in0[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       //// addding seatss

//                                                       _ontapRow2Column12Index0 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row2col12in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row2col12in0[0]
//                                                                       .name,
//                                                               ladies: row2col12in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row2col12in0[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow2Column12Index0 =
//                                                             !_ontapRow2Column12Index0;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow2Column12Index0 ==
//                                                   true
//                                               ? row2col12in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row2col12in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row2col12in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row2col12in0[0].name,
//                                         ),
//                                   row1col12in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : row1col12in0[0].length == '2'
//                                           ? SeatContainerModelLength(
//                                               length: row1col12in0[0].length,
//                                               ladiesColor:
//                                                   row1col12in0[0].ladiesSeat ==
//                                                           'true'
//                                                       ? Colors.pink
//                                                       : Colors.black,
//                                               onTap:
//                                                   row1col12in0[0].available ==
//                                                           'true'
//                                                       ? () {
//                                                           //// addding seatss

//                                                           _ontapRow1Column12Index0 ==
//                                                                   true
//                                                               ? listSeatNameClass.add(ListOfSeatClass(
//                                                                   fareSeat:
//                                                                       row1col12in0[0]
//                                                                           .fare,
//                                                                   name:
//                                                                       row1col12in0[0]
//                                                                           .name,
//                                                                   ladies: row1col12in0[0]
//                                                                               .ladiesSeat ==
//                                                                           'true'
//                                                                       ? 'true'
//                                                                       : 'false'))
//                                                               : listSeatNameClass
//                                                                   .removeWhere((item) =>
//                                                                       item.name ==
//                                                                       row1col12in0[
//                                                                               0]
//                                                                           .name);

//                                                           setState(() {
//                                                             _ontapRow1Column12Index0 =
//                                                                 !_ontapRow1Column12Index0;
//                                                           });
//                                                         }
//                                                       : () {},
//                                               color: _ontapRow1Column12Index0 ==
//                                                       true
//                                                   ? row1col12in0[0]
//                                                                   .ladiesSeat ==
//                                                               'true' &&
//                                                           row1col12in0[0]
//                                                                   .available ==
//                                                               'false'
//                                                       ? Colors.pink
//                                                       : row1col12in0[0]
//                                                                   .available ==
//                                                               'false'
//                                                           ? Colors.grey
//                                                           : Colors.white
//                                                   : Colors.green,
//                                               listObj: row1col12in0[0].name,
//                                             )
//                                           : SeatContainerModelWidth(
//                                               width: row1col12in0[0].width,
//                                               ladiesColor:
//                                                   row1col12in0[0].ladiesSeat ==
//                                                           'true'
//                                                       ? Colors.pink
//                                                       : Colors.black,
//                                               onTap:
//                                                   row1col12in0[0].available ==
//                                                           'true'
//                                                       ? () {
//                                                           print('onTap');
//                                                           setState(() {
//                                                             _ontapRow1Column12Index0 =
//                                                                 !_ontapRow1Column12Index0;
//                                                           });
//                                                         }
//                                                       : () {},
//                                               color: _ontapRow3Column12Index0 ==
//                                                       true
//                                                   ? row1col12in0[0]
//                                                                   .ladiesSeat ==
//                                                               'true' &&
//                                                           row1col12in0[0]
//                                                                   .available ==
//                                                               'false'
//                                                       ? Colors.pink
//                                                       : row1col12in0[0]
//                                                                   .available ==
//                                                               'false'
//                                                           ? Colors.grey
//                                                           : Colors.white
//                                                   : Colors.green,
//                                               listObj: row1col12in0[0].name,
//                                             ),
//                                   row0col12in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col12in0[0].length,
//                                           ladiesColor:
//                                               row0col12in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row0col12in0[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       //// addding seatss

//                                                       _ontapRow0Column12Index0 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col12in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col12in0[0]
//                                                                       .name,
//                                                               ladies: row0col12in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row0col12in0[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow0Column12Index0 =
//                                                             !_ontapRow0Column12Index0;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow0Column12Index0 ==
//                                                   true
//                                               ? row0col12in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col12in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col12in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col12in0[0].name,
//                                         ),
//                                 ],
//                               ),
//                               ////////////////////////////////////////////////111111333333333333333
//                               Row(
//                                 children: [
//                                   row4col13in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row4col13in0[0].length,
//                                           ladiesColor:
//                                               row4col13in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row4col13in0[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       //// addding seatss

//                                                       _ontapRow4Column13Index0 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row4col13in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row4col13in0[0]
//                                                                       .name,
//                                                               ladies: row4col13in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row4col13in0[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow4Column13Index0 =
//                                                             !_ontapRow4Column13Index0;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow4Column13Index0 ==
//                                                   true
//                                               ? row4col13in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row4col13in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row4col13in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row4col13in0[0].name,
//                                         ),
//                                   row3col13in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row3col13in0[0].length,
//                                           ladiesColor:
//                                               row3col13in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row3col13in0[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       //// addding seatss

//                                                       _ontapRow3Column13Index0 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row3col13in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row3col13in0[0]
//                                                                       .name,
//                                                               ladies: row3col13in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row3col13in0[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow3Column13Index0 =
//                                                             !_ontapRow3Column13Index0;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow3Column13Index0 ==
//                                                   true
//                                               ? row3col13in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row3col13in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row3col13in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row3col13in0[0].name,
//                                         ),
//                                   row2col13in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row2col13in0[0].length,
//                                           ladiesColor:
//                                               row2col13in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row2col13in0[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       //// addding seatss

//                                                       _ontapRow2Column13Index0 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row2col13in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row2col13in0[0]
//                                                                       .name,
//                                                               ladies: row2col13in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row2col13in0[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow2Column13Index0 =
//                                                             !_ontapRow2Column13Index0;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow2Column13Index0 ==
//                                                   true
//                                               ? row2col13in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row2col13in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row2col13in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row2col13in0[0].name,
//                                         ),
//                                   row1col13in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : row1col13in0[0].length == '2'
//                                           ? SeatContainerModelLength(
//                                               length: row1col13in0[0].length,
//                                               ladiesColor:
//                                                   row1col13in0[0].ladiesSeat ==
//                                                           'true'
//                                                       ? Colors.pink
//                                                       : Colors.black,
//                                               onTap:
//                                                   row1col13in0[0].available ==
//                                                           'true'
//                                                       ? () {
//                                                           //// addding seatss

//                                                           _ontapRow1Column13Index0 ==
//                                                                   true
//                                                               ? listSeatNameClass.add(ListOfSeatClass(
//                                                                   fareSeat:
//                                                                       row1col13in0[0]
//                                                                           .fare,
//                                                                   name:
//                                                                       row1col13in0[0]
//                                                                           .name,
//                                                                   ladies: row1col13in0[0]
//                                                                               .ladiesSeat ==
//                                                                           'true'
//                                                                       ? 'true'
//                                                                       : 'false'))
//                                                               : listSeatNameClass
//                                                                   .removeWhere((item) =>
//                                                                       item.name ==
//                                                                       row1col13in0[
//                                                                               0]
//                                                                           .name);

//                                                           setState(() {
//                                                             _ontapRow1Column13Index0 =
//                                                                 !_ontapRow1Column13Index0;
//                                                           });
//                                                         }
//                                                       : () {},
//                                               color: _ontapRow1Column13Index0 ==
//                                                       true
//                                                   ? row1col13in0[0]
//                                                                   .ladiesSeat ==
//                                                               'true' &&
//                                                           row1col13in0[0]
//                                                                   .available ==
//                                                               'false'
//                                                       ? Colors.pink
//                                                       : row1col13in0[0]
//                                                                   .available ==
//                                                               'false'
//                                                           ? Colors.grey
//                                                           : Colors.white
//                                                   : Colors.green,
//                                               listObj: row1col13in0[0].name,
//                                             )
//                                           : SeatContainerModelWidth(
//                                               width: row1col13in0[0].width,
//                                               ladiesColor:
//                                                   row1col13in0[0].ladiesSeat ==
//                                                           'true'
//                                                       ? Colors.pink
//                                                       : Colors.black,
//                                               onTap:
//                                                   row1col13in0[0].available ==
//                                                           'true'
//                                                       ? () {
//                                                           //// addding seatss

//                                                           _ontapRow1Column13Index0 ==
//                                                                   true
//                                                               ? listSeatNameClass.add(ListOfSeatClass(
//                                                                   fareSeat:
//                                                                       row1col13in0[0]
//                                                                           .fare,
//                                                                   name:
//                                                                       row1col13in0[0]
//                                                                           .name,
//                                                                   ladies: row1col13in0[0]
//                                                                               .ladiesSeat ==
//                                                                           'true'
//                                                                       ? 'true'
//                                                                       : 'false'))
//                                                               : listSeatNameClass
//                                                                   .removeWhere((item) =>
//                                                                       item.name ==
//                                                                       row1col13in0[
//                                                                               0]
//                                                                           .name);

//                                                           setState(() {
//                                                             _ontapRow1Column13Index0 =
//                                                                 !_ontapRow1Column13Index0;
//                                                           });
//                                                         }
//                                                       : () {},
//                                               color: _ontapRow1Column13Index0 ==
//                                                       true
//                                                   ? row1col13in0[0]
//                                                                   .ladiesSeat ==
//                                                               'true' &&
//                                                           row1col13in0[0]
//                                                                   .available ==
//                                                               'false'
//                                                       ? Colors.pink
//                                                       : row1col13in0[0]
//                                                                   .available ==
//                                                               'false'
//                                                           ? Colors.grey
//                                                           : Colors.white
//                                                   : Colors.green,
//                                               listObj: row1col13in0[0].name,
//                                             ),
//                                   row0col13in0.toString() == '[]'
//                                       ? DummyContainer()
//                                       : SeatContainerModelLength(
//                                           length: row0col13in0[0].length,
//                                           ladiesColor:
//                                               row0col13in0[0].ladiesSeat ==
//                                                       'true'
//                                                   ? Colors.pink
//                                                   : Colors.black,
//                                           onTap:
//                                               row0col13in0[0].available ==
//                                                       'true'
//                                                   ? () {
//                                                       //// addding seatss

//                                                       _ontapRow0Column13Index0 ==
//                                                               true
//                                                           ? listSeatNameClass.add(ListOfSeatClass(
//                                                               fareSeat:
//                                                                   row0col13in0[0]
//                                                                       .fare,
//                                                               name:
//                                                                   row0col13in0[0]
//                                                                       .name,
//                                                               ladies: row0col13in0[
//                                                                               0]
//                                                                           .ladiesSeat ==
//                                                                       'true'
//                                                                   ? 'true'
//                                                                   : 'false'))
//                                                           : listSeatNameClass
//                                                               .removeWhere((item) =>
//                                                                   item.name ==
//                                                                   row0col13in0[
//                                                                           0]
//                                                                       .name);

//                                                       setState(() {
//                                                         _ontapRow0Column13Index0 =
//                                                             !_ontapRow0Column13Index0;
//                                                       });
//                                                     }
//                                                   : () {},
//                                           color: _ontapRow0Column13Index0 ==
//                                                   true
//                                               ? row0col13in0[0].ladiesSeat ==
//                                                           'true' &&
//                                                       row0col13in0[0]
//                                                               .available ==
//                                                           'false'
//                                                   ? Colors.pink
//                                                   : row0col13in0[0].available ==
//                                                           'false'
//                                                       ? Colors.grey
//                                                       : Colors.white
//                                               : Colors.green,
//                                           listObj: row0col13in0[0].name,
//                                         ),
//                                 ],
//                               ),
//                             ], //
//                           ),
//                         ),
//                       ),
//               ]);
//             }

//             return Container();
//           },
//         ),
//       ),
//     );
//   }
// }

// List<ListOfSeatClass> welcomeFromMap(String str) => List<ListOfSeatClass>.from(
//     json.decode(str).map((x) => ListOfSeatClass.fromMap(x)));

// String welcomeToMap(List<ListOfSeatClass> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

// class ListOfSeatClass {
//   String name;
//   String ladies;
//   String fareSeat;

//   ListOfSeatClass(
//       {required this.name, required this.ladies, required this.fareSeat});
//   factory ListOfSeatClass.fromMap(Map<String, dynamic> json) => ListOfSeatClass(
//         name: json["name"],
//         ladies: json["ladies"],
//         fareSeat: json["fareSeat"],
//       );
//   Map<String, dynamic> toMap() => {
//         "name": name,
//         "ladies": ladies,
//         "fareSeat": fareSeat,
//       };
// }

// class SmallContainers extends StatelessWidget {
//   SmallContainers(
//       {Key? key, required this.backColor, required this.borderColor})
//       : super(key: key);
//   final backColor;
//   final borderColor;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: backColor,
//         border: Border.all(width: 1.1, color: borderColor),
//         borderRadius: BorderRadius.circular(1),
//       ),
//       height: 17,
//       width: 17,
//     );
//   }
// }

// class TextWhiteNormalSize extends StatelessWidget {
//   TextWhiteNormalSize({Key? key, required this.test}) : super(key: key);

//   String test;

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       test,
//       style: TextStyle(color: Colors.white),
//     );
//   }
// }

// class DummyContainer extends StatelessWidget {
//   const DummyContainer({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(4.0),
//       child: Container(
//         height: 34.5,
//         width: MediaQuery.of(context).size.width / 10,
//       ),
//     );
//   }
// }

// class SeatContainerModelLength extends StatelessWidget {
//   const SeatContainerModelLength({
//     Key? key,
//     required this.listObj,
//     required this.color,
//     required this.ladiesColor,
//     required this.onTap,
//     required this.length,
//   }) : super(key: key);

//   final String listObj;
//   final dynamic color;
//   final dynamic onTap;
//   final dynamic ladiesColor;
//   final String length;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(4.0),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           decoration: BoxDecoration(
//             color: color,
//             border: Border.all(width: 1.1, color: ladiesColor),
//             borderRadius: BorderRadius.circular(5),
//           ),
//           height: 45 * double.parse(length),
//           width: 45,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 listObj,
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SeatContainerModelWidth extends StatelessWidget {
//   const SeatContainerModelWidth({
//     Key? key,
//     required this.listObj,
//     required this.color,
//     required this.ladiesColor,
//     required this.onTap,
//     required this.width,
//   }) : super(key: key);

//   final String listObj;
//   final dynamic color;
//   final dynamic onTap;
//   final dynamic ladiesColor;
//   final String width;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(4.0),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           decoration: BoxDecoration(
//             color: color,
//             border: Border.all(width: 1.1, color: ladiesColor),
//             borderRadius: BorderRadius.circular(5),
//           ),
//           height: 35,
//           width: 29 * double.parse(width),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 listObj,
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
