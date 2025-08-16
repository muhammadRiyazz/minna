// // To parse this JSON data, do
// //
// //     final boardDropingPointModelClass = boardDropingPointModelClassFromMap(jsondynamic);

import 'package:meta/meta.dart';
import 'dart:convert';

// BoardDropingPointModelClass boardDropingPointModelClassFromMap(dynamic str) =>
//     BoardDropingPointModelClass.fromMap(json.decode(str));

// dynamic boardDropingPointModelClassToMap(BoardDropingPointModelClass data) =>
//     json.encode(data.toMap());

// class BoardDropingPointModelClass {
//   BoardDropingPointModelClass({
//     required this.boardingPoints,
//     required this.droppingPoints,
//   });

//   List<DroppingPoints> boardingPoints;
//   DroppingPoints droppingPoints;

//   factory BoardDropingPointModelClass.fromMap(Map<dynamic, dynamic> json) =>
//       BoardDropingPointModelClass(
//         boardingPoints: List<DroppingPoints>.from(
//             json["boardingPoints"].map((x) => DroppingPoints.fromMap(x))),
//         droppingPoints: DroppingPoints.fromMap(json["droppingPoints"]),
//       );

//   Map<dynamic, dynamic> toMap() => {
//         "boardingPoints":
//             List<dynamic>.from(boardingPoints.map((x) => x.toMap())),
//         "droppingPoints": droppingPoints.toMap(),
//       };
// }

// class DroppingPoints {
//   DroppingPoints({
//     required this.address,
//     required this.contactnumber,
//     required this.id,
//     required this.landmark,
//     required this.locationName,
//     required this.name,
//     required this.rbMasterId,
//   });

//   dynamic address;
//   dynamic contactnumber;
//   dynamic id;
//   dynamic landmark;
//   dynamic locationName;
//   dynamic name;
//   dynamic rbMasterId;

//   factory DroppingPoints.fromMap(Map<dynamic, dynamic> json) => DroppingPoints(
//         address: json["address"],
//         contactnumber: json["contactnumber"],
//         id: json["id"],
//         landmark: json["landmark"],
//         locationName: json["locationName"],
//         name: json["name"],
//         rbMasterId: json["rbMasterId"],
//       );

//   Map<dynamic, dynamic> toMap() => {
//         "address": address,
//         "contactnumber": contactnumber,
//         "id": id,
//         "landmark": landmark,
//         "locationName": locationName,
//         "name": name,
//         "rbMasterId": rbMasterId,
//       };
// }
