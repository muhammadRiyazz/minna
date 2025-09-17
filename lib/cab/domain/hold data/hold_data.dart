class BookingResponse {
  final bool success;
  final BookingData? data;

  BookingResponse({
    required this.success,
    this.data,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) {
    return BookingResponse(
      success: json['success'] ?? false,
      data: json['data'] != null ? BookingData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "data": data?.toJson(),
    };
  }
}

class BookingData {
  final String bookingId;
  final String referenceId;
  final String statusDesc;
  final int statusCode;
  final int tripType;
  final String tripDesc;
  final int cabType;
  final String startDate;
  final String startTime;
  final num totalDistance;
  final num estimatedDuration;
  final int id;
  final String verificationCode;
  final List<RouteData> routes;
  final CabRate? cabRate;

  BookingData({
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
    required this.id,
    required this.verificationCode,
    required this.routes,
    this.cabRate,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      bookingId: json['bookingId'] ?? "",
      referenceId: json['referenceId'] ?? "",
      statusDesc: json['statusDesc'] ?? "",
      statusCode: json['statusCode'] ?? 0,
      tripType: json['tripType'] ?? 0,
      tripDesc: json['tripDesc'] ?? "",
      cabType: json['cabType'] ?? 0,
      startDate: json['startDate'] ?? "",
      startTime: json['startTime'] ?? "",
      totalDistance: json['totalDistance'] ?? 0,
      estimatedDuration: json['estimatedDuration'] ?? 0,
      id: json['id'] ?? 0,
      verificationCode: json['verification_code'] ?? "",
      routes: (json['routes'] as List<dynamic>? ?? [])
          .map((e) => RouteData.fromJson(e))
          .toList(),
      cabRate: json['cabRate'] != null ? CabRate.fromJson(json['cabRate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      "routes": routes.map((e) => e.toJson()).toList(),
      "cabRate": cabRate?.toJson(),
    };
  }
}

class RouteData {
  final String startDate;
  final String startTime;
  final LocationData source;
  final LocationData destination;

  RouteData({
    required this.startDate,
    required this.startTime,
    required this.source,
    required this.destination,
  });

  factory RouteData.fromJson(Map<String, dynamic> json) {
    return RouteData(
      startDate: json['startDate'] ?? "",
      startTime: json['startTime'] ?? "",
      source: LocationData.fromJson(json['source']),
      destination: LocationData.fromJson(json['destination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "startDate": startDate,
      "startTime": startTime,
      "source": source.toJson(),
      "destination": destination.toJson(),
    };
  }
}

class LocationData {
  final String address;
  final Coordinates coordinates;

  LocationData({
    required this.address,
    required this.coordinates,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) {
    return LocationData(
      address: json['address'] ?? "",
      coordinates: Coordinates.fromJson(json['coordinates']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "address": address,
      "coordinates": coordinates.toJson(),
    };
  }
}

class Coordinates {
  final double latitude;
  final double longitude;

  Coordinates({
    required this.latitude,
    required this.longitude,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "latitude": latitude,
      "longitude": longitude,
    };
  }
}

class CabRate {
  final Cab cab;
  final Fare fare;

  CabRate({
    required this.cab,
    required this.fare,
  });

  factory CabRate.fromJson(Map<String, dynamic> json) {
    return CabRate(
      cab: Cab.fromJson(json['cab']),
      fare: Fare.fromJson(json['fare']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "cab": cab.toJson(),
      "fare": fare.toJson(),
    };
  }
}

class Cab {
  final String type;
  final String category;
  final String sClass;
  final List<String> instructions;
  final String image;
  final int seatingCapacity;
  final int bagCapacity;
  final int bigBagCapacity;
  final String isAssured;

  Cab({
    required this.type,
    required this.category,
    required this.sClass,
    required this.instructions,
    required this.image,
    required this.seatingCapacity,
    required this.bagCapacity,
    required this.bigBagCapacity,
    required this.isAssured,
  });

  factory Cab.fromJson(Map<String, dynamic> json) {
    return Cab(
      type: json['type'] ?? "",
      category: json['category'] ?? "",
      sClass: json['sClass'] ?? "",
      instructions: (json['instructions'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      image: json['image'] ?? "",
      seatingCapacity: json['seatingCapacity'] ?? 0,
      bagCapacity: json['bagCapacity'] ?? 0,
      bigBagCapacity: json['bigBagCapaCity'] ?? 0,
      isAssured: json['isAssured'] ?? "0",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "category": category,
      "sClass": sClass,
      "instructions": instructions,
      "image": image,
      "seatingCapacity": seatingCapacity,
      "bagCapacity": bagCapacity,
      "bigBagCapaCity": bigBagCapacity,
      "isAssured": isAssured,
    };
  }
}

class Fare {
  final num baseFare;
  final num driverAllowance;
  final num gst;
  final int tollIncluded;
  final int stateTaxIncluded;
  final num stateTax;
  final num tollTax;
  final int nightPickupIncluded;
  final int nightDropIncluded;
  final num extraPerKmRate;
  final num dueAmount;
  final num totalAmount;
  final num minPay;
  final num minPayPercent;
  final int airportChargeIncluded;
  final num additionalCharge;
  final num airportFee;

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

  factory Fare.fromJson(Map<String, dynamic> json) {
    return Fare(
      baseFare: json['baseFare'] ?? 0,
      driverAllowance: json['driverAllowance'] ?? 0,
      gst: json['gst'] ?? 0,
      tollIncluded: json['tollIncluded'] ?? 0,
      stateTaxIncluded: json['stateTaxIncluded'] ?? 0,
      stateTax: json['stateTax'] ?? 0,
      tollTax: json['tollTax'] ?? 0,
      nightPickupIncluded: json['nightPickupIncluded'] ?? 0,
      nightDropIncluded: json['nightDropIncluded'] ?? 0,
      extraPerKmRate: json['extraPerKmRate'] ?? 0,
      dueAmount: json['dueAmount'] ?? 0,
      totalAmount: json['totalAmount'] ?? 0,
      minPay: json['minPay'] ?? 0,
      minPayPercent: json['minPayPercent'] ?? 0,
      airportChargeIncluded: json['airportChargeIncluded'] ?? 0,
      additionalCharge: json['additionalCharge'] ?? 0,
      airportFee: json['airportFee'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
}
