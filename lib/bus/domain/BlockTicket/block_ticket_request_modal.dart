import 'dart:convert';

BlockTicketRequest blockTicketRequestFromJson(String str) =>
    BlockTicketRequest.fromJson(json.decode(str));

String blockTicketRequestToJson(BlockTicketRequest data) =>
    json.encode(data.toJson());

class BlockTicketRequest {
  BlockTicketRequest({
    this.availableTripID,
    this.boardingPointID,
    this.droppingPointID,
    this.destination,
    this.inventoryItems,
    this.source,
    this.callFareBreakUpAPI,
  });
    String?  callFareBreakUpAPI;
  String? availableTripID;
  String? boardingPointID;
  String? droppingPointID;
  String? destination;
  String? source;
  List<InventoryItem>? inventoryItems;

  factory BlockTicketRequest.fromJson(Map<String, dynamic>  json) =>
      BlockTicketRequest(
        callFareBreakUpAPI:  json["callFareBreakUpAPI"],
        availableTripID: json["availableTripId"],
        boardingPointID: json["boardingPointId"],
        droppingPointID: json["droppingPointId"],
        destination: json["destination"],
        source: json["source"],
        inventoryItems: json["inventoryItems"] == null
            ? []
            : List<InventoryItem>.from(
                json["inventoryItems"].map((x) => InventoryItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "availableTripId": availableTripID,
        "boardingPointId": boardingPointID,
        "droppingPointId": droppingPointID,
        "destination": destination,
        "source": source,
        "inventoryItems": inventoryItems == null
            ? []
            : List<dynamic>.from(inventoryItems!.map((x) => x.toJson())),
      };
}

class InventoryItem {
  InventoryItem({
    required this.seatName,
    required this.fare,
    required this.ladiesSeat,
    required this.passenger,
    this.passengerGSTDetails,
  });

  String seatName;
  String fare;
  String ladiesSeat;
 Passenger passenger;
  List<PassengerGSTDetails>? passengerGSTDetails;

  factory InventoryItem.fromJson(Map<String, dynamic> json) => InventoryItem(
        seatName: json["seatName"],
        fare: json["fare"],
        ladiesSeat: json["ladiesSeat"],
        passenger: 
            json["passenger"],
        passengerGSTDetails: json["passengerGSTDetails"] == null
            ? null
            : List<PassengerGSTDetails>.from(json["passengerGSTDetails"]
                .map((x) => PassengerGSTDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "seatName": seatName,
        "fare": fare,
        "ladiesSeat": ladiesSeat,
        "passenger":
         passenger,
        if (passengerGSTDetails != null)
          "passengerGSTDetails":
              List<dynamic>.from(passengerGSTDetails!.map((x) => x.toJson())),
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

  factory Passenger.fromJson(Map<String, dynamic> json) => Passenger(
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

class PassengerGSTDetails {
  PassengerGSTDetails({
    required this.registrationName,
    required this.gstId,
    required this.address,
    required this.emailId,
  });

  String registrationName;
  String gstId;
  String address;
  String emailId;

  factory PassengerGSTDetails.fromJson(Map<String, dynamic> json) =>
      PassengerGSTDetails(
        registrationName: json["registrationName"],
        gstId: json["gstId"],
        address: json["address"],
        emailId: json["emailId"],
      );

  Map<String, dynamic> toJson() => {
        "registrationName": registrationName,
        "gstId": gstId,
        "address": address,
        "emailId": emailId,
      };
}
