import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:minna/comman/core/api.dart';
import 'package:minna/hotel%20booking/domain/models/popular_hotel_model.dart';

class PopularHotelsService {
  Future<List<PopularHotelsByCity>> fetchPopularHotels() async {
    try {
      final response = await http.get(
        Uri.parse('${baseUrltest1}popular-hotels'),
      );
      log('Popular Hotels Response: ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        if (body['status'] == true && body['data'] != null) {
          final Map<String, dynamic> data =
              body['data'] as Map<String, dynamic>;
          final List<PopularHotelsByCity> result = [];
          data.forEach((city, hotelsJson) {
            final List<PopularHotel> hotels =
                (hotelsJson as List)
                    .map((h) => PopularHotel.fromJson(h as Map<String, dynamic>))
                    .toList();
            result.add(PopularHotelsByCity(cityName: city, hotels: hotels));
          });
          return result;
        }
      }
      return [];
    } catch (e) {
      log('Error fetching popular hotels: $e');
      return [];
    }
  }
}
