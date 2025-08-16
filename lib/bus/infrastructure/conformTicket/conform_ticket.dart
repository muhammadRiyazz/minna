import 'dart:convert';

import 'package:http/http.dart';
import 'package:minna/comman/core/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../red_bus/constants/urls.dart';

conformTicketApi({required blockKey}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
     final userId = preferences.getString('userId') ?? '';

  var _urlPhpAvaiBus = "${baseUrl}CallBackWithParams";

  var bodyBackend = {
    "url":
        "http://api.seatseller.travel/bookticket?blockKey=$blockKey", //VZpx3W4CCQ
    "url_no_param": "http://api.seatseller.travel/bookticket",
    "json_params": jsonEncode({"blockKey": blockKey}),
    "method": "POST",
    "user_id": userId,
    "franch_id": '',
  };
  Response resp = await post(Uri.parse(_urlPhpAvaiBus), body: bodyBackend);

  return resp;
}
