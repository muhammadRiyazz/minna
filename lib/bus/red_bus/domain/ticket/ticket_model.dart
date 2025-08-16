// To parse this JSON data, do
//
//     final modelTicketReddBus = modelTicketReddBusFromMap(jsondynamic);

import 'package:meta/meta.dart';
import 'dart:convert';

ModelTicketReddBus modelTicketReddBusFromMap(dynamic str) => ModelTicketReddBus.fromMap(json.decode(str));

dynamic modelTicketReddBusToMap(ModelTicketReddBus data) => json.encode(data.toMap());

class ModelTicketReddBus {
    ModelTicketReddBus({
        required this.bookingFee,
        required this.busType,
        required this.cancellationCalculationTimestamp,
        required this.cancellationCharges,
        required this.cancellationMessage,
        required this.cancellationPolicy,
        required this.cancellationReason,
        required this.dateOfCancellation,
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
        required this.refundAmount,
        required this.refundServiceTax,
        required this.reschedulingPolicy,
        required this.serviceCharge,
        required this.serviceTaxOnCancellationCharge,
        required this.sourceCity,
        required this.sourceCityId,
        required this.status,
        required this.tin,
        required this.travels,
        required this.vaccinatedBus,
        required this.vaccinatedStaff,
    });

    dynamic bookingFee;
    dynamic busType;
    dynamic cancellationCalculationTimestamp;
    dynamic cancellationCharges;
    dynamic cancellationMessage;
    dynamic cancellationPolicy;
    dynamic cancellationReason;
    dynamic dateOfCancellation;
    dynamic dateOfIssue;
    dynamic destinationCity;
    dynamic destinationCityId;
    dynamic doj;
    dynamic dropLocation;
    dynamic dropLocationId;
    dynamic dropTime;
    dynamic firstBoardingPointTime;
    dynamic hasRtcBreakup;
    dynamic hasSpecialTemplate;
    dynamic inventoryId;
    InventoryItems inventoryItems;
    dynamic mTicketEnabled;
    dynamic partialCancellationAllowed;
    dynamic pickUpContactNo;
    dynamic pickUpLocationAddress;
    dynamic pickupLocation;
    dynamic pickupLocationId;
    dynamic pickupLocationLandmark;
    dynamic pickupTime;
    dynamic pnr;
    dynamic primeDepartureTime;
    dynamic primoBooking;
    dynamic refundAmount;
    dynamic refundServiceTax;
    ReschedulingPolicy reschedulingPolicy;
    dynamic serviceCharge;
    dynamic serviceTaxOnCancellationCharge;
    dynamic sourceCity;
    dynamic sourceCityId;
    dynamic status;
    dynamic tin;
    dynamic travels;
    dynamic vaccinatedBus;
    dynamic vaccinatedStaff;

    factory ModelTicketReddBus.fromMap(Map<dynamic, dynamic> json) => ModelTicketReddBus(
        bookingFee: json["bookingFee"],
        busType: json["busType"],
        cancellationCalculationTimestamp: json["cancellationCalculationTimestamp"],
        cancellationCharges: json["cancellationCharges"],
        cancellationMessage: json["cancellationMessage"],
        cancellationPolicy: json["cancellationPolicy"],
        cancellationReason: json["cancellationReason"],
        dateOfCancellation: json["dateOfCancellation"],
        dateOfIssue: json["dateOfIssue"],
        destinationCity: json["destinationCity"],
        destinationCityId: json["destinationCityId"],
        doj: json["doj"],
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
        refundAmount: json["refundAmount"],
        refundServiceTax: json["refundServiceTax"],
        reschedulingPolicy: ReschedulingPolicy.fromMap(json["reschedulingPolicy"]),
        serviceCharge: json["serviceCharge"],
        serviceTaxOnCancellationCharge: json["serviceTaxOnCancellationCharge"],
        sourceCity: json["sourceCity"],
        sourceCityId: json["sourceCityId"],
        status: json["status"],
        tin: json["tin"],
        travels: json["travels"],
        vaccinatedBus: json["vaccinatedBus"],
        vaccinatedStaff: json["vaccinatedStaff"],
    );

    Map<dynamic, dynamic> toMap() => {
        "bookingFee": bookingFee,
        "busType": busType,
        "cancellationCalculationTimestamp": cancellationCalculationTimestamp,
        "cancellationCharges": cancellationCharges,
        "cancellationMessage": cancellationMessage,
        "cancellationPolicy": cancellationPolicy,
        "cancellationReason": cancellationReason,
        "dateOfCancellation": dateOfCancellation,
        "dateOfIssue": dateOfIssue,
        "destinationCity": destinationCity,
        "destinationCityId": destinationCityId,
        "doj": doj,
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
        "refundAmount": refundAmount,
        "refundServiceTax": refundServiceTax,
        "reschedulingPolicy": reschedulingPolicy.toMap(),
        "serviceCharge": serviceCharge,
        "serviceTaxOnCancellationCharge": serviceTaxOnCancellationCharge,
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
        required this.cancellationReason,
        required this.fare,
        required this.ladiesSeat,
        required this.malesSeat,
        required this.operatorServiceCharge,
        required this.passenger,
        required this.seatName,
        required this.serviceTax,
    });

    dynamic baseFare;
    dynamic cancellationReason;
    dynamic fare;
    dynamic ladiesSeat;
    dynamic malesSeat;
    dynamic operatorServiceCharge;
    Passenger passenger;
    dynamic seatName;
    dynamic serviceTax;

    factory InventoryItems.fromMap(Map<dynamic, dynamic> json) => InventoryItems(
        baseFare: json["baseFare"],
        cancellationReason: json["cancellationReason"],
        fare: json["fare"],
        ladiesSeat: json["ladiesSeat"],
        malesSeat: json["malesSeat"],
        operatorServiceCharge: json["operatorServiceCharge"],
        passenger: Passenger.fromMap(json["passenger"]),
        seatName: json["seatName"],
        serviceTax: json["serviceTax"],
    );

    Map<dynamic, dynamic> toMap() => {
        "baseFare": baseFare,
        "cancellationReason": cancellationReason,
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

    dynamic address;
    dynamic age;
    dynamic email;
    dynamic gender;
    dynamic idNumber;
    dynamic idType;
    dynamic mobile;
    dynamic name;
    dynamic primary;
    dynamic singleLadies;
    dynamic title;

    factory Passenger.fromMap(Map<dynamic, dynamic> json) => Passenger(
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

    Map<dynamic, dynamic> toMap() => {
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

    dynamic reschedulingCharge;
    dynamic windowTime;

    factory ReschedulingPolicy.fromMap(Map<dynamic, dynamic> json) => ReschedulingPolicy(
        reschedulingCharge: json["reschedulingCharge"],
        windowTime: json["windowTime"],
    );

    Map<dynamic, dynamic> toMap() => {
        "reschedulingCharge": reschedulingCharge,
        "windowTime": windowTime,
    };
}
