// // To parse required this JSON data, do
// //
// //     final modelBusSeats = modelBusSeatsFromJson(jsondynamic);

// import 'dart:convert';

// SeatlayoutModal seatlayoutModalFromJson(dynamic str) =>
//     SeatlayoutModal.fromJson(json.decode(str));

// dynamic modelBusSeatsToJson(SeatlayoutModal data) => json.encode(data.toJson());

// class SeatlayoutModal {
//   SeatlayoutModal({
//     required this.availableSingleSeat,
//     required this.callFareBreakUpApi,
//     // required this.fareDetails,
//     required this.noSeatLayoutAvailableSeats,
//     required this.noSeatLayoutEnabled,
//     required this.primo,
//     required this.seats,
//     required this.vaccinatedBus,
//     required this.vaccinatedStaff,
//   });

//   dynamic availableSingleSeat;
//   dynamic callFareBreakUpApi;
//   // List<FareDetail> fareDetails;
//   dynamic noSeatLayoutAvailableSeats;
//   dynamic noSeatLayoutEnabled;
//   dynamic primo;
//   List<Seats> seats;
//   dynamic vaccinatedBus;
//   dynamic vaccinatedStaff;

//   factory SeatlayoutModal.fromJson(Map<dynamic, dynamic> json) => SeatlayoutModal(
//         availableSingleSeat: json["availableSingleSeat"],
//         callFareBreakUpApi: json["callFareBreakUpAPI"],
//         // fareDetails: List<FareDetail>.from(json["fareDetails"].map((x) => FareDetail.fromJson(x))),
//         noSeatLayoutAvailableSeats: json["noSeatLayoutAvailableSeats"],
//         noSeatLayoutEnabled: json["noSeatLayoutEnabled"],
//         primo: json["primo"],
//         seats: List<Seats>.from(json["seats"].map((x) => Seats.fromJson(x))),
//         vaccinatedBus: json["vaccinatedBus"],
//         vaccinatedStaff: json["vaccinatedStaff"],
//       );

//   Map<dynamic, dynamic> toJson() => {
//         "availableSingleSeat": availableSingleSeat,
//         "callFareBreakUpAPI": callFareBreakUpApi,
//         // "fareDetails": List<dynamic>.from(fareDetails.map((x) => x.toJson())),
//         "noSeatLayoutAvailableSeats": noSeatLayoutAvailableSeats,
//         "noSeatLayoutEnabled": noSeatLayoutEnabled,
//         "primo": primo,
//         "seats": List<dynamic>.from(seats.map((x) => x.toJson())),
//         "vaccinatedBus": vaccinatedBus,
//         "vaccinatedStaff": vaccinatedStaff,
//       };
// }

// class FareDetail {
//   FareDetail({
//     required this.bankTrexAmt,
//     required this.baseFare,
//     required this.bookingFee,
//     required this.childFare,
//     required this.gst,
//     required this.levyFare,
//     required this.markupFareAbsolute,
//     required this.markupFarePercentage,
//     required this.opFare,
//     required this.opGroupFare,
//     required this.operatorServiceChargeAbsolute,
//     required this.operatorServiceChargePercentage,
//     required this.serviceCharge,
//     required this.serviceTaxAbsolute,
//     required this.serviceTaxPercentage,
//     required this.srtFee,
//     required this.tollFee,
//     required this.totalFare,
//   });

//   dynamic bankTrexAmt;
//   dynamic baseFare;
//   dynamic bookingFee;
//   dynamic childFare;
//   dynamic gst;
//   dynamic levyFare;
//   dynamic markupFareAbsolute;
//   dynamic markupFarePercentage;
//   dynamic opFare;
//   dynamic opGroupFare;
//   dynamic operatorServiceChargeAbsolute;
//   dynamic operatorServiceChargePercentage;
//   dynamic serviceCharge;
//   dynamic serviceTaxAbsolute;
//   dynamic serviceTaxPercentage;
//   dynamic srtFee;
//   dynamic tollFee;
//   dynamic totalFare;

//   factory FareDetail.fromJson(Map<dynamic, dynamic> json) => FareDetail(
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

