import 'dart:convert';
import 'dart:developer';
import 'package:minna/comman/core/api.dart';
import 'package:minna/flight/domain/airport/airport.dart';
import 'package:http/http.dart' as http;

class AirportService {
  static Future<List<Airport>> searchAirports(String query) async {
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}airport-details'),
        body: {'searchVal': query},
      );
      log(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'SUCCESS') {
          return (data['data'] as List)
              .map((e) => Airport.fromJson(e))
              .toList();
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
}
