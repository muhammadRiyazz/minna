// import 'package:flutter/material.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../application/first_bloc/bloc/bloc/wallet_bloc_bloc.dart';
// import '../../domain/model_bus_seats/model_bus_seats.dart';
// import '../../domain/model_bus_seats/test_model.dart';

// class SeatsScreen extends StatefulWidget {
//   const SeatsScreen({Key? key}) : super(key: key);

//   @override
//   State<SeatsScreen> createState() => _SeatsScreenState();
// }

// class _SeatsScreenState extends State<SeatsScreen> {
//   List lowerListColumn0 = [];
//   // List<String> items = <String>['1', '2', '3', '4', '5'];
//   List upperBirth = [];
//   List<String> coluMn = [];
//   List<Seat> seatList = [];
//   String columnString = '';
//   List result = [];
//   List lowerList = [];
//   List rowLowerList = [];
//   List colLowerList = [];
//   List lowerListRow4 = [];
//   List lowerListRow3 = [];
//   List lowerListRow2 = [];
//   List<List<dynamic>> lowerListRow2Sorted = [];
//   List lowerListRow1 = [];
//   List lowerListRow0 = [];
//   List sortIng = [];
//   List<List<dynamic>> sortIngNameAndAvailable = [];
//   List<List<dynamic>> sortIngNameAndAvailableRow2 = [];
//   List<List<dynamic>> sortIngNameAndAvailableRow2Return = [];
//   // List<List<dynamic>> sortIngNameAndAvailableRow2String = [];
//   List<List<dynamic>> sortIngNameAndAvailableRow2String = [];

//   List<List<dynamic>> coluAvaName = [];
//   List sortIngNameAndAvailableReturn = [];
//   @override
//   Widget build(BuildContext context) {
//     context.read<FirstBlocRedBus>().add(SeatsAvailableEvent(tripIde: ''));
//     return Scaffold(
//       body: SafeArea(
//         child: BlocBuilder<FirstBlocRedBus, WalletBlocState>(
//           builder: (context, state) {
//             if (state is GettingBusSeats) {
//               return CircularProgressIndicator();
//             }
//             if (state is NetworkErrorBusSeatState) {
//               return Text(state.error);
//             }
//             if (state is GotDataBusSeatState) {
//               seatList = state.modelListofSeats.seats;
//               print('Seats ${seatList}');
//               lowerList = seatList.where((seat) => seat.zIndex == '0').toList();

//               print('sssssssssssssssssssssssssssssssssssssssssssssssssss');

//               rowLowerList =
//                   seatList.where((seat) => seat.zIndex == '0').toList();
//               lowerListRow4 = seatList
//                   .where((seat) => seat.zIndex == '0' && seat.row == '4')
//                   .toList();
//               lowerListRow3 = seatList
//                   .where(
//                     (seat) => seat.zIndex == '0' && seat.row == '3',
//                   )
//                   .toList();
//               lowerListRow2 = seatList
//                   .where(
//                     (seat) => seat.zIndex == '0' && seat.row == '2',
//                   )
//                   .toList();
//               lowerListRow1 = seatList
//                   .where(
//                     (seat) => seat.zIndex == '0' && seat.row == '1',
//                   )
//                   .toList();
//               lowerListRow0 = seatList
//                   .where(
//                     (seat) => seat.zIndex == '0' && seat.row == '0',
//                   )
//                   .toList();

//               print('4th Rowwww');
//               print(lowerListRow4);
//               print(lowerListRow4.length);
//               print(lowerListRow4[0].name);

//               print('new list ${lowerListRow0}');
//               sortIng = lowerListRow0.map((e) {
//                 return e.name;
//               }).toList();
//               print('srting');
//               print(sortIng);

//               sortIngNameAndAvailable = lowerListRow0.map((e) {
//                 sortIngNameAndAvailableReturn = [e.column, e.available, e.name];
//                 return sortIngNameAndAvailableReturn;
//               }).toList();
//               print('List for 3 value');
//               // coluAvaName = sortIngNameAndAvailable;
//               print(sortIngNameAndAvailable);
//               print('objectdddddddddddddddddddddddddddddddd');

