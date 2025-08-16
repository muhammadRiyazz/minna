import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:minna/comman/core/api.dart';
import 'package:minna/flight/domain/triplist request/search_request.dart';
import 'package:minna/flight/domain/trip resp/trip_respo.dart';
import 'package:minna/flight/infrastracture/log%20call%20back/log_call_back.dart';

Future<FlightResponse> flightTripListRequest(
  FlightSearchRequest searchRequest,
) async {
  try {
    final uri = Uri.parse('${baseUrl}api-call');
    final Map<String, String> requestBody = {
      'datas': json.encode(searchRequest.toJson()),
      'isLive': liveOrStage.toString(),
      'url': 'Api/webapi/GetAvailability?type=json',
    };

    final String encodedRequestBody = json.encode(requestBody);

    /// 🔹 Log Request
    await logApi(
      responseType: 'FLIGHT SEARCH REQUEST',
      token:  '',
      response: json.encode(searchRequest.toJson()),
    );

    log('Request body: $encodedRequestBody');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: requestBody,
    );

    log('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');

    /// 🔹 Log Response
    await logApi(
      responseType: 'FLIGHT SEARCH RESPONSE',
      token: '',
      response: response.body,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return FlightResponse.fromJson(data);
    } else {
      throw Exception('API error: ${response.body}');
    }
  } catch (e) {
    log('Request failed: $e', stackTrace: StackTrace.current);
    throw Exception('Request failed: $e');
  }
}

void printLargeText(String text) {
  const int chunkSize = 800;
  for (int i = 0; i < text.length; i += chunkSize) {
    final end = (i + chunkSize < text.length) ? i + chunkSize : text.length;
    debugPrint(text.substring(i, end));
  }
}
