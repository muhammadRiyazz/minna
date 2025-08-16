// To parse this JSON data, do
//
//     final inventoryItems = inventoryItemsFromMap(jsonString);

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class NewScreenAddingDetals extends StatefulWidget {
  const NewScreenAddingDetals({Key? key}) : super(key: key);

  @override
  State<NewScreenAddingDetals> createState() => _NewScreenAddingDetalsState();
}

class _NewScreenAddingDetalsState extends State<NewScreenAddingDetals> {
  List<InventoryItems> inventoryList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello world'),
      ),
      body: Column(
        children: [
          // TextButton(
          //   onPressed: () {
          //     inventoryList.add(InventoryItems(fare: 'ff',ladiesSeat: 'fg',passenger: Passenger(address: address, age: age, email: email, gender: gender, idNumber: idNumber, idType: idType, mobile: mobile, name: name, primary: primary, title: title),seatName:'1' ));
          //   },
          //   child: Text('adding'),
          // )
        ],
      ),
    );
  }
}

List<InventoryItems> inventoryItemsFromMap(String str) =>
    List<InventoryItems>.from(
        json.decode(str).map((x) => InventoryItems.fromMap(x)));

String inventoryItemsToMap(List<InventoryItems> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class InventoryItems {
  InventoryItems({
    required this.fare,
    required this.ladiesSeat,
    required this.passenger,
    required this.seatName,
  });

  String fare;
  String ladiesSeat;
  Passenger passenger;
  String seatName;

  factory InventoryItems.fromMap(Map<String, dynamic> json) => InventoryItems(
        fare: json["fare"],
        ladiesSeat: json["ladiesSeat"],
        passenger: Passenger.fromMap(json["passenger"]),
        seatName: json["seatName"],
      );

  Map<String, dynamic> toMap() => {
        "fare": fare,
        "ladiesSeat": ladiesSeat,
        "passenger": passenger.toMap(),
        "seatName": seatName,
      };
}

class Passenger {
  Passenger({
    required this.address,
    required this.age,
    required this.email,
    required this.gender,
    required this.idNumber,
    required this.idType,
    required this.mobile,
    required this.name,
    required this.primary,
    required this.title,
  });

  String address;
  String age;
  String email;
  String gender;
  String idNumber;
  String idType;
  String mobile;
  String name;
  String primary;
  String title;

  factory Passenger.fromMap(Map<String, dynamic> json) => Passenger(
        address: json["address"],
        age: json["age"],
        email: json["email"],
        gender: json["gender"],
        idNumber: json["idNumber"],
        idType: json["idType"],
        mobile: json["mobile"],
        name: json["name"],
        primary: json["primary"],
        title: json["title"],
      );

  Map<String, dynamic> toMap() => {
        "address": address,
        "age": age,
        "email": email,
        "gender": gender,
        "idNumber": idNumber,
        "idType": idType,
        "mobile": mobile,
        "name": name,
        "primary": primary,
        "title": title,
      };
}
