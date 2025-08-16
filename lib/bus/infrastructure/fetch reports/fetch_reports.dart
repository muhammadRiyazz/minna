import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:minna/comman/core/api.dart';

Future<http.Response> fetchReport({
  required String fromdate,
  required String todate,
}) async {
  log('fetchReport-----');
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final userId = preferences.getString('userId') ?? '';

  var postUrl = Uri.parse('${baseUrl}Report');
  var response = await http.post(
    postUrl,
    body: {'from': fromdate, 'to': todate, 'user_id': userId},
  );

  log('fetchReport ---');
  log(response.body);
  return response;
}
