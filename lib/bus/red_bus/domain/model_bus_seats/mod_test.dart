// To parse this JSON data, do
//
//     final boardDropingPointModelClass = boardDropingPointModelClassFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

//// Test case model class for redBus
BoardDropingPointModelClass boardDropingPointModelClassFromMap(String str) =>
    BoardDropingPointModelClass.fromMap(json.decode(str));

String boardDropingPointModelClassToMap(BoardDropingPointModelClass data) =>
    json.encode(data.toMap());

class BoardDropingPointModelClass {
  BoardDropingPointModelClass({
    required this.boardingPoints,
    required this.droppingPoints,
  });

  IngPoints boardingPoints;
  IngPoints droppingPoints;

  factory BoardDropingPointModelClass.fromMap(Map<String, dynamic> json) =>
      BoardDropingPointModelClass(
        boardingPoints: IngPoints.fromMap(json["boardingPoints"]),
        droppingPoints: IngPoints.fromMap(json["droppingPoints"]),
      );

  Map<String, dynamic> toMap() => {
        "boardingPoints": boardingPoints.toMap(),
        "droppingPoints": droppingPoints.toMap(),
      };
}

class IngPoints {
  IngPoints({
    required this.address,
    required this.contactnumber,
    required this.id,
    required this.landmark,
    required this.locationName,
    required this.name,
    required this.rbMasterId,
  });

  String address;
  String contactnumber;
  String id;
  String landmark;
  String locationName;
  String name;
  String rbMasterId;

  factory IngPoints.fromMap(Map<String, dynamic> json) => IngPoints(
        address: json["address"],
        contactnumber: json["contactnumber"],
        id: json["id"],
        landmark: json["landmark"],
        locationName: json["locationName"],
        name: json["name"],
        rbMasterId: json["rbMasterId"],
      );

  Map<String, dynamic> toMap() => {
        "address": address,
        "contactnumber": contactnumber,
        "id": id,
        "landmark": landmark,
        "locationName": locationName,
        "name": name,
        "rbMasterId": rbMasterId,
      };
}
