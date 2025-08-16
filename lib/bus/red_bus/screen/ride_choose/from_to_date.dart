// import 'dart:developer';

// import 'package:flutter/material.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl/intl.dart';
// import 'package:maaxusminihub/screen/homepage/homepage.dart';
// import 'package:maaxusminihub/screen/insurance/screen/pages/report.dart';

// import 'package:maaxusminihub/screen/red_bus/application/first_bloc/bloc/bloc/wallet_bloc_bloc.dart';
// import 'package:maaxusminihub/screen/red_bus/domain/data_post_redBus.dart';
// import 'package:maaxusminihub/screen/red_bus/domain/search_location/search_location.dart';
// import 'package:maaxusminihub/screen/red_bus/screen/ride_choose/available_bus.dart';

// import 'package:maaxusminihub/screen/red_bus/screen/ride_choose/search_page.dart';
// import 'package:maaxusminihub/screen/red_bus/screen/new/presendation/screen%20reports/screen_reports.dart';
// import 'package:maaxusminihub/screen/red_bus/screen/ticket/save_file_mobile.dart';
// import 'package:maaxusminihub/screen/red_bus/screen/ticket/viewTic.dart';

// import 'package:searchfield/searchfield.dart';

// import '../../../insurance/screen/pages/2whlr_quik2/new_widget.dart';
// import '../ticket/show_ticket.dart';

// class FromToDateSearchPage extends StatefulWidget {
//   FromToDateSearchPage({Key? key}) : super(key: key);

//   @override
//   State<FromToDateSearchPage> createState() => _FromToDateSearchPageState();
// }

// class _FromToDateSearchPageState extends State<FromToDateSearchPage> {
//   DateTime date1 = DateTime.now();
//   DateTime todaydate = DateTime.now();
//   DateTime now = DateTime.now();
//   // DateTime tomorrow = DateTime(now);
//   DateTime? picked;
//   String todaydateNew = DateTime.now().toString().characters.take(10).string;
//   List<ModelSearchLocation>? bankName;

//   bool boolOntap = false;
//   String tempStr = '';
//   String tempStrLocation = '';
//   List _statesOfIndia = ['sdfsd', 'sdfsa'];

//   @override
//   Widget build(BuildContext context) {
//     print('start');
//     // context.read<FirstBlocRedBus>().add(LocationSearchListEvent());

//     return Scaffold(
//       // appBar: AppBar(
//       //   leading: Icon(Icons.list),
//       // ),

