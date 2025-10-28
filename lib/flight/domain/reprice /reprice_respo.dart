import 'dart:convert';

RePriceResponse flightBookingResponseFromJson(String str) => RePriceResponse.fromJson(json.decode(str));

String flightBookingResponseToJson(RePriceResponse data) => json.encode(data.toJson());

class RePriceResponse {
  ReJourneyData? journy;
  dynamic errors;
  String? tripMode;
  dynamic ssrAvailability;
  List<RePassenger>? passengers;

  RePriceResponse({
    this.journy,
    this.errors,
    this.tripMode,
    this.ssrAvailability,
    this.passengers,
  });

  factory RePriceResponse.fromJson(Map<String, dynamic> json) => RePriceResponse(
    journy: json["Journy"] == null ? null : ReJourneyData.fromJson(json["Journy"]),
    errors: json["Errors"],
    tripMode: json["TripMode"],
    ssrAvailability: json["SSRAvailability"],
    passengers: json["Passengers"] == null ? [] : List<RePassenger>.from(json["Passengers"]!.map((x) => RePassenger.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Journy": journy?.toJson(),
    "Errors": errors,
    "TripMode": tripMode,
    "SSRAvailability": ssrAvailability,
    "Passengers": passengers == null ? [] : List<dynamic>.from(passengers!.map((x) => x.toJson())),
  };
}

class ReJourneyData {
  dynamic flightOptions;
  ReFlightOption? flightOption;
  dynamic hostTokens;
  dynamic errors;

  ReJourneyData({
    this.flightOptions,
    this.flightOption,
    this.hostTokens,
    this.errors,
  });

  factory ReJourneyData.fromJson(Map<String, dynamic> json) => ReJourneyData(
    flightOptions: json["FlightOptions"],
    flightOption: json["FlightOption"] == null ? null : ReFlightOption.fromJson(json["FlightOption"]),
    hostTokens: json["HostTokens"],
    errors: json["Errors"],
  );

  Map<String, dynamic> toJson() => {
    "FlightOptions": flightOptions,
    "FlightOption": flightOption?.toJson(),
    "HostTokens": hostTokens,
    "Errors": errors,
  };
}

class ReFlightOption {
  String? key;
  String? ticketingCarrier;
  String? apiType;
  dynamic crsPnr;
  dynamic providerCode;
  int? availableSeat;
  List<ReFlightFare>? flightFares;
  List<ReFlightLeg>? flightLegs;
  bool? seatEnabled;
  bool? reprice;
  bool? ffNoEnabled;

  ReFlightOption({
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

  factory ReFlightOption.fromJson(Map<String, dynamic> json) => ReFlightOption(
    key: json["Key"],
    ticketingCarrier: json["TicketingCarrier"],
    apiType: json["ApiType"],
    crsPnr: json["CrsPnr"],
    providerCode: json["ProviderCode"],
    availableSeat: json["AvailableSeat"],
    flightFares: json["FlightFares"] == null ? [] : List<ReFlightFare>.from(json["FlightFares"]!.map((x) => ReFlightFare.fromJson(x))),
    flightLegs: json["FlightLegs"] == null ? [] : List<ReFlightLeg>.from(json["FlightLegs"]!.map((x) => ReFlightLeg.fromJson(x))),
    seatEnabled: json["SeatEnabled"],
    reprice: json["Reprice"],
    ffNoEnabled: json["FFNoEnabled"],
  );

  Map<String, dynamic> toJson() => {
    "Key": key,
    "TicketingCarrier": ticketingCarrier,
    "ApiType": apiType,
    "CrsPnr": crsPnr,
    "ProviderCode": providerCode,
    "AvailableSeat": availableSeat,
    "FlightFares": flightFares == null ? [] : List<dynamic>.from(flightFares!.map((x) => x.toJson())),
    "FlightLegs": flightLegs == null ? [] : List<dynamic>.from(flightLegs!.map((x) => x.toJson())),
    "SeatEnabled": seatEnabled,
    "Reprice": reprice,
    "FFNoEnabled": ffNoEnabled,
  };
}

class ReFlightFare {
  List<ReFare>? fares;
  String? fid;
  dynamic refundableInfo;
  String? fareKey;
  double? aprxTotalBaseFare;
  double? aprxTotalTax;
  double? totalDiscount;
  dynamic extrafare;
  double? aprxTotalAmount;
  dynamic currency;
  dynamic fareType;
  dynamic fareName;
  double? totalAmount;

  ReFlightFare({
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

  factory ReFlightFare.fromJson(Map<String, dynamic> json) => ReFlightFare(
    fares: json["Fares"] == null ? [] : List<ReFare>.from(json["Fares"]!.map((x) => ReFare.fromJson(x))),
    fid: json["FID"],
    refundableInfo: json["RefundableInfo"],
    fareKey: json["FareKey"],
    aprxTotalBaseFare: json["AprxTotalBaseFare"]?.toDouble(),
    aprxTotalTax: json["AprxTotalTax"]?.toDouble(),
    totalDiscount: json["TotalDiscount"]?.toDouble(),
    extrafare: json["Extrafare"],
    aprxTotalAmount: json["AprxTotalAmount"]?.toDouble(),
    currency: json["Currency"],
    fareType: json["FareType"],
    fareName: json["FareName"],
    totalAmount: json["TotalAmount"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "Fares": fares == null ? [] : List<dynamic>.from(fares!.map((x) => x.toJson())),
    "FID": fid,
    "RefundableInfo": refundableInfo,
    "FareKey": fareKey,
    "AprxTotalBaseFare": aprxTotalBaseFare,
    "AprxTotalTax": aprxTotalTax,
    "TotalDiscount": totalDiscount,
    "Extrafare": extrafare,
    "AprxTotalAmount": aprxTotalAmount,
    "Currency": currency,
    "FareType": fareType,
    "FareName": fareName,
    "TotalAmount": totalAmount,
  };
}

class ReFare {
  String? ptc;
  double? baseFare;
  double? tax;
  double? discount;
  List<ReSplitup>? splitup;

  ReFare({
    this.ptc,
    this.baseFare,
    this.tax,
    this.discount,
    this.splitup,
  });

  factory ReFare.fromJson(Map<String, dynamic> json) => ReFare(
    ptc: json["PTC"],
    baseFare: json["BaseFare"]?.toDouble(),
    tax: json["Tax"]?.toDouble(),
    discount: json["Discount"]?.toDouble(),
    splitup: json["Splitup"] == null ? [] : List<ReSplitup>.from(json["Splitup"]!.map((x) => ReSplitup.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "PTC": ptc,
    "BaseFare": baseFare,
    "Tax": tax,
    "Discount": discount,
    "Splitup": splitup == null ? [] : List<dynamic>.from(splitup!.map((x) => x.toJson())),
  };
}

class ReSplitup {
  String? category;
  double? amount;

  ReSplitup({
    this.category,
    this.amount,
  });

  factory ReSplitup.fromJson(Map<String, dynamic> json) => ReSplitup(
    category: json["Category"],
    amount: json["Amount"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "Category": category,
    "Amount": amount,
  };
}

class ReFlightLeg {
  String? type;
  dynamic airlinePnr;
  String? key;
  String? origin;
  String? destination;
  String? departureTime;
  String? arrivalTime;
  String? arrivalTerminal;
  String? departureTerminal;
  String? flightNo;
  String? airlineCode;
  dynamic carrier;
  double? distance;
  dynamic optionalServiceIndicators;
  dynamic segmentRefKey;
  dynamic mealKey;
  dynamic baggageKey;
  dynamic freeBaggages;
  String? codeShare;
  String? rbd;

  ReFlightLeg({
    this.type,
    this.airlinePnr,
    this.key,
    this.origin,
    this.destination,
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

  factory ReFlightLeg.fromJson(Map<String, dynamic> json) => ReFlightLeg(
    type: json["Type"],
    airlinePnr: json["AirlinePNR"],
    key: json["Key"],
    origin: json["Origin"],
    destination: json["Destination"],
    departureTime: json["DepartureTime"],
    arrivalTime: json["ArrivalTime"],
    arrivalTerminal: json["ArrivalTerminal"],
    departureTerminal: json["DepartureTerminal"],
    flightNo: json["FlightNo"],
    airlineCode: json["AirlineCode"],
    carrier: json["Carrier"],
    distance: json["Distance"],
    optionalServiceIndicators: json["OptionalServiceIndicators"],
    segmentRefKey: json["SegmentRefKey"],
    mealKey: json["MealKey"],
    baggageKey: json["BaggageKey"],
    freeBaggages: json["FreeBaggages"],
    codeShare: json["CodeShare"],
    rbd: json["RBD"],
  );

  Map<String, dynamic> toJson() => {
    "Type": type,
    "AirlinePNR": airlinePnr,
    "Key": key,
    "Origin": origin,
    "Destination": destination,
    "DepartureTime": departureTime,
    "ArrivalTime": arrivalTime,
    "ArrivalTerminal": arrivalTerminal,
    "DepartureTerminal": departureTerminal,
    "FlightNo": flightNo,
    "AirlineCode": airlineCode,
    "Carrier": carrier,
    "Distance": distance,
    "OptionalServiceIndicators": optionalServiceIndicators,
    "SegmentRefKey": segmentRefKey,
    "MealKey": mealKey,
    "BaggageKey": baggageKey,
    "FreeBaggages": freeBaggages,
    "CodeShare": codeShare,
    "RBD": rbd,
  };
}

class RePassenger {
  String? paxNo;
  String? paxKey;
  String? paxType;
  String? title;
  String? firstName;
  String? lastName;
  String? dob;
  String? contact;
  String? email;
  String? address;
  String? nationality;
  String? countryCode;
  dynamic passportNo;
  String? countryOfIssue;
  String? dateOfExpiry;
  String? frequentFlyerNo;
  dynamic ticketNo;
  dynamic ticketNoReturn;
  String? pinCode;
  ReSsrAvailability? ssrAvailability;

  RePassenger({
    this.paxNo,
    this.paxKey,
    this.paxType,
    this.title,
    this.firstName,
    this.lastName,
    this.dob,
    this.contact,
    this.countryCode,
    this.email,
    this.address,
    this.nationality,
    this.passportNo,
    this.countryOfIssue,
    this.dateOfExpiry,
    this.frequentFlyerNo,
    this.ticketNo,
    this.ticketNoReturn,
    this.pinCode,
    this.ssrAvailability,
  });

  factory RePassenger.fromJson(Map<String, dynamic> json) => RePassenger(
    paxNo: json["PaxNo"],
    paxKey: json["PaxKey"],
    paxType: json["PaxType"],
    title: json["Title"],
    firstName: json["FirstName"],
    lastName: json["LastName"],
    dob: json["DOB"],
    countryCode: json["CountryCode"],
    contact: json["Contact"],
    email: json["Email"],
    address: json["Address"],
    nationality: json["Nationality"],
    passportNo: json["PassportNo"],
    countryOfIssue: json["CountryOfIssue"],
    dateOfExpiry: json["DateOfExpiry"],
    frequentFlyerNo: json["FrequentFlyerNo"],
    ticketNo: json["TicketNo"],
    ticketNoReturn: json["TicketNo_Return"],
    pinCode: json["PinCode"],
    ssrAvailability: json["SSRAvailability"] == null ? null : ReSsrAvailability.fromJson(json["SSRAvailability"]),
  );

  Map<String, dynamic> toJson() => {
    "PaxNo": paxNo,
    "PaxKey": paxKey,
    "PaxType": paxType,
    "Title": title,
    "FirstName": firstName,
    "LastName": lastName,
    "DOB": dob,
    "Contact": contact,
    "Email": email,
    "Address": address,
    "CountryCode":countryCode,
    "Nationality": nationality,
    "PassportNo": passportNo,
    "CountryOfIssue": countryOfIssue,
    "DateOfExpiry": dateOfExpiry,
    "FrequentFlyerNo": frequentFlyerNo,
    "TicketNo": ticketNo,
    "TicketNo_Return": ticketNoReturn,
    "PinCode": pinCode,
    "SSRAvailability": ssrAvailability?.toJson(),
  };
}

class ReSsrAvailability {
  List<ReMealInfo>? mealInfo;
  List<ReBaggageInfo>? baggageInfo;
  List<ReSeatInfo>? seatInfo;

  ReSsrAvailability({
    this.mealInfo,
    this.baggageInfo,
    this.seatInfo,
  });

  factory ReSsrAvailability.fromJson(Map<String, dynamic> json) => ReSsrAvailability(
    mealInfo: json["MealInfo"] == null ? [] : List<ReMealInfo>.from(json["MealInfo"]!.map((x) => ReMealInfo.fromJson(x))),
    baggageInfo: json["BaggageInfo"] == null ? [] : List<ReBaggageInfo>.from(json["BaggageInfo"]!.map((x) => ReBaggageInfo.fromJson(x))),
    seatInfo: json["SeatInfo"] == null ? [] : List<ReSeatInfo>.from(json["SeatInfo"]!.map((x) => ReSeatInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "MealInfo": mealInfo == null ? [] : List<dynamic>.from(mealInfo!.map((x) => x.toJson())),
    "BaggageInfo": baggageInfo == null ? [] : List<dynamic>.from(baggageInfo!.map((x) => x.toJson())),
    "SeatInfo": seatInfo == null ? [] : List<dynamic>.from(seatInfo!.map((x) => x.toJson())),
  };
}

class ReBaggageInfo {
  dynamic tripMode;
  dynamic baggageKey;
  List<ReBaggage>? baggages;

  ReBaggageInfo({
    this.tripMode,
    this.baggageKey,
    this.baggages,
  });

  factory ReBaggageInfo.fromJson(Map<String, dynamic> json) => ReBaggageInfo(
    tripMode: json["TripMode"],
    baggageKey: json["BaggageKey"],
    baggages: json["Baggages"] == null ? [] : List<ReBaggage>.from(json["Baggages"]!.map((x) => ReBaggage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "TripMode": tripMode,
    "BaggageKey": baggageKey,
    "Baggages": baggages == null ? [] : List<dynamic>.from(baggages!.map((x) => x.toJson())),
  };
}

class ReBaggage {
  dynamic ptc;
  String? code;
  String? name;
  dynamic weight;
  double? amount;
  String? currency;
  String? legKey;

  ReBaggage({
    this.ptc,
    this.code,
    this.name,
    this.weight,
    this.amount,
    this.currency,
    this.legKey,
  });

  factory ReBaggage.fromJson(Map<String, dynamic> json) => ReBaggage(
    ptc: json["PTC"],
    code: json["Code"],
    name: json["Name"],
    weight: json["Weight"],
    amount: json["Amount"]?.toDouble(),
    currency: json["Currency"],
    legKey: json["LegKey"],
  );

  Map<String, dynamic> toJson() => {
    "PTC": ptc,
    "Code": code,
    "Name": name,
    "Weight": weight,
    "Amount": amount,
    "Currency": currency,
    "LegKey": legKey,
  };
}

class ReMealInfo {
  dynamic mealKey;
  dynamic tripMode;
  List<ReMeal>? meals;

  ReMealInfo({
    this.mealKey,
    this.tripMode,
    this.meals,
  });

  factory ReMealInfo.fromJson(Map<String, dynamic> json) => ReMealInfo(
    mealKey: json["MealKey"],
    tripMode: json["TripMode"],
    meals: json["Meals"] == null ? [] : List<ReMeal>.from(json["Meals"]!.map((x) => ReMeal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "MealKey": mealKey,
    "TripMode": tripMode,
    "Meals": meals == null ? [] : List<dynamic>.from(meals!.map((x) => x.toJson())),
  };
}

class ReMeal {
  dynamic ptc;
  String? code;
  String? name;
  double? amount;
  String? currency;
  String? legKey;

  ReMeal({
    this.ptc,
    this.code,
    this.name,
    this.amount,
    this.currency,
    this.legKey,
  });

  factory ReMeal.fromJson(Map<String, dynamic> json) => ReMeal(
    ptc: json["PTC"],
    code: json["Code"],
    name: json["Name"],
    amount: json["Amount"]?.toDouble(),
    currency: json["Currency"],
    legKey: json["LegKey"],
  );

  Map<String, dynamic> toJson() => {
    "PTC": ptc,
    "Code": code,
    "Name": name,
    "Amount": amount,
    "Currency": currency,
    "LegKey": legKey,
  };
}

class ReSeatInfo {
  List<ReSeat>? seats;

  ReSeatInfo({
    this.seats,
  });

  factory ReSeatInfo.fromJson(Map<String, dynamic> json) => ReSeatInfo(
    seats: json["Seats"] == null ? [] : List<ReSeat>.from(json["Seats"]!.map((x) => ReSeat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Seats": seats == null ? [] : List<dynamic>.from(seats!.map((x) => x.toJson())),
  };
}

class ReSeat {
  String? ptc;
  String? seatKey;
  String? legKey;
  String? fare;
  dynamic currency;

  ReSeat({
    this.ptc,
    this.seatKey,
    this.legKey,
    this.fare,
    this.currency,
  });

  factory ReSeat.fromJson(Map<String, dynamic> json) => ReSeat(
    ptc: json["PTC"],
    seatKey: json["SeatKey"],
    legKey: json["LegKey"],
    fare: json["Fare"],
    currency: json["Currency"],
  );

  Map<String, dynamic> toJson() => {
    "PTC": ptc,
    "SeatKey": seatKey,
    "LegKey": legKey,
    "Fare": fare,
    "Currency": currency,
  };
}