//   Map<dynamic, dynamic> toJson() => {
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

// class Seats {
//   Seats({
//     required this.available,
//     required this.bankTrexAmt,
//     required this.baseFare,
//     required this.childFare,
//     required this.column,
//     required this.concession,
//     required this.doubleBirth,
//     required this.fare,
//     required this.ladiesSeat,
//     required this.length,
//     required this.levyFare,
//     required this.malesSeat,
//     required this.markupFareAbsolute,
//     required this.markupFarePercentage,
//     required this.name,
//     required this.operatorServiceChargeAbsolute,
//     required this.operatorServiceChargePercent,
//     required this.reservedForSocialDistancing,
//     required this.row,
//     required this.serviceTaxAbsolute,
//     required this.serviceTaxPercentage,
//     required this.srtFee,
//     required this.tollFee,
//     required this.width,
//     required this.zIndex,
//   });

//   dynamic available;
//   dynamic bankTrexAmt;
//   dynamic baseFare;
//   dynamic childFare;
//   dynamic column;
//   dynamic concession;
//   dynamic doubleBirth;
//   dynamic fare;
//   dynamic ladiesSeat;
//   dynamic length;
//   dynamic levyFare;
//   dynamic malesSeat;
//   dynamic markupFareAbsolute;
//   dynamic markupFarePercentage;
//   dynamic name;
//   dynamic operatorServiceChargeAbsolute;
//   dynamic operatorServiceChargePercent;
//   dynamic reservedForSocialDistancing;
//   dynamic row;
//   dynamic serviceTaxAbsolute;
//   dynamic serviceTaxPercentage;
//   dynamic srtFee;
//   dynamic tollFee;
//   dynamic width;
//   dynamic zIndex;

//   factory Seats.fromJson(Map<dynamic, dynamic> json) => Seats(
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

//   Map<dynamic, dynamic> toJson() => {
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
import 'dart:developer';

class BusSeatModel {
  final String availableSeats;
  final String availableSingleSeat;
  final List<BoardingTime> boardingTimes;
  final String callFareBreakUpAPI;
  final DroppingTime droppingTimes;
  final FareDetails fareDetails;
  final String forcedSeats;
  final String isAggregator;
  final String maxSeatsPerTicket;
  final String noSeatLayoutEnabled;
  final String primo;
  final List<Seat> seats;
  final String vaccinatedBus;
  final String vaccinatedStaff;

  BusSeatModel({
    required this.availableSeats,
    required this.availableSingleSeat,
    required this.boardingTimes,
    required this.callFareBreakUpAPI,
    required this.droppingTimes,
    required this.fareDetails,
    required this.forcedSeats,
    required this.isAggregator,
    required this.maxSeatsPerTicket,
    required this.noSeatLayoutEnabled,
    required this.primo,
    required this.seats,
    required this.vaccinatedBus,
    required this.vaccinatedStaff,
  });

