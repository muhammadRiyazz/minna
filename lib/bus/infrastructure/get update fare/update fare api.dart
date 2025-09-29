import 'dart:developer';

import 'dart:convert';

import 'package:minna/bus/domain/updated%20fare%20respo/update_fare.dart';
import 'package:http/http.dart';
import 'package:minna/comman/core/api.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<UpdatedFareResponse?> getUpdatedFare({required String blockKey}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final userId = preferences.getString('userId') ?? '';

  var urlPhp = '${baseUrl}CallBackWithParams';

  


final Map<String, dynamic> requestBody = {
      "url": "http://api.seatseller.travel/rtcfarebreakup?blockKey=$blockKey",
      "url_no_param": "http://api.seatseller.travel/rtcfarebreakup",
      "json_params": jsonEncode({"blockKey": blockKey}),
      "method": "GET",
      "user_id": userId,
      "franch_id": "",
    };



  log("Calling GetUpdatedFare API with BlockKey: $blockKey");

  final resRedBus = await post(Uri.parse(urlPhp), body: requestBody);

  log("UpdatedFare raw response: ${resRedBus.body}");

  if (resRedBus.statusCode == 200) {
    try {
      final data = jsonDecode(resRedBus.body);
      return UpdatedFareResponse.fromJson(data);
    } catch (e) {
      log("Parse error: $e");
      return null;
    }
  } else {
    log("Failed with status: ${resRedBus.statusCode}");
    return null;
  }
}
