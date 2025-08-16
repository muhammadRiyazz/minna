import 'dart:convert';

InsertDataModal insertDataModalFromJson(String str) =>
    InsertDataModal.fromJson(json.decode(str));

String insertDataModalToJson(InsertDataModal data) =>
    json.encode(data.toJson());

class InsertDataModal {
  InsertDataModal(
      {required this.availableTripID,
      required this.boardingPoint,
      required this.dropingpoint,
      required this.destination,
      required this.inventoryItems,
      required this.source,
      required this.franchid,
      required this.userid});

  String availableTripID;
  String boardingPoint;
  String dropingpoint;
  String userid;
  String franchid;

  String destination;
  List<InsertInventoryItem> inventoryItems;
  String? source;

  factory InsertDataModal.fromJson(Map<String, dynamic> json) =>
      InsertDataModal(
        franchid: json["franch_id"],
        userid: json["user_id"],
        availableTripID: json["availableTripID"],
        boardingPoint: json["boardingPointId"],
        destination: json["destination"],
        inventoryItems: List<InsertInventoryItem>.from(
            json["inventoryItems"].map((x) => InsertInventoryItem.fromJson(x))),
        source: json["source"],
        dropingpoint: json["droppingPointId"],
      );

  Map<String, dynamic> toJson() => {
        "franch_id": franchid,
        "user_id": userid,
        "droppingPointId": dropingpoint,
        "availableTripID": availableTripID,
        "boardingPointId": boardingPoint,
        "destination": destination,
        "inventory": List<dynamic>.from(inventoryItems.map((x) => x.toJson())),
        "source": source,
      };
}

class InsertInventoryItem {
  InsertInventoryItem(
      {required this.fare,
      required this.ladiesSeat,
      required this.passenger,
      required this.seatName,
      required this.baseFare});

  String fare;
  String baseFare;
  String ladiesSeat;
  InsertPassenger passenger;
  String seatName;

  factory InsertInventoryItem.fromJson(Map<String, dynamic> json) =>
      InsertInventoryItem(
        fare: json["fare"],
        baseFare: json["baseFare"],
        ladiesSeat: json["ladiesSeat"],
        passenger: InsertPassenger.fromJson(json["passenger"]),
        seatName: json["seatName"],
      );

  Map<String, dynamic> toJson() => {
        "fare": fare,
        "baseFare": baseFare,
        "ladiesSeat": ladiesSeat,
        "passenger": passenger.toJson(),
        "seatName": seatName,
      };
}

class InsertPassenger {
  InsertPassenger({
    this.address,
    required this.age,
    required this.email,
    required this.gender,
    this.idNumber,
    this.idType,
    required this.mobile,
    required this.name,
    required this.primary,
    required this.title,
  });

  String? address;
  String age;
  String email;
  String gender;
  String? idNumber;
  String? idType;
  String mobile;
  String name;
  String primary;
  String title;

  factory InsertPassenger.fromJson(Map<String, dynamic> json) =>
      InsertPassenger(
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

  Map<String, dynamic> toJson() => {
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
