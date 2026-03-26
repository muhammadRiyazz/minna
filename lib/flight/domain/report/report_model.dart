// models/report_model.dart
import 'dart:convert';
import 'dart:developer';

class ReportResponse {
  final bool status;
  final String message;
  final ReportDataWrapper? data;

  ReportResponse({required this.status, required this.message, this.data});

  factory ReportResponse.fromJson(Map<String, dynamic> json) {
    return ReportResponse(
      status: json['status'] == true, // Handle bool directly
      message: json['message']?.toString() ?? '',
      data: json['data'] != null
          ? ReportDataWrapper.fromJson(json['data'])
          : null,
    );
  }
}

class ReportDataWrapper {
  final int totalRecords;
  final List<ReportData> bookings;

  ReportDataWrapper({required this.totalRecords, required this.bookings});

  factory ReportDataWrapper.fromJson(Map<String, dynamic> json) {
    return ReportDataWrapper(
      totalRecords: json['total_records'] ?? 0,
      bookings: json['bookings'] != null
          ? List<ReportData>.from(
              (json['bookings'] as List).map((x) => ReportData.fromJson(x)),
            )
          : [],
    );
  }
}

class ReportData {
  final String bookingId;
  final String? pnr;
  final String bookingStatus;
  final String paymentStatus;
  final String? paymentId;
  final String? orderId;
  final String amount;
  final String totalAmount;
  final String commission;
  final ResponseData? response;

  ReportData({
    required this.bookingId,
    required this.pnr,
    required this.bookingStatus,
    required this.paymentStatus,
    required this.paymentId,
    required this.orderId,
    required this.amount,
    required this.totalAmount,
    required this.commission,
    this.response,
  });

  factory ReportData.fromJson(Map<String, dynamic> json) {
    // Parse the flight_response field if it's a string
    dynamic responseData = json['flight_response'];
    ResponseData? parsedResponse;

    if (responseData != null &&
        responseData is String &&
        responseData.isNotEmpty) {
      try {
        final responseJson = jsonDecode(responseData);
        parsedResponse = ResponseData.fromJson(responseJson);
      } catch (e) {
        log('Error parsing response JSON: $e');
        parsedResponse = null;
      }
    } else if (responseData != null && responseData is Map<String, dynamic>) {
      parsedResponse = ResponseData.fromJson(responseData);
    }

    return ReportData(
      bookingId: json['booking_id']?.toString() ?? '',
      pnr: json['pnr']?.toString(),
      bookingStatus: json['booking_status']?.toString() ?? '',
      paymentStatus: json['payment_status']?.toString() ?? '',
      paymentId: json['payment_id']?.toString(),
      orderId: json['order_id']?.toString(),
      amount: json['amount']?.toString() ?? '',
      totalAmount: json['total_amount']?.toString() ?? '',
      commission: json['commission']?.toString() ?? '',
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
              (json['Passengers'] as List).map(
                (x) => ReportPassenger.fromJson(x),
              ),
            )
          : [],
      currency: json['Currency']?.toString() ?? 'INR',
    );
  }
}

class ReportJourney {
  final List<dynamic> flightOptions;
  final ReportFlightOption flightOption;

  ReportJourney({required this.flightOptions, required this.flightOption});

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
              (json['FlightFares'] as List).map(
                (x) => ReportFlightFare.fromJson(x),
              ),
            )
          : [],
      flightLegs: json['FlightLegs'] != null
          ? List<ReportFlightLeg>.from(
              (json['FlightLegs'] as List).map(
                (x) => ReportFlightLeg.fromJson(x),
              ),
            )
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
              (json['Fares'] as List).map((x) => ReportFare.fromJson(x)),
            )
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

// Updated ReportPassenger class with SSR information
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
  final ReportSsrAvailability? ssrAvailability;

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
    this.ssrAvailability,
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
      ssrAvailability: json['SSRAvailability'] != null
          ? ReportSsrAvailability.fromJson(json['SSRAvailability'])
          : null,
    );
  }
}

// New classes for SSR (Additional Services)
class ReportSsrAvailability {
  final List<ReportMealInfo>? mealInfo;
  final List<ReportBaggageInfo>? baggageInfo;
  final List<ReportSeatInfo>? seatInfo;

  ReportSsrAvailability({this.mealInfo, this.baggageInfo, this.seatInfo});

