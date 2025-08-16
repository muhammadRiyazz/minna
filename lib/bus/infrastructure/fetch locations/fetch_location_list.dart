import 'dart:convert';
import 'dart:developer';

import 'package:minna/comman/core/api.dart';
import 'package:http/http.dart' as http;

Future<http.Response> locationData() async {
  const String apiRelayUrl = "${baseUrl}CallAPI";
  const String targetGetUrl = "http://api.seatseller.travel/cities";

  try {
    final Map<String, String> requestBody = {
      "path": targetGetUrl,
      "user_id": '',
      "franch_id": '',
      "method": "GET",
    };

    final http.Response response = await http.post(
      Uri.parse(apiRelayUrl),
      body: requestBody,
    );

    log("Response Status: ${response.statusCode}");
    log("Response Body: ${response.body}");

    // Optional: check response status and parse
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData is Map && responseData.containsKey('cities')) {
        log("Fetched cities: ${responseData['cities']}");
      }
    }

    return response;
  } catch (e) {
    log("Error in locationData: $e");
    rethrow;
  }
}