//       // drawer: Drawer(
//       //   child: ListView(
//       //     padding: EdgeInsets.zero,
//       //     children: [
//       //       const DrawerHeader(
//       //         decoration: BoxDecoration(
//       //           color: Colors.red,
//       //         ),
//       //         child: Text(
//       //           'mBus',
//       //           style: TextStyle(
//       //               fontSize: 25,
//       //               fontWeight: FontWeight.bold,
//       //               color: Colors.white),
//       //         ),
//       //       ),
//       //       DrawerButton(
//       //           onTap: () async {
//       //             Navigator.push(context, MaterialPageRoute(
//       //               builder: (context) {
//       //                 return ScreenReport();
//       //               },
//       //             ));
//       //           },
//       //           tesT: ' View tickets '),
//       //       // DrawerButton(
//       //       //     onTap: () async {
//       //       //       await Get.to(() => const AddPage());
//       //       //     },
//       //       //     tesT: 'Add Wallet'),
//       //     ],
//       //   ),
//       // ),
//       // appBar: AppBar(
//       //   title: Text('red Bus'),
//       //   leading: IconButton(
//       //     icon: Icon(Icons.arrow_back),
//       //     onPressed: () async {
//       //       await Navigator.pushAndRemoveUntil(
//       //           context,
//       //           MaterialPageRoute(builder: (context) => HomePage()),
//       //           (route) => true);
//       //     },
//       //   ),
//       // ),
//       //
//       //
//       body: Stack(children: [
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.white10,
//             image: const DecorationImage(
//               image: AssetImage('asset/redBus_wallpapper.png'),
//               fit: BoxFit.cover,
//             ),
//             // border: Border.all(
//             //   width: 8,
//             // ),
//             // borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         Padding(
//           padding:
//               EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.5),
//           child: ListView(
//             children: [
//               Stack(
//                 children: [
//                   Card(
//                     color: Color.fromARGB(130, 158, 158, 158),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 15),
//                           child: TextSize15ColorWhite(
//                             test: 'From',
//                           ),
//                         ),
//                         //  BlocBuilder<FirstBlocRedBus, WalletBlocState>(
//                         //  builder: (context, state) {
//                         // if (state is GettingDataSearchLocationState) {
//                         //   return Center(
//                         //     child: Padding(
//                         //       padding: const EdgeInsets.only(top: 15),
//                         //       child: GestureDetector(
//                         //         child: Column(
//                         //           children: [
//                         //             CircularProgressIndicator(
//                         //               color: Colors.red,
//                         //             ),
//                         //             TextButton(
//                         //                 onPressed: () {
//                         //                   context
//                         //                       .read<FirstBlocRedBus>()
//                         //                       .add(
//                         //                           LocationSearchListEvent());
//                         //                 },
//                         //                 child: Text(
//                         //                   'Refresh',
//                         //                   style:
//                         //                       TextStyle(color: Colors.red),
//                         //                 ))
//                         //           ],
//                         //         ),
//                         //         onTap: () {
//                         //           context
//                         //               .read<FirstBlocRedBus>()
//                         //               .add(LocationSearchListEvent());
//                         //         },
//                         //       ),
//                         //     ),
//                         //   );
//                         // }
//                         // if (state is NetworkErrorState) {
//                         //   return Text19Black(test: '');
//                         // }
//                         // if (state is GotDataSearchLocationListState) {
//                         // return
//                         FromButton(
//                           froName: boolOntap == true
//                               ? globalPostRedBus.toLocation
//                               : globalPostRedBus.fromLocation,
//                           image: 'bus_entering.png',
//                           onTap: () async {
//                             // await CreatePdf().createPdf2();

//                             await Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => SearchingPages(
//                                   fromOrto: 'from',
//                                   // cityName: state.modelList,
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                         // }
//                         // return Container();
//                         // },
//                         //   ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 15),
//                           child: TextSize15ColorWhite(
//                             test: 'To',
//                           ),
//                         ),
//                         // BlocBuilder<FirstBlocRedBus, WalletBlocState>(
//                         //  builder: (context, state) {
//                         // if (state is GettingDataSearchLocationState) {
//                         //   return Text('');
//                         // }
//                         // if (state is NetworkErrorState) {
//                         //   context
//                         //       .read<FirstBlocRedBus>()
//                         //       .add(LocationSearchListEvent());
//                         //   return Container(
//                         //     width: double.infinity,
//                         //     child: TextButton(
//                         //       child:
//                         //           TextSize15ColorWhite(test: ' Refresh '),
//                         //       onPressed: () {
//                         //         context
//                         //             .read<FirstBlocRedBus>()
//                         //             .add(LocationSearchListEvent());
//                         //       },
//                         //     ),
//                         //   );
//                         // }
//                         //if (state is GotDataSearchLocationListState) {
//                         //  return
//                         FromButton(
//                           froName: boolOntap == true
//                               ? globalPostRedBus.fromLocation
//                               : globalPostRedBus.toLocation,
//                           image: 'bus_out.png',
//                           onTap: () async {
//                             await Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => SearchingPages(
//                                   fromOrto: 'to',
//                                   //  cityName: state.modelList,
//                                 ),
//                               ),
//                             );
//                             // await Navigator.push(
//                             //   context,
//                             //   MaterialPageRoute(
//                             //       builder: (context) => TicketScr()),
//                             // );
//                           },
//                         ),
//                         // }
//                         // return Container();
//                         //},
//                         // ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 269, top: 63),
//                     child: IconButton(
//                       icon: Icon(
//                         Icons.swap_vert_circle,
//                         size: 67,
//                         color: Colors.grey,
//                       ),
//                       onPressed: () async {
//                         boolOntap == false
//                             ? tempStr = globalPostRedBus.idFromLocation
//                             : tempStr = globalPostRedBus.idFromLocation;

