import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../red_bus/constants/urls.dart';

cancelRefund({required response, required String blocid}) async {
  log(response.toString());
  var postUrl = Uri.parse('CancelTicket');
  final Response respo = await http.post(
    postUrl,
    body: {
      'blockID': blocid,
      'response': response,
    },
  );
  log(respo.body);
  log('calll done');
  return respo;
}
