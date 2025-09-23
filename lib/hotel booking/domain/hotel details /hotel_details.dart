import 'dart:convert';

class HotelDetailsResponse {
  final Status status;
  final List<HotelDetail> hotelDetails;

  HotelDetailsResponse({
    required this.status,
    required this.hotelDetails,
  });

  factory HotelDetailsResponse.fromJson(Map<String, dynamic> json) {
    return HotelDetailsResponse(
      status: Status.fromJson(json['Status'] ?? {}),
      hotelDetails: json['HotelDetails'] != null
          ? List<HotelDetail>.from(
              (json['HotelDetails'] as List<dynamic>)
                  .map((x) => HotelDetail.fromJson(x)),
            )
          : [],
    );
  }

  /// Helper: Parse from raw json string
  static HotelDetailsResponse fromRawJson(String str) =>
      HotelDetailsResponse.fromJson(json.decode(str));

  /// Convert to raw json string
  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "Status": status.toJson(),
        "HotelDetails": List<dynamic>.from(hotelDetails.map((x) => x.toJson())),
      };
}

class Status {
  final int code;
  final String description;

  Status({
    required this.code,
    required this.description,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      code: json['Code'] ?? 0,
      description: json['Description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "Code": code,
        "Description": description,
      };
}

class HotelDetail {
  final String hotelCode;
  final String hotelName;
  final String description;
  final List<String> hotelFacilities;
  final List<String> attractions;
  final List<String> images;
  final String address;
  final String pinCode;
  final String cityId;
  final String countryName;
  final String phoneNumber;
  final String faxNumber;
  final String map;
  final int hotelRating;
  final String cityName;
  final String countryCode;
  final String checkInTime;
  final String checkOutTime;

  HotelDetail({
    required this.hotelCode,
    required this.hotelName,
    required this.description,
    required this.hotelFacilities,
    required this.attractions,
    required this.images,
    required this.address,
    required this.pinCode,
    required this.cityId,
    required this.countryName,
    required this.phoneNumber,
    required this.faxNumber,
    required this.map,
    required this.hotelRating,
    required this.cityName,
    required this.countryCode,
    required this.checkInTime,
    required this.checkOutTime,
  });

  factory HotelDetail.fromJson(Map<String, dynamic> json) {
    return HotelDetail(
      hotelCode: json['HotelCode'] ?? '',
      hotelName: json['HotelName'] ?? '',
      description: json['Description'] ?? '',
      hotelFacilities: json['HotelFacilities'] != null
          ? List<String>.from(json['HotelFacilities'])
          : [],
      attractions: _parseAttractions(json['Attractions']),
      images: json['Images'] != null
          ? List<String>.from(json['Images'])
          : [],
      address: json['Address'] ?? '',
      pinCode: json['PinCode'] ?? '',
      cityId: json['CityId'] ?? '',
      countryName: json['CountryName'] ?? '',
      phoneNumber: json['PhoneNumber'] ?? '',
      faxNumber: json['FaxNumber'] ?? '',
      map: json['Map'] ?? '',
      hotelRating: json['HotelRating'] ?? 0,
      cityName: json['CityName'] ?? '',
      countryCode: json['CountryCode'] ?? '',
      checkInTime: json['CheckInTime'] ?? '',
      checkOutTime: json['CheckOutTime'] ?? '',
    );
  }

  // Helper method to parse attractions safely
  static List<String> _parseAttractions(dynamic attractionsData) {
    if (attractionsData == null) return [];
    
    if (attractionsData is Map) {
      // Check if it's an empty map {}
      if (attractionsData.isEmpty) return [];
      
      // Handle map format like {"1) ": "Chinese Fishing Nets", "2) ": "The Delta Study"}
      final List<String> attractions = [];
      attractionsData.forEach((key, value) {
        if (value is String && value.isNotEmpty) {
          attractions.add(value);
        }
      });
      return attractions;
    }
    
    if (attractionsData is String) {
      // Handle string format (if any)
      return attractionsData.isNotEmpty ? [attractionsData] : [];
    }
    
    return [];
  }

  Map<String, dynamic> toJson() => {
        "HotelCode": hotelCode,
        "HotelName": hotelName,
        "Description": description,
        "HotelFacilities": hotelFacilities,
        "Attractions": attractions.isNotEmpty 
            ? { for (int i = 0; i < attractions.length; i++) "${i + 1}) ": attractions[i] }
            : {},
        "Images": images,
        "Address": address,
        "PinCode": pinCode,
        "CityId": cityId,
        "CountryName": countryName,
        "PhoneNumber": phoneNumber,
        "FaxNumber": faxNumber,
        "Map": map,
        "HotelRating": hotelRating,
        "CityName": cityName,
        "CountryCode": countryCode,
        "CheckInTime": checkInTime,
        "CheckOutTime": checkOutTime,
      };
}