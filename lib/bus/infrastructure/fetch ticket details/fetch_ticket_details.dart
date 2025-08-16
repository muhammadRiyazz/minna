import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:minna/comman/core/api.dart'; // Make sure baseUrl is correct

Future<http.Response?> getTicketData({required String tIn}) async {
  try {
    log('call -----getTicketData ---');
    log('tin ----$tIn');
    final String urlPhpAvaiBus = "$baseUrl/CallBackWithParams";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('userId');

    if (userId == null) {
      log("User ID not found in SharedPreferences");
      return null;
    }

    final Map<String, dynamic> body = {
      "url": "http://api.seatseller.travel/ticket?tin=$tIn",
      "url_no_param": "http://api.seatseller.travel/ticket",
      "json_params": jsonEncode({"tin": tIn}),
      "method": "GET",
      "user_id": userId,
      "franch_id": "", // Assuming empty string is fine
    };

    final response = await http.post(Uri.parse(urlPhpAvaiBus), body: body);

    log("Ticket data fetched: ${response.body}");
    return response;
  } catch (e, s) {
    log("getTicketData error: $e", stackTrace: s);
    return null;
  }
}
