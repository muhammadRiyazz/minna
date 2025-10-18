// models/report_model.dart
import 'dart:convert';
import 'dart:developer';

class ReportResponse {
  final String status;
  final int statusCode;
  final String statusDesc;
  final List<ReportData>? data;

  ReportResponse({
    required this.status,
    required this.statusCode,
    required this.statusDesc,
    this.data,
  });

  factory ReportResponse.fromJson(Map<String, dynamic> json) {
    return ReportResponse(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      statusDesc: json['statusDesc'] ?? '',
      data: json['data'] != null
          ? List<ReportData>.from(
              json['data'].map((x) => ReportData.fromJson(x)))
          : null,
    );
  }
}

class ReportData {
  final String id;
  final String? alhindPnr;
  final String amount;
  final String createdDate;
  final String createdTime;
  final ResponseData? response;

  ReportData({
    required this.id,
    required this.alhindPnr,
    required this.amount,
    required this.createdDate,
    required this.createdTime,
    required this.response,
  });

  factory ReportData.fromJson(Map<String, dynamic> json) {
    // Parse the response field if it's a string
    dynamic responseData = json['response'];
    ResponseData? parsedResponse;
    
    if (responseData != null && responseData is String && responseData.isNotEmpty) {
      try {
        final responseJson =jsonDecode (responseData);
        parsedResponse = ResponseData.fromJson(responseJson);
      } catch (e) {
        log('Error parsing response JSON: $e');
        parsedResponse = null;
      }
    } else if (responseData != null && responseData is Map<String, dynamic>) {
      parsedResponse = ResponseData.fromJson(responseData);
    }

    return ReportData(
      id: json['id']?.toString() ?? '',
      alhindPnr: json['AlhindPnr']?.toString(),
      amount: json['Amount']?.toString() ?? '',
      createdDate: json['created_date']?.toString() ?? '',
      createdTime: json['created_time']?.toString() ?? '',
      response: parsedResponse,
    );
  }
}

class ResponseData {
  final String alhindPnr;
  final String tripMode;
  final ReportJourney journey;
  final List<ReportPassenger> passengers;
  final String currency;

  ResponseData({
    required this.alhindPnr,
    required this.tripMode,
    required this.journey,
    required this.passengers,
    required this.currency,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      alhindPnr: json['AlhindPnr']?.toString() ?? '',
      tripMode: json['TripMode']?.toString() ?? '',
      journey: ReportJourney.fromJson(json['Journy'] ?? {}),
      passengers: json['Passengers'] != null
          ? List<ReportPassenger>.from(
              (json['Passengers'] as List).map((x) => ReportPassenger.fromJson(x)))
          : [],
      currency: json['Currency']?.toString() ?? 'INR',
    );
  }
}

class ReportJourney {
  final List<dynamic> flightOptions;
  final ReportFlightOption flightOption;

  ReportJourney({
    required this.flightOptions,
    required this.flightOption,
  });

  factory ReportJourney.fromJson(Map<String, dynamic> json) {
    return ReportJourney(
      flightOptions: json['FlightOptions'] ?? [],
      flightOption: ReportFlightOption.fromJson(json['FlightOption'] ?? {}),
    );
  }
}

class ReportFlightOption {
  final String key;
  final String ticketingCarrier;
  final String apiType;
  final List<ReportFlightFare> flightFares;
  final List<ReportFlightLeg> flightLegs;

  ReportFlightOption({
    required this.key,
    required this.ticketingCarrier,
    required this.apiType,
    required this.flightFares,
    required this.flightLegs,
  });

  factory ReportFlightOption.fromJson(Map<String, dynamic> json) {
    return ReportFlightOption(
      key: json['Key']?.toString() ?? '',
      ticketingCarrier: json['TicketingCarrier']?.toString() ?? '',
      apiType: json['ApiType']?.toString() ?? '',
      flightFares: json['FlightFares'] != null
          ? List<ReportFlightFare>.from(
              (json['FlightFares'] as List).map((x) => ReportFlightFare.fromJson(x)))
          : [],
      flightLegs: json['FlightLegs'] != null
          ? List<ReportFlightLeg>.from(
              (json['FlightLegs'] as List).map((x) => ReportFlightLeg.fromJson(x)))
          : [],
    );
  }
}

