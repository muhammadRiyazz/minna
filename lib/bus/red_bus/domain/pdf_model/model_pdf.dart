// To parse this JSON data, do
//
//     final modelTicket = modelTicketFromMap(jsonString);

import 'dart:convert';

ModelTicket modelTicketFromMap(String str) => ModelTicket.fromMap(json.decode(str));

String modelTicketToMap(ModelTicket data) => json.encode(data.toMap());

class ModelTicket {
    ModelTicket({
        required this.bookingFee,
        required this.busType,
        required this.cancellationCalculationTimestamp,
        required this.cancellationMessage,
        required this.cancellationPolicy,
        required this.dateOfIssue,
        required this.destinationCity,
        required this.destinationCityId,
        required this.doj,
        required this.dropLocation,
        required this.dropLocationId,
        required this.dropTime,
        required this.firstBoardingPointTime,
        required this.hasRtcBreakup,
        required this.hasSpecialTemplate,
        required this.inventoryId,
        required this.inventoryItems,
        required this.mTicketEnabled,
        required this.partialCancellationAllowed,
        required this.pickUpContactNo,
        required this.pickUpLocationAddress,
        required this.pickupLocation,
        required this.pickupLocationId,
        required this.pickupLocationLandmark,
        required this.pickupTime,
        required this.pnr,
        required this.primeDepartureTime,
        required this.primoBooking,
        required this.reschedulingPolicy,
        required this.serviceCharge,
        required this.sourceCity,
        required this.sourceCityId,
        required this.status,
        required this.tin,
        required this.travels,
        required this.vaccinatedBus,
        required this.vaccinatedStaff,
    });

    String bookingFee;
    String busType;
    DateTime cancellationCalculationTimestamp;
    String cancellationMessage;
    String cancellationPolicy;
    DateTime dateOfIssue;
    String destinationCity;
    String destinationCityId;
    DateTime doj;
    String dropLocation;
    String dropLocationId;
    String dropTime;
    String firstBoardingPointTime;
    String hasRtcBreakup;
    String hasSpecialTemplate;
    String inventoryId;
    InventoryItems inventoryItems;
    String mTicketEnabled;
    String partialCancellationAllowed;
    String pickUpContactNo;
    String pickUpLocationAddress;
    String pickupLocation;
    String pickupLocationId;
    String pickupLocationLandmark;
    String pickupTime;
    String pnr;
    String primeDepartureTime;
    String primoBooking;
    ReschedulingPolicy reschedulingPolicy;
    String serviceCharge;
    String sourceCity;
    String sourceCityId;
    String status;
    String tin;
    String travels;
    String vaccinatedBus;
    String vaccinatedStaff;

    factory ModelTicket.fromMap(Map<String, dynamic> json) => ModelTicket(
        bookingFee: json["bookingFee"],
        busType: json["busType"],
        cancellationCalculationTimestamp: DateTime.parse(json["cancellationCalculationTimestamp"]),
        cancellationMessage: json["cancellationMessage"],
        cancellationPolicy: json["cancellationPolicy"],
        dateOfIssue: DateTime.parse(json["dateOfIssue"]),
        destinationCity: json["destinationCity"],
        destinationCityId: json["destinationCityId"],
        doj: DateTime.parse(json["doj"]),
        dropLocation: json["dropLocation"],
        dropLocationId: json["dropLocationId"],
        dropTime: json["dropTime"],
        firstBoardingPointTime: json["firstBoardingPointTime"],
        hasRtcBreakup: json["hasRTCBreakup"],
        hasSpecialTemplate: json["hasSpecialTemplate"],
        inventoryId: json["inventoryId"],
        inventoryItems: InventoryItems.fromMap(json["inventoryItems"]),
        mTicketEnabled: json["MTicketEnabled"],
        partialCancellationAllowed: json["partialCancellationAllowed"],
        pickUpContactNo: json["pickUpContactNo"],
        pickUpLocationAddress: json["pickUpLocationAddress"],
        pickupLocation: json["pickupLocation"],
        pickupLocationId: json["pickupLocationId"],
        pickupLocationLandmark: json["pickupLocationLandmark"],
        pickupTime: json["pickupTime"],
        pnr: json["pnr"],
        primeDepartureTime: json["primeDepartureTime"],
        primoBooking: json["primoBooking"],
        reschedulingPolicy: ReschedulingPolicy.fromMap(json["reschedulingPolicy"]),
        serviceCharge: json["serviceCharge"],
        sourceCity: json["sourceCity"],
        sourceCityId: json["sourceCityId"],
        status: json["status"],
        tin: json["tin"],
        travels: json["travels"],
        vaccinatedBus: json["vaccinatedBus"],
        vaccinatedStaff: json["vaccinatedStaff"],
    );

