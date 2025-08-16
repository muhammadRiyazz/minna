class FlightResponse {
  String? token;
  Journy? journy;
  dynamic errors;
  String? tripMode;
  String? message;

  FlightResponse({
    this.token,
    this.journy,
    this.errors,
    this.tripMode,
    this.message,
  });

  factory FlightResponse.fromJson(Map<String, dynamic> json) => FlightResponse(
    token: json["Token"],
    journy: json["Journy"] == null ? null : Journy.fromJson(json["Journy"]),
    errors: json["Errors"],
    tripMode: json["TripMode"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Token": token,
    "Journy": journy?.toJson(),
    "Errors": errors,
    "TripMode": tripMode,
    "Message": message,
  };

  FlightResponse copyWith({
    String? token,
    Journy? journy,
    dynamic errors,
    String? tripMode,
    String? message,
  }) {
    return FlightResponse(
      token: token ?? this.token,
      journy: journy ?? this.journy,
      errors: errors ?? this.errors,
      tripMode: tripMode ?? this.tripMode,
      message: message ?? this.message,
    );
  }
}

class Journy {
  List<FlightOptionElement>? flightOptions;
  dynamic flightOption;
  dynamic hostTokens;
  dynamic errors;

  Journy({this.flightOptions, this.flightOption, this.hostTokens, this.errors});

  factory Journy.fromJson(Map<String, dynamic> json) => Journy(
    flightOptions:
        json["FlightOptions"] == null
            ? []
            : List<FlightOptionElement>.from(
              json["FlightOptions"]!.map(
                (x) => FlightOptionElement.fromJson(x),
              ),
            ),
    flightOption: json["FlightOption"],
    hostTokens: json["HostTokens"],
    errors: json["Errors"],
  );

  Map<String, dynamic> toJson() => {
    "FlightOptions":
        flightOptions == null
            ? []
            : List<dynamic>.from(flightOptions!.map((x) => x.toJson())),
    "FlightOption": flightOption,
    "HostTokens": hostTokens,
    "Errors": errors,
  };

  Journy copyWith({
    List<FlightOptionElement>? flightOptions,
    dynamic flightOption,
    dynamic hostTokens,
    dynamic errors,
  }) {
    return Journy(
      flightOptions: flightOptions ?? this.flightOptions,
      flightOption: flightOption ?? this.flightOption,
      hostTokens: hostTokens ?? this.hostTokens,
      errors: errors ?? this.errors,
    );
  }
}

class FlightOptionElement {
  String? key;
  String? ticketingCarrier;
  String? apiType;
  String? flightName;
  String? flightimg;
  dynamic crsPnr;
  String? providerCode;
  int? availableSeat;
  FlightFare? selectedFare;
  List<FlightFare>? flightFares;
  List<FlightLeg>? flightLegs;
  List<FlightLeg>? returnLegs;
  List<FlightLeg>? onwardLegs;

  bool? seatEnabled;
  bool? reprice;
  bool? ffNoEnabled;

  FlightOptionElement({
    this.key,
    this.ticketingCarrier,
    this.apiType,
    this.flightName,
    this.flightimg,
    this.crsPnr,
    this.providerCode,
    this.availableSeat,
    this.selectedFare,
    this.flightFares,
    this.flightLegs,
    this.returnLegs,
    this.onwardLegs,

    this.seatEnabled,
    this.reprice,
    this.ffNoEnabled,
  });

  factory FlightOptionElement.fromJson(Map<String, dynamic> json) =>
      FlightOptionElement(
        key: json["Key"],
        ticketingCarrier: json["TicketingCarrier"],
        apiType: json["ApiType"],
        flightName: json["flightName"],
        flightimg: json["flightimg"],
        crsPnr: json["CrsPnr"],
        providerCode: json["ProviderCode"],
        availableSeat: json["AvailableSeat"],
        flightFares:
            json["FlightFares"] == null
                ? []
                : List<FlightFare>.from(
                  json["FlightFares"]!.map((x) => FlightFare.fromJson(x)),
                ),
        flightLegs:
            json["FlightLegs"] == null
                ? []
                : List<FlightLeg>.from(
                  json["FlightLegs"]!.map((x) => FlightLeg.fromJson(x)),
                ),
        seatEnabled: json["SeatEnabled"],
        reprice: json["Reprice"],
        ffNoEnabled: json["FFNoEnabled"],
      );

  Map<String, dynamic> toJson() => {
    "Key": key,
    "TicketingCarrier": ticketingCarrier,
    "ApiType": apiType,
    "flightName": flightName,
    "flightimg": flightimg,
    "CrsPnr": crsPnr,
    "ProviderCode": providerCode,
    "AvailableSeat": availableSeat,
    "FlightFares":
        flightFares == null
            ? []
            : List<dynamic>.from(flightFares!.map((x) => x.toJson())),
    "FlightLegs":
        flightLegs == null
            ? []
            : List<dynamic>.from(flightLegs!.map((x) => x.toJson())),
    "SeatEnabled": seatEnabled,
    "Reprice": reprice,
    "FFNoEnabled": ffNoEnabled,
  };

  FlightOptionElement copyWith({
    String? key,
    String? ticketingCarrier,
    String? apiType,
    String? flightName,
    String? flightimg,
    dynamic crsPnr,
    String? providerCode,
    int? availableSeat,
    FlightFare? selectedFare,

    List<FlightFare>? flightFares,
    List<FlightLeg>? flightLegs,
    List<FlightLeg>? returnLegs,
    List<FlightLeg>? onwardLegs,

    bool? seatEnabled,
    bool? reprice,
    bool? ffNoEnabled,
  }) {
    return FlightOptionElement(
      key: key ?? this.key,
      ticketingCarrier: ticketingCarrier ?? this.ticketingCarrier,
      apiType: apiType ?? this.apiType,
      flightName: flightName ?? this.flightName,
      flightimg: flightimg ?? this.flightimg,
      crsPnr: crsPnr ?? this.crsPnr,
      providerCode: providerCode ?? this.providerCode,
      availableSeat: availableSeat ?? this.availableSeat,
      selectedFare: selectedFare ?? this.selectedFare,
      flightFares: flightFares ?? this.flightFares,
      flightLegs: flightLegs ?? this.flightLegs,
      returnLegs: returnLegs ?? this.returnLegs,
      onwardLegs: onwardLegs ?? this.onwardLegs,

      seatEnabled: seatEnabled ?? this.seatEnabled,
      reprice: reprice ?? this.reprice,
      ffNoEnabled: ffNoEnabled ?? this.ffNoEnabled,
    );
  }
}

class FlightFare {
  List<Fare>? fares;
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

  FlightFare({
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

  factory FlightFare.fromJson(Map<String, dynamic> json) => FlightFare(
    fares:
        json["Fares"] == null
            ? []
            : List<Fare>.from(json["Fares"]!.map((x) => Fare.fromJson(x))),
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
    "Fares":
        fares == null ? [] : List<dynamic>.from(fares!.map((x) => x.toJson())),
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

  FlightFare copyWith({
    List<Fare>? fares,
    String? fid,
    dynamic refundableInfo,
    String? fareKey,
    double? aprxTotalBaseFare,
    double? aprxTotalTax,
    double? totalDiscount,
    dynamic extrafare,
    double? aprxTotalAmount,
    dynamic currency,
    dynamic fareType,
    dynamic fareName,
    double? totalAmount,
  }) {
    return FlightFare(
      fares: fares ?? this.fares,
      fid: fid ?? this.fid,
      refundableInfo: refundableInfo ?? this.refundableInfo,
      fareKey: fareKey ?? this.fareKey,
      aprxTotalBaseFare: aprxTotalBaseFare ?? this.aprxTotalBaseFare,
      aprxTotalTax: aprxTotalTax ?? this.aprxTotalTax,
      totalDiscount: totalDiscount ?? this.totalDiscount,
      extrafare: extrafare ?? this.extrafare,
      aprxTotalAmount: aprxTotalAmount ?? this.aprxTotalAmount,
      currency: currency ?? this.currency,
      fareType: fareType ?? this.fareType,
      fareName: fareName ?? this.fareName,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}

class Fare {
  String? ptc;
  double? baseFare;
  double? tax;
  double? discount;
  List<Splitup>? splitup;

  Fare({this.ptc, this.baseFare, this.tax, this.discount, this.splitup});

  factory Fare.fromJson(Map<String, dynamic> json) => Fare(
    ptc: json["PTC"],
    baseFare: json["BaseFare"]?.toDouble(),
    tax: json["Tax"]?.toDouble(),
    discount: json["Discount"]?.toDouble(),
    splitup:
        json["Splitup"] == null
            ? []
            : List<Splitup>.from(
              json["Splitup"]!.map((x) => Splitup.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "PTC": ptc,
    "BaseFare": baseFare,
    "Tax": tax,
    "Discount": discount,
    "Splitup":
        splitup == null
            ? []
            : List<dynamic>.from(splitup!.map((x) => x.toJson())),
  };

  Fare copyWith({
    String? ptc,
    double? baseFare,
    double? tax,
    double? discount,
    List<Splitup>? splitup,
  }) {
    return Fare(
      ptc: ptc ?? this.ptc,
      baseFare: baseFare ?? this.baseFare,
      tax: tax ?? this.tax,
      discount: discount ?? this.discount,
      splitup: splitup ?? this.splitup,
    );
  }
}

class Splitup {
  String? category;
  double? amount;

  Splitup({this.category, this.amount});

  factory Splitup.fromJson(Map<String, dynamic> json) =>
      Splitup(category: json["Category"], amount: json["Amount"]?.toDouble());

  Map<String, dynamic> toJson() => {"Category": category, "Amount": amount};

  Splitup copyWith({String? category, double? amount}) {
    return Splitup(
      category: category ?? this.category,
      amount: amount ?? this.amount,
    );
  }
}

class FlightLeg {
  String? type;
  dynamic airlinePnr;
  String? key;
  String? origin;
  String? destination;
  String? departureTime;
  String? destinationName;
  String? originName;
  String? arrivalTime;
  String? arrivalTerminal;
  String? departureTerminal;
  String? flightNo;
  String? airlineCode;
  String? flightName;
  String? flightimg;
  dynamic carrier;
  double? distance;
  dynamic optionalServiceIndicators;
  dynamic segmentRefKey;
  dynamic mealKey;
  dynamic baggageKey;
  List<FreeBaggage>? freeBaggages;
  String? codeShare;
  String? rbd;

  FlightLeg({
    this.type,
    this.airlinePnr,
    this.key,
    this.origin,
    this.destination,
    this.departureTime,
    this.destinationName,
    this.originName,
    this.arrivalTime,
    this.arrivalTerminal,
    this.departureTerminal,
    this.flightNo,
    this.airlineCode,
    this.flightName,
    this.flightimg,
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

  factory FlightLeg.fromJson(Map<String, dynamic> json) => FlightLeg(
    type: json["Type"],
    airlinePnr: json["AirlinePNR"],
    key: json["Key"],
    origin: json["Origin"],
    destination: json["Destination"],
    departureTime: json["DepartureTime"],
    destinationName: json["destinationName"],
    originName: json["originName"],
    arrivalTime: json["ArrivalTime"],
    arrivalTerminal: json["ArrivalTerminal"],
    departureTerminal: json["DepartureTerminal"],
    flightNo: json["FlightNo"],
    airlineCode: json["AirlineCode"],
    flightName: json["flightName"],
    flightimg: json["flightimg"],
    carrier: json["Carrier"],
    distance: json["Distance"]?.toDouble(),
    optionalServiceIndicators: json["OptionalServiceIndicators"],
    segmentRefKey: json["SegmentRefKey"],
    mealKey: json["MealKey"],
    baggageKey: json["BaggageKey"],
    freeBaggages:
        json["FreeBaggages"] == null
            ? []
            : List<FreeBaggage>.from(
              json["FreeBaggages"]!.map((x) => FreeBaggage.fromJson(x)),
            ),
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
    "destinationName": destinationName,
    "originName": originName,
    "ArrivalTime": arrivalTime,
    "ArrivalTerminal": arrivalTerminal,
    "DepartureTerminal": departureTerminal,
    "FlightNo": flightNo,
    "AirlineCode": airlineCode,
    "flightName": flightName,
    "flightimg": flightimg,
    "Carrier": carrier,
    "Distance": distance,
    "OptionalServiceIndicators": optionalServiceIndicators,
    "SegmentRefKey": segmentRefKey,
    "MealKey": mealKey,
    "BaggageKey": baggageKey,
    "FreeBaggages":
        freeBaggages == null
            ? []
            : List<dynamic>.from(freeBaggages!.map((x) => x.toJson())),
    "CodeShare": codeShare,
    "RBD": rbd,
  };

  FlightLeg copyWith({
    String? type,
    dynamic airlinePnr,
    String? key,
    String? origin,
    String? destination,
    String? departureTime,
    String? destinationName,
    String? originName,
    String? arrivalTime,
    String? arrivalTerminal,
    String? departureTerminal,
    String? flightNo,
    String? airlineCode,
    String? flightName,
    String? flightimg,
    dynamic carrier,
    double? distance,
    dynamic optionalServiceIndicators,
    dynamic segmentRefKey,
    dynamic mealKey,
    dynamic baggageKey,
    List<FreeBaggage>? freeBaggages,
    String? codeShare,
    String? rbd,
  }) {
    return FlightLeg(
      type: type ?? this.type,
      airlinePnr: airlinePnr ?? this.airlinePnr,
      key: key ?? this.key,
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      departureTime: departureTime ?? this.departureTime,
      destinationName: destinationName ?? this.destinationName,
      originName: originName ?? this.originName,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      arrivalTerminal: arrivalTerminal ?? this.arrivalTerminal,
      departureTerminal: departureTerminal ?? this.departureTerminal,
      flightNo: flightNo ?? this.flightNo,
      airlineCode: airlineCode ?? this.airlineCode,
      flightName: flightName ?? this.flightName,
      flightimg: flightimg ?? this.flightimg,
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
    );
  }
}

class FreeBaggage {
  String? fid;
  String? adtBaggage;
  String? chdBaggage;
  String? infBaggage;

  FreeBaggage({this.fid, this.adtBaggage, this.chdBaggage, this.infBaggage});

  factory FreeBaggage.fromJson(Map<String, dynamic> json) => FreeBaggage(
    fid: json["FID"],
    adtBaggage: json["Adt_Baggage"],
    chdBaggage: json["Chd_Baggage"],
    infBaggage: json["Inf_Baggage"],
  );

  Map<String, dynamic> toJson() => {
    "FID": fid,
    "Adt_Baggage": adtBaggage,
    "Chd_Baggage": chdBaggage,
    "Inf_Baggage": infBaggage,
  };

  FreeBaggage copyWith({
    String? fid,
    String? adtBaggage,
    String? chdBaggage,
    String? infBaggage,
  }) {
    return FreeBaggage(
      fid: fid ?? this.fid,
      adtBaggage: adtBaggage ?? this.adtBaggage,
      chdBaggage: chdBaggage ?? this.chdBaggage,
      infBaggage: infBaggage ?? this.infBaggage,
    );
  }
}
