// lib/hotel booking/functions/get_hotel_details.dart
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:minna/hotel%20booking/core/core.dart';
import 'package:minna/hotel%20booking/domain/hotel%20details%20/hotel_details.dart';

class HotelDetailsApiService {
  static const String baseUrl = 'http://api.tbotechnology.in/TBOHolidays_HotelAPI/Hoteldetails';
  String get _basicAuth => 'Basic ${base64Encode(utf8.encode('$hotelusername:$hoteluserpass'))}';

  Future<HotelDetailsResponse> fetchHotelDetails(String hotelCode) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
                    'Authorization': _basicAuth,

          'Content-Type': 'application/json',
        },
        body: json.encode({
        'Hotelcodes': 1124503,
          // 'Hotelcodes': hotelCode,
          'Language': 'EN'
        }),      
      );


      log(json.encode({
          'Hotelcodes': hotelCode,
          'Language': 'EN'
        }).toString());

log(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return HotelDetailsResponse.fromJson(data);
      } else {
        throw Exception('Failed to load hotel details: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to load hotel details: $e');
    }
  }
}