  factory BusSeatModel.fromJson(Map<String, dynamic> json) {
    try {
      // Safely parse boardingTimes
      final boardingTimes =
          (json['boardingTimes'] is List)
              ? List<BoardingTime>.from(
                (json['boardingTimes'] as List).map(
                  (e) => BoardingTime.fromJson(e as Map<String, dynamic>),
                ),
              )
              : <BoardingTime>[];

      // Safely parse seats
      final seats =
          (json['seats'] is List)
              ? List<Seat>.from(
                (json['seats'] as List).map(
                  (e) => Seat.fromJson(e as Map<String, dynamic>),
                ),
              )
              : <Seat>[];

      // Safely parse droppingTimes
      final droppingTimes =
          (json['droppingTimes'] is Map)
              ? DroppingTime.fromJson(
                json['droppingTimes'] as Map<String, dynamic>,
              )
              : DroppingTime.fromJson({});

      // Safely parse fareDetails
      final fareDetails =
          (json['fareDetails'] is Map)
              ? FareDetails.fromJson(
                json['fareDetails'] as Map<String, dynamic>,
              )
              : FareDetails.fromJson({});

      return BusSeatModel(
        availableSeats: json['availableSeats']?.toString() ?? '0',
        availableSingleSeat: json['availableSingleSeat']?.toString() ?? '0',
        boardingTimes: boardingTimes,
        callFareBreakUpAPI: json['callFareBreakUpAPI']?.toString() ?? 'false',
        droppingTimes: droppingTimes,
        fareDetails: fareDetails,
        forcedSeats: json['forcedSeats']?.toString() ?? '',
        isAggregator: json['isAggregator']?.toString() ?? '0',
        maxSeatsPerTicket: json['maxSeatsPerTicket']?.toString() ?? '6',
        noSeatLayoutEnabled: json['noSeatLayoutEnabled']?.toString() ?? 'false',
        primo: json['primo']?.toString() ?? 'false',
        seats: seats,
        vaccinatedBus: json['vaccinatedBus']?.toString() ?? 'false',
        vaccinatedStaff: json['vaccinatedStaff']?.toString() ?? 'false',
      );
    } catch (e, stackTrace) {
      log('Error in BusSeatModel.fromJson: $e');
      log('Stack trace: $stackTrace');
      rethrow;
    }
  }

  static List<BoardingTime> parseBoardingTimes(dynamic data) {
    if (data is List) {
      return data
          .map((e) => BoardingTime.fromJson(e as Map<String, dynamic>? ?? {}))
          .toList();
    }
    return <BoardingTime>[];
  }

  static List<Seat> parseSeats(dynamic data) {
    if (data is List) {
      return data
          .map((e) => Seat.fromJson(e as Map<String, dynamic>? ?? {}))
          .toList();
    }
    return <Seat>[];
  }
}

class BoardingTime {
  final String address;
  final String bpId;
  final String bpName;
  final String city;
  final String cityId;
  final String contactNumber;
  final String landmark;
  final String location;
  final String locationId;
  final String prime;
  final String time;

  BoardingTime({
    required this.address,
    required this.bpId,
    required this.bpName,
    required this.city,
    required this.cityId,
    required this.contactNumber,
    required this.landmark,
    required this.location,
    required this.locationId,
    required this.prime,
    required this.time,
  });

  factory BoardingTime.fromJson(Map<String, dynamic> json) {
    return BoardingTime(
      address: json['address']?.toString() ?? '',
      bpId: json['bpId']?.toString() ?? '',
      bpName: json['bpName']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      cityId: json['cityId']?.toString() ?? '',
      contactNumber: json['contactNumber']?.toString() ?? '',
      landmark: json['landmark']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      locationId: json['locationId']?.toString() ?? '',
      prime: json['prime']?.toString() ?? 'false',
      time: json['time']?.toString() ?? '',
    );
  }
}

class DroppingTime {
  final String address;
  final String bpId;
  final String bpName;
  final String city;
  final String cityId;
  final String contactNumber;
  final String landmark;
  final String location;
  final String locationId;
  final String prime;
  final String time;

  DroppingTime({
    required this.address,
    required this.bpId,
    required this.bpName,
    required this.city,
    required this.cityId,
    required this.contactNumber,
    required this.landmark,
    required this.location,
    required this.locationId,
    required this.prime,
    required this.time,
  });

  factory DroppingTime.fromJson(Map<String, dynamic> json) {
    return DroppingTime(
      address: json['address']?.toString() ?? '',
      bpId: json['bpId']?.toString() ?? '',
      bpName: json['bpName']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      cityId: json['cityId']?.toString() ?? '',
      contactNumber: json['contactNumber']?.toString() ?? '',
      landmark: json['landmark']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      locationId: json['locationId']?.toString() ?? '',
      prime: json['prime']?.toString() ?? 'false',
      time: json['time']?.toString() ?? '',
    );
  }
}

class FareDetails {
  final String bankTrexAmt;
  final String baseFare;
  final String bookingFee;
  final String childFare;
  final String gst;
  final String levyFare;
  final String markupFareAbsolute;
  final String markupFarePercentage;
  final String opFare;
  final String opGroupFare;
  final String operatorServiceChargeAbsolute;
  final String operatorServiceChargePercentage;
  final String serviceCharge;
  final String serviceTaxAbsolute;
  final String serviceTaxPercentage;
  final String srtFee;
  final String tollFee;
  final String totalFare;

