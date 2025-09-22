import 'dart:developer';

import 'package:minna/bus/domain/profile%20modal/profile_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<ProfileModal> fetchProfileData() async {
  log('call function');
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var userId = preferences.getString('userdbid');
  log(userId.toString());
  var postUrl = Uri.parse(
    'https://maaxusdigitalhub.com/apinew/ApiCommon/maaxpayProfile',
  );
  var responce = await http.post(postUrl, body: {'user_id': userId});
  log(responce.body);
  final ProfileModal data = profileModalFromJson(responce.body);
  return data;
}
