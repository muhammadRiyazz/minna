import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:minna/comman/core/api.dart'; // import baseUrl and liveOrStage
import 'package:minna/hotel%20booking/domain/hotel%20list/hotel_list.dart' show Hotel, HotelResponse;

class HotelApiService {
  Future<List<Hotel>> fetchHotels(String cityCode) async {
    final response = await http.post(
      Uri.parse('$baseUrl/hotel-api-call-basic'),
      body: {
        'url': 'TBOHotelCodeList',
        'isLive': liveOrStage.toString(),
        'datas': jsonEncode({"CityCode": cityCode}),
      },
    );
    log('TBOHotelCodeList callback response: ${response.body}');
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final data = responseData['data'];

      if (data != null && data['Status']['Code'] == 200) {
        final hotelResponse = HotelResponse.fromJson(data);
        return hotelResponse.hotels;
      } else {
        final errorMessage = data != null
            ? data['Status']['Description']
            : 'Unknown error from backend';
        throw Exception('API Error: $errorMessage');
      }
    } else {
      throw Exception('Failed to fetch hotels');
    }
  }
}
