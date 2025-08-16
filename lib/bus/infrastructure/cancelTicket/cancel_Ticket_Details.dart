import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:minna/comman/core/api.dart'; // Ensure baseUrl is correct

Future<http.Response?> cancelDetails({required String tin}) async {
  try {
    log('Starting cancellation request for TIN: $tin');

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('userId');

    if (userId == null) {
      log("User credentials not found in SharedPreferences");
      return null;
    }

    log("User ID: $userId");

    const String endpoint = "CallBackWithParams";
    final String url = "$baseUrl$endpoint";

    final Map<String, dynamic> requestBody = {
      "url": "http://api.seatseller.travel/cancellationdata?tin=$tin",
      "url_no_param": "http://api.seatseller.travel/cancellationdata",
      "json_params": jsonEncode({"tin": tin}),
      "method": "GET",
      "user_id": userId,
      "franch_id": "",
    };

    log("Sending cancellation request to: $url");
    final response = await http.post(Uri.parse(url), body: requestBody);

    log("Cancellation response received: ${response.statusCode}");
    log("Response body: ${response.body}");

    return response;
  } catch (e, stackTrace) {
    log("Error in cancelDetails: $e", stackTrace: stackTrace);
    return null;
  }
}
