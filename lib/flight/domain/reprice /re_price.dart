// // ignore_for_file: non_constant_identifier_names

// import 'package:minna/flight/domain/fare%20request%20and%20respo/fare_respo.dart';

// class RepriceRequest {
//   final String token;
//   final String userId;
//   final String? error;
//   final String tripMode;
//   final Journey journy;
//   final PSSRAvailability? ssrAvailability;
//   final List<Passenger> passengers;

//   RepriceRequest({
//     required this.token,
//     required this.userId,
//     this.error,
//     required this.tripMode,
//     required this.journy,
//     this.ssrAvailability,
//     required this.passengers,
//   });

//   Map<String, dynamic> toJson() => {
//         'Token': token,
//         'UserId': userId,
//         'Error': error,
//         'TripMode': tripMode,
//         'Journy': journy.toJson(),
//         'SSRAvailability': ssrAvailability?.toJson(),
//         'Passengers': passengers.map((e) => e.toJson()).toList(),
//       };
// }

// class Journey {
//   final List<dynamic> flightOptions;
//   final RFlightOption flightOption;
//   final List<dynamic> hostTokens;
//   final List<dynamic> errors;

//   Journey({
//     required this.flightOptions,
//     required this.flightOption,
//     required this.hostTokens,
//     required this.errors,
//   });

//   Map<String, dynamic> toJson() => {
//         'FlightOptions': flightOptions,
//         'FlightOption': flightOption.toJson(),
//         'HostTokens': hostTokens,
//         'Errors': errors,
//       };
// }

// class RFlightOption {
//   final String key;
//   final String ticketingCarrier;
//   final String apiType;
//   final bool seatEnabled;
//   final bool reprice;
//   final bool ffNoEnabled;
//   final int availableSeat;
//   final List<FFlightFare> flightFares;
//   final List<PFlightLeg> flightLegs;

//   RFlightOption({
//     required this.key,
//     required this.ticketingCarrier,
//     required this.apiType,
//     required this.seatEnabled,
//     required this.reprice,
//     required this.ffNoEnabled,
//     required this.availableSeat,
//     required this.flightFares,
//     required this.flightLegs,
//   });

//   Map<String, dynamic> toJson() => {
//         'Key': key,
//         'TicketingCarrier': ticketingCarrier,
//         'ApiType': apiType,
//         'SeatEnabled': seatEnabled,
//         'Reprice': reprice,
//         'FfNoEnabled': ffNoEnabled,
//         'AvailableSeat': availableSeat,
//         'FlightFares': flightFares.map((e) => e.toJson()).toList(),
//         'FlightLegs': flightLegs.map((e) => e.toJson()).toList(),
//       };
// }

// // class FFlightFare {
// //   final List<Fare> fares;
// //   final String fid;
// //   final String fareKey;
// //   final double aprxTotalBaseFare;
// //   final double aprxTotalTax;
// //   final double totalDiscount;
// //   final double aprxTotalAmount;
// //   final double totalAmount;

// //   FFlightFare({
// //     required this.fares,
// //     required this.fid,
// //     required this.fareKey,
// //     required this.aprxTotalBaseFare,
// //     required this.aprxTotalTax,
// //     required this.totalDiscount,
// //     required this.aprxTotalAmount,
// //     required this.totalAmount,
// //   });

// //   Map<String, dynamic> toJson() => {
// //         'Fares': fares.map((e) => e.toJson()).toList(),
// //         'FID': fid,
// //         'FareKey': fareKey,
// //         'AprxTotalBaseFare': aprxTotalBaseFare,
// //         'AprxTotalTax': aprxTotalTax,
// //         'TotalDiscount': totalDiscount,
// //         'AprxTotalAmount': aprxTotalAmount,
// //         'TotalAmount': totalAmount,
// //       };
// // }

// // class Fare {
// //   final String ptc;
// //   final int baseFare;
// //   final int tax;
// //   final int discount;
// //   final List<Splitup> splitup;

