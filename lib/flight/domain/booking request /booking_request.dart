import 'package:minna/flight/domain/reprice%20/reprice_respo.dart';

class BBBookingRequest {
  final BBJourney journey;
  final dynamic errors;
  final String token;
  final String userId;
  final String tripMode;
  final List<RePassenger> passengers;

  BBBookingRequest({
    required this.journey,
    required this.errors,
    required this.token,
    required this.userId,
    required this.tripMode,
    required this.passengers,
  });

  factory BBBookingRequest.fromJson(Map<String, dynamic> json) {
    return BBBookingRequest(
      journey: BBJourney.fromJson(json['Journy']),
      errors: json['Errors'] ?? [],
      token: json['Token'],
      userId: json['UserId'],
      tripMode: json['TripMode'],
      passengers: List<RePassenger>.from(
        json['Passengers'].map((x) => RePassenger.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Journy': journey.toJson(),
      'Errors': errors,
      'Token': token,
      'UserId': userId,
      'TripMode': tripMode,
      'Passengers': passengers.map((x) => x.toJson()).toList(),
    };
  }
}

class BBJourney {
  final List<dynamic> flightOptions;
  final BBFlightOption flightOption;
  final List<dynamic> hostTokens;
  final List<dynamic> errors;

  BBJourney({
    required this.flightOptions,
    required this.flightOption,
    required this.hostTokens,
    required this.errors,
  });

  factory BBJourney.fromJson(Map<String, dynamic> json) {
    return BBJourney(
      flightOptions: json['FlightOptions'] ?? [],
      flightOption: BBFlightOption.fromJson(json['FlightOption']),
      hostTokens: json['HostTokens'] ?? [],
      errors: json['Errors'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FlightOptions': flightOptions,
      'FlightOption': flightOption.toJson(),
      'HostTokens': hostTokens,
      'Errors': errors,
    };
  }
}

class BBFlightOption {
  final String key;
  final String ticketingCarrier;
  final String apiType;
  final dynamic crsPnr;
  final dynamic providerCode;
  final int availableSeat;
  final List<BBFlightFare> flightFares;
  final List<BBFlightLeg> flightLegs;
  final bool seatEnabled;
  final bool reprice;
  final bool ffNoEnabled;

  BBFlightOption({
    required this.key,
    required this.ticketingCarrier,
    required this.apiType,
    this.crsPnr,
    this.providerCode,
    required this.availableSeat,
    required this.flightFares,
    required this.flightLegs,
    required this.seatEnabled,
    required this.reprice,
    required this.ffNoEnabled,
  });

  factory BBFlightOption.fromJson(Map<String, dynamic> json) {
    return BBFlightOption(
      key: json['Key'],
      ticketingCarrier: json['TicketingCarrier'],
      apiType: json['ApiType'],
      crsPnr: json['CrsPnr'],
      providerCode: json['ProviderCode'],
      availableSeat: json['AvailableSeat'],
      flightFares: List<BBFlightFare>.from(
        json['FlightFares'].map((x) => BBFlightFare.fromJson(x)),
      ),
      flightLegs: List<BBFlightLeg>.from(
        json['FlightLegs'].map((x) => BBFlightLeg.fromJson(x)),
      ),
      seatEnabled: json['SeatEnabled'],
      reprice: json['Reprice'],
      ffNoEnabled: json['FFNoEnabled'],
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
      'FlightFares': flightFares.map((x) => x.toJson()).toList(),
      'FlightLegs': flightLegs.map((x) => x.toJson()).toList(),
      'SeatEnabled': seatEnabled,
      'Reprice': reprice,
      'FFNoEnabled': ffNoEnabled,
    };
  }
}

class BBFlightFare {
  final List<ReFare> fares;
  final String fid;
  final dynamic refundableInfo;
  final String fareKey;
  final double aprxTotalBaseFare;
  final double aprxTotalTax;
  final double totalDiscount;
  final dynamic extrafare;
  final double aprxTotalAmount;
  final dynamic currency;
  final dynamic fareType;
  final dynamic fareName;
  final double totalAmount;

  BBFlightFare({
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

  factory BBFlightFare.fromJson(Map<String, dynamic> json) {
    return BBFlightFare(
      fares: List<ReFare>.from(json['Fares'].map((x) => ReFare.fromJson(x))),
      fid: json['FID'],
      refundableInfo: json['RefundableInfo'],
      fareKey: json['FareKey'],
      aprxTotalBaseFare: json['AprxTotalBaseFare'],
      aprxTotalTax: json['AprxTotalTax'],
      totalDiscount: json['TotalDiscount'].toDouble(),
      extrafare: json['Extrafare'],
      aprxTotalAmount: json['AprxTotalAmount'],
      currency: json['Currency'],
      fareType: json['FareType'],
      fareName: json['FareName'],
      totalAmount: json['TotalAmount'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Fares': fares.map((x) => x.toJson()).toList(),
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

class BBFlightLeg {
  final String type;
  final dynamic airlinePNR;
  final String key;
  final String origin;
  final String destination;
  final String departureTime;
  final String arrivalTime;
  final dynamic arrivalTerminal;
  final dynamic departureTerminal;
  final String flightNo;
  final String airlineCode;
  final dynamic carrier;
  final double distance;
  final dynamic optionalServiceIndicators;
  final dynamic segmentRefKey;
  final dynamic mealKey;
  final dynamic baggageKey;
  final List<dynamic> freeBaggages;
  final dynamic codeShare;
  final dynamic rbd;

  BBFlightLeg({
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
    required this.distance,
    this.optionalServiceIndicators,
    this.segmentRefKey,
    this.mealKey,
    this.baggageKey,
    required this.freeBaggages,
    this.codeShare,
    this.rbd,
  });

  factory BBFlightLeg.fromJson(Map<String, dynamic> json) {
    return BBFlightLeg(
      type: json['Type'],
      airlinePNR: json['AirlinePNR'],
      key: json['Key'],
      origin: json['Origin'],
      destination: json['Destination'],
      departureTime: json['DepartureTime'],
      arrivalTime: json['ArrivalTime'],
      arrivalTerminal: json['ArrivalTerminal'],
      departureTerminal: json['DepartureTerminal'],
      flightNo: json['FlightNo'],
      airlineCode: json['AirlineCode'],
      carrier: json['Carrier'],
      distance: json['Distance'],
      optionalServiceIndicators: json['OptionalServiceIndicators'],
      segmentRefKey: json['SegmentRefKey'],
      mealKey: json['MealKey'],
      baggageKey: json['BaggageKey'],
      freeBaggages: json['FreeBaggages'] ?? [],
      codeShare: json['CodeShare'],
      rbd: json['RBD'],
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
}
