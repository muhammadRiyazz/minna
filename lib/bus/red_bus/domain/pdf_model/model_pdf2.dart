// To parse this JSON data, do
//
//     final modelTickePerson2 = modelTickePerson2FromJson(jsondynamic);

import 'package:meta/meta.dart';
import 'dart:convert';

ModelTickePerson2 modelTickePerson2FromJson(dynamic str) =>
    ModelTickePerson2.fromJson(json.decode(str));

dynamic modelTickePerson2ToJson(ModelTickePerson2 data) =>
    json.encode(data.toJson());

class ModelTickePerson2 {
  ModelTickePerson2({
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

  dynamic bookingFee;
  dynamic busType;
  DateTime cancellationCalculationTimestamp;
  dynamic cancellationMessage;
  dynamic cancellationPolicy;
  DateTime dateOfIssue;
  dynamic destinationCity;
  dynamic destinationCityId;
  DateTime doj;
  dynamic dropLocation;
  dynamic dropLocationId;
  dynamic dropTime;
  dynamic firstBoardingPointTime;
  dynamic hasRtcBreakup;
  dynamic hasSpecialTemplate;
  dynamic inventoryId;
  List<InventoryItem> inventoryItems;
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
  ReschedulingPolicy reschedulingPolicy;
  dynamic serviceCharge;
  dynamic sourceCity;
  dynamic sourceCityId;
  dynamic status;
  dynamic tin;
  dynamic travels;
  dynamic vaccinatedBus;
  dynamic vaccinatedStaff;

  factory ModelTickePerson2.fromJson(Map<dynamic, dynamic> json) =>
      ModelTickePerson2(
        bookingFee: json["bookingFee"],
        busType: json["busType"],
        cancellationCalculationTimestamp:
            DateTime.parse(json["cancellationCalculationTimestamp"]),
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
        inventoryItems: List<InventoryItem>.from(
            json["inventoryItems"].map((x) => InventoryItem.fromJson(x))),
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
        reschedulingPolicy:
            ReschedulingPolicy.fromJson(json["reschedulingPolicy"]),
        serviceCharge: json["serviceCharge"],
        sourceCity: json["sourceCity"],
        sourceCityId: json["sourceCityId"],
        status: json["status"],
        tin: json["tin"],
        travels: json["travels"],
        vaccinatedBus: json["vaccinatedBus"],
        vaccinatedStaff: json["vaccinatedStaff"],
      );

  Map<dynamic, dynamic> toJson() => {
        "bookingFee": bookingFee,
        "busType": busType,
        "cancellationCalculationTimestamp": cancellationCalculationTimestamp,
        "cancellationMessage": cancellationMessage,
        "cancellationPolicy": cancellationPolicy,
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
        "inventoryItems":
            List<dynamic>.from(inventoryItems.map((x) => x.toJson())),
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
        "reschedulingPolicy": reschedulingPolicy.toJson(),
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

class InventoryItem {
  InventoryItem({
    required this.baseFare,
    required this.fare,
    required this.ladiesSeat,
    required this.malesSeat,
    required this.operatorServiceCharge,
    required this.passenger,
    required this.seatName,
    required this.serviceTax,
  });

  dynamic baseFare;
  dynamic fare;
  dynamic ladiesSeat;
  dynamic malesSeat;
  dynamic operatorServiceCharge;
  Passenger passenger;
  dynamic seatName;
  dynamic serviceTax;

  factory InventoryItem.fromJson(Map<dynamic, dynamic> json) => InventoryItem(
        baseFare: json["baseFare"],
        fare: json["fare"],
        ladiesSeat: json["ladiesSeat"],
        malesSeat: json["malesSeat"],
        operatorServiceCharge: json["operatorServiceCharge"],
        passenger: Passenger.fromJson(json["passenger"]),
        seatName: json["seatName"],
        serviceTax: json["serviceTax"],
      );

  Map<dynamic, dynamic> toJson() => {
        "baseFare": baseFare,
        "fare": fare,
        "ladiesSeat": ladiesSeat,
        "malesSeat": malesSeat,
        "operatorServiceCharge": operatorServiceCharge,
        "passenger": passenger.toJson(),
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

  factory Passenger.fromJson(Map<dynamic, dynamic> json) => Passenger(
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

  Map<dynamic, dynamic> toJson() => {
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

  factory ReschedulingPolicy.fromJson(Map<dynamic, dynamic> json) =>
      ReschedulingPolicy(
        reschedulingCharge: json["reschedulingCharge"],
        windowTime: json["windowTime"],
      );

  Map<dynamic, dynamic> toJson() => {
        "reschedulingCharge": reschedulingCharge,
        "windowTime": windowTime,
      };
}
