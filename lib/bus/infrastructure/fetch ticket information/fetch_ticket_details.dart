import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../red_bus/constants/urls.dart';

getTicketdata({required tIn}) async {
  var _urlPhpAvaiBus = "CallBackWithParams";
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var userId = preferences.getString('userdbid');
  var franchid = preferences.getString('fran_id');
  var bodyBackend = {
    "url": "http://api.seatseller.travel/ticket?tin=$tIn", //VZpx3W4CCQ
    "url_no_param": "http://api.seatseller.travel/ticket",
    "json_params": jsonEncode({
      "tin": tIn,
    }),
    "method": "GET",
    "user_id": userId,
    "franch_id": franchid,
  };

  Response _res = await post(Uri.parse(_urlPhpAvaiBus), body: bodyBackend);
  log(_res.body);
}
