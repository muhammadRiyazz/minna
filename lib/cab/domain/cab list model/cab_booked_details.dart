// lib/cab/domain/booking_details_model.dart
class BookingDetails {
  final String bookingId;
  final String statusDesc;
  final int statusCode;
  final int tripType;
  final double tripDistance;
  final String pickupDate;
  final String pickupTime;
  final String bookingDate;
  final String bookingTime;
  final List<BookedRoute> routes;
  final BookedTraveller traveller;
  final BookedCabRate cabRate;

  BookingDetails({
    required this.bookingId,
    required this.statusDesc,
    required this.statusCode,
    required this.tripType,
    required this.tripDistance,
    required this.pickupDate,
    required this.pickupTime,
    required this.bookingDate,
    required this.bookingTime,
    required this.routes,
    required this.traveller,
    required this.cabRate,
  });

  factory BookingDetails.fromJson(Map<String, dynamic> json) {
    return BookingDetails(
      bookingId: json['bookingId'] ?? '',
      statusDesc: json['statusDesc'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      tripType: json['tripType'] ?? 0,
      tripDistance: (json['tripDistance'] ?? 0).toDouble(),
      pickupDate: json['pickupDate'] ?? '',
      pickupTime: json['pickupTime'] ?? '',
      bookingDate: json['bookingDate'] ?? '',
      bookingTime: json['bookingTime'] ?? '',
      routes: (json['routes'] as List<dynamic>?)
              ?.map((route) => BookedRoute.fromJson(route))
              .toList() ??
          [],
      traveller: BookedTraveller.fromJson(json['traveller'] ?? {}),
      cabRate: BookedCabRate.fromJson(json['cabRate'] ?? {}),
    );
  }

  String get tripTypeName {
    switch (tripType) {
      case 1:
        return 'One Way';
      case 2:
        return 'Round Trip';
      case 3:
        return 'Multi City';
      case 4:
        return 'Airport Transfer';
      default:
        return 'Unknown';
    }
  }

  bool get isMultiCity => tripType == 3;
  bool get isRoundTrip => tripType == 2;
  bool get isAirportTransfer => tripType == 4;
}

class BookedRoute {
  final String startDate;
  final String startTime;
  final BookedLocation source;
  final BookedLocation destination;

  BookedRoute({
    required this.startDate,
    required this.startTime,
    required this.source,
    required this.destination,
  });

  factory BookedRoute.fromJson(Map<String, dynamic> json) {
    return BookedRoute(
      startDate: json['startDate'] ?? '',
      startTime: json['startTime'] ?? '',
      source: BookedLocation.fromJson(json['source'] ?? {}),
      destination: BookedLocation.fromJson(json['destination'] ?? {}),
    );
  }
}

class BookedLocation {
  final String address;
  final BookedCoordinates coordinates;

  BookedLocation({
    required this.address,
    required this.coordinates,
  });

  factory BookedLocation.fromJson(Map<String, dynamic> json) {
    return BookedLocation(
      address: json['address'] ?? '',
      coordinates: BookedCoordinates.fromJson(json['coordinates'] ?? {}),
    );
  }
}

class BookedCoordinates {
  final double latitude;
  final double longitude;

  BookedCoordinates({
    required this.latitude,
    required this.longitude,
  });

  factory BookedCoordinates.fromJson(Map<String, dynamic> json) {
    return BookedCoordinates(
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
    );
  }
}

class BookedTraveller {
  final String firstName;
  final String lastName;
  final String email;
  final BookedContact primaryContact;
  final BookedContact alternateContact;

  BookedTraveller({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.primaryContact,
    required this.alternateContact,
  });

  factory BookedTraveller.fromJson(Map<String, dynamic> json) {
    return BookedTraveller(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      primaryContact: BookedContact.fromJson(json['primaryContact'] ?? {}),
      alternateContact: BookedContact.fromJson(json['alternateContact'] ?? {}),
    );
  }