// //   Fare({
// //     required this.ptc,
// //     required this.baseFare,
// //     required this.tax,
// //     required this.discount,
// //     required this.splitup,
// //   });

// //   Map<String, dynamic> toJson() => {
// //         'PTC': ptc,
// //         'BaseFare': baseFare,
// //         'Tax': tax,
// //         'Discount': discount,
// //         'Splitup': splitup.map((e) => e.toJson()).toList(),
// //       };
// // }

// // class Splitup {
// //   final String category;
// //   final int amount;

// //   Splitup({required this.category, required this.amount});

// //   Map<String, dynamic> toJson() => {
// //         'Category': category,
// //         'Amount': amount,
// //       };
// // }

// class PFlightLeg {
//   final String type;
//   final String key;
//   final String origin;
//   final String destination;
//   final String departureTime;
//   final String arrivalTime;
//   final String flightNo;
//   final String airlineCode;

//   PFlightLeg({
//     required this.type,
//     required this.key,
//     required this.origin,
//     required this.destination,
//     required this.departureTime,
//     required this.arrivalTime,
//     required this.flightNo,
//     required this.airlineCode,
//   });

//   Map<String, dynamic> toJson() => {
//         'Type': type,
//         'Key': key,
//         'Origin': origin,
//         'Destination': destination,
//         'DepartureTime': departureTime,
//         'ArrivalTime': arrivalTime,
//         'FlightNo': flightNo,
//         'AirlineCode': airlineCode,
//       };
// }

// class Passenger {
//   final String paxType;
//   final String title;
//   final String firstName;
//   final String lastName;
//   final String dob;
//   final String contact;
//   final String email;
//   final String nationality;
//   final PSSRAvailability ssrAvailability;

//   Passenger({
//     required this.paxType,
//     required this.title,
//     required this.firstName,
//     required this.lastName,
//     required this.dob,
//     required this.contact,
//     required this.email,
//     required this.nationality,
//     required this.ssrAvailability,
//   });

//   Map<String, dynamic> toJson() => {
//         'PaxType': paxType,
//         'Title': title,
//         'FirstName': firstName,
//         'LastName': lastName,
//         'DOB': dob,
//         'Contact': contact,
//         'Email': email,
//         'Nationality': nationality,
//         'SSRAvailability': ssrAvailability.toJson(),
//       };
// }

// class PSSRAvailability {
//   final List<PMealInfo> mealInfo;
//   final List<PBaggageInfo> baggageInfo;
//   final List<PSeatInfo> seatInfo;

//   PSSRAvailability({
//     required this.mealInfo,
//     required this.baggageInfo,
//     required this.seatInfo,
//   });

//   factory PSSRAvailability.fromJson(Map<String, dynamic> json) => PSSRAvailability(
//         mealInfo: (json['MealInfo'] as List?)?.map((e) => PMealInfo.fromJson(e)).toList() ?? [],
//         baggageInfo: (json['BaggageInfo'] as List?)?.map((e) => PBaggageInfo.fromJson(e)).toList() ?? [],
//         seatInfo: (json['SeatInfo'] as List?)?.map((e) => PSeatInfo.fromJson(e)).toList() ?? [],
//       );

//   Map<String, dynamic> toJson() => {
//         'MealInfo': mealInfo.map((e) => e.toJson()).toList(),
//         'BaggageInfo': baggageInfo.map((e) => e.toJson()).toList(),
//         'SeatInfo': seatInfo.map((e) => e.toJson()).toList(),
//       };
// }

// class PMealInfo {
//   final List<PMeal> meals;

//   PMealInfo({required this.meals});

//   factory PMealInfo.fromJson(Map<String, dynamic> json) => PMealInfo(
//         meals: (json['Meals'] as List?)?.map((e) => PMeal.fromJson(e)).toList() ?? [],
//       );

//   Map<String, dynamic> toJson() => {
//         'Meals': meals.map((e) => e.toJson()).toList(),
//       };
// }

