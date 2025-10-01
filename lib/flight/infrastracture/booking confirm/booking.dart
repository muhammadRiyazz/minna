import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:minna/flight/domain/booking%20request%20/booking_request.dart';
import 'package:minna/comman/core/api.dart';
import 'package:minna/flight/infrastracture/log%20call%20back/log_call_back.dart';

Future<Response> bookingConfirmApi(BBBookingRequest fareRequest) async {
  try {
    final uri = Uri.parse('${baseUrl}api-call');
    final Map<String, String> requestBody = {
      'datas': jsonEncode(fareRequest.toJson()),
      'isLive': liveOrStage.toString(),
      'url': 'Api/webapi/Bookin?type=json',
    };

    // final String encodedRequest = jsonEncode(requestBody);

    /// 🔹 Log Booking Request
    await logApi(
      responseType: 'BOOKING REQUEST',
      token: '',
      response: jsonEncode(fareRequest.toJson()),
    );

    log('Booking Request to: $uri');
    log(
      'Request headers: ${{'Content-Type': 'application/x-www-form-urlencoded'}}',
    );
    log('Request body bookingConfirmApi------ $requestBody');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: requestBody,
    );

    log('Response status: ${response.statusCode}');
    log('Response body: bookingConfirmApi ----${response.body}');

    /// 🔹 Log Booking Response
    await logApi(
      responseType: 'BOOKING RESPONSE',
      token: '',
      response: response.body,
    );

    if (response.statusCode == 200) {
      return response;
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
