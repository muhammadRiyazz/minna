import 'dart:convert';
import 'dart:developer';
import 'package:minna/flight/domain/fare%20request%20and%20respo/fare_request.dart';
import 'package:minna/flight/domain/fare%20request%20and%20respo/fare_respo.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:minna/comman/core/api.dart';
import 'package:minna/flight/infrastracture/log%20call%20back/log_call_back.dart';

Future<FFlightResponse> flightFareRequestApi(FareRequest fareRequest) async {
  try {
    final uri = Uri.parse('${baseUrl}api-call');
    final Map<String, String> requestBody = {
      'datas': jsonEncode(fareRequest.toJson()),
      'isLive': liveOrStage.toString(),
      'url': 'Api/webapi/GetFare?type=json',
    };

    // final String encodedRequest = jsonEncode(requestBody);

    /// 🔹 Log Request
    await logApi(
      responseType: 'FLIGHT FARE REQUEST',
      token:  '',
      response: jsonEncode(fareRequest.toJson()),
    );

    log('Request body flightFareRequestApi --------: $requestBody');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: requestBody,
    );

    log('Response status: ${response.statusCode}');
    log('Response body  flightFareRequestApi ---------: ${response.body}');

    /// 🔹 Log Response
    await logApi(
      responseType: 'FLIGHT FARE RESPONSE',
      token:  '',
      response: response.body,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return FFlightResponse.fromJson(data);
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