// class PMeal {
//   final String code;
//   final String name;
//   final double amount;
//   final String currency;
//   final String legKey;

//   PMeal({
//     required this.code,
//     required this.name,
//     required this.amount,
//     required this.currency,
//     required this.legKey,
//   });

//   factory PMeal.fromJson(Map<String, dynamic> json) => PMeal(
//         code: json['Code'] ?? '',
//         name: json['Name'] ?? '',
//         amount: (json['Amount']),
//         currency: json['Currency'] ?? '',
//         legKey: json['LegKey'] ?? '',
//       );

//   Map<String, dynamic> toJson() => {
//         'Code': code,
//         'Name': name,
//         'Amount': amount,
//         'Currency': currency,
//         'LegKey': legKey,
//       };
// }

// class PBaggageInfo {
//   final List<PBaggage> baggages;

//   PBaggageInfo({required this.baggages});

//   factory PBaggageInfo.fromJson(Map<String, dynamic> json) => PBaggageInfo(
//         baggages: (json['Baggages'] as List?)?.map((e) => PBaggage.fromJson(e)).toList() ?? [],
//       );

//   Map<String, dynamic> toJson() => {
//         'Baggages': baggages.map((e) => e.toJson()).toList(),
//       };
// }

// class PBaggage {
//   final String code;
//   final String name;
//   final double amount;
//   final String currency;
//   final String legKey;

//   PBaggage({
//     required this.code,
//     required this.name,
//     required this.amount,
//     required this.currency,
//     required this.legKey,
//   });

//   factory PBaggage.fromJson(Map<String, dynamic> json) => PBaggage(
//         code: json['Code'] ?? '',
//         name: json['Name'] ?? '',
//         amount: json['Amount']  ?? 0.00,
//         currency: json['Currency'] ?? '',
//         legKey: json['LegKey'] ?? '',
//       );

//   Map<String, dynamic> toJson() => {
//         'Code': code,
//         'Name': name,
//         'Amount': amount,
//         'Currency': currency,
//         'LegKey': legKey,
//       };
// }

// class PSeatInfo {
//   final List<PSeat> seats;

//   PSeatInfo({required this.seats});

//   factory PSeatInfo.fromJson(Map<String, dynamic> json) => PSeatInfo(
//         seats: (json['Seats'] as List?)?.map((e) => PSeat.fromJson(e)).toList() ?? [],
//       );

//   Map<String, dynamic> toJson() => {
//         'Seats': seats.map((e) => e.toJson()).toList(),
//       };
// }

// class PSeat {
//   final String seatKey;
//   final String legKey;
//   final String fare;

//   PSeat({required this.seatKey, required this.legKey, required this.fare});

//   factory PSeat.fromJson(Map<String, dynamic> json) => PSeat(
//         seatKey: json['SeatKey'] ?? '',
//         legKey: json['LegKey'] ?? '',
//         fare: json['Fare'] ?? '',
//       );

//   Map<String, dynamic> toJson() => {
//         'SeatKey': seatKey,
//         'LegKey': legKey,
//         'Fare': fare,
//       };
// }

// ignore_for_file: non_constant_identifier_names

class RepriceRequest {
  final String token;
  final String userId;
  final String? error;
  final String tripMode;
  final Journey journy;
  final dynamic ssrAvailability;
  final List<Passenger> passengers;

  RepriceRequest({
    required this.token,
    required this.userId,
    this.error,
    required this.tripMode,
    required this.journy,
    this.ssrAvailability,
    required this.passengers,
  });

  Map<String, dynamic> toJson() => {
        'Token': token,
        'UserId': userId,
        'Error': error,
        'TripMode': tripMode,
        'Journy': journy.toJson(),
        'SSRAvailability': ssrAvailability,
        'Passengers': passengers.map((e) => e.toJson()).toList(),
      };
}

class Journey {
  final dynamic flightOptions;
  final RFlightOption flightOption;
  final dynamic hostTokens;
  final dynamic errors;

