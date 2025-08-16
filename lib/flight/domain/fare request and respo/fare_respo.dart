import 'package:minna/flight/domain/reprice%20/reprice_respo.dart';
import 'package:minna/flight/domain/trip%20resp/trip_respo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class FFlightResponse {
  final FJourney? journey;
  final List<dynamic>? errors;
  final String? tripMode;
  final SSRAvailability? ssrAvailability;
  final List<PassengerInfo>? passengerInfo;

  FFlightResponse({
    this.journey,
    this.errors,
    this.tripMode,
    this.ssrAvailability,
    this.passengerInfo,
  });

  factory FFlightResponse.fromJson(Map<String, dynamic> json) {
    return FFlightResponse(
      journey: json['Journy'] != null
          ? FJourney.fromJson(json['Journy'])
          : null,
      errors: json['Errors'] as List<dynamic>?,
      tripMode: json['TripMode'] as String?,
      ssrAvailability: json['SSRAvailability'] != null
          ? SSRAvailability.fromJson(json['SSRAvailability'])
          : null,
      passengerInfo: json['PassengerInfo'] != null
          ? List<PassengerInfo>.from(
              json['PassengerInfo'].map((x) => PassengerInfo.fromJson(x)),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Journy': journey?.toJson(),
      'Errors': errors,
      'TripMode': tripMode,
      'SSRAvailability': ssrAvailability?.toJson(),
      'PassengerInfo': passengerInfo?.map((x) => x.toJson()).toList(),
    };
  }

  FFlightResponse copyWith({
    FJourney? journey,
    List<dynamic>? errors,
    String? tripMode,
    SSRAvailability? ssrAvailability,
    List<PassengerInfo>? passengerInfo,
  }) {
    return FFlightResponse(
      journey: journey ?? this.journey,
      errors: errors ?? this.errors,
      tripMode: tripMode ?? this.tripMode,
      ssrAvailability: ssrAvailability ?? this.ssrAvailability,
      passengerInfo: passengerInfo ?? this.passengerInfo,
    );
  }
}

class FJourney {
  final dynamic flightOptions;
  final FFlightOption? flightOption;
  final dynamic hostTokens;
  final dynamic errors;

  FJourney({
    this.flightOptions,
    this.flightOption,
    this.hostTokens,
    this.errors,
  });

  // Add copyWith method
  FJourney copyWith({
    dynamic flightOptions,
    FFlightOption? flightOption,
    dynamic hostTokens,
    dynamic errors,
  }) {
    return FJourney(
      flightOptions: flightOptions ?? this.flightOptions,
      flightOption: flightOption ?? this.flightOption,
      hostTokens: hostTokens ?? this.hostTokens,
      errors: errors ?? this.errors,
    );
  }

  factory FJourney.fromJson(Map<String, dynamic> json) {
    return FJourney(
      flightOptions: json['FlightOptions'],
      flightOption: json['FlightOption'] != null
          ? FFlightOption.fromJson(json['FlightOption'])
          : null,
      hostTokens: json['HostTokens'],
      errors: json['Errors'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FlightOptions': flightOptions,
      'FlightOption': flightOption?.toJson(),
      'HostTokens': hostTokens,
      'Errors': errors,
    };
  }
}

class FFlightOption {
  final String? flightName;
  final String? flightimg;
  final String? key;
  final String? ticketingCarrier;
  final String? apiType;
  final dynamic crsPnr;
  final String? providerCode;
  final int? availableSeat;
  List<FFlightLeg>? flightOnwardLegs;
  final List<FFlightLeg>? flightRetunLegs;
  final List<FFlightFare>? flightFares;
  final List<FFlightLeg>? flightLegs;

  final bool? seatEnabled;
  final bool? reprice;
  final bool? ffNoEnabled;

  FFlightOption({
    this.flightOnwardLegs,
    this.flightRetunLegs,

    this.flightName,
    this.flightimg,
    this.key,
    this.ticketingCarrier,
    this.apiType,
    this.crsPnr,
    this.providerCode,
    this.availableSeat,
    this.flightFares,
    this.flightLegs,
    this.seatEnabled,
    this.reprice,
    this.ffNoEnabled,
  });

