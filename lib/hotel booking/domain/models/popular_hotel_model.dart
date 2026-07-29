class PopularHotel {
  final String hotelCode;
  final String hotelName;
  final String hotelRating;
  final String address;
  final String latitude;
  final String longitude;
  final String cityName;
  final String countryName;
  String image; // mutable — filled in from details API

  PopularHotel({
    required this.hotelCode,
    required this.hotelName,
    required this.hotelRating,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.cityName,
    required this.countryName,
    this.image = '',
  });

  factory PopularHotel.fromJson(Map<String, dynamic> json) {
    return PopularHotel(
      hotelCode: json['hotel_code']?.toString() ?? '',
      hotelName: json['hotel_name']?.toString() ?? '',
      hotelRating: json['hotel_rating']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      latitude: json['latitude']?.toString() ?? '',
      longitude: json['longitude']?.toString() ?? '',
      cityName: json['city_name']?.toString() ?? '',
      countryName: json['country_name']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
    );
  }

  int get starCount {
    switch (hotelRating.toLowerCase()) {
      case 'onestar':
        return 1;
      case 'twostar':
        return 2;
      case 'threestar':
        return 3;
      case 'fourstar':
        return 4;
      case 'fivestar':
        return 5;
      default:
        return 3;
    }
  }
}

class PopularHotelsByCity {
  final String cityName;
  final List<PopularHotel> hotels;

  PopularHotelsByCity({required this.cityName, required this.hotels});
}