  Journey({
    required this.flightOptions,
    required this.flightOption,
    required this.hostTokens,
    required this.errors,
  });

  Map<String, dynamic> toJson() => {
        'FlightOptions': flightOptions,
        'FlightOption': flightOption.toJson(),
        'HostTokens': hostTokens,
        'Errors': errors,
      };
}

class RFlightOption {
  final String key;
  final String ticketingCarrier;
  final String apiType;
  final String? crsPnr;
  final String? providerCode;
  final bool seatEnabled;
  final bool reprice;
  final bool ffNoEnabled;
  final int availableSeat;
  final List<dynamic> flightFares;
  final List<PFlightLeg> flightLegs;

  RFlightOption({
    required this.key,
    required this.ticketingCarrier,
    required this.apiType,
    this.crsPnr,
    this.providerCode,
    required this.seatEnabled,
    required this.reprice,
    required this.ffNoEnabled,
    required this.availableSeat,
    required this.flightFares,
    required this.flightLegs,
  });


  Map<String, dynamic> toJson() => {
        'Key': key,
        'TicketingCarrier': ticketingCarrier,
        'ApiType': apiType,
        'CrsPnr': crsPnr,
        'ProviderCode': providerCode,
        'SeatEnabled': seatEnabled,
        'Reprice': reprice,
        'FfNoEnabled': ffNoEnabled,
        'AvailableSeat': availableSeat,
        'FlightFares': flightFares.map((e) => e.toJson()).toList(),
        'FlightLegs': flightLegs.map((e) => e.toJson()).toList(),
      };
}

class FFlightFare {
  final List<Fare> fares;
  final String fid;
  final String? refundableInfo;
  final String fareKey;
  final double aprxTotalBaseFare;
  final double aprxTotalTax;
  final double totalDiscount;
  final dynamic extrafare;
  final double aprxTotalAmount;
  final String? currency;
  final String? fareType;
  final String? fareName;
  final double totalAmount;

  FFlightFare({
    required this.fares,
    required this.fid,
    this.refundableInfo,
    required this.fareKey,
    required this.aprxTotalBaseFare,
    required this.aprxTotalTax,
    required this.totalDiscount,
    this.extrafare,
    required this.aprxTotalAmount,
    this.currency,
    this.fareType,
    this.fareName,
    required this.totalAmount,
  });

  Map<String, dynamic> toJson() => {
        'Fares': fares.map((e) => e.toJson()).toList(),
        'FID': fid,
        'RefundableInfo': refundableInfo,
        'FareKey': fareKey,
        'AprxTotalBaseFare': aprxTotalBaseFare,
        'AprxTotalTax': aprxTotalTax,
        'TotalDiscount': totalDiscount,
        'Extrafare': extrafare,
        'AprxTotalAmount': aprxTotalAmount,
        'Currency': currency,
        'FareType': fareType,
        'FareName': fareName,
        'TotalAmount': totalAmount,
      };
}

class Fare {
  final String ptc;
  final double baseFare;
  final double tax;
  final double discount;
  final List<Splitup> splitup;

  Fare({
    required this.ptc,
    required this.baseFare,
    required this.tax,
    required this.discount,
    required this.splitup,
  });

  Map<String, dynamic> toJson() => {
        'PTC': ptc,
        'BaseFare': baseFare,
        'Tax': tax,
        'Discount': discount,
        'Splitup': splitup.map((e) => e.toJson()).toList(),
      };
}

class Splitup {
  final String category;
  final double amount;

  Splitup({required this.category, required this.amount});

  Map<String, dynamic> toJson() => {
        'Category': category,
        'Amount': amount,
      };
}

class PFlightLeg {
  final String type;
  final String? airlinePNR;
  final String key;
  final String origin;
  final String destination;
  final String departureTime;
  final String arrivalTime;
  final String? arrivalTerminal;
  final String? departureTerminal;
  final String flightNo;
  final String airlineCode;
  final String? carrier;
  final int? distance;
  final dynamic optionalServiceIndicators;
  final dynamic segmentRefKey;
  final String? mealKey;
  final String? baggageKey;
  final dynamic freeBaggages;
  final String? codeShare;
  final String? rbd;

