import 'dart:convert';
import 'dart:developer';
import 'dart:async';

import 'package:minna/comman/core/api.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<Response> fetchseats({required String tripid}) async {
  try {
    // Validate baseUrl is not null or empty
    if (baseUrl.isEmpty) {
      throw Exception('API base URL is not set.');
    }

    log('-- Fetching seats for Trip ID: $tripid');

    final urlSeating = '${baseUrl}CallBackWithParams';
    final requestBody = {
      "url": "http://api.seatseller.travel/tripdetails?id=$tripid",
      "url_no_param": "http://api.seatseller.travel/tripdetails",
      "json_params": jsonEncode({"id": tripid}),
      "method": "GET",
      "user_id": '',
      "franch_id": '',
    };

    final response = await http.post(Uri.parse(urlSeating), body: requestBody);

    log('Response status: ${response.statusCode}');
    // log('Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Request failed with status: ${response.statusCode}');
    }

    if (response.body.isEmpty) {
      throw Exception('Empty response body');
    }

    return response;
  } catch (e) {
    log('Error occurred in fetchseats: $e');
    throw Exception('Failed to fetch seat data: ${e.toString()}');
  }
}
