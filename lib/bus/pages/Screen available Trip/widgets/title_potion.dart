// import 'package:minna/red_bus/screen/new/const/color.dart';
// import 'package:flutter/material.dart';

// import '../../../../../../domain/data_post_redBus.dart';

// class TitlePotion extends StatelessWidget {
//   const TitlePotion({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final _size = MediaQuery.of(context).size;
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: maincolor1,
//         // borderRadius: BorderRadius.only(
//         //   bottomLeft: Radius.circular(29),
//         //   bottomRight: Radius.circular(29),
//         // ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         //color: Colors.black,
//                         // width: _size.width * .35,
//                         child: Text(
//                           globalPostRedBus.fromLocation,
//                           textAlign: TextAlign.start,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(height: .5, color: Colors.white, width: 10),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 5),
//                           child: Icon(
//                             Icons.directions_bus_outlined,
//                             size: 22,
//                             color: Colors.white,
//                           ),
//                         ),
//                         Container(height: .5, color: Colors.white, width: 10),
//                       ],
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         // width: _size.width * .35,
//                         //color: Colors.black,
//                         child: Text(
//                           globalPostRedBus.toLocation,
//                           textAlign: TextAlign.end,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 // SizedBox(
//                 //   height: 10,
//                 // ),
//                 // Text(
//                 //   globalPostRedBus.dateOfJurny,
//                 //   style: TextStyle(
//                 //       color: Colors.white,
//                 //       fontSize: 16,
//                 //       fontWeight: FontWeight.w300),
//                 // ),
//                 // SizedBox(
//                 //   height: 2,
//                 // ),
//               ],
//             ),
//           ),
//           SizedBox(height: 10),
//         ],
//       ),
//     );
//   }
// }