//               sortIngNameAndAvailable.sort(
//                   (List<dynamic> a, List<dynamic> b) => a[2].compareTo(b[2]));

//               print('Final sort${sortIngNameAndAvailable}');
//               print(lowerListRow0.map((e) {
//                 sortIngNameAndAvailableReturn = [e.column, e.available, e.name];

//                 return sortIngNameAndAvailableReturn;
//               }));

//               print('Sorting/Available ${sortIngNameAndAvailable}');

//               lowerListRow0.forEach((element) {
//                 print(element.name);
//               });
//               print('sorting${lowerListRow0.toString()}');

//               print('Listtt${lowerListRow0}');
//               lowerListRow0.forEach(
//                 (element) => print(element.name),
//               );

//               print(
//                   seatList.where((seat) => seat.available == 'true').toList());
//               print(lowerList);
//               lowerList.forEach((element) {
//                 print(element.zIndex);
//               });

//               //
//               print(' second Rowwwwwwwwww ');
//               print(lowerListRow2);

//               lowerListRow2.forEach((element) {
//                 print(element.name);
//               });

//               print('unnnakkan');

//               print(lowerListRow2
//                   .map((e) => [e.column, e.row, e.name, e.available])
//                   .toList());
//               sortIngNameAndAvailableRow2String = lowerListRow2.map((e) {
//                 return [
//                   int.parse(e.column.toString()),
//                   e.row.toString(),
//                   e.name.toString(),
//                   e.available.toString()
//                 ];
//               }).toList();

//               print('Rajivvv ${sortIngNameAndAvailableRow2String}');

//               print('finall sortingggg');
//               List<List<dynamic>> listinnnnn =
//                   sortIngNameAndAvailableRow2String;

//               listinnnnn.sort(
//                   (List<dynamic> a, List<dynamic> b) => a[0].compareTo(b[0]));
//               print(listinnnnn);

//               listinnnnn.toList();
//               print(listinnnnn.toList());

