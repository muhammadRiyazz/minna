import 'dart:convert';
import 'dart:developer';
import 'package:minna/comman/core/api.dart';
import 'package:minna/flight/domain/nation/nations.dart';
import 'package:http/http.dart' as http;

Future<List<Country>> getNationality() async {
  try {
    final response = await http.post(Uri.parse('${baseUrl}nationality'));
    log(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'SUCCESS') {
        return (data['data'] as List).map((e) => Country.fromJson(e)).toList();
      } else {
        throw Exception(data['statusDesc'] ?? 'Failed to fetch airports');
      }
    } else {
      throw Exception('Failed to load airports');
    }
  } catch (e) {
    throw Exception('Error searching airports: $e');
  }
}