//                         print(tempStr);
//                         boolOntap == false
//                             ? globalPostRedBus = globalPostRedBus.copyWith(
//                                 idFromLocation: globalPostRedBus.idToLocation)
//                             : globalPostRedBus = globalPostRedBus.copyWith(
//                                 idFromLocation: globalPostRedBus.idToLocation);

//                         boolOntap == false
//                             ? globalPostRedBus =
//                                 globalPostRedBus.copyWith(idToLocation: tempStr)
//                             : globalPostRedBus = globalPostRedBus.copyWith(
//                                 idToLocation: tempStr);

//                         setState(() {
//                           print('onTap');
//                           boolOntap = !boolOntap;
//                         });
//                       },
//                     ),
//                   )
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   GestureDetector(
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                           builder: (context, child) {
//                             return Theme(
//                               data: Theme.of(context).copyWith(
//                                 colorScheme: ColorScheme.light(
//                                   primary: Colors.black, // <-- SEE HERE
//                                   onPrimary: Colors.white, // <-- SEE HERE
//                                   onSurface: Colors.black, // <-- SEE HERE
//                                 ),
//                               ),
//                               child: child!,
//                             );
//                           },
//                           context: context, //context of current state
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime
//                               .now(), //DateTime.now() - not to allow to choose before today.
//                           lastDate: DateTime(2101));

//                       if (pickedDate != null) {
//                         print(
//                             pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
//                         String formattedDate =
//                             DateFormat('yyyy-MM-dd').format(pickedDate);

//                         todaydateNew = formattedDate;
//                         print('****************************');
//                         print(formattedDate);
//                         print(todaydateNew);
//                         //XZformatted date output using intl package =>  2021-03-16
//                         globalPostRedBus = globalPostRedBus.copyWith(
//                             dateOfJurny: formattedDate);

//                         setState(() {});
//                       } else {}
//                     },
//                     child: Padding(
//                       padding:
//                           const EdgeInsets.only(top: 15, left: 5, right: 5),
//                       child: Container(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Icon(
//                               Icons.calendar_month_outlined,
//                               color: Colors.green,
//                             ),
//                             TextSize17White(
//                               test: todaydateNew,
//                             )
//                           ],
//                         ),
//                         height: 50,
//                         width: 150,
//                         decoration: BoxDecoration(
//                           color: Colors.white10,
//                           border: Border.all(
//                             color: Colors.black,
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 11.0),
//                     child: Row(
//                       children: [
//                         TextButton(
//                           onPressed: () async {
//                             print(todaydate.toString().characters.take(10));
//                             globalPostRedBus = globalPostRedBus.copyWith(
//                                 dateOfJurny: todaydate
//                                     .toString()
//                                     .characters
//                                     .take(10)
//                                     .toString());
//                             // print(todaydate
//                             //     .isAfter(DateTime.now().add(Duration(days: 1))));
//                             // print(todaydate.day + 1);
//                             await Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => AvailableBusScreen()),
//                             );
//                             setState(() {});
//                             // await ApiCallBackFromPhp().getDataFromPhpBackend();
//                             // await Navigator.push(
//                             //   context,
//                             //   MaterialPageRoute(
//                             //       builder: (context) =>
//                             //           BoardingPointDropingPoint()),
//                             // );
//                             // print('Tapped Today');
//                             // print(globalPostRedBus.dateOfJurny);
//                           },
//                           child: TextSize17White(
//                             test: 'Today',
//                           ),
//                         ),
//                         TextSize17BoldWhite(test: 'I'),
//                         TextButton(
//                           onPressed: () async {
//                             globalPostRedBus = globalPostRedBus.copyWith(
//                                 dateOfJurny:
//                                     '${todaydate.year}-${todaydate.month}-${todaydate.day + 1}');

//                             await Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => AvailableBusScreen()),
//                             );

//                             ///////////////
//                           },
//                           child: TextSize17White(
//                             test: 'Tommorow',
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 15, right: 9, left: 9),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,

//                     shadowColor: Colors.white,
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(9.0)),
//                     minimumSize: Size(double.infinity, 40), //////// HERE
//                   ),
//                   onPressed: globalPostRedBus.dateOfJurny == ''
//                       ? () async {
//                           await Fluttertoast.showToast(msg: 'Choose Date');
//                         }
//                       : () async {
//                           await Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>