//               return Column(
//                 children: [
//                   Text(
//                       'Total seats ${state.modelListofSeats.seats.length.toString()}'),
//                   Row(
//                     children: [
//                       Container(
//                         width: 60,
//                         color: Colors.red,
//                         height: 650,
//                         child: ListView.builder(
//                             itemCount: lowerListRow4.length,
//                             itemBuilder: (c, i) {
//                               return Column(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(3.0),
//                                     child: SeatContainer(
//                                       color:
//                                           lowerListRow4[i].available == 'true'
//                                               ? Colors.white
//                                               : Colors.grey,
//                                       // available: lowerListRow4[i].available,
//                                       column: '1',
//                                       index: '1',
//                                       length: '1',
//                                       name: lowerListRow4[i].name,
//                                       row: lowerListRow4[i].row,
//                                       width: '10',
//                                       height: '100',
//                                     ),
//                                   ),
//                                   // Text('${lowerListRow4[i].row}/'),
//                                   // Text(lowerListRow4[i].name),
//                                 ],
//                               );
//                             }),
//                       ),
//                       Container(
//                         width: 60,
//                         color: Colors.blue,
//                         height: 640,
//                         child: ListView.builder(
//                             itemCount: lowerListRow3.length,
//                             itemBuilder: (c, i) {
//                               return Row(
//                                 children: [
//                                   // SeatContainer(
//                                   //   available: lowerListRow3[i].available,
//                                   //   column: '1',
//                                   //   index: '1',
//                                   //   length: '1',
//                                   //   name: lowerListRow3[i].name,
//                                   //   row: lowerListRow3[i].row,
//                                   //   width: '10',
//                                   //   height: '100',
//                                   // ),
//                                   Text('${lowerListRow3[i].row}/'),
//                                   Text(lowerListRow3[i].name),
//                                 ],
//                               );
//                             }),
//                       ),
//                       Container(
//                         width: 60,
//                         color: Colors.pink,
//                         height: 650,
//                         child: ListView.builder(
//                             itemCount: lowerListRow2.length,
//                             itemBuilder: (c, i) {
//                               return Column(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(3.0),
//                                     child: SeatContainer(
//                                       color:
//                                           lowerListRow2[i].available == 'true'
//                                               ? Colors.white
//                                               : Colors.grey,
//                                       // available: lowerListRow2[i].available,
//                                       column: '1',
//                                       index: '1',
//                                       length: '1',
//                                       name: lowerListRow2[i].name,
//                                       row: lowerListRow2[i].row,
//                                       width: '10',
//                                       height: '100',
//                                     ),
//                                   ),
//                                   // Text(lowerListRow2[i].name),
//                                   // Text(lowerListRow2[i].column),
//                                 ],
//                               );
//                             }),
//                       ),
//                       Container(
//                         width: 60,
//                         color: Colors.indigo,
//                         height: 650,
//                         child: ListView.builder(
//                             itemCount: lowerListRow1.length,
//                             itemBuilder: (c, i) {
//                               return Column(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(3.0),
//                                     child: SeatContainer(
//                                       color:
//                                           lowerListRow1[i].available == 'true'
//                                               ? Colors.white
//                                               : Colors.grey,
//                                       // available: lowerListRow1[i].available,
//                                       column: '1',
//                                       index: '1',
//                                       length: '1',
//                                       name: lowerListRow1[i].name,
//                                       row: lowerListRow1[i].row,
//                                       width: '10',
//                                       height: '100',
//                                     ),
//                                   ),
//                                   // Text('${lowerListRow1[i].row}/'),
//                                   // Text(lowerListRow1[i].name),
//                                 ],
//                               );
//                             }),
//                       ),
//                       Container(
//                         width: 60,
//                         color: Color.fromRGBO(76, 175, 80, 1),
//                         height: 650,
//                         child: ListView.builder(
//                             itemCount: lowerListRow0.length,
//                             itemBuilder: (c, i) {
//                               return Row(
//                                 children: [
//                                   Text('R ${lowerListRow0[i].row}/'),
//                                   Text(lowerListRow0[i].name),
//                                   Text(lowerListRow0[i].available),
//                                   Text(lowerListRow0[i].column),
//                                 ],
//                               );
//                             }),
//                       ),
//                       // Container(
//                       //   width: 100,
//                       //   color: Colors.grey,
//                       //   height: 250,
//                       //   child: ListView.builder(
//                       //       itemCount: sortIng.length,
//                       //       itemBuilder: (c, i) {
//                       //         return Row(
//                       //           children: [
//                       //             Text('${lowerListRow0[i].row}/'),
//                       //             Text(sortIng[i]),
//                       //             Text(state
//                       //                 .modelListofSeats.seats[i].available),
//                       //           ],
//                       //         );
//                       //       }),
//                       // )
//                     ],
//                   )
//                 ],
//               );
//             }
//             return Container();
//           },
//         ),
//       ),
//     );
//   }
// }

// class SeatContainer extends StatelessWidget {
//   SeatContainer(
//       {Key? key,
//       required this.width,
//       required this.length,
//       required this.index,
//       required this.row,
//       required this.column,
//       required this.name,
//       required this.height,
//       // required this.available,
//       required this.color})
//       : super(key: key);

//   String width;
//   String height;
//   // String available;
//   String length;
//   String index;
//   String row;
//   String column;
//   String name;
//   final color;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.parse(width + 5.toString()),
//       height: double.parse(height),
//       color: color,
//       child: Column(
//         children: [
//           Text(name),
//           Text(row),
//           // Text(available),
//         ],
//       ),
//     );
//   }
// }
// // GridView.custom(
// //                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                           crossAxisCount: 5),
// //                       childrenDelegate: SliverChildBuilderDelegate(
// //                         (BuildContext context, int index) {
// //                           // print(items.length);
// //                           // print('Key value ${items[index]}');
// //                           print(
// //                               'No of sets : ${state.modelListofSeats.seats.length}');

