import 'dart:convert';

DpBdPointModal dpBdPointModalFromJson(String str) =>
    DpBdPointModal.fromJson(json.decode(str));

String welcomeToJson(DpBdPointModal data) => json.encode(data.toJson());

class DpBdPointModal {
  DpBdPointModal({
    required this.boardingPoints,
    required this.droppingPoints,
  });

  List<IngPoint> boardingPoints;
  List<IngPoint> droppingPoints;

  factory DpBdPointModal.fromJson(Map<String, dynamic> json) {
    final boardingPointsJson = json['boardingPoints'];
    final droppingPointsJson = json['droppingPoints'];
   
    List<IngPoint> droppingPoints = [];
    List<IngPoint> boardingPoints = [];
    if (boardingPointsJson is List) {
      boardingPoints = List<IngPoint>.from(
        boardingPointsJson.map((x) => IngPoint.fromJson(x)),
      );
    } else if (boardingPointsJson is Map) {
      boardingPoints = [
        IngPoint.fromJson(boardingPointsJson as Map<String, dynamic>)
      ];
    }

    if (droppingPointsJson is List) {
      droppingPoints = List<IngPoint>.from(
        droppingPointsJson.map((x) => IngPoint.fromJson(x)),
      );
    } else if (droppingPointsJson is Map) {
      droppingPoints = [
        IngPoint.fromJson(droppingPointsJson as Map<String, dynamic>)
      ];
    }

    return DpBdPointModal(
      boardingPoints: boardingPoints,
      droppingPoints: droppingPoints,
    );
  }

  Map<String, dynamic> toJson() => {
        "boardingPoints":
            List<dynamic>.from(boardingPoints.map((x) => x.toJson())),
        "droppingPoints":
            List<dynamic>.from(droppingPoints.map((x) => x.toJson())),
      };
}

class IngPoint {
  IngPoint({
    required this.address,
    required this.contactnumber,
    required this.id,
    required this.landmark,
    required this.locationName,
    required this.name,
  });

  String address;
  String contactnumber;
  String id;
  String landmark;
  String locationName;
  String name;

  factory IngPoint.fromJson(Map<String, dynamic> json) => IngPoint(
        address: json["address"],
        contactnumber: json["contactnumber"],
        id: json["id"],
        landmark: json["landmark"],
        locationName: json["locationName"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "contactnumber": contactnumber,
        "id": id,
        "landmark": landmark,
        "locationName": locationName,
        "name": name,
      };
}
