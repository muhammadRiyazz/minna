// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

TicketinfoMore ticketinfoMoreFromJson(String str) =>
    TicketinfoMore.fromJson(json.decode(str));

String ticketinfoMoreToJson(TicketinfoMore data) => json.encode(data.toJson());

class TicketinfoMore {
  TicketinfoMore({
    required this.bookingFee,
    required this.busType,
    this.cancellationCalculationTimestamp,
    this.cancellationCharges,
    this.cancellationMessage,
    this.cancellationPolicy,
    this.cancellationReason,
    this.dateOfCancellation,
    required this.dateOfIssue,
    required this.destinationCity,
    required this.destinationCityId,
    required this.doj,
    required this.dropLocation,
    this.dropLocationAddress,
    this.dropLocationLandmark,
    required this.dropLocationId,
    required this.dropTime,
    required this.firstBoardingPointTime,
    required this.hasRtcBreakup,
    required this.hasSpecialTemplate,
    required this.inventoryId,
    required this.inventoryItems,
    required this.mTicketEnabled,
    this.otherDetails,
    required this.partialCancellationAllowed,
    required this.pickUpContactNo,
    this.pickUpLocationAddress,
    required this.pickupLocation,
    required this.pickupLocationId,
    this.pickupLocationLandmark,
    required this.pickupTime,
    required this.pnr,
    required this.primeDepartureTime,
    required this.primoBooking,
    this.refundAmount,
    this.refundServiceTax,
    this.reschedulingPolicy,
    required this.serviceCharge,
    required this.serviceStartTime,
    this.serviceTaxOnCancellationCharge,
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
  DateTime? cancellationCalculationTimestamp;
  String? cancellationCharges;
  String? cancellationMessage;
  String? cancellationPolicy;
  String? cancellationReason;
  DateTime? dateOfCancellation;
  DateTime dateOfIssue;
  String destinationCity;
  String destinationCityId;
  DateTime doj;
  String dropLocation;
  String? dropLocationAddress;
  String? dropLocationLandmark;
  String dropLocationId;
  String dropTime;
  String firstBoardingPointTime;
  String hasRtcBreakup;
  String hasSpecialTemplate;
  String inventoryId;
  List<InventoryItem> inventoryItems;
  String mTicketEnabled;
  OtherDetails? otherDetails;
  String partialCancellationAllowed;
  String pickUpContactNo;
  String? pickUpLocationAddress;
  String pickupLocation;
  String pickupLocationId;
  String? pickupLocationLandmark;
  String pickupTime;
  String pnr;
  String primeDepartureTime;
  String primoBooking;
  String? refundAmount;
  String? refundServiceTax;
  ReschedulingPolicy? reschedulingPolicy;
  String serviceCharge;
  String serviceStartTime;
  String? serviceTaxOnCancellationCharge;
  String sourceCity;
  String sourceCityId;
  String status;
  String tin;
  String travels;
  String vaccinatedBus;
  String vaccinatedStaff;

  factory TicketinfoMore.fromJson(Map<String, dynamic> json) {
    // Handle inventoryItems - could be a list or a single object
    List<InventoryItem> inventoryItems = [];
    if (json['inventoryItems'] is List) {
      inventoryItems = List<InventoryItem>.from(
        json['inventoryItems'].map((x) => InventoryItem.fromJson(x)),
      );
    } else if (json['inventoryItems'] is Map<String, dynamic>) {
      inventoryItems = [InventoryItem.fromJson(json['inventoryItems'])];
    }

    // Handle dateOfCancellation - might be null for non-cancelled tickets
    DateTime? dateOfCancellation;
    if (json["dateOfCancellation"] != null) {
      try {
        dateOfCancellation = DateTime.parse(json["dateOfCancellation"]);
      } catch (e) {
        dateOfCancellation = null;
      }
    }

    // Handle cancellationCalculationTimestamp
    DateTime? cancellationCalculationTimestamp;
    if (json["cancellationCalculationTimestamp"] != null) {
      try {
        // This might be in a different format, so we need to handle it carefully
        final timestampStr = json["cancellationCalculationTimestamp"].toString();
        if (timestampStr.contains('-')) {
          cancellationCalculationTimestamp = DateTime.parse(timestampStr);
        } else {
          // Handle other formats if needed
          cancellationCalculationTimestamp = DateTime.now();
        }
      } catch (e) {
        cancellationCalculationTimestamp = null;
      }
    }

    // Handle otherDetails
    OtherDetails? otherDetails;
    if (json["otherDetails"] != null && json["otherDetails"] is Map<String, dynamic>) {
      otherDetails = OtherDetails.fromJson(json["otherDetails"]);
    }

    // Handle reschedulingPolicy
    ReschedulingPolicy? reschedulingPolicy;
    if (json["reschedulingPolicy"] != null && json["reschedulingPolicy"] is Map<String, dynamic>) {
      reschedulingPolicy = ReschedulingPolicy.fromJson(json["reschedulingPolicy"]);
    }

    return TicketinfoMore(
      bookingFee: json["bookingFee"] ?? '',
      busType: json["busType"] ?? '',
      cancellationCalculationTimestamp: cancellationCalculationTimestamp,
      cancellationCharges: json["cancellationCharges"] ?? '',
      cancellationMessage: json["cancellationMessage"] ?? '',
      cancellationPolicy: json["cancellationPolicy"] ?? '',
      cancellationReason: json["cancellationReason"] ?? '',
      dateOfCancellation: dateOfCancellation,
      dateOfIssue: DateTime.parse(json["dateOfIssue"] ?? DateTime.now().toIso8601String()),
      destinationCity: json["destinationCity"] ?? '',
      destinationCityId: json["destinationCityId"] ?? '',
      doj: DateTime.parse(json["doj"] ?? DateTime.now().toIso8601String()),
      dropLocation: json["dropLocation"] ?? '',
      dropLocationAddress: json["dropLocationAddress"] ?? '',
      dropLocationLandmark: json["dropLocationLandmark"] ?? '',
      dropLocationId: json["dropLocationId"] ?? '',
      dropTime: json["dropTime"] ?? '',
      firstBoardingPointTime: json["firstBoardingPointTime"] ?? '',
      hasRtcBreakup: json["hasRTCBreakup"] ?? '',
      hasSpecialTemplate: json["hasSpecialTemplate"] ?? '',
      inventoryId: json["inventoryId"] ?? '',
      inventoryItems: inventoryItems,
      mTicketEnabled: json["MTicketEnabled"] ?? '',
      otherDetails: otherDetails,
      partialCancellationAllowed: json["partialCancellationAllowed"] ?? '',
      pickUpContactNo: json["pickUpContactNo"] ?? '',
      pickUpLocationAddress: json["pickUpLocationAddress"] ?? '',
      pickupLocation: json["pickupLocation"] ?? '',
      pickupLocationId: json["pickupLocationId"] ?? '',
      pickupLocationLandmark: json["pickupLocationLandmark"] ?? '',
      pickupTime: json["pickupTime"] ?? '',
      pnr: json["pnr"] ?? '',
      primeDepartureTime: json["primeDepartureTime"] ?? '',
      primoBooking: json["primoBooking"] ?? '',
      refundAmount: json["refundAmount"] ?? '',
      refundServiceTax: json["refundServiceTax"] ?? '',
      reschedulingPolicy: reschedulingPolicy,
      serviceCharge: json["serviceCharge"] ?? '',
      serviceStartTime: json["serviceStartTime"] ?? '',
      serviceTaxOnCancellationCharge: json["serviceTaxOnCancellationCharge"] ?? '',
      sourceCity: json["sourceCity"] ?? '',
      sourceCityId: json["sourceCityId"] ?? '',
      status: json["status"] ?? '',
      tin: json["tin"] ?? '',
      travels: json["travels"] ?? '',
      vaccinatedBus: json["vaccinatedBus"] ?? '',
      vaccinatedStaff: json["vaccinatedStaff"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "bookingFee": bookingFee,
        "busType": busType,
        "cancellationCalculationTimestamp": cancellationCalculationTimestamp?.toIso8601String(),
        "cancellationCharges": cancellationCharges,
        "cancellationMessage": cancellationMessage,
        "cancellationPolicy": cancellationPolicy,
        "cancellationReason": cancellationReason,
        "dateOfCancellation": dateOfCancellation?.toIso8601String(),
        "dateOfIssue": dateOfIssue.toIso8601String(),
        "destinationCity": destinationCity,
        "destinationCityId": destinationCityId,
        "doj": doj.toIso8601String(),
        "dropLocation": dropLocation,
        "dropLocationAddress": dropLocationAddress,
        "dropLocationLandmark": dropLocationLandmark,
        "dropLocationId": dropLocationId,
        "dropTime": dropTime,
        "firstBoardingPointTime": firstBoardingPointTime,
        "hasRTCBreakup": hasRtcBreakup,
        "hasSpecialTemplate": hasSpecialTemplate,
        "inventoryId": inventoryId,
        "inventoryItems": List<dynamic>.from(inventoryItems.map((x) => x.toJson())),
        "MTicketEnabled": mTicketEnabled,
        "otherDetails": otherDetails?.toJson(),
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
        "reschedulingPolicy": reschedulingPolicy?.toJson(),
        "serviceCharge": serviceCharge,
        "serviceStartTime": serviceStartTime,
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

class InventoryItem {
  InventoryItem({
    required this.baseFare,
    this.cancellationReason,
    required this.fare,
    required this.flashDealSeat,
    required this.ladiesSeat,
    required this.malesSeat,
    required this.operatorServiceCharge,
    required this.passenger,
    required this.seatName,
    required this.serviceTax,
  });

  String baseFare;
  String? cancellationReason;
  String fare;
  String flashDealSeat;
  String ladiesSeat;
  String malesSeat;
  String operatorServiceCharge;
  Passenger passenger;
  String seatName;
  String serviceTax;

  factory InventoryItem.fromJson(Map<String, dynamic> json) => InventoryItem(
        baseFare: json["baseFare"] ?? '',
        cancellationReason: json["cancellationReason"],
        fare: json["fare"] ?? '',
        flashDealSeat: json["flashDealSeat"] ?? 'false',
        ladiesSeat: json["ladiesSeat"] ?? 'false',
        malesSeat: json["malesSeat"] ?? 'false',
        operatorServiceCharge: json["operatorServiceCharge"] ?? '',
        passenger: Passenger.fromJson(json["passenger"]),
        seatName: json["seatName"] ?? '',
        serviceTax: json["serviceTax"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "baseFare": baseFare,
        "cancellationReason": cancellationReason,
        "fare": fare,
        "flashDealSeat": flashDealSeat,
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

  factory Passenger.fromJson(Map<String, dynamic> json) => Passenger(
        address: json["address"] ?? '',
        age: json["age"] ?? '',
        email: json["email"] ?? '',
        gender: json["gender"] ?? '',
        idNumber: json["idNumber"] ?? '',
        idType: json["idType"] ?? '',
        mobile: json["mobile"] ?? '',
        name: json["name"] ?? '',
        primary: json["primary"] ?? '',
        singleLadies: json["singleLadies"] ?? '',
        title: json["title"] ?? '',
      );

  Map<String, dynamic> toJson() => {
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

class OtherDetails {
  OtherDetails({
    required this.entry,
  });

  List<Entry> entry;

  factory OtherDetails.fromJson(Map<String, dynamic> json) => OtherDetails(
        entry: List<Entry>.from(json["entry"].map((x) => Entry.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "entry": List<dynamic>.from(entry.map((x) => x.toJson())),
      };
}

class Entry {
  Entry({
    required this.key,
    required this.value,
  });

  String key;
  String value;

  factory Entry.fromJson(Map<String, dynamic> json) => Entry(
        key: json["key"] ?? '',
        value: json["value"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}

class ReschedulingPolicy {
  ReschedulingPolicy({
    required this.reschedulingCharge,
    required this.windowTime,
  });

  String reschedulingCharge;
  String windowTime;

  factory ReschedulingPolicy.fromJson(Map<String, dynamic> json) => ReschedulingPolicy(
        reschedulingCharge: json["reschedulingCharge"] ?? '',
        windowTime: json["windowTime"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "reschedulingCharge": reschedulingCharge,
        "windowTime": windowTime,
      };
} 