//                                   //  Sample()
//                                   AvailableBusScreen(),
//                               // NewwwBuAvaScreennn()
//                             ),
//                           );
//                           setState(() {});
//                         },
//                   child: Text(
//                     ' Search Bus ',
//                     style: TextStyle(color: Colors.white, fontSize: 19),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ]),
//     );
//   }
// }

// class FromButton extends StatelessWidget {
//   FromButton(
//       {Key? key,
//       required this.image,
//       required this.froName,
//       required this.onTap})
//       : super(key: key);
//   String image;
//   String froName;
//   final onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 7, right: 7, top: 3, bottom: 3),
//       child: ElevatedButton(
//         onPressed: onTap,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Image.asset(
//               'asset/${image}',
//               width: 50,
//               height: 50,
//               color: Colors.white,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 7),
//               child: TextSize17ColorWhite(test: froName),
//             ),
//           ],
//         ),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.transparent,
//           side: BorderSide(color: Colors.black38),
//           shape: RoundedRectangleBorder(
//             borderRadius: new BorderRadius.circular(11.0),
//           ),
//           minimumSize: Size(300, 50),
//         ),
//       ),
//     );
//   }
// }

// class SearchFieldFromTo extends StatelessWidget {
//   SearchFieldFromTo({Key? key, required this.bankName}) : super(key: key);
//   List<ModelSearchLocation>? bankName;
//   SearchFieldListItem<String>? initialValue;
//   @override
//   Widget build(BuildContext context) {
//     // context.read<FirstBlocRedBus>().add(LocationSearchListEvent());
//     return Scaffold(
//       body: SafeArea(
//         child: ListView(
//           children: [
//             SearchField(
//               suggestions: bankName!
//                   .map(
//                     (e) => SearchFieldListItem<String>(
//                       e.cityName,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 5),
//                         child: GestureDetector(
//                           onTap: () async {
//                             print('onnnnnnnnnn ttttttaaaaaaapppppp');
//                             globalPostRedBus = globalPostRedBus.copyWith(
//                                 fromLocation: e.cityName);
//                             print(globalPostRedBus.fromLocation);
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       // SearchFieldFromTo(
//                                       //   bankName: state.modelList,
//                                       // )
//                                       FromToDateSearchPage()),
//                             );
//                           },
//                           child: Container(
//                             child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text19Black(
//                                     test: e.cityName,
//                                   ),
//                                   Icon(Icons.arrow_forward_ios_outlined)
//                                 ]),
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                   .toList(),
//               textInputAction: TextInputAction.next,
//               hint: 'SearchField Example 2',
//               // hasOverlay: false,
//               searchStyle: TextStyle(
//                 fontSize: 18,
//                 color: Colors.black.withOpacity(0.8),
//               ),

