



class HotelCityHotel {
  final String code;
  final String name;

  HotelCityHotel({required this.code, required this.name});

  factory HotelCityHotel.fromJson(Map<String, dynamic> json) {
    return HotelCityHotel(
      code: json['Code'] ?? '',
      name: json['Name'] ?? '',
    );
  }
}