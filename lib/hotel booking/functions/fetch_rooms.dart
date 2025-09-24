import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:minna/hotel%20booking/core/core.dart';
import 'package:minna/hotel%20booking/domain/rooms/rooms.dart';

class HotelRoomApiService {
  static const String baseUrl = "https://affiliate.tektravels.com/HotelAPI/Search";

  static String get basicAuth =>
      'Basic ${base64Encode(utf8.encode('$livehotelusername:$livehoteluserpass'))}';

  static Future<HotelSearchResponse> searchHotels(
      HotelSearchRequest request) async {
    

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': basicAuth,
        "Content-Type": "application/json",
      },
      body:  request.encode(),
    );
    log(request.toJson().toString());
      log(response.body);


    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return HotelSearchResponse.fromJson(jsonData);
    } else {
      throw Exception("Failed to load hotels. Status: ${response.statusCode}");
    }
  }
}