  String get fullName => '$firstName $lastName';
}

class BookedContact {
  final String code;
  final String number;

  BookedContact({
    required this.code,
    required this.number,
  });

  factory BookedContact.fromJson(Map<String, dynamic> json) {
    return BookedContact(
      code: json['code'] ?? '',
      number: json['number'] ?? '',
    );
  }

  String get fullNumber => '+$code $number';
}

class BookedCabRate {
  final BookedCab cab;
  final BookedFare fare;

  BookedCabRate({
    required this.cab,
    required this.fare,
  });

  factory BookedCabRate.fromJson(Map<String, dynamic> json) {
    return BookedCabRate(
      cab: BookedCab.fromJson(json['cab'] ?? {}),
      fare: BookedFare.fromJson(json['fare'] ?? {}),
    );
  }
}

class BookedCab {
  final String type;
  final String category;
  final String sClass;
  final List<String> instructions;
  final String image;
  final int seatingCapacity;
  final int bagCapacity;
  final int bigBagCapacity;
  final bool isAssured;

  BookedCab({
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

  factory BookedCab.fromJson(Map<String, dynamic> json) {
    return BookedCab(
      type: json['type'] ?? '',
      category: json['category'] ?? '',
      sClass: json['sClass'] ?? '',
      instructions: (json['instructions'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      image: json['image'] ?? '',
      seatingCapacity: json['seatingCapacity'] ?? 0,
      bagCapacity: json['bagCapacity'] ?? 0,
      bigBagCapacity: json['bigBagCapaCity'] ?? 0,
      isAssured: (json['isAssured'] ?? '0') == '1',
    );
  }
}

class BookedFare {
  final double baseFare;
  final double driverAllowance;
  final double gst;
  final bool tollIncluded;
  final bool stateTaxIncluded;
  final double stateTax;
  final double tollTax;
  final bool nightPickupIncluded;
  final bool nightDropIncluded;
  final double extraPerKmRate;
  final double dueAmount;
  final double totalAmount;
  final double minPay;
  final double minPayPercent;
  final bool airportChargeIncluded;
  final double additionalCharge;
  final double airportFee;

  BookedFare({
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

  factory BookedFare.fromJson(Map<String, dynamic> json) {
    return BookedFare(
      baseFare: (json['baseFare'] ?? 0).toDouble(),
      driverAllowance: (json['driverAllowance'] ?? 0).toDouble(),
      gst: (json['gst'] ?? 0).toDouble(),
      tollIncluded: (json['tollIncluded'] ?? 0) == 1,
      stateTaxIncluded: (json['stateTaxIncluded'] ?? 0) == 1,
      stateTax: (json['stateTax'] ?? 0).toDouble(),
      tollTax: (json['tollTax'] ?? 0).toDouble(),
      nightPickupIncluded: (json['nightPickupIncluded'] ?? 0) == 1,
      nightDropIncluded: (json['nightDropIncluded'] ?? 0) == 1,
      extraPerKmRate: (json['extraPerKmRate'] ?? 0).toDouble(),
      dueAmount: (json['dueAmount'] ?? 0).toDouble(),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      minPay: (json['minPay'] ?? 0).toDouble(),
      minPayPercent: (json['minPayPercent'] ?? 0).toDouble(),
      airportChargeIncluded: (json['airportChargeIncluded'] ?? 0) == 1,
      additionalCharge: (json['additionalCharge'] ?? 0).toDouble(),
      airportFee: (json['airportFee'] ?? 0).toDouble(),
    );
  }
}

class BookingDetailsResponse {
  final bool success;
  final BookingDetails? data;
  final String? errorMessage;

  BookingDetailsResponse({
    required this.success,
    this.data,
    this.errorMessage,
  });

  factory BookingDetailsResponse.fromJson(Map<String, dynamic> json) {
    return BookingDetailsResponse(
      success: json['success'] ?? false,
      data: json['data'] != null ? BookingDetails.fromJson(json['data']) : null,
      errorMessage: json['message'],
    );
  }
}