    Map<String, dynamic> toMap() => {
        "bookingFee": bookingFee,
        "busType": busType,
        "cancellationCalculationTimestamp": cancellationCalculationTimestamp.toIso8601String(),
        "cancellationMessage": cancellationMessage,
        "cancellationPolicy": cancellationPolicy,
        "dateOfIssue": dateOfIssue.toIso8601String(),
        "destinationCity": destinationCity,
        "destinationCityId": destinationCityId,
        "doj": doj.toIso8601String(),
        "dropLocation": dropLocation,
        "dropLocationId": dropLocationId,
        "dropTime": dropTime,
        "firstBoardingPointTime": firstBoardingPointTime,
        "hasRTCBreakup": hasRtcBreakup,
        "hasSpecialTemplate": hasSpecialTemplate,
        "inventoryId": inventoryId,
        "inventoryItems": inventoryItems.toMap(),
        "MTicketEnabled": mTicketEnabled,
        "partialCancellationAllowed": partialCancellationAllowed,
        "pickUpContactNo": pickUpContactNo,
        "pickUpLocationAddress": pickUpLocationAddress,
        "pickupLocation": pickupLocation,
        "pickupLocationId": pickupLocationId,
        "pickupLocationLandmark": pickupLocationLandmark,
        "pickupTime": pickupTime,
        "pnr": pnr,
        "primeDepartureTime": primeDepartureTime,
        "primoBooking": primoBooking,
        "reschedulingPolicy": reschedulingPolicy.toMap(),
        "serviceCharge": serviceCharge,
        "sourceCity": sourceCity,
        "sourceCityId": sourceCityId,
        "status": status,
        "tin": tin,
        "travels": travels,
        "vaccinatedBus": vaccinatedBus,
        "vaccinatedStaff": vaccinatedStaff,
    };
}

class InventoryItems {
    InventoryItems({
        required this.baseFare,
        required this.fare,
        required this.ladiesSeat,
        required this.malesSeat,
        required this.operatorServiceCharge,
        required this.passenger,
        required this.seatName,
        required this.serviceTax,
    });

    String baseFare;
    String fare;
    String ladiesSeat;
    String malesSeat;
    String operatorServiceCharge;
    Passenger passenger;
    String seatName;
    String serviceTax;

    factory InventoryItems.fromMap(Map<String, dynamic> json) => InventoryItems(
        baseFare: json["baseFare"],
        fare: json["fare"],
        ladiesSeat: json["ladiesSeat"],
        malesSeat: json["malesSeat"],
        operatorServiceCharge: json["operatorServiceCharge"],
        passenger: Passenger.fromMap(json["passenger"]),
        seatName: json["seatName"],
        serviceTax: json["serviceTax"],
    );

    Map<String, dynamic> toMap() => {
        "baseFare": baseFare,
        "fare": fare,
        "ladiesSeat": ladiesSeat,
        "malesSeat": malesSeat,
        "operatorServiceCharge": operatorServiceCharge,
        "passenger": passenger.toMap(),
        "seatName": seatName,
        "serviceTax": serviceTax,
    };
}

class Passenger {
    Passenger({
        required this.address,
        required this.age,
        required this.email,
        required this.gender,
        required this.idNumber,
        required this.idType,
        required this.mobile,
        required this.name,
        required this.primary,
        required this.singleLadies,
        required this.title,
    });

    String address;
    String age;
    String email;
    String gender;
    String idNumber;
    String idType;
    String mobile;
    String name;
    String primary;
    String singleLadies;
    String title;

    factory Passenger.fromMap(Map<String, dynamic> json) => Passenger(
        address: json["address"],
        age: json["age"],
        email: json["email"],
        gender: json["gender"],
        idNumber: json["idNumber"],
        idType: json["idType"],
        mobile: json["mobile"],
        name: json["name"],
        primary: json["primary"],
        singleLadies: json["singleLadies"],
        title: json["title"],
    );

    Map<String, dynamic> toMap() => {
        "address": address,
        "age": age,
        "email": email,
        "gender": gender,
        "idNumber": idNumber,
        "idType": idType,
        "mobile": mobile,
        "name": name,
        "primary": primary,
        "singleLadies": singleLadies,
        "title": title,
    };
}

class ReschedulingPolicy {
    ReschedulingPolicy({
        required this.reschedulingCharge,
        required this.windowTime,
    });

    String reschedulingCharge;
    String windowTime;

    factory ReschedulingPolicy.fromMap(Map<String, dynamic> json) => ReschedulingPolicy(
        reschedulingCharge: json["reschedulingCharge"],
        windowTime: json["windowTime"],
    );

    Map<String, dynamic> toMap() => {
        "reschedulingCharge": reschedulingCharge,
        "windowTime": windowTime,
    };
}