//               searchInputDecoration: InputDecoration(
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.black.withOpacity(0.8),
//                   ),
//                 ),
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.red),
//                 ),
//               ),
//               maxSuggestionsInViewPort: 6,
//               itemHeight: 50,
//               //  onTap: (x) {},
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: BlocBuilder<FirstBlocRedBus, WalletBlocState>(
//                 builder: (context, state) {
//                   if (state is GettingDataSearchLocationState) {
//                     return CircularProgressIndicator();
//                   }
//                   if (state is NetworkErrorState) {
//                     return Text19Black(test: state.error);
//                   }
//                   if (state is GotDataSearchLocationListState) {
//                     return Container(
//                       height: 50,
//                       width: double.infinity,
//                       child: SearchField(
//                         // initialValue: ,

//                         // onSubmit: (String test) {
//                         //   print('on submity');
//                         //   print(test);
//                         //   globalPostRedBus =
//                         //       globalPostRedBus.copyWith(fromLocation: test);
//                         // },
//                         itemHeight: 41,
//                         textInputAction: TextInputAction.next,
//                         // controller: _contLer,
//                         searchInputDecoration:
//                             InputDecoration(fillColor: Colors.blue),
//                         // hasOverlay: false,
//                         searchStyle: TextStyle(
//                           fontSize: 17,
//                           color: Colors.black.withOpacity(0.8),
//                         ),

//                         // hint: '    Search here',
//                         maxSuggestionsInViewPort: 15,
//                         suggestions: state.modelList
//                             .map(
//                               (e) => SearchFieldListItem<String>(
//                                 e.cityName,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(left: 5),
//                                   child: GestureDetector(
//                                     onTap: () async {
//                                       print('onnnnnnnnnn ttttttaaaaaaapppppp');
//                                       globalPostRedBus = globalPostRedBus
//                                           .copyWith(fromLocation: e.cityName);
//                                       print(globalPostRedBus.fromLocation);
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 // SearchFieldFromTo(
//                                                 //   bankName: state.modelList,
//                                                 // )
//                                                 FromToDateSearchPage()),
//                                       );
//                                     },
//                                     child: Container(
//                                       child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text19Black(
//                                               test: e.cityName,
//                                             ),
//                                             Icon(Icons
//                                                 .arrow_forward_ios_outlined)
//                                           ]),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             )
//                             .toList(),
//                       ),
//                     );
//                   }
//                   return Container();
//                 },
//               ),
//             ),
//             Container(
//               height: 750,
//               width: double.infinity,
//               child: BlocBuilder<FirstBlocRedBus, WalletBlocState>(
//                 builder: (context, state) {
//                   return ListView.builder(
//                       itemCount: bankName?.length,
//                       itemBuilder: (c, i) {
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 15, top: 5, bottom: 5),
//                               child: GestureDetector(
//                                   onTap: () async {
//                                     print('ontap');
//                                   },
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       TextSize17(test: bankName![i].cityName),
//                                       IconButton(
//                                           onPressed: () {},
//                                           icon: Icon(
//                                               Icons.arrow_forward_ios_outlined))
//                                     ],
//                                   )),
//                             ),
//                             Divider(
//                               thickness: 1,
//                             )
//                           ],
//                         );
//                       });
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // class SerchListRedBus extends StatefulWidget {
// //   const SerchListRedBus({Key? key}) : super(key: key);

// //   @override
// //   State<SerchListRedBus> createState() => _SerchListRedBusState();
// // }

// // class _SerchListRedBusState extends State<SerchListRedBus> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: ,
// //     );
// //   }
// // }

// class FormFieldValidatorFromTo extends StatelessWidget {
//   FormFieldValidatorFromTo({
//     Key? key,
//     required TextEditingController controller,
//     required this.headTest,
//     required this.validator,
//   })  : _controller = controller,
//         super(key: key);

//   final TextEditingController _controller;
//   String headTest;
//   dynamic validator;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextFormField(
//         validator: validator,
//         controller: _controller,
//         decoration: InputDecoration(
//           label: Padding(
//             padding: const EdgeInsets.only(left: 5),
//             child: Text(
//               headTest,
//               style: TextStyle(fontSize: 17),
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: BorderSide(color: Colors.black, width: 1),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: BorderSide(color: Colors.black, width: 1),
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class TextSize17White extends StatelessWidget {
//   TextSize17White({
//     Key? key,
//     required this.test,
//   }) : super(key: key);
//   String test;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(3.0),
//       child: Text(
//         test,
//         style: TextStyle(fontSize: 17, color: Colors.white),
//       ),
//     );
//   }
// }

// class TextSize15ColorWhite extends StatelessWidget {
//   TextSize15ColorWhite({
//     Key? key,
//     required this.test,
//   }) : super(key: key);
//   String test;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(3.0),
//       child: Text(
//         test,
//         style: TextStyle(fontSize: 17, color: Colors.white),
//       ),
//     );
//   }
// }

// class TextSize17ColorWhite extends StatelessWidget {
//   TextSize17ColorWhite({
//     Key? key,
//     required this.test,
//   }) : super(key: key);
//   String test;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(3.0),
//       child: Text(
//         test,
//         style: TextStyle(fontSize: 17, color: Colors.white),
//       ),
//     );
//   }
// }

// class DrawerButton extends StatelessWidget {
//   DrawerButton({Key? key, required this.tesT, required this.onTap})
//       : super(key: key);
//   String tesT;
//   dynamic onTap;
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [Text(tesT), const Icon(Icons.arrow_forward)],
//       ),
//       onTap: onTap
//       // Update the state of the app
//       // ...
//       // Then close the drawer
//       // Navigator.pop(context);
//       ,
//     );
//   }
// }
