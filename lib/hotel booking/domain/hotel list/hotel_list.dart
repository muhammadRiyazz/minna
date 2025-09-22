class HotelResponse {
  final Status status;
  final List<Hotel> hotels;

  HotelResponse({required this.status, required this.hotels});

  factory HotelResponse.fromJson(Map<String, dynamic> json) {
    return HotelResponse(
      status: Status.fromJson(json['Status']),
      hotels: (json['Hotels'] as List<dynamic>)
          .map((e) => Hotel.fromJson(e))
          .toList(),
    );
  }
}

class Status {
  final int code;
  final String description;

  Status({required this.code, required this.description});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      code: json['Code'],
      description: json['Description'],
    );
  }
}

class Hotel {
  final String hotelCode;
  final String hotelName;
  final String latitude;
  final String longitude;
  final String hotelRating;
  final String address;
  final String countryName;
  final String cityName;

  Hotel({
    required this.hotelCode,
    required this.hotelName,
    required this.latitude,
    required this.longitude,
    required this.hotelRating,
    required this.address,
    required this.countryName,
    required this.cityName,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      hotelCode: json['HotelCode'],
      hotelName: json['HotelName'],
      latitude: json['Latitude'],
      longitude: json['Longitude'],
      hotelRating: json['HotelRating'],
      address: json['Address'],
      countryName: json['CountryName'],
      cityName: json['CityName'],
    );
  }
}
