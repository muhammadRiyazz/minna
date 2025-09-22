import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../red_bus/constants/urls.dart';

Future<Response> getDpBdPoint({required String trpid}) async {
  log(trpid);
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var userId = preferences.getString('userdbid');
  var franchid = preferences.getString('fran_id');
  var urlPhpAvaiBus = "CallBackWithParams";

  var bodyBackend = {
    "url": "http://api.seatseller.travel/bpdpDetails?id=$trpid",
    "url_no_param": "http://api.seatseller.travel/bpdpDetails",
    "json_params": jsonEncode({
      "id": trpid,
    }),
    "method": "GET",
    "user_id": userId,
    "franch_id": franchid,
  };

  Response resp = await post(Uri.parse(urlPhpAvaiBus), body: bodyBackend);
  log(resp.body);
  return resp;
}