  PFlightLeg({
    required this.type,
    this.airlinePNR,
    required this.key,
    required this.origin,
    required this.destination,
    required this.departureTime,
    required this.arrivalTime,
    this.arrivalTerminal,
    this.departureTerminal,
    required this.flightNo,
    required this.airlineCode,
    this.carrier,
    this.distance,
    this.optionalServiceIndicators,
    this.segmentRefKey,
    this.mealKey,
    this.baggageKey,
    this.freeBaggages,
    this.codeShare,
    this.rbd,
  });

  Map<String, dynamic> toJson() => {
        'Type': type,
        'AirlinePNR': airlinePNR,
        'Key': key,
        'Origin': origin,
        'Destination': destination,
        'DepartureTime': departureTime,
        'ArrivalTime': arrivalTime,
        'ArrivalTerminal': arrivalTerminal,
        'DepartureTerminal': departureTerminal,
        'FlightNo': flightNo,
        'AirlineCode': airlineCode,
        'Carrier': carrier,
        'Distance': distance,
        'OptionalServiceIndicators': optionalServiceIndicators,
        'SegmentRefKey': segmentRefKey,
        'MealKey': mealKey,
        'BaggageKey': baggageKey,
        'FreeBaggages': freeBaggages,
        'CodeShare': codeShare,
        'RBD': rbd,
      };
}

class Passenger {
  final String? paxNo;
  final String? paxKey;
  final String paxType;
  final String title;
  final String firstName;
  final String lastName;
  final String dob;
  final String contact;
  final String? countryCode;
  final String email;
  final String? address;
  final String nationality;
  final String? passportNo;
  final String? countryOfIssue;
  final String? dateOfExpiry;
  final String? frequentFlyerNo;
  final String? ticketNo;
  final String? ticketNo_Return;
  final String? pinCode;
  final PSSRAvailability ssrAvailability;

  Passenger({
    this.paxNo,
    this.paxKey,
    required this.paxType,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.contact,
    this.countryCode,
    required this.email,
    this.address,
    required this.nationality,
    this.passportNo,
    this.countryOfIssue,
    this.dateOfExpiry,
    this.frequentFlyerNo,
    this.ticketNo,
    this.ticketNo_Return,
    this.pinCode,
    required this.ssrAvailability,
  });

  Map<String, dynamic> toJson() => {
        'PaxNo': paxNo,
        'PaxKey': paxKey,
        'PaxType': paxType,
        'Title': title,
        'FirstName': firstName,
        'LastName': lastName,
        'DOB': dob,
        'Contact': contact,
        'CountryCode': countryCode,
        'Email': email,
        'Address': address,
        'Nationality': nationality,
        'PassportNo': passportNo,
        'CountryOfIssue': countryOfIssue,
        'DateOfExpiry': dateOfExpiry,
        'FrequentFlyerNo': frequentFlyerNo,
        'TicketNo': ticketNo,
        'TicketNo_Return': ticketNo_Return,
        'PinCode': pinCode,
        'SSRAvailability': ssrAvailability.toJson(),
      };
}

class PSSRAvailability {
  final List<PMealInfo> mealInfo;
  final List<PBaggageInfo> baggageInfo;
  final List<PSeatInfo> seatInfo;

  PSSRAvailability({
    required this.mealInfo,
    required this.baggageInfo,
    required this.seatInfo,
  });

  factory PSSRAvailability.fromJson(Map<String, dynamic> json) => PSSRAvailability(
        mealInfo: (json['MealInfo'] as List?)?.map((e) => PMealInfo.fromJson(e)).toList() ?? [],
        baggageInfo: (json['BaggageInfo'] as List?)?.map((e) => PBaggageInfo.fromJson(e)).toList() ?? [],
        seatInfo: (json['SeatInfo'] as List?)?.map((e) => PSeatInfo.fromJson(e)).toList() ?? [],
      );

