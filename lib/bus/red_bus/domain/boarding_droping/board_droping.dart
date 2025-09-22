
// To parse this JSON data, do

//     final boardingDroping = boardingDropingFromJson(jsonString);

import 'dart:convert';

BoardingDropingList boardingDropingFromJson(String str) =>
    BoardingDropingList.fromJson(json.decode(str));

String boardingDropingToJson(BoardingDropingList data) =>
    json.encode(data.toJson());

class BoardingDropingList {
  BoardingDropingList({
    required this.boardingPoints,
    required this.droppingPoints,
  });

  List<IngPoint> boardingPoints;
  List<IngPoint> droppingPoints;

  factory BoardingDropingList.fromJson(Map<String, dynamic> json) =>
      BoardingDropingList(
        boardingPoints: List<IngPoint>.from(
            json["boardingPoints"].map((x) => IngPoint.fromJson(x))),
        droppingPoints: List<IngPoint>.from(
            json["droppingPoints"].map((x) => IngPoint.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "boardingPoints":
            List<dynamic>.from(boardingPoints.map((x) => x.toJson())),
        "droppingPoints":
            List<dynamic>.from(droppingPoints.map((x) => x.toJson())),
      };
}

class IngPoint {
  IngPoint({
    required this.address,
    required this.contactnumber,
    required this.id,
    required this.landmark,
    required this.locationName,
    required this.name,
  });

  String address;
  String contactnumber;
  String id;
  String landmark;
  String locationName;
  String name;

  factory IngPoint.fromJson(Map<String, dynamic> json) => IngPoint(
        address: json["address"],
        contactnumber: json["contactnumber"],
        id: json["id"],
        landmark: json["landmark"],
        locationName: json["locationName"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "contactnumber": contactnumber,
        "id": id,
        "landmark": landmark,
        "locationName": locationName,
        "name": name,
      };
}



























// // To parse this JSON data, do
// //
// //     final boarding = boardingFromMap(jsonString);

// import 'dart:convert';

// BoardingDroping boardingFromMap(String str) =>
//     BoardingDroping.fromMap(json.decode(str));

// String boardingToMap(BoardingDroping? data) => json.encode(data!.toMap());

// class BoardingDroping {
//   BoardingDroping({
//     // this.availableSingleSeat,
//     required this.boardingTimes,
//     // this.callFareBreakUpApi,
//     required this.droppingTimes,
//     // this.fareDetails,
//     // this.noSeatLayoutAvailableSeats,
//     // this.noSeatLayoutEnabled,
//     // this.primo,
//     // this.seats,
//     // this.vaccinatedBus,
//     // this.vaccinatedStaff,
//   });

//   // String? availableSingleSeat;
//   List<IngTime?> boardingTimes;
//   // String? callFareBreakUpApi;
//   List<IngTime?> droppingTimes;
//   // List<FareDetail?>? fareDetails;
//   // String? noSeatLayoutAvailableSeats;
//   // String? noSeatLayoutEnabled;
//   // String? primo;
//   // List<Seat?>? seats;
//   // String? vaccinatedBus;
//   // String? vaccinatedStaff;

//   factory BoardingDroping.fromMap(Map<String, dynamic> json) => BoardingDroping(
//         // availableSingleSeat: json["availableSingleSeat"],
//         boardingTimes: json["boardingTimes"] == null
//             ? []
//             : List<IngTime?>.from(
//                 json["boardingTimes"]!.map((x) => IngTime.fromMap(x)),
//               ),
//         // callFareBreakUpApi: json["callFareBreakUpAPI"],
//         droppingTimes: json["droppingTimes"] == null
//             ? []
//             : List<IngTime?>.from(
//                 json["droppingTimes"]!.map((x) => IngTime.fromMap(x))),
//         // fareDetails: json["fareDetails"] == null ? [] : List<FareDetail?>.from(json["fareDetails"]!.map((x) => FareDetail.fromMap(x))),
//         // noSeatLayoutAvailableSeats: json["noSeatLayoutAvailableSeats"],
//         // noSeatLayoutEnabled: json["noSeatLayoutEnabled"],
//         // primo: json["primo"],
//         // seats: json["seats"] == null ? [] : List<Seat?>.from(json["seats"]!.map((x) => Seat.fromMap(x))),
//         // vaccinatedBus: json["vaccinatedBus"],
//         // vaccinatedStaff: json["vaccinatedStaff"],
//       );

//   Map<String, dynamic> toMap() => {
//         // "availableSingleSeat": availableSingleSeat,
//         "boardingTimes": boardingTimes == null
//             ? []
//             : List<dynamic>.from(boardingTimes.map((x) => x!.toMap())),
//         // "callFareBreakUpAPI": callFareBreakUpApi,
//         "droppingTimes": droppingTimes == null
//             ? []
//             : List<dynamic>.from(droppingTimes.map((x) => x!.toMap())),
//         // "fareDetails": fareDetails == null ? [] : List<dynamic>.from(fareDetails!.map((x) => x!.toMap())),
//         // "noSeatLayoutAvailableSeats": noSeatLayoutAvailableSeats,
//         // "noSeatLayoutEnabled": noSeatLayoutEnabled,
//         // "primo": primo,
//         // "seats": seats == null ? [] : List<dynamic>.from(seats!.map((x) => x!.toMap())),
//         // "vaccinatedBus": vaccinatedBus,
//         // "vaccinatedStaff": vaccinatedStaff,
//       };
// }

// class IngTime {
//   IngTime({
//     required this.address,
//     required this.bpAmenities,
//     required this.bpId,
//     required this.bpIdentifier,
//     required this.bpName,
//     required this.contactNumber,
//     required this.landmark,
//     required this.location,
//     required this.prime,
//     required this.time,
//   });

//   String address;
//   String bpAmenities;
//   String bpId;
//   String bpIdentifier;
//   String bpName;
//   String contactNumber;
//   String landmark;
//   String location;
//   String prime;
//   String time;

//   factory IngTime.fromMap(Map<String, dynamic> json) => IngTime(
//         address: json["address"],
//         bpAmenities: json["bpAmenities"],
//         bpId: json["bpId"],
//         bpIdentifier: json["bpIdentifier"],
//         bpName: json["bpName"],
//         contactNumber: json["contactNumber"],
//         landmark: json["landmark"],
//         location: json["location"],
//         prime: json["prime"],
//         time: json["time"],
//       );

//   Map<String, dynamic> toMap() => {
//         "address": address,
//         "bpAmenities": bpAmenities,
//         "bpId": bpId,
//         "bpIdentifier": bpIdentifier,
//         "bpName": bpName,
//         "contactNumber": contactNumber,
//         "landmark": landmark,
//         "location": location,
//         "prime": prime,
//         "time": time,
//       };
// }

// class FareDetail {
//   FareDetail({
//     this.bankTrexAmt,
//     this.baseFare,
//     this.bookingFee,
//     this.childFare,
//     this.gst,
//     this.levyFare,
//     this.markupFareAbsolute,
//     this.markupFarePercentage,
//     this.opFare,
//     this.opGroupFare,
//     this.operatorServiceChargeAbsolute,
//     this.operatorServiceChargePercentage,
//     this.serviceCharge,
//     this.serviceTaxAbsolute,
//     this.serviceTaxPercentage,
//     this.srtFee,
//     this.tollFee,
//     this.totalFare,
//   });

//   String? bankTrexAmt;
//   String? baseFare;
//   String? bookingFee;
//   String? childFare;
//   String? gst;
//   String? levyFare;
//   String? markupFareAbsolute;
//   String? markupFarePercentage;
//   String? opFare;
//   String? opGroupFare;
//   String? operatorServiceChargeAbsolute;
//   String? operatorServiceChargePercentage;
//   String? serviceCharge;
//   String? serviceTaxAbsolute;
//   String? serviceTaxPercentage;
//   String? srtFee;
//   String? tollFee;
//   String? totalFare;

//   factory FareDetail.fromMap(Map<String, dynamic> json) => FareDetail(
//         bankTrexAmt: json["bankTrexAmt"],
//         baseFare: json["baseFare"],
//         bookingFee: json["bookingFee"],
//         childFare: json["childFare"],
//         gst: json["gst"],
//         levyFare: json["levyFare"],
//         markupFareAbsolute: json["markupFareAbsolute"],
//         markupFarePercentage: json["markupFarePercentage"],
//         opFare: json["opFare"],
//         opGroupFare: json["opGroupFare"],
//         operatorServiceChargeAbsolute: json["operatorServiceChargeAbsolute"],
//         operatorServiceChargePercentage:
//             json["operatorServiceChargePercentage"],
//         serviceCharge: json["serviceCharge"],
//         serviceTaxAbsolute: json["serviceTaxAbsolute"],
//         serviceTaxPercentage: json["serviceTaxPercentage"],
//         srtFee: json["srtFee"],
//         tollFee: json["tollFee"],
//         totalFare: json["totalFare"],
//       );

//   Map<String, dynamic> toMap() => {
//         "bankTrexAmt": bankTrexAmt,
//         "baseFare": baseFare,
//         "bookingFee": bookingFee,
//         "childFare": childFare,
//         "gst": gst,
//         "levyFare": levyFare,
//         "markupFareAbsolute": markupFareAbsolute,
//         "markupFarePercentage": markupFarePercentage,
//         "opFare": opFare,
//         "opGroupFare": opGroupFare,
//         "operatorServiceChargeAbsolute": operatorServiceChargeAbsolute,
//         "operatorServiceChargePercentage": operatorServiceChargePercentage,
//         "serviceCharge": serviceCharge,
//         "serviceTaxAbsolute": serviceTaxAbsolute,
//         "serviceTaxPercentage": serviceTaxPercentage,
//         "srtFee": srtFee,
//         "tollFee": tollFee,
//         "totalFare": totalFare,
//       };
// }

// class Seat {
//   Seat({
//     this.available,
//     this.bankTrexAmt,
//     this.baseFare,
//     this.childFare,
//     this.column,
//     this.concession,
//     this.doubleBirth,
//     this.fare,
//     this.ladiesSeat,
//     this.length,
//     this.levyFare,
//     this.malesSeat,
//     this.markupFareAbsolute,
//     this.markupFarePercentage,
//     this.name,
//     this.operatorServiceChargeAbsolute,
//     this.operatorServiceChargePercent,
//     this.reservedForSocialDistancing,
//     this.row,
//     this.serviceTaxAbsolute,
//     this.serviceTaxPercentage,
//     this.srtFee,
//     this.tollFee,
//     this.width,
//     this.zIndex,
//   });

//   String? available;
//   String? bankTrexAmt;
//   String? baseFare;
//   String? childFare;
//   String? column;
//   String? concession;
//   String? doubleBirth;
//   String? fare;
//   String? ladiesSeat;
//   String? length;
//   String? levyFare;
//   String? malesSeat;
//   String? markupFareAbsolute;
//   String? markupFarePercentage;
//   String? name;
//   String? operatorServiceChargeAbsolute;
//   String? operatorServiceChargePercent;
//   String? reservedForSocialDistancing;
//   String? row;
//   String? serviceTaxAbsolute;
//   String? serviceTaxPercentage;
//   String? srtFee;
//   String? tollFee;
//   String? width;
//   String? zIndex;

//   factory Seat.fromMap(Map<String, dynamic> json) => Seat(
//         available: json["available"],
//         bankTrexAmt: json["bankTrexAmt"],
//         baseFare: json["baseFare"],
//         childFare: json["childFare"],
//         column: json["column"],
//         concession: json["concession"],
//         doubleBirth: json["doubleBirth"],
//         fare: json["fare"],
//         ladiesSeat: json["ladiesSeat"],
//         length: json["length"],
//         levyFare: json["levyFare"],
//         malesSeat: json["malesSeat"],
//         markupFareAbsolute: json["markupFareAbsolute"],
//         markupFarePercentage: json["markupFarePercentage"],
//         name: json["name"],
//         operatorServiceChargeAbsolute: json["operatorServiceChargeAbsolute"],
//         operatorServiceChargePercent: json["operatorServiceChargePercent"],
//         reservedForSocialDistancing: json["reservedForSocialDistancing"],
//         row: json["row"],
//         serviceTaxAbsolute: json["serviceTaxAbsolute"],
//         serviceTaxPercentage: json["serviceTaxPercentage"],
//         srtFee: json["srtFee"],
//         tollFee: json["tollFee"],
//         width: json["width"],
//         zIndex: json["zIndex"],
//       );

//   Map<String, dynamic> toMap() => {
//         "available": available,
//         "bankTrexAmt": bankTrexAmt,
//         "baseFare": baseFare,
//         "childFare": childFare,
//         "column": column,
//         "concession": concession,
//         "doubleBirth": doubleBirth,
//         "fare": fare,
//         "ladiesSeat": ladiesSeat,
//         "length": length,
//         "levyFare": levyFare,
//         "malesSeat": malesSeat,
//         "markupFareAbsolute": markupFareAbsolute,
//         "markupFarePercentage": markupFarePercentage,
//         "name": name,
//         "operatorServiceChargeAbsolute": operatorServiceChargeAbsolute,
//         "operatorServiceChargePercent": operatorServiceChargePercent,
//         "reservedForSocialDistancing": reservedForSocialDistancing,
//         "row": row,
//         "serviceTaxAbsolute": serviceTaxAbsolute,
//         "serviceTaxPercentage": serviceTaxPercentage,
//         "srtFee": srtFee,
//         "tollFee": tollFee,
//         "width": width,
//         "zIndex": zIndex,
//       };
// }