// //                           print(upperBirth);

// //                           print(
// //                               'Column ${state.modelListofSeats.seats[index].column}');

// //                           state.modelListofSeats.seats[index].column.characters
// //                               .forEach((element) {
// //                             element;
// //                           });

// //                           // upperBirth.take(index);
// //                           // print(upperBirth.take(index));
// //                           // print(upperBirth);
// //                           return GestureDetector(
// //                             onTap: () {
// //                               print('object');
// //                               // print(items[index]);
// //                               // print(items[index]);
// //                             },
// //                             child: state.modelListofSeats.seats[index].width ==
// //                                     '1'
// //                                 ? Padding(
// //                                     padding: const EdgeInsets.all(3.0),
// //                                     child: Container(
// //                                       height: 100,
// //                                       width: 100,
// //                                       color: state.modelListofSeats.seats[index]
// //                                                   .available ==
// //                                               'true'
// //                                           ? Colors.yellow
// //                                           : Colors.white,
// //                                       child: Column(
// //                                         children: [
// //                                           // Text(
// //                                           //     'nme${state.modelListofSeats.seats[index].name}'),
// //                                           // Text(
// //                                           //     '${state.modelListofSeats.seats[index].available}'),
// //                                           Text(
// //                                               '${state.modelListofSeats.seats[index].row}'),
// //                                           Text(
// //                                               '${state.modelListofSeats.seats[index].column}'),

// //                                           Text(
// //                                               '${state.modelListofSeats.seats[index].zIndex}'),
// //                                           // Text(
// //                                           //     'w${state.modelListofSeats.seats[index].width}'),
// //                                         ],
// //                                       ),
// //                                     ),
// //                                   )
// //                                 : Text(
// //                                     '${state.modelListofSeats.seats[index].width}'),
// //                           );
// //                         },
// //                         childCount: state.modelListofSeats.seats.length,
// //                         // findChildIndexCallback: (Key key) {
// //                         //   print('find axiss');
// //                         //   final ValueKey<String> valueKey =
// //                         //       key as ValueKey<String>;
// //                         //   final String data = valueKey.value;
// //                         //   return items.indexOf(data);
// //                         // }
// //                       ),
// //                     ),

// class MyListView extends StatefulWidget {
//   const MyListView({Key? key}) : super(key: key);

//   @override
//   State<MyListView> createState() => _MyListViewState();
// }

// class _MyListViewState extends State<MyListView> {
//   List<String> items = <String>['1', '2', '3', '4', '5'];

//   void _reverse() {
//     setState(() {
//       items = items.reversed.toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(items);
//     return Scaffold(
//       body: SafeArea(
//         child: ListView.custom(
//           childrenDelegate: SliverChildBuilderDelegate(
//               (BuildContext context, int index) {
//                 print(items.length);
//                 print('Key value ${items[index]}');
//                 return KeepAlive(
//                   data: items[index],
//                   key: ValueKey<String>(items[index]),
//                 );
//               },
//               childCount: items.length,
//               findChildIndexCallback: (Key key) {
//                 final ValueKey<String> valueKey = key as ValueKey<String>;
//                 final String data = valueKey.value;
//                 return items.indexOf(data);
//               }),
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextButton(
//               onPressed: () => _reverse(),
//               child: const Text('Reverse items'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class KeepAlive extends StatefulWidget {
//   const KeepAlive({
//     required Key key,
//     required this.data,
//   }) : super(key: key);

//   final String data;

//   @override
//   State<KeepAlive> createState() => _KeepAliveState();
// }

// class _KeepAliveState extends State<KeepAlive>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   bool get wantKeepAlive => true;

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return Text(widget.data);
//   }
// }
