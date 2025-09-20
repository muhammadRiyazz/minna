import 'dart:convert';

BookingConfirmResponse bookingResponseFromJson(String str) =>
    BookingConfirmResponse.fromJson(json.decode(str));

String bookingResponseToJson(BookingConfirmResponse data) =>
    json.encode(data.toJson());

class BookingConfirmResponse {
  final bool success;
  final BookingConfirmData? data;

  BookingConfirmResponse({
    required this.success,
    this.data,
  });

  factory BookingConfirmResponse.fromJson(Map<String, dynamic> json) =>
      BookingConfirmResponse(
        success: json["success"] ?? false,
        data: json["data"] != null
            ? BookingConfirmData.fromJson(json["data"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}

class BookingConfirmData {
  final String bookingId;
  final String referenceId;
  final String statusDesc;
  final int statusCode;
  final String tripType;
  final String tripDesc;
  final int cabType;
  final String startDate;
  final String startTime;
  final int totalDistance;
  final int estimatedDuration;
  final int? id; // nullable because API may not return it
  final String verificationCode;
  final List<RouteInfo> routes;
  final CabRate cabRate;

  BookingConfirmData({
    required this.bookingId,
    required this.referenceId,
    required this.statusDesc,
    required this.statusCode,
    required this.tripType,
    required this.tripDesc,
    required this.cabType,
    required this.startDate,
    required this.startTime,
    required this.totalDistance,
    required this.estimatedDuration,
    this.id,
    required this.verificationCode,
    required this.routes,
    required this.cabRate,
  });

  factory BookingConfirmData.fromJson(Map<String, dynamic> json) =>
      BookingConfirmData(
        bookingId: json["bookingId"] ?? "",
        referenceId: json["referenceId"] ?? "",
        statusDesc: json["statusDesc"] ?? "",
        statusCode: _toInt(json["statusCode"]),
        tripType: json["tripType"]?.toString() ?? "",
        tripDesc: json["tripDesc"] ?? "",
        cabType: _toInt(json["cabType"]),
        startDate: json["startDate"] ?? "",
        startTime: json["startTime"] ?? "",
        totalDistance: _toInt(json["totalDistance"]),
        estimatedDuration: _toInt(json["estimatedDuration"]),
        id: json["id"] != null ? _toInt(json["id"]) : null,
        verificationCode: json["verification_code"]?.toString() ?? "",
        routes: json["routes"] == null
            ? []
            : List<RouteInfo>.from(
                json["routes"].map((x) => RouteInfo.fromJson(x))),
        cabRate: CabRate.fromJson(json["cabRate"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "bookingId": bookingId,
        "referenceId": referenceId,
        "statusDesc": statusDesc,
        "statusCode": statusCode,
        "tripType": tripType,
        "tripDesc": tripDesc,
        "cabType": cabType,
        "startDate": startDate,
        "startTime": startTime,
        "totalDistance": totalDistance,
        "estimatedDuration": estimatedDuration,
        "id": id,
        "verification_code": verificationCode,
        "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
        "cabRate": cabRate.toJson(),
      };
}

class RouteInfo {
  final String startDate;
  final String startTime;
  final Location source;
  final Location destination;

  RouteInfo({
    required this.startDate,
    required this.startTime,
    required this.source,
    required this.destination,
  });

  factory RouteInfo.fromJson(Map<String, dynamic> json) => RouteInfo(
        startDate: json["startDate"] ?? "",
        startTime: json["startTime"] ?? "",
        source: Location.fromJson(json["source"] ?? {}),
        destination: Location.fromJson(json["destination"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "startDate": startDate,
        "startTime": startTime,
        "source": source.toJson(),
        "destination": destination.toJson(),
      };
}

class Location {
  final String address;
  final Coordinates coordinates;

  Location({
    required this.address,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        address: json["address"] ?? "",
        coordinates: Coordinates.fromJson(json["coordinates"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "coordinates": coordinates.toJson(),
      };
}

class Coordinates {
  final double latitude;
  final double longitude;

  Coordinates({
    required this.latitude,
    required this.longitude,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        latitude: _toDouble(json["latitude"]),
        longitude: _toDouble(json["longitude"]),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class CabRate {
  final Cab cab;
  final Fare fare;

  CabRate({
    required this.cab,
    required this.fare,
  });

  factory CabRate.fromJson(Map<String, dynamic> json) => CabRate(
        cab: Cab.fromJson(json["cab"] ?? {}),
        fare: Fare.fromJson(json["fare"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "cab": cab.toJson(),
        "fare": fare.toJson(),
      };
}

class Cab {
  final String type;
  final String category;
  final String sClass;
  final List<String> instructions;
  final String image;
  final int seatingCapacity;
  final int bagCapacity;
  final int bigBagCapaCity;
  final String isAssured;

  Cab({
    required this.type,
    required this.category,
    required this.sClass,
    required this.instructions,
    required this.image,
    required this.seatingCapacity,
    required this.bagCapacity,
    required this.bigBagCapaCity,
    required this.isAssured,
  });

  factory Cab.fromJson(Map<String, dynamic> json) => Cab(
        type: json["type"] ?? "",
        category: json["category"] ?? "",
        sClass: json["sClass"] ?? "",
        instructions: json["instructions"] == null
            ? []
            : List<String>.from(json["instructions"].map((x) => x.toString())),
        image: json["image"] ?? "",
        seatingCapacity: _toInt(json["seatingCapacity"]),
        bagCapacity: _toInt(json["bagCapacity"]),
        bigBagCapaCity: _toInt(json["bigBagCapaCity"]),
        isAssured: json["isAssured"]?.toString() ?? "0",
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "category": category,
        "sClass": sClass,
        "instructions": List<dynamic>.from(instructions.map((x) => x)),
        "image": image,
        "seatingCapacity": seatingCapacity,
        "bagCapacity": bagCapacity,
        "bigBagCapaCity": bigBagCapaCity,
        "isAssured": isAssured,
      };
}

class Fare {
  final int baseFare;
  final int driverAllowance;
  final int gst;
  final int tollIncluded;
  final int stateTaxIncluded;
  final int stateTax;
  final int tollTax;
  final int nightPickupIncluded;
  final int nightDropIncluded;
  final int extraPerKmRate;
  final int dueAmount;
  final int totalAmount;
  final int minPay;
  final int minPayPercent;
  final int airportChargeIncluded;
  final int additionalCharge;
  final int airportFee;

  Fare({
    required this.baseFare,
    required this.driverAllowance,
    required this.gst,
    required this.tollIncluded,
    required this.stateTaxIncluded,
    required this.stateTax,
    required this.tollTax,
    required this.nightPickupIncluded,
    required this.nightDropIncluded,
    required this.extraPerKmRate,
    required this.dueAmount,
    required this.totalAmount,
    required this.minPay,
    required this.minPayPercent,
    required this.airportChargeIncluded,
    required this.additionalCharge,
    required this.airportFee,
  });

  factory Fare.fromJson(Map<String, dynamic> json) => Fare(
        baseFare: _toInt(json["baseFare"]),
        driverAllowance: _toInt(json["driverAllowance"]),
        gst: _toInt(json["gst"]),
        tollIncluded: _toInt(json["tollIncluded"]),
        stateTaxIncluded: _toInt(json["stateTaxIncluded"]),
        stateTax: _toInt(json["stateTax"]),
        tollTax: _toInt(json["tollTax"]),
        nightPickupIncluded: _toInt(json["nightPickupIncluded"]),
        nightDropIncluded: _toInt(json["nightDropIncluded"]),
        extraPerKmRate: _toInt(json["extraPerKmRate"]),
        dueAmount: _toInt(json["dueAmount"]),
        totalAmount: _toInt(json["totalAmount"]),
        minPay: _toInt(json["minPay"]),
        minPayPercent: _toInt(json["minPayPercent"]),
        airportChargeIncluded: _toInt(json["airportChargeIncluded"]),
        additionalCharge: _toInt(json["additionalCharge"]),
        airportFee: _toInt(json["airportFee"]),
      );

  Map<String, dynamic> toJson() => {
        "baseFare": baseFare,
        "driverAllowance": driverAllowance,
        "gst": gst,
        "tollIncluded": tollIncluded,
        "stateTaxIncluded": stateTaxIncluded,
        "stateTax": stateTax,
        "tollTax": tollTax,
        "nightPickupIncluded": nightPickupIncluded,
        "nightDropIncluded": nightDropIncluded,
        "extraPerKmRate": extraPerKmRate,
        "dueAmount": dueAmount,
        "totalAmount": totalAmount,
        "minPay": minPay,
        "minPayPercent": minPayPercent,
        "airportChargeIncluded": airportChargeIncluded,
        "additionalCharge": additionalCharge,
        "airportFee": airportFee,
      };
}

/// ---------- Safe Parsing Helpers ----------
int _toInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}

double _toDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}