  FareDetails({
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

  factory FareDetails.fromJson(Map<String, dynamic> json) {
    return FareDetails(
      bankTrexAmt: json['bankTrexAmt']?.toString() ?? '0',
      baseFare: json['baseFare']?.toString() ?? '0.00',
      bookingFee: json['bookingFee']?.toString() ?? '0',
      childFare: json['childFare']?.toString() ?? '0',
      gst: json['gst']?.toString() ?? '0',
      levyFare: json['levyFare']?.toString() ?? '0',
      markupFareAbsolute: json['markupFareAbsolute']?.toString() ?? '0',
      markupFarePercentage: json['markupFarePercentage']?.toString() ?? '0',
      opFare: json['opFare']?.toString() ?? '0',
      opGroupFare: json['opGroupFare']?.toString() ?? '0',
      operatorServiceChargeAbsolute:
          json['operatorServiceChargeAbsolute']?.toString() ?? '0.00',
      operatorServiceChargePercentage:
          json['operatorServiceChargePercentage']?.toString() ?? '0.00',
      serviceCharge: json['serviceCharge']?.toString() ?? '0.00',
      serviceTaxAbsolute: json['serviceTaxAbsolute']?.toString() ?? '0.00',
      serviceTaxPercentage: json['serviceTaxPercentage']?.toString() ?? '0',
      srtFee: json['srtFee']?.toString() ?? '0',
      tollFee: json['tollFee']?.toString() ?? '0',
      totalFare: json['totalFare']?.toString() ?? '0.00',
    );
  }
}

class Seat {
  final String available;
  final String baseFare;
  final String column;
  final String doubleBirth;
  final String fare;
  final String ladiesSeat;
  final String length;
  final String malesSeat;
  final String markupFareAbsolute;
  final String markupFarePercentage;
  final String name;
  final String operatorServiceChargeAbsolute;
  final String operatorServiceChargePercent;
  final String reservedForSocialDistancing;
  final String row;
  final String serviceTaxAbsolute;
  final String serviceTaxPercentage;
  final String width;
  final String window;
  final String zIndex;

  Seat({
    required this.available,
    required this.baseFare,
    required this.column,
    required this.doubleBirth,
    required this.fare,
    required this.ladiesSeat,
    required this.length,
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
    required this.width,
    required this.window,
    required this.zIndex,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      available: json['available']?.toString() ?? 'false',
      baseFare: json['baseFare']?.toString() ?? '0.00',
      column: json['column']?.toString() ?? '0',
      doubleBirth: json['doubleBirth']?.toString() ?? 'false',
      fare: json['fare']?.toString() ?? '0.00',
      ladiesSeat: json['ladiesSeat']?.toString() ?? 'false',
      length: json['length']?.toString() ?? '1',
      malesSeat: json['malesSeat']?.toString() ?? 'false',
      markupFareAbsolute: json['markupFareAbsolute']?.toString() ?? '0.00',
      markupFarePercentage: json['markupFarePercentage']?.toString() ?? '0',
      name: json['name']?.toString() ?? '',
      operatorServiceChargeAbsolute:
          json['operatorServiceChargeAbsolute']?.toString() ?? '0.00',
      operatorServiceChargePercent:
          json['operatorServiceChargePercent']?.toString() ?? '0.00',
      reservedForSocialDistancing:
          json['reservedForSocialDistancing']?.toString() ?? 'false',
      row: json['row']?.toString() ?? '0',
      serviceTaxAbsolute: json['serviceTaxAbsolute']?.toString() ?? '0.00',
      serviceTaxPercentage: json['serviceTaxPercentage']?.toString() ?? '0',
      width: json['width']?.toString() ?? '1',
      window: json['window']?.toString() ?? 'false',
      zIndex: json['zIndex']?.toString() ?? '0',
    );
  }
}