class ReportFlightFare {
  final List<ReportFare> fares;
  final String fid;
  final double aprxTotalBaseFare;
  final double aprxTotalTax;
  final double totalDiscount;
  final double totalAmount;

  ReportFlightFare({
    required this.fares,
    required this.fid,
    required this.aprxTotalBaseFare,
    required this.aprxTotalTax,
    required this.totalDiscount,
    required this.totalAmount,
  });

  factory ReportFlightFare.fromJson(Map<String, dynamic> json) {
    return ReportFlightFare(
      fares: json['Fares'] != null
          ? List<ReportFare>.from(
              (json['Fares'] as List).map((x) => ReportFare.fromJson(x)))
          : [],
      fid: json['FID']?.toString() ?? '',
      aprxTotalBaseFare: (json['AprxTotalBaseFare'] ?? 0).toDouble(),
      aprxTotalTax: (json['AprxTotalTax'] ?? 0).toDouble(),
      totalDiscount: (json['TotalDiscount'] ?? 0).toDouble(),
      totalAmount: (json['TotalAmount'] ?? 0).toDouble(),
    );
  }
}

class ReportFare {
  final String ptc;
  final double baseFare;
  final double tax;
  final double discount;
  final List<dynamic> splitup;

  ReportFare({
    required this.ptc,
    required this.baseFare,
    required this.tax,
    required this.discount,
    required this.splitup,
  });

  factory ReportFare.fromJson(Map<String, dynamic> json) {
    return ReportFare(
      ptc: json['PTC']?.toString() ?? '',
      baseFare: (json['BaseFare'] ?? 0).toDouble(),
      tax: (json['Tax'] ?? 0).toDouble(),
      discount: (json['Discount'] ?? 0).toDouble(),
      splitup: json['Splitup'] ?? [],
    );
  }
}

class ReportFlightLeg {
  final String type;
  final String airlinePNR;
  final String origin;
  final String destination;
  final String departureTime;
  final String arrivalTime;
  final String flightNo;
  final String airlineCode;

  ReportFlightLeg({
    required this.type,
    required this.airlinePNR,
    required this.origin,
    required this.destination,
    required this.departureTime,
    required this.arrivalTime,
    required this.flightNo,
    required this.airlineCode,
  });

  factory ReportFlightLeg.fromJson(Map<String, dynamic> json) {
    return ReportFlightLeg(
      type: json['Type']?.toString() ?? '',
      airlinePNR: json['AirlinePNR']?.toString() ?? '',
      origin: json['Origin']?.toString() ?? '',
      destination: json['Destination']?.toString() ?? '',
      departureTime: json['DepartureTime']?.toString() ?? '',
      arrivalTime: json['ArrivalTime']?.toString() ?? '',
      flightNo: json['FlightNo']?.toString() ?? '',
      airlineCode: json['AirlineCode']?.toString() ?? '',
    );
  }
}

class ReportPassenger {
  final String paxType;
  final String title;
  final String firstName;
  final String lastName;
  final String dob;
  final String contact;
  final String email;
  final String passportNo;
  final String ticketNo;

  ReportPassenger({
    required this.paxType,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.contact,
    required this.email,
    required this.passportNo,
    required this.ticketNo,
  });

  factory ReportPassenger.fromJson(Map<String, dynamic> json) {
    return ReportPassenger(
      paxType: json['PaxType']?.toString() ?? '',
      title: json['Title']?.toString() ?? '',
      firstName: json['FirstName']?.toString() ?? '',
      lastName: json['LastName']?.toString() ?? '',
      dob: json['DOB']?.toString() ?? '',
      contact: json['Contact']?.toString() ?? '',
      email: json['Email']?.toString() ?? '',
      passportNo: json['PassportNo']?.toString() ?? '',
      ticketNo: json['TicketNo']?.toString() ?? '',
    );
  }
}