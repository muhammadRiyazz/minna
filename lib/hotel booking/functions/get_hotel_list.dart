import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:minna/hotel%20booking/core/core.dart';
import 'package:minna/hotel%20booking/domain/hotel%20list/hotel_list.dart' show Hotel, HotelResponse;

class HotelApiService {
  final String baseUrl =
      'http://api.tbotechnology.in/TBOHolidays_HotelAPI/TBOHotelCodeList';
  String get _basicAuth => 'Basic ${base64Encode(utf8.encode('$hotelusername:$hoteluserpass'))}';

  Future<List<Hotel>> fetchHotels(String cityCode) async {
    final response = await http.post(
      Uri.parse(baseUrl),
 headers: {
          'Authorization': _basicAuth,
          'Content-Type': 'application/json',
        },      body: jsonEncode({"CityCode": cityCode}),
    );
log(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final hotelResponse = HotelResponse.fromJson(data);
      if (hotelResponse.status.code == 200) {
        return hotelResponse.hotels;
      } else {
        throw Exception('API Error: ${hotelResponse.status.description}');
      }
    } else {
      throw Exception('Failed to fetch hotels');
    }
  }
}
