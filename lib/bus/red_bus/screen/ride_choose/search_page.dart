// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// import 'package:maaxusminihub/screen/red_bus/domain/data_post_redBus.dart';
// import 'package:maaxusminihub/screen/red_bus/screen/ride_choose/from_to_date.dart';
// import 'package:searchfield/searchfield.dart';

// import '../../domain/search_location/search_location.dart';
// import '../../infrastructure/search_location.dart';

// class SearchingPages extends StatefulWidget {
//   SearchingPages({Key? key, required this.fromOrto}) : super(key: key);
//   //List<ModelSearchLocation>? cityName;
//   String? fromOrto;

//   @override
//   State<SearchingPages> createState() => _SearchingPagesState();
// }

// class _SearchingPagesState extends State<SearchingPages> {
//   TextEditingController _controller = TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   bool isloading = true;
//   bool iserror = false;
//   late List<ModelSearchLocation> locationlist;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: isloading
//             ? Center(child: CircularProgressIndicator())
//             : iserror
//                 ? Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text('Error occurred while loading data  '),
//                         ElevatedButton(
//                             onPressed: fetchData, child: Text('Retry'))
//                       ],
//                     ),
//                   )
//                 : Center(
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 11.0),
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 7, right: 7),
//                             child: SearchField(
//                               onSuggestionTap: widget.fromOrto == 'from'
//                                   ? (e) {
//                                       globalPostRedBus =
//                                           globalPostRedBus.copyWith(
//                                               idFromLocation:
//                                                   e.item.toString());
//                                       print(e.item);
//                                       print(globalPostRedBus.idFromLocation);
//                                     }
//                                   : (e) {
//                                       globalPostRedBus =
//                                           globalPostRedBus.copyWith(
//                                               idToLocation: e.item.toString());
//                                       print(e.item);
//                                       print(globalPostRedBus.toLocation);
//                                     },
//                               controller: _controller,
//                               suggestionStyle: TextStyle(fontSize: 21),
//                               hint: " Search here",
//                               itemHeight: 41,
//                               textInputAction: TextInputAction.next,
//                               searchInputDecoration:
//                                   InputDecoration(fillColor: Colors.blue),
//                               searchStyle: TextStyle(
//                                 fontSize: 17,
//                                 color: Colors.black.withOpacity(0.8),
//                               ),
//                               maxSuggestionsInViewPort: 21,
//                               suggestions: locationlist
//                                   .map(
//                                     (e) => SearchFieldListItem<String>(
//                                         e.cityName,
//                                         child: Text(e.cityName),
//                                         item: e.id.toString()),
//                                   )
//                                   .toList(),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 35),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   },
//                                   child: Text('Back'),
//                                 ),
//                                 ElevatedButton(
//                                   child: Text(
//                                     'Confirm Location',
//                                     style: TextStyle(
//                                         fontSize: 17, color: Colors.white),
//                                   ),
//                                   onPressed: widget.fromOrto == 'from'
//                                       ? () async {
//                                           globalPostRedBus =
//                                               globalPostRedBus.copyWith(
//                                                   fromLocation:
//                                                       _controller.text);
//                                           print(globalPostRedBus);
//                                           await Navigator.pushReplacement(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     FromToDateSearchPage()),
//                                           );
//                                         }
//                                       : () async {
//                                           globalPostRedBus =
//                                               globalPostRedBus.copyWith(
//                                                   toLocation: _controller.text);
//                                           print(globalPostRedBus);
//                                           await Navigator.pushReplacement(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     FromToDateSearchPage()),
//                                           );
//                                         },
//                                   style: ButtonStyle(
//                                       backgroundColor:
//                                           MaterialStateProperty.all(
//                                               Colors.green),
//                                       textStyle: MaterialStateProperty.all(
//                                           TextStyle(fontSize: 17))),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//       ),
//     );
//   }

//   fetchData() async {
//     setState(() {
//       isloading = true;
//       iserror = false;
//     });

//     try {
//       final data = await SearchLocationClass.getSearchLocationData();

//       if (data.statusCode == 200 ||
//           data.body !=
//               'Error: Authorization failed please send valid consumer key and secret in the api request.') {
//         setState(() {
//           isloading = false;
//           locationlist = modelSearchLocationFromJson(data.body);
//         });
//       } else if (data.body ==
//           'Error: Authorization failed please send valid consumer key and secret in the api request.') {}
//     } catch (e) {
//       setState(() {
//         iserror = true;
//         isloading = false;
//       });
//     }
//   }
// }
