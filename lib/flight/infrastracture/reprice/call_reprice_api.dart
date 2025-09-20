import 'dart:convert';
import 'dart:developer';

import 'package:minna/comman/core/api.dart';
import 'package:minna/flight/domain/reprice /re_price.dart';
import 'package:minna/flight/domain/reprice /reprice_respo.dart';
import 'package:http/http.dart' as http;
import 'package:minna/flight/infrastracture/log%20call%20back/log_call_back.dart';

Future<RePriceResponse> repriceRequestApi(RepriceRequest rePriceRequest) async {
  final uri = Uri.parse('${baseUrl}api-call');
  final requestBody = {


    'datas': jsonEncode(rePriceRequest.toJson()),
    'isLive': liveOrStage.toString(),
    'url': 'Api/webapi/Reprice?type=json',
  };
  final encodedRequest = json.encode(requestBody);

  // 🔹 Log the request externally
  await logApi(
    responseType: 'REPRICE REQUEST',
    token: '',
    response: jsonEncode(rePriceRequest.toJson()),
  );

  log('Reprice Request to: $uri');
  log('Request headers: ${{'Content-Type': 'application/x-www-form-urlencoded'}}');
  log('Request body: $encodedRequest');

  final response = await http
      .post(
        uri,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: requestBody,
      )
      .timeout(const Duration(seconds: 30));

  log('Response status: ${response.statusCode}');
  log('Response body: ${response.body}');

  // 🔹 Log the response externally
  await logApi(
    responseType: 'REPRICE RESPONSE',
    token: '',
    response: response.body,
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body) as Map<String, dynamic>;
    return RePriceResponse.fromJson(data);
  } else {
    throw Exception('Request failed with status: ${response.statusCode}');
  }
}