  Map<String, dynamic> toJson() => {
        'MealInfo': mealInfo.map((e) => e.toJson()).toList(),
        'BaggageInfo': baggageInfo.map((e) => e.toJson()).toList(),
        'SeatInfo': seatInfo.map((e) => e.toJson()).toList(),
      };
}

class PMealInfo {
  final List<PMeal> meals;

  PMealInfo({required this.meals});

  factory PMealInfo.fromJson(Map<String, dynamic> json) => PMealInfo(
        meals: (json['Meals'] as List?)?.map((e) => PMeal.fromJson(e)).toList() ?? [],
      );

  Map<String, dynamic> toJson() => {
        'Meals': meals.map((e) => e.toJson()).toList(),
      };
}

class PMeal {
  final String code;
  final String name;
  final double amount;
  final String currency;
  final String legKey;

  PMeal({
    required this.code,
    required this.name,
    required this.amount,
    required this.currency,
    required this.legKey,
  });

  factory PMeal.fromJson(Map<String, dynamic> json) => PMeal(
        code: json['Code'] ?? '',
        name: json['Name'] ?? '',
        amount: safeToDouble(json['Amount']),
        currency: json['Currency'] ?? '',
        legKey: json['LegKey'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'Code': code,
        'Name': name,
        'Amount': amount,
        'Currency': currency,
        'LegKey': legKey,
      };
}

class PBaggageInfo {
  final String? tripMode;
  final String? baggageKey;
  final List<PBaggage> baggages;

  PBaggageInfo({
    this.tripMode,
    this.baggageKey,
    required this.baggages,
  });

  factory PBaggageInfo.fromJson(Map<String, dynamic> json) => PBaggageInfo(
        tripMode: json['TripMode'],
        baggageKey: json['BaggageKey'],
        baggages: (json['Baggages'] as List?)?.map((e) => PBaggage.fromJson(e)).toList() ?? [],
      );

  Map<String, dynamic> toJson() => {
        'TripMode': tripMode,
        'BaggageKey': baggageKey,
        'Baggages': baggages.map((e) => e.toJson()).toList(),
      };
}

class PBaggage {
  final String? ptc;
  final String code;
  final String name;
  final String? weight;
  final double amount;
  final String currency;
  final String legKey;

  PBaggage({
    this.ptc,
    required this.code,
    required this.name,
    this.weight,
    required this.amount,
    required this.currency,
    required this.legKey,
  });

  factory PBaggage.fromJson(Map<String, dynamic> json) => PBaggage(
        ptc: json['PTC'],
        code: json['Code'] ?? '',
        name: json['Name'] ?? '',
        weight: json['Weight'],
        amount: safeToDouble(json['Amount']),
        currency: json['Currency'] ?? '',
        legKey: json['LegKey'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'PTC': ptc,
        'Code': code,
        'Name': name,
        'Weight': weight,
        'Amount': amount,
        'Currency': currency,
        'LegKey': legKey,
      };
}

class PSeatInfo {
  final List<PSeat> seats;

  PSeatInfo({required this.seats});

  factory PSeatInfo.fromJson(Map<String, dynamic> json) => PSeatInfo(
        seats: (json['Seats'] as List?)?.map((e) => PSeat.fromJson(e)).toList() ?? [],
      );

  Map<String, dynamic> toJson() => {
        'Seats': seats.map((e) => e.toJson()).toList(),
      };
}

class PSeat {
  final String seatKey;
  final String legKey;
  final String fare;

  PSeat({required this.seatKey, required this.legKey, required this.fare});

  factory PSeat.fromJson(Map<String, dynamic> json) => PSeat(
        seatKey: json['SeatKey'] ?? '',
        legKey: json['LegKey'] ?? '',
        fare: json['Fare'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'SeatKey': seatKey,
        'LegKey': legKey,
        'Fare': fare,
      };
}

// Helper function for safe double conversion
double safeToDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}