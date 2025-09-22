// To parse this JSON data, do
//
//     final boarding = boardingFromMap(jsonString);

import 'dart:convert';

BusAvaDet boardingFromMap(String str) => BusAvaDet.fromMap(json.decode(str));

String boardingToMap(BusAvaDet? data) => json.encode(data!.toMap());

class BusAvaDet {
    BusAvaDet({
        required this.agentMappedToCp,
        required this.agentMappedToEarning,
        required this.availableTrips,
    });

    String? agentMappedToCp;
    String? agentMappedToEarning;
    List<AvailableTrip?> availableTrips;

    factory BusAvaDet.fromMap(Map<String, dynamic> json) => BusAvaDet(
        agentMappedToCp: json["agentMappedToCp"],
        agentMappedToEarning: json["agentMappedToEarning"],
        availableTrips: json["availableTrips"] == null ? [] : List<AvailableTrip?>.from(json["availableTrips"]!.map((x) => AvailableTrip.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "agentMappedToCp": agentMappedToCp,
        "agentMappedToEarning": agentMappedToEarning,
        "availableTrips": List<dynamic>.from(availableTrips.map((x) => x!.toMap())),
    };
}

class AvailableTrip {
    AvailableTrip({
        required this.ac,
        required this.additionalCommission,
        required this.agentServiceCharge,
        required this.agentServiceChargeAllowed,
        required this.allowLadiesToBookDoubleSeats,
        required this.allowLadyNextToMale,
        required this.arrivalTime,
        required this.availCatCard,
        required this.availSrCitizen,
        required this.availableSeats,
        required this.availableSingleSeat,
        required this.avlWindowSeats,
        required this.boCommission,
        required this.boPriorityOperator,
        required this.boardingTimes,
        required this.bookable,
        required this.bpDpSeatLayout,
        required this.busCancelled,
        required this.busImageCount,
        required this.busRoutes,
        required this.busServiceId,
        required this.busType,
        required this.busTypeId,
        required this.businfo,
        required this.callFareBreakUpApi,
        required this.cancellationCalculationTimestamp,
        required this.cancellationPolicy,
        required this.departureTime,
        required this.destination,
        required this.doj,
        required this.dropPointMandatory,
        required this.droppingTimes,
        required this.duration,
        required this.exactSearch,
        required this.fareDetails,
        required this.fares,
        required this.flatComApplicable,
        required this.flatSsComApplicable,
        required this.gdsCommission,
        required this.groupOfferPriceEnabled,
        required this.happyHours,
        required this.id,
        required this.idProofRequired,
        required this.imagesMetadataUrl,
        required this.isLmbAllowed,
        required this.liveTrackingAvailable,
        required this.maxSeatsPerTicket,
        required this.nextDay,
        required this.noSeatLayoutAvailableSeats,
        required this.noSeatLayoutEnabled,
        required this.nonAc,
        required this.offerPriceEnabled,
        required this.availableTripOperator,
        required this.otgEnabled,
        required this.partialCancellationAllowed,
        required this.partnerBaseCommission,
        required this.primaryPaxCancellable,
        required this.primo,
        required this.routeId,
        required this.rtc,
        required this.ssAgentAccount,
        required this.seater,
        required this.selfInventory,
        required this.serviceStartTime,
        required this.singleLadies,
        required this.sleeper,
        required this.socialDistancing,
        required this.source,
        required this.tatkalTime,
        required this.travels,
        required this.unAvailable,
        required this.vaccinatedBus,
        required this.vaccinatedStaff,
        required this.vehicleType,
        required this.viaRoutes,
        required this.zeroCancellationTime,
        required this.mTicketEnabled,
        required this.forcedSeats,
    });

    String ac;
    String additionalCommission;
    String agentServiceCharge;
    String agentServiceChargeAllowed;
    String allowLadiesToBookDoubleSeats;
    String allowLadyNextToMale;
    String arrivalTime;
    String availCatCard;
    String availSrCitizen;
    String availableSeats;
    String availableSingleSeat;
    String avlWindowSeats;
    String boCommission;
    String boPriorityOperator;
    List<BoardingTime?>? boardingTimes;
    String? bookable;
    String? bpDpSeatLayout;
    String? busCancelled;
    String? busImageCount;
    String? busRoutes;
    String? busServiceId;
    String? busType;
    String? busTypeId;
    Businfo? businfo;
    String? callFareBreakUpApi;
    String? cancellationCalculationTimestamp;
    String? cancellationPolicy;
    String? departureTime;
    String? destination;
    DateTime? doj;
    String? dropPointMandatory;
    dynamic droppingTimes;
    String? duration;
    String? exactSearch;
    dynamic fareDetails;
    dynamic fares;
    String? flatComApplicable;
    String? flatSsComApplicable;
    String? gdsCommission;
    String? groupOfferPriceEnabled;
    String? happyHours;
    String? id;
    String? idProofRequired;
    String? imagesMetadataUrl;
    String? isLmbAllowed;
    String? liveTrackingAvailable;
    String? maxSeatsPerTicket;
    String? nextDay;
    String? noSeatLayoutAvailableSeats;
    String? noSeatLayoutEnabled;
    String? nonAc;
    String? offerPriceEnabled;
    String? availableTripOperator;
    String? otgEnabled;
    String? partialCancellationAllowed;
    String? partnerBaseCommission;
    String? primaryPaxCancellable;
    String? primo;
    String? routeId;
    String? rtc;
    String? ssAgentAccount;
    String? seater;
    String? selfInventory;
    String? serviceStartTime;
    String? singleLadies;
    String? sleeper;
    String? socialDistancing;
    String? source;
    String? tatkalTime;
    String? travels;
    String? unAvailable;
    String? vaccinatedBus;
    String? vaccinatedStaff;
    VehicleType? vehicleType;
    String? viaRoutes;
    String? zeroCancellationTime;
    String? mTicketEnabled;
    String? forcedSeats;

    factory AvailableTrip.fromMap(Map<String, dynamic> json) => AvailableTrip(
        ac: json["AC"],
        additionalCommission: json["additionalCommission"],
        agentServiceCharge: json["agentServiceCharge"],
        agentServiceChargeAllowed: json["agentServiceChargeAllowed"],
        allowLadiesToBookDoubleSeats: json["allowLadiesToBookDoubleSeats"],
        allowLadyNextToMale: json["allowLadyNextToMale"],
        arrivalTime: json["arrivalTime"],
        availCatCard: json["availCatCard"],
        availSrCitizen: json["availSrCitizen"],
        availableSeats: json["availableSeats"],
        availableSingleSeat: json["availableSingleSeat"],
        avlWindowSeats: json["avlWindowSeats"],
        boCommission: json["boCommission"],
        boPriorityOperator: json["boPriorityOperator"],
        boardingTimes: json["boardingTimes"] == null ? [] : List<BoardingTime?>.from(json["boardingTimes"]!.map((x) => BoardingTime.fromMap(x))),
        bookable: json["bookable"],
        bpDpSeatLayout: json["bpDpSeatLayout"],
        busCancelled: json["busCancelled"],
        busImageCount: json["busImageCount"],
        busRoutes: json["busRoutes"],
        busServiceId: json["busServiceId"],
        busType: json["busType"],
        busTypeId: json["busTypeId"],
        businfo: Businfo.fromMap(json["businfo"]),
        callFareBreakUpApi: json["callFareBreakUpAPI"],
        cancellationCalculationTimestamp: json["cancellationCalculationTimestamp"],
        cancellationPolicy: json["cancellationPolicy"],
        departureTime: json["departureTime"],
        destination: json["destination"],
        doj: DateTime.parse(json["doj"]),
        dropPointMandatory: json["dropPointMandatory"],
        droppingTimes: json["droppingTimes"],
        duration: json["duration"],
        exactSearch: json["exactSearch"],
        fareDetails: json["fareDetails"],
        fares: json["fares"],
        flatComApplicable: json["flatComApplicable"],
        flatSsComApplicable: json["flatSSComApplicable"],
        gdsCommission: json["gdsCommission"],
        groupOfferPriceEnabled: json["groupOfferPriceEnabled"],
        happyHours: json["happyHours"],
        id: json["id"],
        idProofRequired: json["idProofRequired"],
        imagesMetadataUrl: json["imagesMetadataUrl"],
        isLmbAllowed: json["isLMBAllowed"],
        liveTrackingAvailable: json["liveTrackingAvailable"],
        maxSeatsPerTicket: json["maxSeatsPerTicket"],
        nextDay: json["nextDay"],
        noSeatLayoutAvailableSeats: json["noSeatLayoutAvailableSeats"],
        noSeatLayoutEnabled: json["noSeatLayoutEnabled"],
        nonAc: json["nonAC"],
        offerPriceEnabled: json["offerPriceEnabled"],
        availableTripOperator: json["operator"],
        otgEnabled: json["otgEnabled"],
        partialCancellationAllowed: json["partialCancellationAllowed"],
        partnerBaseCommission: json["partnerBaseCommission"],
        primaryPaxCancellable: json["primaryPaxCancellable"],
        primo: json["primo"],
        routeId: json["routeId"],
        rtc: json["rtc"],
        ssAgentAccount: json["SSAgentAccount"],
        seater: json["seater"],
        selfInventory: json["selfInventory"],
        serviceStartTime: json["serviceStartTime"],
        singleLadies: json["singleLadies"],
        sleeper: json["sleeper"],
        socialDistancing: json["socialDistancing"],
        source: json["source"],
        tatkalTime: json["tatkalTime"],
        travels: json["travels"],
        unAvailable: json["unAvailable"],
        vaccinatedBus: json["vaccinatedBus"],
        vaccinatedStaff: json["vaccinatedStaff"],
        vehicleType: vehicleTypeValues.map[json["vehicleType"]],
        viaRoutes: json["viaRoutes"],
        zeroCancellationTime: json["zeroCancellationTime"],
        mTicketEnabled: json["mTicketEnabled"],
        forcedSeats: json["forcedSeats"],
    );

    Map<String, dynamic> toMap() => {
        "AC": ac,
        "additionalCommission": additionalCommission,
        "agentServiceCharge": agentServiceCharge,
        "agentServiceChargeAllowed": agentServiceChargeAllowed,
        "allowLadiesToBookDoubleSeats": allowLadiesToBookDoubleSeats,
        "allowLadyNextToMale": allowLadyNextToMale,
        "arrivalTime": arrivalTime,
        "availCatCard": availCatCard,
        "availSrCitizen": availSrCitizen,
        "availableSeats": availableSeats,
        "availableSingleSeat": availableSingleSeat,
        "avlWindowSeats": avlWindowSeats,
        "boCommission": boCommission,
        "boPriorityOperator": boPriorityOperator,
        "boardingTimes": boardingTimes == null ? [] : List<dynamic>.from(boardingTimes!.map((x) => x!.toMap())),
        "bookable": bookable,
        "bpDpSeatLayout": bpDpSeatLayout,
        "busCancelled": busCancelled,
        "busImageCount": busImageCount,
        "busRoutes": busRoutes,
        "busServiceId": busServiceId,
        "busType": busType,
        "busTypeId": busTypeId,
        "businfo": businfo!.toMap(),
        "callFareBreakUpAPI": callFareBreakUpApi,
        "cancellationCalculationTimestamp": cancellationCalculationTimestamp,
        "cancellationPolicy": cancellationPolicy,
        "departureTime": departureTime,
        "destination": destination,
        "doj": doj?.toIso8601String(),
        "dropPointMandatory": dropPointMandatory,
        "droppingTimes": droppingTimes,
        "duration": duration,
        "exactSearch": exactSearch,
        "fareDetails": fareDetails,
        "fares": fares,
        "flatComApplicable": flatComApplicable,
        "flatSSComApplicable": flatSsComApplicable,
        "gdsCommission": gdsCommission,
        "groupOfferPriceEnabled": groupOfferPriceEnabled,
        "happyHours": happyHours,
        "id": id,
        "idProofRequired": idProofRequired,
        "imagesMetadataUrl": imagesMetadataUrl,
        "isLMBAllowed": isLmbAllowed,
        "liveTrackingAvailable": liveTrackingAvailable,
        "maxSeatsPerTicket": maxSeatsPerTicket,
        "nextDay": nextDay,
        "noSeatLayoutAvailableSeats": noSeatLayoutAvailableSeats,
        "noSeatLayoutEnabled": noSeatLayoutEnabled,
        "nonAC": nonAc,
        "offerPriceEnabled": offerPriceEnabled,
        "operator": availableTripOperator,
        "otgEnabled": otgEnabled,
        "partialCancellationAllowed": partialCancellationAllowed,
        "partnerBaseCommission": partnerBaseCommission,
        "primaryPaxCancellable": primaryPaxCancellable,
        "primo": primo,
        "routeId": routeId,
        "rtc": rtc,
        "SSAgentAccount": ssAgentAccount,
        "seater": seater,
        "selfInventory": selfInventory,
        "serviceStartTime": serviceStartTime,
        "singleLadies": singleLadies,
        "sleeper": sleeper,
        "socialDistancing": socialDistancing,
        "source": source,
        "tatkalTime": tatkalTime,
        "travels": travels,
        "unAvailable": unAvailable,
        "vaccinatedBus": vaccinatedBus,
        "vaccinatedStaff": vaccinatedStaff,
        "vehicleType": vehicleTypeValues.reverse![vehicleType],
        "viaRoutes": viaRoutes,
        "zeroCancellationTime": zeroCancellationTime,
        "mTicketEnabled": mTicketEnabled,
        "forcedSeats": forcedSeats,
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

    String? address;
    String? bpId;
    String? bpIdentifier;
    String? bpName;
    String? contactNumber;
    String? landmark;
    String? location;
    String? prime;
    String? time;

    factory BoardingTime.fromMap(Map<String, dynamic> json) => BoardingTime(
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

    Map<String, dynamic> toMap() => {
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

class Businfo {
    Businfo({
        required this.busNumber,
        required this.driverMobile,
        required this.driverName,
    });

    BusNumber? busNumber;
    BusNumber? driverMobile;
    BusNumber? driverName;

    factory Businfo.fromMap(Map<String, dynamic> json) => Businfo(
        busNumber: busNumberValues.map[json["busNumber"]],
        driverMobile: busNumberValues.map[json["driverMobile"]],
        driverName: busNumberValues.map[json["driverName"]],
    );

    Map<String, dynamic> toMap() => {
        "busNumber": busNumberValues.reverse![busNumber],
        "driverMobile": busNumberValues.reverse![driverMobile],
        "driverName": busNumberValues.reverse![driverName],
    };
}

enum BusNumber { N_A }

final busNumberValues = EnumValues({
    "N/A": BusNumber.N_A
});

class FareDetail {
    FareDetail({
        required this.bankTrexAmt,
        required this.baseFare,
        required this.bookingFee,
        required this.childFare,
        required this.gst,
        required this.levyFare,
        required this.markupFareAbsolute,
        required this.markupFarePercentage,
        required this.opFare,
        required this.opGroupFare,
        required this.operatorServiceChargeAbsolute,
        required this.operatorServiceChargePercentage,
        required this.serviceCharge,
        required this.serviceTaxAbsolute,
        required this.serviceTaxPercentage,
        required this.srtFee,
        required this.tollFee,
        required this.totalFare,
    });

    String? bankTrexAmt;
    String? baseFare;
    String? bookingFee;
    String? childFare;
    String? gst;
    String? levyFare;
    String? markupFareAbsolute;
    String? markupFarePercentage;
    String? opFare;
    String? opGroupFare;
    String? operatorServiceChargeAbsolute;
    String? operatorServiceChargePercentage;
    String? serviceCharge;
    String? serviceTaxAbsolute;
    String? serviceTaxPercentage;
    String? srtFee;
    String? tollFee;
    String? totalFare;

    factory FareDetail.fromMap(Map<String, dynamic> json) => FareDetail(
        bankTrexAmt: json["bankTrexAmt"],
        baseFare: json["baseFare"],
        bookingFee: json["bookingFee"],
        childFare: json["childFare"],
        gst: json["gst"],
        levyFare: json["levyFare"],
        markupFareAbsolute: json["markupFareAbsolute"],
        markupFarePercentage: json["markupFarePercentage"],
        opFare: json["opFare"],
        opGroupFare: json["opGroupFare"],
        operatorServiceChargeAbsolute: json["operatorServiceChargeAbsolute"],
        operatorServiceChargePercentage: json["operatorServiceChargePercentage"],
        serviceCharge: json["serviceCharge"],
        serviceTaxAbsolute: json["serviceTaxAbsolute"],
        serviceTaxPercentage: json["serviceTaxPercentage"],
        srtFee: json["srtFee"],
        tollFee: json["tollFee"],
        totalFare: json["totalFare"],
    );

    Map<String, dynamic> toMap() => {
        "bankTrexAmt": bankTrexAmt,
        "baseFare": baseFare,
        "bookingFee": bookingFee,
        "childFare": childFare,
        "gst": gst,
        "levyFare": levyFare,
        "markupFareAbsolute": markupFareAbsolute,
        "markupFarePercentage": markupFarePercentage,
        "opFare": opFare,
        "opGroupFare": opGroupFare,
        "operatorServiceChargeAbsolute": operatorServiceChargeAbsolute,
        "operatorServiceChargePercentage": operatorServiceChargePercentage,
        "serviceCharge": serviceCharge,
        "serviceTaxAbsolute": serviceTaxAbsolute,
        "serviceTaxPercentage": serviceTaxPercentage,
        "srtFee": srtFee,
        "tollFee": tollFee,
        "totalFare": totalFare,
    };
}

enum VehicleType { BUS }

final vehicleTypeValues = EnumValues({
    "BUS": VehicleType.BUS
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String>? get reverse {
        reverseMap ??= map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
