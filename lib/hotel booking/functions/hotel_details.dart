import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:minna/comman/core/api.dart';
import 'package:minna/hotel%20booking/domain/hotel%20details%20/hotel_details.dart';

class HotelDetailsApiService {
  Future<HotelDetailsResponse> fetchHotelDetails(String hotelCode) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/hotel-api-call-basic'),
        body: {
          'url': 'Hoteldetails',
          'isLive': '0',
          'datas': json.encode({
            'Hotelcodes': hotelCode,
            'Language': 'EN',
            'IsRoomDetailRequired': true,
          }),
        },
      );

      log(
        'Hotel Details Callback Body: ${json.encode({'Hotelcodes': hotelCode, 'Language': 'EN'})}',
      );

      log('Hotel Details Callback Response: ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final data = responseData['data'];

        if (data != null) {
          return HotelDetailsResponse.fromJson(data);
        } else {
          throw Exception(
            'Failed to load hotel details: Response data is null',
          );
        }
      } else {
        throw Exception('Failed to load hotel details: ${response.statusCode}');
      }
    } catch (e) {
      log('Error in fetchHotelDetails: ${e.toString()}');
      throw Exception('Failed to load hotel details: $e');
    }
  }
}