  factory FFlightOption.fromJson(Map<String, dynamic> json) {
    return FFlightOption(
      flightOnwardLegs: [],
      flightRetunLegs: [],
      key: json['Key'] as String?,
      ticketingCarrier: json['TicketingCarrier'] as String?,
      apiType: json['ApiType'] as String?,
      crsPnr: json['CrsPnr'],
      providerCode: json['ProviderCode'] as String?,
      availableSeat: json['AvailableSeat'] as int?,
      flightFares: json['FlightFares'] != null
          ? List<FFlightFare>.from(
              json['FlightFares'].map((x) => FFlightFare.fromJson(x)),
            )
          : null,
      flightLegs: json['FlightLegs'] != null
          ? List<FFlightLeg>.from(
              json['FlightLegs'].map((x) => FFlightLeg.fromJson(x)),
            )
          : null,
      seatEnabled: json['SeatEnabled'] as bool?,
      reprice: json['Reprice'] as bool?,
      ffNoEnabled: json['FFNoEnabled'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Key': key,
      'TicketingCarrier': ticketingCarrier,
      'ApiType': apiType,
      'CrsPnr': crsPnr,
      'ProviderCode': providerCode,
      'AvailableSeat': availableSeat,
      'FlightFares': flightFares?.map((x) => x.toJson()).toList(),
      'FlightLegs': flightLegs?.map((x) => x.toJson()).toList(),
      'SeatEnabled': seatEnabled,
      'Reprice': reprice,
      'FFNoEnabled': ffNoEnabled,
    };
  }

  FFlightOption copyWith({
    String? flightName,
    String? flightimg,
    String? key,
    String? ticketingCarrier,
    String? apiType,
    dynamic crsPnr,
    String? providerCode,
    int? availableSeat,
    List<FFlightFare>? flightFares,
    List<FFlightLeg>? flightLegs,
    List<FFlightLeg>? flightOnwardLegs,
    List<FFlightLeg>? flightRetunLegs,

    bool? seatEnabled,
    bool? reprice,
    bool? ffNoEnabled,
  }) {
    return FFlightOption(
      flightOnwardLegs: flightOnwardLegs ?? this.flightOnwardLegs,
      flightRetunLegs: flightRetunLegs ?? this.flightRetunLegs,
      flightName: flightName ?? this.flightName,
      flightimg: flightimg ?? this.flightimg,
      key: key ?? this.key,
      ticketingCarrier: ticketingCarrier ?? this.ticketingCarrier,
      apiType: apiType ?? this.apiType,
      crsPnr: crsPnr ?? this.crsPnr,
      providerCode: providerCode ?? this.providerCode,
      availableSeat: availableSeat ?? this.availableSeat,
      flightFares: flightFares ?? this.flightFares,
      flightLegs: flightLegs ?? this.flightLegs,
      seatEnabled: seatEnabled ?? this.seatEnabled,
      reprice: reprice ?? this.reprice,
      ffNoEnabled: ffNoEnabled ?? this.ffNoEnabled,
    );
  }
}

class FFlightFare {
  final List<ReFare>? fares;
  final String? fid;
  final dynamic refundableInfo;
  final String? fareKey;
  final double? aprxTotalBaseFare;
  final double? aprxTotalTax;
  final double? totalDiscount;
  final dynamic extrafare;
  final double? aprxTotalAmount;
  final dynamic currency;
  final dynamic fareType;
  final dynamic fareName;
  final double? totalAmount;

  FFlightFare({
    this.fares,
    this.fid,
    this.refundableInfo,
    this.fareKey,
    this.aprxTotalBaseFare,
    this.aprxTotalTax,
    this.totalDiscount,
    this.extrafare,
    this.aprxTotalAmount,
    this.currency,
    this.fareType,
    this.fareName,
    this.totalAmount,
  });

