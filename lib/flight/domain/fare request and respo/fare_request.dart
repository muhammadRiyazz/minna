import 'package:minna/flight/domain/trip%20resp/trip_respo.dart';

class FareRequest {
  final String userId;
  final String token;
  final String tripMode;
  final dynamic error;
  final Journy journy;

  FareRequest({
    required this.userId,
    required this.token,
    required this.tripMode,
    this.error,
    required this.journy,
  });

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'Token': token,
      'TripMode': tripMode,
      'Error': error,
      'Journy': journy.toJson(),
    };
  }
}

class FlightOption {
  final String key;
  final String ticketingCarrier;
  final String apiType;
  final String? crsPnr;
  final String providerCode;
  final int availableSeat;
  final List<FlightFare> flightFares;
  final List<RFlightLeg> flightLegs;
  final bool seatEnabled;
  final bool reprice;
  final bool ffNoEnabled;

  FlightOption({
    required this.key,
    required this.ticketingCarrier,
    required this.apiType,
    this.crsPnr,
    required this.providerCode,
    required this.availableSeat,
    required this.flightFares,
    required this.flightLegs,
    required this.seatEnabled,
    required this.reprice,
    required this.ffNoEnabled,
  });

  Map<String, dynamic> toJson() {
    return {
      'Key': key,
      'TicketingCarrier': ticketingCarrier,
      'ApiType': apiType,
      'CrsPnr': crsPnr,
      'ProviderCode': providerCode,
      'AvailableSeat': availableSeat,
      'FlightFares': flightFares.map((f) => f.toJson()).toList(),
      'FlightLegs': flightLegs.map((f) => f.toJson()).toList(),
      'SeatEnabled': seatEnabled,
      'Reprice': reprice,
      'FFNoEnabled': ffNoEnabled,
    };
  }
}

class RFlightLeg {
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
  final double distance;
  final String? codeShare;
  final String? rbd;

  RFlightLeg({
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
    this.codeShare,
    this.rbd,
  });

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
      'CodeShare': codeShare,
      'RBD': rbd,
    };
  }
}
