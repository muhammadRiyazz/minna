// To parse required this JSON data, do
//
//     final modelBusSeats = modelBusSeatsFromJson(jsondynamic);

import 'dart:convert';

ModelBusSeats modelBusSeatsFromJson(dynamic str) =>
    ModelBusSeats.fromJson(json.decode(str));

dynamic modelBusSeatsToJson(ModelBusSeats data) => json.encode(data.toJson());

class ModelBusSeats {
  ModelBusSeats({
    required this.availableSingleSeat,
    required this.callFareBreakUpApi,
    // required this.fareDetails,
    required this.noSeatLayoutAvailableSeats,
    required this.noSeatLayoutEnabled,
    required this.primo,
    required this.seats,
    required this.vaccinatedBus,
    required this.vaccinatedStaff,
  });

  dynamic availableSingleSeat;
  dynamic callFareBreakUpApi;
  // List<FareDetail> fareDetails;
  dynamic noSeatLayoutAvailableSeats;
  dynamic noSeatLayoutEnabled;
  dynamic primo;
  List<Seat> seats;
  dynamic vaccinatedBus;
  dynamic vaccinatedStaff;

  factory ModelBusSeats.fromJson(Map<dynamic, dynamic> json) => ModelBusSeats(
        availableSingleSeat: json["availableSingleSeat"],
        callFareBreakUpApi: json["callFareBreakUpAPI"],
        // fareDetails: List<FareDetail>.from(json["fareDetails"].map((x) => FareDetail.fromJson(x))),
        noSeatLayoutAvailableSeats: json["noSeatLayoutAvailableSeats"],
        noSeatLayoutEnabled: json["noSeatLayoutEnabled"],
        primo: json["primo"],
        seats: List<Seat>.from(json["seats"].map((x) => Seat.fromJson(x))),
        vaccinatedBus: json["vaccinatedBus"],
        vaccinatedStaff: json["vaccinatedStaff"],
      );

  Map<dynamic, dynamic> toJson() => {
        "availableSingleSeat": availableSingleSeat,
        "callFareBreakUpAPI": callFareBreakUpApi,
        // "fareDetails": List<dynamic>.from(fareDetails.map((x) => x.toJson())),
        "noSeatLayoutAvailableSeats": noSeatLayoutAvailableSeats,
        "noSeatLayoutEnabled": noSeatLayoutEnabled,
        "primo": primo,
        "seats": List<dynamic>.from(seats.map((x) => x.toJson())),
        "vaccinatedBus": vaccinatedBus,
        "vaccinatedStaff": vaccinatedStaff,
      };
}

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

  dynamic bankTrexAmt;
  dynamic baseFare;
  dynamic bookingFee;
  dynamic childFare;
  dynamic gst;
  dynamic levyFare;
  dynamic markupFareAbsolute;
  dynamic markupFarePercentage;
  dynamic opFare;
  dynamic opGroupFare;
  dynamic operatorServiceChargeAbsolute;
  dynamic operatorServiceChargePercentage;
  dynamic serviceCharge;
  dynamic serviceTaxAbsolute;
  dynamic serviceTaxPercentage;
  dynamic srtFee;
  dynamic tollFee;
  dynamic totalFare;

  factory FareDetail.fromJson(Map<dynamic, dynamic> json) => FareDetail(
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
        operatorServiceChargePercentage:
            json["operatorServiceChargePercentage"],
        serviceCharge: json["serviceCharge"],
        serviceTaxAbsolute: json["serviceTaxAbsolute"],
        serviceTaxPercentage: json["serviceTaxPercentage"],
        srtFee: json["srtFee"],
        tollFee: json["tollFee"],
        totalFare: json["totalFare"],
      );

  Map<dynamic, dynamic> toJson() => {
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

class Seat {
  Seat({
    required this.available,
    required this.bankTrexAmt,
    required this.baseFare,
    required this.childFare,
    required this.column,
    required this.concession,
    required this.doubleBirth,
    required this.fare,
    required this.ladiesSeat,
    required this.length,
    required this.levyFare,
    required this.malesSeat,
    required this.markupFareAbsolute,
    required this.markupFarePercentage,
    required this.name,
    required this.operatorServiceChargeAbsolute,
    required this.operatorServiceChargePercent,
    required this.reservedForSocialDistancing,
    required this.row,
    required this.serviceTaxAbsolute,
    required this.serviceTaxPercentage,
    required this.srtFee,
    required this.tollFee,
    required this.width,
    required this.zIndex,
  });

  dynamic available;
  dynamic bankTrexAmt;
  dynamic baseFare;
  dynamic childFare;
  dynamic column;
  dynamic concession;
  dynamic doubleBirth;
  dynamic fare;
  dynamic ladiesSeat;
  dynamic length;
  dynamic levyFare;
  dynamic malesSeat;
  dynamic markupFareAbsolute;
  dynamic markupFarePercentage;
  dynamic name;
  dynamic operatorServiceChargeAbsolute;
  dynamic operatorServiceChargePercent;
  dynamic reservedForSocialDistancing;
  dynamic row;
  dynamic serviceTaxAbsolute;
  dynamic serviceTaxPercentage;
  dynamic srtFee;
  dynamic tollFee;
  dynamic width;
  dynamic zIndex;

  factory Seat.fromJson(Map<dynamic, dynamic> json) => Seat(
        available: json["available"],
        bankTrexAmt: json["bankTrexAmt"],
        baseFare: json["baseFare"],
        childFare: json["childFare"],
        column: json["column"],
        concession: json["concession"],
        doubleBirth: json["doubleBirth"],
        fare: json["fare"],
        ladiesSeat: json["ladiesSeat"],
        length: json["length"],
        levyFare: json["levyFare"],
        malesSeat: json["malesSeat"],
        markupFareAbsolute: json["markupFareAbsolute"],
        markupFarePercentage: json["markupFarePercentage"],
        name: json["name"],
        operatorServiceChargeAbsolute: json["operatorServiceChargeAbsolute"],
        operatorServiceChargePercent: json["operatorServiceChargePercent"],
        reservedForSocialDistancing: json["reservedForSocialDistancing"],
        row: json["row"],
        serviceTaxAbsolute: json["serviceTaxAbsolute"],
        serviceTaxPercentage: json["serviceTaxPercentage"],
        srtFee: json["srtFee"],
        tollFee: json["tollFee"],
        width: json["width"],
        zIndex: json["zIndex"],
      );

  Map<dynamic, dynamic> toJson() => {
        "available": available,
        "bankTrexAmt": bankTrexAmt,
        "baseFare": baseFare,
        "childFare": childFare,
        "column": column,
        "concession": concession,
        "doubleBirth": doubleBirth,
        "fare": fare,
        "ladiesSeat": ladiesSeat,
        "length": length,
        "levyFare": levyFare,
        "malesSeat": malesSeat,
        "markupFareAbsolute": markupFareAbsolute,
        "markupFarePercentage": markupFarePercentage,
        "name": name,
        "operatorServiceChargeAbsolute": operatorServiceChargeAbsolute,
        "operatorServiceChargePercent": operatorServiceChargePercent,
        "reservedForSocialDistancing": reservedForSocialDistancing,
        "row": row,
        "serviceTaxAbsolute": serviceTaxAbsolute,
        "serviceTaxPercentage": serviceTaxPercentage,
        "srtFee": srtFee,
        "tollFee": tollFee,
        "width": width,
        "zIndex": zIndex,
      };
}
