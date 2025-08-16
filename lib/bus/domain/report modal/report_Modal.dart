// To parse this JSON data, do
//
//     final reports = busTicketReportFromJson(jsonString);

import 'dart:convert';

List<BusTicketReport> busTicketReportFromJson(String str) =>
    List<BusTicketReport>.from(
      json.decode(str).map((x) => BusTicketReport.fromJson(x)),
    );

String busTicketReportToJson(List<BusTicketReport> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BusTicketReport {
  String slNo;
  String date;
  String source;
  String destination;
  String boardingPoint;
  String droppingPoint;
  String ticketNo;
  String blockKey;
  List<SeatDetails> seatDetails;
  String totalFare;
  String status;

  BusTicketReport({
    required this.slNo,
    required this.date,
    required this.source,
    required this.destination,
    required this.boardingPoint,
    required this.droppingPoint,
    required this.ticketNo,
    required this.blockKey,
    required this.seatDetails,
    required this.totalFare,
    required this.status,
  });

  factory BusTicketReport.fromJson(Map<String, dynamic> json) {
    final rawSeatDetails = json['SeatDetails'];
    List<dynamic> seatJsonList = [];

    // Decode stringified SeatDetails JSON array
    if (rawSeatDetails is String && rawSeatDetails.isNotEmpty) {
      try {
        seatJsonList = jsonDecode(rawSeatDetails);
      } catch (_) {}
    }

    final seatDetailsList = seatJsonList
        .map((seat) => SeatDetails.fromJson(seat))
        .toList();

    return BusTicketReport(
      slNo: json['SLNo'] ?? '',
      date: json['date'] ?? '',
      source: json['Source'] ?? '',
      destination: json['Destination'] ?? '',
      boardingPoint: json['Boarding_Point'] ?? '',
      droppingPoint: json['Dropping_Point'] ?? '',
      ticketNo: json['Ticket_No'] ?? '',
      blockKey: json['Block Key'] ?? '',
      seatDetails: List<SeatDetails>.from(seatDetailsList),
      totalFare: json['Total_Fare'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "SLNo": slNo,
    "date": date,
    "Source": source,
    "Destination": destination,
    "Boarding_Point": boardingPoint,
    "Dropping_Point": droppingPoint,
    "Ticket_No": ticketNo,
    "Block Key": blockKey,
    "SeatDetails": jsonEncode(seatDetails.map((x) => x.toJson()).toList()),
    "Total_Fare": totalFare,
    "status": status,
  };
}

class SeatDetails {
  String fare;
  String baseFare;
  String seatName;
  Passenger passenger;
  String ladiesSeat;

  SeatDetails({
    required this.fare,
    required this.baseFare,
    required this.seatName,
    required this.passenger,
    required this.ladiesSeat,
  });

  factory SeatDetails.fromJson(Map<String, dynamic> json) => SeatDetails(
    fare: json['fare'] ?? '',
    baseFare: json['baseFare'] ?? '',
    seatName: json['seatName'] ?? '',
    passenger: Passenger.fromJson(json['passenger'] ?? {}),
    ladiesSeat: json['ladiesSeat'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "fare": fare,
    "baseFare": baseFare,
    "seatName": seatName,
    "passenger": passenger.toJson(),
    "ladiesSeat": ladiesSeat,
  };
}

class Passenger {
  String age;
  String name;
  String email;
  String title;
  String gender;
  String idType;
  String mobile;
  String address;
  String idNumber;
  String primary;

  Passenger({
    required this.age,
    required this.name,
    required this.email,
    required this.title,
    required this.gender,
    required this.idType,
    required this.mobile,
    required this.address,
    required this.idNumber,
    required this.primary,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) => Passenger(
    age: json['age'] ?? '',
    name: json['name'] ?? '',
    email: json['email'] ?? '',
    title: json['title'] ?? '',
    gender: json['gender'] ?? '',
    idType: json['idType'] ?? '',
    mobile: json['mobile'] ?? '',
    address: json['address'] ?? '',
    idNumber: json['idNumber'] ?? '',
    primary: json['primary'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "age": age,
    "name": name,
    "email": email,
    "title": title,
    "gender": gender,
    "idType": idType,
    "mobile": mobile,
    "address": address,
    "idNumber": idNumber,
    "primary": primary,
  };
}
