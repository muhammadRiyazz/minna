// lib/hotel booking/domain/hotel details/hotel_details.dart
class HotelDetailsResponse {
  final Status status;
  final List<HotelDetail> hotelDetails;

  HotelDetailsResponse({
    required this.status,
    required this.hotelDetails,
  });

  factory HotelDetailsResponse.fromJson(Map<String, dynamic> json) {
    return HotelDetailsResponse(
      status: Status.fromJson(json['Status']),
      hotelDetails: List<HotelDetail>.from(
          json['HotelDetails'].map((x) => HotelDetail.fromJson(x))),
    );
  }
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
      code: json['Code'],
      description: json['Description'],
    );
  }
}

class HotelDetail {
  final String hotelCode;
  final String hotelName;
  final String description;
  final List<String> hotelFacilities;
  final String attractions;
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
      hotelFacilities: List<String>.from(json['HotelFacilities'] ?? []),
      attractions: json['Attractions'] is String 
          ? json['Attractions'] 
          : json['Attractions']?.toString() ?? '',
      images: List<String>.from(json['Images'] ?? []),
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
}