import 'dart:convert';

BusLog busLogFromJson(String str) => BusLog.fromJson(json.decode(str));

String busLogToJson(BusLog data) => json.encode(data.toJson());

class BusLog {
  String agentMappedToCp;
  String agentMappedToEarning;
  List<AvailableTrip> availableTrips;

  BusLog({
    required this.agentMappedToCp,
    required this.agentMappedToEarning,
    required this.availableTrips,
  });

  factory BusLog.fromJson(Map<String, dynamic> json) => BusLog(
    agentMappedToCp: json["agentMappedToCp"] ?? "false",
    agentMappedToEarning: json["agentMappedToEarning"] ?? "false",
    availableTrips: json["availableTrips"] != null
        ? List<AvailableTrip>.from(
            json["availableTrips"].map((x) => AvailableTrip.fromJson(x)),
          )
        : <AvailableTrip>[],
  );

  Map<String, dynamic> toJson() => {
    "agentMappedToCp": agentMappedToCp,
    "agentMappedToEarning": agentMappedToEarning,
    "availableTrips": List<dynamic>.from(availableTrips.map((x) => x.toJson())),
  };
}

class AvailableTrip {
  String ac;
  String arrivalTime;
  String availableSeats;
  String availableSingleSeat;
  List<BoardingPoint> boardingTimes;
  String busType;
  String callFareBreakUpApi;
  String departureTime;
  String destination;
  List<BoardingPoint> droppingTimes;
  String duration;
  List<FareDetail> fareDetails;
  dynamic fares;
  String id;
  String nonAc;
  String seater;
  String sleeper;
  String source;
  String travels;

  AvailableTrip({
    required this.ac,
    required this.arrivalTime,
    required this.availableSeats,
    required this.availableSingleSeat,
    required this.boardingTimes,
    required this.busType,
    required this.callFareBreakUpApi,
    required this.departureTime,
    required this.destination,
    required this.droppingTimes,
    required this.duration,
    required this.fareDetails,
    required this.fares,
    required this.id,
    required this.nonAc,
    required this.seater,
    required this.sleeper,
    required this.source,
    required this.travels,
  });

  factory AvailableTrip.fromJson(Map<String, dynamic> json) {
    // Convert boardingTimes to List
    List<BoardingPoint> boardingTimesList = [];
    if (json["boardingTimes"] != null) {
      if (json["boardingTimes"] is List) {
        boardingTimesList = List<BoardingPoint>.from(
          json["boardingTimes"].map((x) => BoardingPoint.fromJson(x)),
        );
      } else {
        boardingTimesList = [BoardingPoint.fromJson(json["boardingTimes"])];
      }
    }

    // Convert droppingTimes to List
    List<BoardingPoint> droppingTimesList = [];
    if (json["droppingTimes"] != null) {
      if (json["droppingTimes"] is List) {
        droppingTimesList = List<BoardingPoint>.from(
          json["droppingTimes"].map((x) => BoardingPoint.fromJson(x)),
        );
      } else {
        droppingTimesList = [BoardingPoint.fromJson(json["droppingTimes"])];
      }
    }

    // Convert fareDetails to List
    List<FareDetail> fareDetailsList = [];
    if (json["fareDetails"] != null) {
      if (json["fareDetails"] is List) {
        fareDetailsList = List<FareDetail>.from(
          json["fareDetails"].map((x) => FareDetail.fromJson(x)),
        );
      } else {
        fareDetailsList = [FareDetail.fromJson(json["fareDetails"])];
      }
    }

    return AvailableTrip(
      ac: json["AC"]?.toString() ?? "false",
      arrivalTime: json["arrivalTime"]?.toString() ?? "",
      availableSeats: json["availableSeats"]?.toString() ?? "0",
      availableSingleSeat: json["availableSingleSeat"]?.toString() ?? "0",
      boardingTimes: boardingTimesList,
      busType: json["busType"]?.toString() ?? "",
      callFareBreakUpApi: json["callFareBreakUpAPI"]?.toString() ?? "false",
      departureTime: json["departureTime"]?.toString() ?? "",
      destination: json["destination"]?.toString() ?? "",
      droppingTimes: droppingTimesList,
      duration: json["duration"]?.toString() ?? "",
      fareDetails: fareDetailsList,
      fares: json["fares"]?.toString() ?? "0.00",
      id: json["id"]?.toString() ?? "",
      nonAc: json["nonAC"]?.toString() ?? "false",
      seater: json["seater"]?.toString() ?? "false",
      sleeper: json["sleeper"]?.toString() ?? "false",
      source: json["source"]?.toString() ?? "",
      travels: json["travels"]?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "AC": ac,
    "arrivalTime": arrivalTime,
    "availableSeats": availableSeats,
    "availableSingleSeat": availableSingleSeat,
    "boardingTimes": List<dynamic>.from(boardingTimes.map((x) => x.toJson())),
    "busType": busType,
    "callFareBreakUpAPI": callFareBreakUpApi,
    "departureTime": departureTime,
    "destination": destination,
    "droppingTimes": List<dynamic>.from(droppingTimes.map((x) => x.toJson())),
    "duration": duration,
    "fareDetails": List<dynamic>.from(fareDetails.map((x) => x.toJson())),
    "fares": fares,
    "id": id,
    "nonAC": nonAc,
    "seater": seater,
    "sleeper": sleeper,
    "source": source,
    "travels": travels,
  };
}

class BoardingPoint {
  String address;
  String bpId;
  String bpName;
  String contactNumber;
  String landmark;
  String location;
  String prime;
  String time;

  BoardingPoint({
    required this.address,
    required this.bpId,
    required this.bpName,
    required this.contactNumber,
    required this.landmark,
    required this.location,
    required this.prime,
    required this.time,
  });

  factory BoardingPoint.fromJson(Map<String, dynamic> json) => BoardingPoint(
    address: json["address"]?.toString() ?? "",
    bpId: json["bpId"]?.toString() ?? "",
    bpName: json["bpName"]?.toString() ?? "",
    contactNumber: json["contactNumber"]?.toString() ?? "",
    landmark: json["landmark"]?.toString() ?? "",
    location: json["location"]?.toString() ?? "",
    prime: json["prime"]?.toString() ?? "false",
    time: json["time"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "bpId": bpId,
    "bpName": bpName,
    "contactNumber": contactNumber,
    "landmark": landmark,
    "location": location,
    "prime": prime,
    "time": time,
  };
}

class FareDetail {
  String baseFare;
  String totalFare;

  FareDetail({
    required this.baseFare,
    required this.totalFare,
  });

  factory FareDetail.fromJson(Map<String, dynamic> json) => FareDetail(
    baseFare: json["baseFare"]?.toString() ?? "0.00",
    totalFare: json["totalFare"]?.toString() ?? "0.00",
  );

  Map<String, dynamic> toJson() => {
    "baseFare": baseFare,
    "totalFare": totalFare,
  };
}