import 'dart:convert';

/// ------------ REQUEST ------------

class PaxRoom {
  final int adults;
  final int children;
  final List<int>? childrenAges;

  PaxRoom({
    required this.adults,
    required this.children,
    this.childrenAges,
  });

  Map<String, dynamic> toJson() {
    return {
      "Adults": adults,
      "Children": children,
      "ChildrenAges": children > 0 ? childrenAges : null,
    };
  }
}

class HotelSearchRequest {
  final String checkIn;
  final String checkOut;
  final String hotelCodes;
  final String guestNationality;
  final List<PaxRoom> paxRooms;
  final double responseTime;
  final bool isDetailedResponse;
  final bool refundable;
  final int noOfRooms;
  final String? mealType;
  final String? starRating;

  HotelSearchRequest({
    required this.checkIn,
    required this.checkOut,
    required this.hotelCodes,
    required this.guestNationality,
    required this.paxRooms,
    this.responseTime = 30.0,
    this.isDetailedResponse = true,
    this.refundable = false,
    this.noOfRooms = 0,
    this.mealType,
    this.starRating,
  });

  Map<String, dynamic> toJson() {
    return {
      "CheckIn": checkIn,
      "CheckOut": checkOut,
      "HotelCodes": hotelCodes,
      "GuestNationality": guestNationality,
      "PaxRooms": paxRooms.map((e) => e.toJson()).toList(),
      "ResponseTime": responseTime,
      "IsDetailedResponse": isDetailedResponse,
      "Filters": {
        "Refundable": refundable,
        "NoOfRooms": noOfRooms,
        "MealType": mealType,
        "StarRating": starRating,
      }
    };
  }

  String encode() => jsonEncode(toJson());
}

/// ------------ RESPONSE ------------

class CancelPolicy {
  final String index;
  final String fromDate;
  final String chargeType;
  final double cancellationCharge;

  CancelPolicy({
    required this.index,
    required this.fromDate,
    required this.chargeType,
    required this.cancellationCharge,
  });

  factory CancelPolicy.fromJson(Map<String, dynamic> json) {
    return CancelPolicy(
      index: json['Index'] ?? '',
      fromDate: json['FromDate'] ?? '',
      chargeType: json['ChargeType'] ?? '',
      cancellationCharge:
          (json['CancellationCharge'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class Room {
  final List<String> name;
  final String bookingCode;
  final String inclusion;
  final List<List<Map<String, dynamic>>> dayRates;
  final double totalFare;
  final double totalTax;
  final List<String> roomPromotion;
  final List<CancelPolicy> cancelPolicies;
  final String mealType;
  final bool isRefundable;

  Room({
    required this.name,
    required this.bookingCode,
    required this.inclusion,
    required this.dayRates,
    required this.totalFare,
    required this.totalTax,
    required this.roomPromotion,
    required this.cancelPolicies,
    required this.mealType,
    required this.isRefundable,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      name: List<String>.from(json['Name'] ?? []),
      bookingCode: json['BookingCode'] ?? '',
      inclusion: json['Inclusion'] ?? '',
      dayRates: (json['DayRates'] as List<dynamic>?)
              ?.map((r) => List<Map<String, dynamic>>.from(r))
              .toList() ??
          [],
      totalFare: (json['TotalFare'] as num?)?.toDouble() ?? 0.0,
      totalTax: (json['TotalTax'] as num?)?.toDouble() ?? 0.0,
      roomPromotion: List<String>.from(json['RoomPromotion'] ?? []),
      cancelPolicies: (json['CancelPolicies'] as List<dynamic>?)
              ?.map((e) => CancelPolicy.fromJson(e))
              .toList() ??
          [],
      mealType: json['MealType'] ?? '',
      isRefundable: json['IsRefundable'] ?? false,
    );
  }
}

class HotelRoomResult {
  final String hotelCode;
  final String currency;
  final List<Room> rooms;

  HotelRoomResult({
    required this.hotelCode,
    required this.currency,
    required this.rooms,
  });

  factory HotelRoomResult.fromJson(Map<String, dynamic> json) {
    return HotelRoomResult(
      hotelCode: json['HotelCode'] ?? '',
      currency: json['Currency'] ?? '',
      rooms: (json['Rooms'] as List<dynamic>?)
              ?.map((e) => Room.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class HotelSearchResponse {
  final int statusCode;
  final String description;
  final List<HotelRoomResult> hotelResult;

  HotelSearchResponse({
    required this.statusCode,
    required this.description,
    required this.hotelResult,
  });

  factory HotelSearchResponse.fromJson(Map<String, dynamic> json) {
    return HotelSearchResponse(
      statusCode: json['Status']?['Code'] ?? 0,
      description: json['Status']?['Description'] ?? '',
      hotelResult: (json['HotelResult'] as List<dynamic>?)
              ?.map((e) => HotelRoomResult.fromJson(e))
              .toList() ??
          [],
    );
  }
}
