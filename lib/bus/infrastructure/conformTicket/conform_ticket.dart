import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:minna/comman/core/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../red_bus/constants/urls.dart';

Future<Response> conformTicketApi({required String blockKey}) async {
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString('userId') ?? '';

    var _urlPhpAvaiBus = "${baseUrl}CallBackWithParams";

    var bodyBackend = {
      "url": "http://api.seatseller.travel/bookticket?blockKey=$blockKey",
      "url_no_param": "http://api.seatseller.travel/bookticket",
      "json_params": jsonEncode({"blockKey": blockKey}),
      "method": "POST",
      "user_id": userId,
      "franch_id": '',
    };
    
    log("Calling conformTicketApi with blockKey: $blockKey");
    
    Response resp = await post(Uri.parse(_urlPhpAvaiBus), body: bodyBackend)
        .timeout(const Duration(seconds: 30));
    
    log("conformTicketApi response status: ${resp.statusCode}");
    log("conformTicketApi response body: ${resp.body}");
    
    return resp;
    
  } on TimeoutException {
    log("conformTicketApi timeout for blockKey: $blockKey");
    return Response('Timeout Error: Request took too long to complete', 408);
    
  } on FormatException catch (e) {
    log("conformTicketApi format exception: $e");
    return Response('Format Error: Invalid response format', 500);
    
  } on Exception catch (e) {
    log("conformTicketApi general exception: $e");
    return Response('Network Error: ${e.toString()}', 500);
  }
}