  factory FFlightFare.fromJson(Map<String, dynamic> json) {
    return FFlightFare(
      fares: json['Fares'] != null
          ? List<ReFare>.from(json['Fares'].map((x) => ReFare.fromJson(x)))
          : null,
      fid: json['FID'] as String?,
      refundableInfo: json['RefundableInfo'],
      fareKey: json['FareKey'] as String?,
      aprxTotalBaseFare: json['AprxTotalBaseFare']?.toDouble(),
      aprxTotalTax: json['AprxTotalTax']?.toDouble(),
      totalDiscount: json['TotalDiscount']?.toDouble(),
      extrafare: json['Extrafare'],
      aprxTotalAmount: json['AprxTotalAmount']?.toDouble(),
      currency: json['Currency'],
      fareType: json['FareType'],
      fareName: json['FareName'],
      totalAmount: json['TotalAmount']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Fares': fares?.map((x) => x.toJson()).toList(),
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
}

// class FFare {
//   final String? ptc;
//   final double? baseFare;
//   final double? tax;
//   final double? discount;
//   final List<FSplitup>? splitup;

//   FFare({this.ptc, this.baseFare, this.tax, this.discount, this.splitup});

//   factory FFare.fromJson(Map<String, dynamic> json) {
//     return FFare(
//       ptc: json['PTC'] as String?,
//       baseFare: json['BaseFare']?.toDouble(),
//       tax: json['Tax']?.toDouble(),
//       discount: json['Discount']?.toDouble(),
//       splitup:
//           json['Splitup'] != null
//               ? List<FSplitup>.from(
//                 json['Splitup'].map((x) => FSplitup.fromJson(x)),
//               )
//               : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'PTC': ptc,
//       'BaseFare': baseFare,
//       'Tax': tax,
//       'Discount': discount,
//       'Splitup': splitup?.map((x) => x.toJson()).toList(),
//     };
//   }
// }

// class FSplitup {
//   final String? category;
//   final double? amount;

//   FSplitup({this.category, this.amount});

//   factory FSplitup.fromJson(Map<String, dynamic> json) {
//     return FSplitup(
//       category: json['Category'] as String?,
//       amount: json['Amount']?.toDouble(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {'Category': category, 'Amount': amount};
//   }
// }

class FFlightLeg {
  final String? type;
  final dynamic airlinePNR;
  final String? key;
  final String? origin;
  final String? destination;
  final String? departureTime;
  final String? arrivalTime;
  final String? arrivalTerminal;
  final String? departureTerminal;
  final String? flightNo;
  final String? airlineCode;
  final dynamic carrier;
  final double? distance;
  final dynamic optionalServiceIndicators;
  final dynamic segmentRefKey;
  final String? mealKey;
  final String? baggageKey;
  final List<FreeBaggage>? freeBaggages;
  final String? codeShare;
  final String? rbd;

  final String? flightName;
  final String? flightimg;
  final String? destinationName;
  final String? originName;

  FFlightLeg({
    this.flightName,
    this.flightimg,
    this.type,
    this.airlinePNR,
    this.key,
    this.origin,
    this.destination,
    this.originName,
    this.destinationName,
    this.departureTime,
    this.arrivalTime,
    this.arrivalTerminal,
    this.departureTerminal,
    this.flightNo,
    this.airlineCode,
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

  factory FFlightLeg.fromJson(Map<String, dynamic> json) {
    return FFlightLeg(
      type: json['Type'] as String?,
      airlinePNR: json['AirlinePNR'],
      key: json['Key'] as String?,
      origin: json['Origin'] as String?,
      destination: json['Destination'] as String?,
      departureTime: json['DepartureTime'] as String?,
      arrivalTime: json['ArrivalTime'] as String?,
      arrivalTerminal: json['ArrivalTerminal'] as String?,
      departureTerminal: json['DepartureTerminal'] as String?,
      flightNo: json['FlightNo'] as String?,
      airlineCode: json['AirlineCode'] as String?,
      carrier: json['Carrier'],
      distance: json['Distance']?.toDouble(),
      optionalServiceIndicators: json['OptionalServiceIndicators'],
      segmentRefKey: json['SegmentRefKey'],
      mealKey: json['MealKey'] as String?,
      baggageKey: json['BaggageKey'] as String?,
      freeBaggages: json['FreeBaggages'],
      codeShare: json['CodeShare'] as String?,
      rbd: json['RBD'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
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

  FFlightLeg copyWith({
    String? type,
    dynamic airlinePNR,
    String? key,
    String? origin,
    String? destination,
    String? departureTime,
    String? arrivalTime,
    String? arrivalTerminal,
    String? departureTerminal,
    String? flightNo,
    String? airlineCode,
    dynamic carrier,
    double? distance,
    dynamic optionalServiceIndicators,
    dynamic segmentRefKey,
    String? mealKey,
    String? baggageKey,
    dynamic freeBaggages,
    String? codeShare,
    String? rbd,
    String? flightName,
    String? flightimg,
    String? destinationName,
    String? originName,
  }) {
    return FFlightLeg(
      type: type ?? this.type,
      airlinePNR: airlinePNR ?? this.airlinePNR,
      key: key ?? this.key,
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      originName: originName ?? this.originName,
      destinationName: destinationName ?? this.destinationName,
      departureTime: departureTime ?? this.departureTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      arrivalTerminal: arrivalTerminal ?? this.arrivalTerminal,
      departureTerminal: departureTerminal ?? this.departureTerminal,
      flightNo: flightNo ?? this.flightNo,
      airlineCode: airlineCode ?? this.airlineCode,
      carrier: carrier ?? this.carrier,
      distance: distance ?? this.distance,
      optionalServiceIndicators:
          optionalServiceIndicators ?? this.optionalServiceIndicators,
      segmentRefKey: segmentRefKey ?? this.segmentRefKey,
      mealKey: mealKey ?? this.mealKey,
      baggageKey: baggageKey ?? this.baggageKey,
      freeBaggages: freeBaggages ?? this.freeBaggages,
      codeShare: codeShare ?? this.codeShare,
      rbd: rbd ?? this.rbd,
      flightName: flightName ?? this.flightName,
      flightimg: flightimg ?? this.flightimg,
    );
  }
}

class SSRAvailability {
  final List<MealInfo>? mealInfo;
  final List<BaggageInfo>? baggageInfo;
  final dynamic seatInfo;

  SSRAvailability({this.mealInfo, this.baggageInfo, this.seatInfo});

  factory SSRAvailability.fromJson(Map<String, dynamic> json) {
    return SSRAvailability(
      mealInfo: json['MealInfo'] != null
          ? List<MealInfo>.from(
              json['MealInfo'].map((x) => MealInfo.fromJson(x)),
            )
          : null,
      baggageInfo: json['BaggageInfo'] != null
          ? List<BaggageInfo>.from(
              json['BaggageInfo'].map((x) => BaggageInfo.fromJson(x)),
            )
          : null,
      seatInfo: json['SeatInfo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MealInfo': mealInfo?.map((x) => x.toJson()).toList(),
      'BaggageInfo': baggageInfo?.map((x) => x.toJson()).toList(),
      'SeatInfo': seatInfo,
    };
  }
}

class MealInfo {
  final String? mealKey;
  final dynamic tripMode;
  final List<Meal>? meals;

  MealInfo({this.mealKey, this.tripMode, this.meals});

  factory MealInfo.fromJson(Map<String, dynamic> json) {
    return MealInfo(
      mealKey: json['MealKey'] as String?,
      tripMode: json['TripMode'],
      meals: json['Meals'] != null
          ? List<Meal>.from(json['Meals'].map((x) => Meal.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MealKey': mealKey,
      'TripMode': tripMode,
      'Meals': meals?.map((x) => x.toJson()).toList(),
    };
  }
}

class Meal {
  final String? ptc;
  final String? paxKey;
  final String? code;
  final String? name;
  final double? amount;
  final String? currency;
  final dynamic legKey;

  Meal({
    this.ptc,
    this.paxKey,
    this.code,
    this.name,
    this.amount,
    this.currency,
    this.legKey,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      ptc: json['PTC'] as String?,
      paxKey: json['PaxKey'] as String?,
      code: json['Code'] as String?,
      name: json['Name'] as String?,
      amount: json['Amount']?.toDouble(),
      currency: json['Currency'] as String?,
      legKey: json['LegKey'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PTC': ptc,
      'PaxKey': paxKey,
      'Code': code,
      'Name': name,
      'Amount': amount,
      'Currency': currency,
      'LegKey': legKey,
    };
  }
}

class BaggageInfo {
  final dynamic tripMode;
  final String? baggageKey;
  final List<Baggage>? baggages;

  BaggageInfo({this.tripMode, this.baggageKey, this.baggages});

  factory BaggageInfo.fromJson(Map<String, dynamic> json) {
    return BaggageInfo(
      tripMode: json['TripMode'],
      baggageKey: json['BaggageKey'] as String?,
      baggages: json['Baggages'] != null
          ? List<Baggage>.from(json['Baggages'].map((x) => Baggage.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TripMode': tripMode,
      'BaggageKey': baggageKey,
      'Baggages': baggages?.map((x) => x.toJson()).toList(),
    };
  }
}

class Baggage {
  final String? ptc;
  final String? paxKey;
  final String? code;
  final String? name;
  final String? weight;
  final double? amount;
  final String? currency;
  final dynamic legKey;

  Baggage({
    this.ptc,
    this.paxKey,
    this.code,
    this.name,
    this.weight,
    this.amount,
    this.currency,
    this.legKey,
  });

  factory Baggage.fromJson(Map<String, dynamic> json) {
    return Baggage(
      ptc: json['PTC'] as String?,
      paxKey: json['PaxKey'] as String?,
      code: json['Code'] as String?,
      name: json['Name'] as String?,
      weight: json['Weight'] as String?,
      amount: json['Amount']?.toDouble(),
      currency: json['Currency'] as String?,
      legKey: json['LegKey'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PTC': ptc,
      'PaxKey': paxKey,
      'Code': code,
      'Name': name,
      'Weight': weight,
      'Amount': amount,
      'Currency': currency,
      'LegKey': legKey,
    };
  }
}

class PassengerInfo {
  final String? ptc;
  final String? paxNo;
  final String? paxKey;
  final bool? isDobMandatory;
  final bool? isPassportMandatory;
  final bool? isBaggageMandatory;
  final bool? isMealMandatory;
  final bool? isSeatMandatory;

  PassengerInfo({
    this.ptc,
    this.paxNo,
    this.paxKey,
    this.isDobMandatory,
    this.isPassportMandatory,
    this.isBaggageMandatory,
    this.isMealMandatory,
    this.isSeatMandatory,
  });

  factory PassengerInfo.fromJson(Map<String, dynamic> json) {
    return PassengerInfo(
      ptc: json['PTC'] as String?,
      paxNo: json['PaxNo'] as String?,
      paxKey: json['PaxKey'] as String?,
      isDobMandatory: json['IsDobMandatory'] as bool?,
      isPassportMandatory: json['IsPassportMandatory'] as bool?,
      isBaggageMandatory: json['IsBaggageMandatory'] as bool?,
      isMealMandatory: json['IsMealMandatory'] as bool?,
      isSeatMandatory: json['IsSeatMandatory'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PTC': ptc,
      'PaxNo': paxNo,
      'PaxKey': paxKey,
      'IsDobMandatory': isDobMandatory,
      'IsPassportMandatory': isPassportMandatory,
      'IsBaggageMandatory': isBaggageMandatory,
      'IsMealMandatory': isMealMandatory,
      'IsSeatMandatory': isSeatMandatory,
    };
  }
}