  factory ReportSsrAvailability.fromJson(Map<String, dynamic> json) {
    return ReportSsrAvailability(
      mealInfo: json['MealInfo'] != null
          ? List<ReportMealInfo>.from(
              (json['MealInfo'] as List).map((x) => ReportMealInfo.fromJson(x)),
            )
          : null,
      baggageInfo: json['BaggageInfo'] != null
          ? List<ReportBaggageInfo>.from(
              (json['BaggageInfo'] as List).map(
                (x) => ReportBaggageInfo.fromJson(x),
              ),
            )
          : null,
      seatInfo: json['SeatInfo'] != null
          ? List<ReportSeatInfo>.from(
              (json['SeatInfo'] as List).map((x) => ReportSeatInfo.fromJson(x)),
            )
          : null,
    );
  }
}

class ReportMealInfo {
  final dynamic mealKey;
  final dynamic tripMode;
  final List<ReportMeal>? meals;

  ReportMealInfo({this.mealKey, this.tripMode, this.meals});

  factory ReportMealInfo.fromJson(Map<String, dynamic> json) {
    return ReportMealInfo(
      mealKey: json['MealKey'],
      tripMode: json['TripMode'],
      meals: json['Meals'] != null
          ? List<ReportMeal>.from(
              (json['Meals'] as List).map((x) => ReportMeal.fromJson(x)),
            )
          : null,
    );
  }
}

class ReportMeal {
  final dynamic ptc;
  final String? code;
  final String? name;
  final double? amount;
  final String? currency;
  final String? legKey;

  ReportMeal({
    this.ptc,
    this.code,
    this.name,
    this.amount,
    this.currency,
    this.legKey,
  });

  factory ReportMeal.fromJson(Map<String, dynamic> json) {
    return ReportMeal(
      ptc: json['PTC'],
      code: json['Code']?.toString(),
      name: json['Name']?.toString(),
      amount: (json['Amount'] ?? 0).toDouble(),
      currency: json['Currency']?.toString(),
      legKey: json['LegKey']?.toString(),
    );
  }
}

class ReportBaggageInfo {
  final dynamic tripMode;
  final dynamic baggageKey;
  final List<ReportBaggage>? baggages;

  ReportBaggageInfo({this.tripMode, this.baggageKey, this.baggages});

  factory ReportBaggageInfo.fromJson(Map<String, dynamic> json) {
    return ReportBaggageInfo(
      tripMode: json['TripMode'],
      baggageKey: json['BaggageKey'],
      baggages: json['Baggages'] != null
          ? List<ReportBaggage>.from(
              (json['Baggages'] as List).map((x) => ReportBaggage.fromJson(x)),
            )
          : null,
    );
  }
}

class ReportBaggage {
  final dynamic ptc;
  final String? code;
  final String? name;
  final dynamic weight;
  final double? amount;
  final String? currency;
  final String? legKey;

  ReportBaggage({
    this.ptc,
    this.code,
    this.name,
    this.weight,
    this.amount,
    this.currency,
    this.legKey,
  });

  factory ReportBaggage.fromJson(Map<String, dynamic> json) {
    return ReportBaggage(
      ptc: json['PTC'],
      code: json['Code']?.toString(),
      name: json['Name']?.toString(),
      weight: json['Weight'],
      amount: (json['Amount'] ?? 0).toDouble(),
      currency: json['Currency']?.toString(),
      legKey: json['LegKey']?.toString(),
    );
  }
}

class ReportSeatInfo {
  final List<ReportSeat>? seats;

  ReportSeatInfo({this.seats});

  factory ReportSeatInfo.fromJson(Map<String, dynamic> json) {
    return ReportSeatInfo(
      seats: json['Seats'] != null
          ? List<ReportSeat>.from(
              (json['Seats'] as List).map((x) => ReportSeat.fromJson(x)),
            )
          : null,
    );
  }
}

class ReportSeat {
  final String? ptc;
  final String? seatKey;
  final String? legKey;
  final String? fare;
  final dynamic currency;

  ReportSeat({this.ptc, this.seatKey, this.legKey, this.fare, this.currency});

  factory ReportSeat.fromJson(Map<String, dynamic> json) {
    return ReportSeat(
      ptc: json['PTC']?.toString(),
      seatKey: json['SeatKey']?.toString(),
      legKey: json['LegKey']?.toString(),
      fare: json['Fare']?.toString(),
      currency: json['Currency'],
    );
  }
}
