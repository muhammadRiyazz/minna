// To parse required this JSON data, do
//
//     final modelBusDetails = modelBusDetailsFromJson(jsondynamic);

import 'dart:convert';

ModelBusDetails modelBusDetailsFromJson(dynamic str) =>
    ModelBusDetails.fromJson(json.decode(str));

dynamic modelBusDetailsToJson(ModelBusDetails data) =>
    json.encode(data.toJson());

class ModelBusDetails {
  ModelBusDetails({
    // required this.agentMappedToCp,
    // required this.agentMappedToEarning,
    required this.availableTrips,
  });

  dynamic agentMappedToCp;
  dynamic agentMappedToEarning;
  List<AvailableTrip> availableTrips;

  factory ModelBusDetails.fromJson(Map<dynamic, dynamic> json) =>
      ModelBusDetails(
        // agentMappedToCp: json["agentMappedToCp"],
        // agentMappedToEarning: json["agentMappedToEarning"],
        availableTrips: List<AvailableTrip>.from(
            json["availableTrips"].map((x) => AvailableTrip.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        // "agentMappedToCp": agentMappedToCp,
        // "agentMappedToEarning": agentMappedToEarning,
        "availableTrips":
            List<dynamic>.from(availableTrips.map((x) => x.toJson())),
      };
}

class AvailableTrip {
  AvailableTrip({
    required this.ac,
    // required this.additionalCommission,
    // required this.agentServiceCharge,
    // required this.agentServiceChargeAllowed,
    // required this.allowLadiesToBookDoubleSeats,
    // required this.allowLadyNextToMale,
    required this.arrivalTime,
    // required this.availCatCard,
    required this.availSrCitizen,
    required this.availableSeats,
    required this.availableSingleSeat,
    required this.avlWindowSeats,
    // required this.boCommission,
    // required this.boPriorityOperator,
    required this.boardingTimes,
    // required this.bookable,
    // required this.bpDpSeatLayout,
    required this.busCancelled,
    // required this.busImageCount,
    // required this.busRoutes,
    // required this.busServiceId,
    required this.busType,
    required this.busTypeId,
    // required this.businfo,
    // required this.callFareBreakUpApi,
    // required this.cancellationCalculationTimestamp,
    // required this.cancellationPolicy,
    required this.departureTime,
    required this.destination,
    required this.doj,
    // required this.dropPointMandatory,
    // required this.droppingTimes,
    required this.duration,
    // required this.exactSearch,
    required this.fareDetails,
    required this.fares, ////////////////////
    // required this.flatComApplicable,
    // required this.flatSsComApplicable,
    // required this.gdsCommission,
    // required this.groupOfferPriceEnabled,
    // required this.happyHours,
    required this.id,
    // required this.idProofRequired,
    // required this.imagesMetadataUrl,
    // required this.isLmbAllowed,
    // required this.liveTrackingAvailable,
    // required this.maxSeatsPerTicket,
    // required this.nextDay,
    required this.noSeatLayoutAvailableSeats,
    // required this.noSeatLayoutEnabled,
    // required this.nonAc,
    // required this.offerPriceEnabled,
    // required this.availableTripOperator,
    // required this.otgEnabled,
    // required this.partialCancellationAllowed,
    // required this.partnerBaseCommission,
    // required this.primaryPaxCancellable,
    // required this.primo,
    // required this.routeId,
    // required this.rtc,
    // required this.ssAgentAccount,
    // required this.seater,
    // required this.selfInventory,
    // required this.serviceStartTime,
    // required this.singleLadies,
    required this.sleeper,
    // required this.socialDistancing,
    // required this.source,
    // required this.tatkalTime,
    required this.travels,
    // required this.unAvailable,
    // required this.vaccinatedBus,
    // required this.vaccinatedStaff,
    // required this.vehicleType,
    // required this.viaRoutes,
    // required this.zeroCancellationTime,
    // required this.mTicketEnabled,
    // required this.forcedSeats,
  });

  dynamic ac; //
  // dynamic additionalCommission;
  // dynamic agentServiceCharge;
  // dynamic agentServiceChargeAllowed;
  // dynamic allowLadiesToBookDoubleSeats;
  // dynamic allowLadyNextToMale;
  dynamic arrivalTime; //
  // dynamic availCatCard;
  dynamic availSrCitizen; //
  dynamic availableSeats; //
  dynamic availableSingleSeat; //
  dynamic avlWindowSeats; //
  // dynamic boCommission;
  // dynamic boPriorityOperator;
  List<BoardingTime> boardingTimes;
  // dynamic bookable;
  // dynamic bpDpSeatLayout;
  dynamic busCancelled; //
  // dynamic busImageCount;
  // dynamic busRoutes;
  // dynamic busServiceId;
  dynamic busType; //
  dynamic busTypeId; //
  // Businfo businfo;
  // dynamic callFareBreakUpApi;
  // dynamic cancellationCalculationTimestamp;
  // dynamic cancellationPolicy;
  dynamic departureTime; //
  dynamic destination; //
  DateTime doj; //
  // dynamic dropPointMandatory;
  // dynamic droppingTimes;
  dynamic duration; //
  // dynamic exactSearch;
  dynamic fareDetails;
  dynamic fares; //
  // dynamic flatComApplicable;
  // dynamic flatSsComApplicable;
  // dynamic gdsCommission;
  // dynamic groupOfferPriceEnabled;
  // dynamic happyHours;
  dynamic id; //
  // dynamic idProofRequired;
  // dynamic imagesMetadataUrl;
  // dynamic isLmbAllowed;
  // dynamic liveTrackingAvailable;
  // dynamic maxSeatsPerTicket;
  // dynamic nextDay;
  dynamic noSeatLayoutAvailableSeats; //
  // dynamic noSeatLayoutEnabled;
  // dynamic nonAc;
  // dynamic offerPriceEnabled;
  // dynamic availableTripOperator;
  // dynamic otgEnabled;
  // dynamic partialCancellationAllowed;
  // dynamic partnerBaseCommission;
  // dynamic primaryPaxCancellable;
  // dynamic primo;
  // dynamic routeId;
  // dynamic rtc;
  // dynamic ssAgentAccount;
  // dynamic seater;
  // dynamic selfInventory;
  // dynamic serviceStartTime;
  // dynamic singleLadies;
  dynamic sleeper; //
  // dynamic socialDistancing;
  // dynamic source;
  // dynamic tatkalTime;
  dynamic travels;
  // dynamic unAvailable;
  // dynamic vaccinatedBus;
  // dynamic vaccinatedStaff;
  //  VehicleType vehicleType;
  // dynamic viaRoutes;
  // dynamic zeroCancellationTime;
  // dynamic mTicketEnabled;
  // dynamic forcedSeats;

  factory AvailableTrip.fromJson(Map<dynamic, dynamic> json) => AvailableTrip(
        ac: json["AC"],
        // additionalCommission: json["additionalCommission"],
        // agentServiceCharge: json["agentServiceCharge"],
        // agentServiceChargeAllowed: json["agentServiceChargeAllowed"],
        // allowLadiesToBookDoubleSeats: json["allowLadiesToBookDoubleSeats"] == null ? null : json["allowLadiesToBookDoubleSeats"],
        // allowLadyNextToMale: json["allowLadyNextToMale"] == null ? null : json["allowLadyNextToMale"],
        arrivalTime: json["arrivalTime"],
        // availCatCard: json["availCatCard"],
        availSrCitizen: json["availSrCitizen"],
        availableSeats: json["availableSeats"],
        availableSingleSeat: json["availableSingleSeat"],
        avlWindowSeats: json["avlWindowSeats"],
        // boCommission: json["boCommission"],
        // boPriorityOperator: json["boPriorityOperator"],
        boardingTimes: List<BoardingTime>.from(
            json["boardingTimes"].map((x) => BoardingTime.fromJson(x))),
        // bookable: json["bookable"],
        // bpDpSeatLayout: json["bpDpSeatLayout"],
        busCancelled: json["busCancelled"],
        // busImageCount: json["busImageCount"],
        // busRoutes: json["busRoutes"],
        // busServiceId: json["busServiceId"],
        busType: json["busType"],
        busTypeId: json["busTypeId"],
        // businfo: Businfo.fromJson(json["businfo"]),
        // callFareBreakUpApi: json["callFareBreakUpAPI"],
        // cancellationCalculationTimestamp: json["cancellationCalculationTimestamp"],
        // cancellationPolicy: json["cancellationPolicy"],
        departureTime: json["departureTime"],
        destination: json["destination"],
        doj: DateTime.parse(json["doj"]),
        // dropPointMandatory: json["dropPointMandatory"],
        // droppingTimes: json["droppingTimes"],
        duration: json["duration"],
        // exactSearch: json["exactSearch"],
        fareDetails: json["fareDetails"],
        fares: json["fares"], ////////////////////
        // flatComApplicable: json["flatComApplicable"],
        // flatSsComApplicable: json["flatSSComApplicable"],
        // gdsCommission: json["gdsCommission"],
        // groupOfferPriceEnabled: json["groupOfferPriceEnabled"],
        // happyHours: json["happyHours"],
        id: json["id"],
        // idProofRequired: json["idProofRequired"],
        // imagesMetadataUrl: json["imagesMetadataUrl"],
        // isLmbAllowed: json["isLMBAllowed"],
        // liveTrackingAvailable: json["liveTrackingAvailable"],
        // maxSeatsPerTicket: json["maxSeatsPerTicket"],
        // nextDay: json["nextDay"],
        noSeatLayoutAvailableSeats: json["noSeatLayoutAvailableSeats"],
        // noSeatLayoutEnabled: json["noSeatLayoutEnabled"],
        // nonAc: json["nonAC"],
        // offerPriceEnabled: json["offerPriceEnabled"],
        // availableTripOperator: json["operator"],
        // otgEnabled: json["otgEnabled"],
        // partialCancellationAllowed: json["partialCancellationAllowed"],
        // partnerBaseCommission: json["partnerBaseCommission"],
        // primaryPaxCancellable: json["primaryPaxCancellable"],
        // primo: json["primo"],
        // routeId: json["routeId"],
        // rtc: json["rtc"],
        // ssAgentAccount: json["SSAgentAccount"],
        // seater: json["seater"],
        // selfInventory: json["selfInventory"],
        // serviceStartTime: json["serviceStartTime"],
        // singleLadies: json["singleLadies"],
        sleeper: json["sleeper"],
        // socialDistancing: json["socialDistancing"],
        // source: json["source"],
        // tatkalTime: json["tatkalTime"],
        travels: json["travels"],
        // unAvailable: json["unAvailable"],
        // vaccinatedBus: json["vaccinatedBus"],
        // vaccinatedStaff: json["vaccinatedStaff"],
        // vehicleType: vehicleTypeValues.map[json["vehicleType"]],
        // viaRoutes: json["viaRoutes"],
        // zeroCancellationTime: json["zeroCancellationTime"],
        // mTicketEnabled: json["mTicketEnabled"],
        // forcedSeats: json["forcedSeats"] == null ? null : json["forcedSeats"],
      );

  Map<dynamic, dynamic> toJson() => {
        "AC": ac,
        // "additionalCommission": additionalCommission,
        // "agentServiceCharge": agentServiceCharge,
        // "agentServiceChargeAllowed": agentServiceChargeAllowed,
        // "allowLadiesToBookDoubleSeats": allowLadiesToBookDoubleSeats == null ? null : allowLadiesToBookDoubleSeats,
        // "allowLadyNextToMale": allowLadyNextToMale == null ? null : allowLadyNextToMale,
        "arrivalTime": arrivalTime,
        // "availCatCard": availCatCard,
        "availSrCitizen": availSrCitizen,
        "availableSeats": availableSeats,
        "availableSingleSeat": availableSingleSeat,
        "avlWindowSeats": avlWindowSeats,
        // "boCommission": boCommission,
        // "boPriorityOperator": boPriorityOperator,
        // "boardingTimes": List<dynamic>.from(boardingTimes.map((x) => x.toJson())),
        // "bookable": bookable,
        // "bpDpSeatLayout": bpDpSeatLayout,
        "busCancelled": busCancelled,
        // "busImageCount": busImageCount,
        // "busRoutes": busRoutes,
        // "busServiceId": busServiceId,
        "busType": busType,
        "busTypeId": busTypeId,
        // "businfo": businfo.toJson(),
        // "callFareBreakUpAPI": callFareBreakUpApi,
        // "cancellationCalculationTimestamp": cancellationCalculationTimestamp,
        // "cancellationPolicy": cancellationPolicy,
        "departureTime": departureTime,
        "destination": destination,
        "doj": doj.toIso8601String(),
        // "dropPointMandatory": dropPointMandatory,
        // "droppingTimes": droppingTimes,
        "duration": duration,
        // "exactSearch": exactSearch,
        "fareDetails": fareDetails,
        "fares": fares,
        // "flatComApplicable": flatComApplicable,
        // "flatSSComApplicable": flatSsComApplicable,
        // "gdsCommission": gdsCommission,
        // "groupOfferPriceEnabled": groupOfferPriceEnabled,
        // "happyHours": happyHours,
        "id": id,
        // "idProofRequired": idProofRequired,
        // "imagesMetadataUrl": imagesMetadataUrl,
        // "isLMBAllowed": isLmbAllowed,
        // "liveTrackingAvailable": liveTrackingAvailable,
        // "maxSeatsPerTicket": maxSeatsPerTicket,
        // "nextDay": nextDay,
        "noSeatLayoutAvailableSeats": noSeatLayoutAvailableSeats,
        // "noSeatLayoutEnabled": noSeatLayoutEnabled,
        // "nonAC": nonAc,
        // "offerPriceEnabled": offerPriceEnabled,
        // "operator": availableTripOperator,
        // "otgEnabled": otgEnabled,
        // "partialCancellationAllowed": partialCancellationAllowed,
        // "partnerBaseCommission": partnerBaseCommission,
        // "primaryPaxCancellable": primaryPaxCancellable,
        // "primo": primo,
        // "routeId": routeId,
        // "rtc": rtc,
        // "SSAgentAccount": ssAgentAccount,
        // "seater": seater,
        // "selfInventory": selfInventory,
        // "serviceStartTime": serviceStartTime,
        // "singleLadies": singleLadies,
        "sleeper": sleeper,
        // "socialDistancing": socialDistancing,
        // "source": source,
        // "tatkalTime": tatkalTime,
        "travels": travels,
        // "unAvailable": unAvailable,
        // "vaccinatedBus": vaccinatedBus,
        // "vaccinatedStaff": vaccinatedStaff,
        // "vehicleType": vehicleTypeValues.reverse[vehicleType],
        // "viaRoutes": viaRoutes,
        // "zeroCancellationTime": zeroCancellationTime,
        // "mTicketEnabled": mTicketEnabled,
        // "forcedSeats": forcedSeats == null ? null : forcedSeats,
      };
}

class BoardingTime {
  BoardingTime({
    required this.address,
    required this.bpId,
    required this.bpIdentifier,
    required this.bpName,
    required this.contactNumber,
    required this.landmark,
    required this.location,
    required this.prime,
    required this.time,
  });

  dynamic address;
  dynamic bpId;
  dynamic bpIdentifier;
  dynamic bpName;
  dynamic contactNumber;
  dynamic landmark;
  dynamic location;
  dynamic prime;
  dynamic time;

  factory BoardingTime.fromJson(Map<dynamic, dynamic> json) => BoardingTime(
        address: json["address"],
        bpId: json["bpId"],
        bpIdentifier: json["bpIdentifier"],
        bpName: json["bpName"],
        contactNumber: json["contactNumber"],
        landmark: json["landmark"],
        location: json["location"],
        prime: json["prime"],
        time: json["time"],
      );

  Map<dynamic, dynamic> toJson() => {
        "address": address,
        "bpId": bpId,
        "bpIdentifier": bpIdentifier,
        "bpName": bpName,
        "contactNumber": contactNumber,
        "landmark": landmark,
        "location": location,
        "prime": prime,
        "time": time,
      };
}

// class Businfo {
//     Businfo({
//         required this.busNumber,
//         required this.driverMobile,
//         required this.driverName,
//     });

//     dynamic busNumber;
//     dynamic driverMobile;
//     dynamic driverName;

//     factory Businfo.fromJson(Map<dynamic, dynamic> json) => Businfo(
//         busNumber: busNumberValues.map[json["busNumber"]],
//         driverMobile: busNumberValues.map[json["driverMobile"]],
//         driverName: busNumberValues.map[json["driverName"]],
//     );

//     Map<dynamic, dynamic> toJson() => {
//         "busNumber": busNumberValues.reverse[busNumber],
//         "driverMobile": busNumberValues.reverse[driverMobile],
//         "driverName": busNumberValues.reverse[driverName],
//     };
// }

class FareDetail {
  FareDetail({
    // required this.bankTrexAmt,
    required this.baseFare,
    // required this.bookingFee,
    // required this.childFare,
    // required this.gst,
    // required this.levyFare,
    // required this.markupFareAbsolute,
    // required this.markupFarePercentage,
    // required this.opFare,
    // required this.opGroupFare,
    // required this.operatorServiceChargeAbsolute,
    // required this.operatorServiceChargePercentage,
    // required this.serviceCharge,
    // required this.serviceTaxAbsolute,
    // required this.serviceTaxPercentage,
    // required this.srtFee,
    // required this.tollFee,
    // required this.totalFare,
  });

  // dynamic bankTrexAmt;
  dynamic baseFare;
  // dynamic bookingFee;
  // dynamic childFare;
  // dynamic gst;
  // dynamic levyFare;
  // dynamic markupFareAbsolute;
  // dynamic markupFarePercentage;
  // dynamic opFare;
  // dynamic opGroupFare;
  // dynamic operatorServiceChargeAbsolute;
  // dynamic operatorServiceChargePercentage;
  // dynamic serviceCharge;
  // dynamic serviceTaxAbsolute;
  // dynamic serviceTaxPercentage;
  // dynamic srtFee;
  // dynamic tollFee;
  // dynamic totalFare;

  factory FareDetail.fromJson(Map<dynamic, dynamic> json) => FareDetail(
        // bankTrexAmt: json["bankTrexAmt"],
        baseFare: json["baseFare"],
        // bookingFee: json["bookingFee"],
        // childFare: json["childFare"],
        // gst: json["gst"],
        // levyFare: json["levyFare"],
        // markupFareAbsolute: json["markupFareAbsolute"],
        // markupFarePercentage: json["markupFarePercentage"],
        // opFare: json["opFare"],
        // opGroupFare: json["opGroupFare"],
        // operatorServiceChargeAbsolute: json["operatorServiceChargeAbsolute"],
        // operatorServiceChargePercentage:
        //     json["operatorServiceChargePercentage"],
        // serviceCharge: json["serviceCharge"],
        // serviceTaxAbsolute: json["serviceTaxAbsolute"],
        // serviceTaxPercentage: json["serviceTaxPercentage"],
        // srtFee: json["srtFee"],
        // tollFee: json["tollFee"],
        // totalFare: json["totalFare"],
      );

  Map<dynamic, dynamic> toJson() => {
        // "bankTrexAmt": bankTrexAmt,
        "baseFare": baseFare,
        // "bookingFee": bookingFee,
        // "childFare": childFare,
        // "gst": gst,
        // "levyFare": levyFare,
        // "markupFareAbsolute": markupFareAbsolute,
        // "markupFarePercentage": markupFarePercentage,
        // "opFare": opFare,
        // "opGroupFare": opGroupFare,
        // "operatorServiceChargeAbsolute": operatorServiceChargeAbsolute,
        // "operatorServiceChargePercentage": operatorServiceChargePercentage,
        // "serviceCharge": serviceCharge,
        // "serviceTaxAbsolute": serviceTaxAbsolute,
        // "serviceTaxPercentage": serviceTaxPercentage,
        // "srtFee": srtFee,
        // "tollFee": tollFee,
        // "totalFare": totalFare,
      };
}

// enum VehicleType { BUS }

// final vehicleTypeValues = EnumValues({
//     "BUS": VehicleType.BUS
// });

// class EnumValues<T> {
//     Map<dynamic, T> map;
//     Map<T, dynamic> reverseMap;

//     EnumValues(required this.map);

//     Map<T, dynamic> get reverse {
//         if (reverseMap == null) {
//             reverseMap = map.map((k, v) => new MapEntry(v, k));
//         }
//         return reverseMap;
//     }
// }
