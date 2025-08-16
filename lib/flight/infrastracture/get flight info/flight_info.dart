import 'dart:convert';
import 'dart:developer';
import 'package:minna/comman/core/api.dart';
import 'package:http/http.dart' as http;

class FlightInfo {
  final String? name;
  final String? img;

  FlightInfo({this.name, this.img});
}

Future<FlightInfo?> fetchFlightInfo(String code) async {
  try {
    if (code.isEmpty) return null;

    final response = await http.post(
      Uri.parse('${baseUrl}airline-details'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {"airlineCode": code},
    );

    log('fetchFlightInfo response --- ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['status'] == 'SUCCESS' && data['data'] != null) {
        final airlineData = data['data'];
        return FlightInfo(
          name: airlineData['AirlineTitle'],
          img: airlineData['AirlineImage'],
        );
      }
    }

    return null;
  } catch (e) {
    log('Error fetching flight info: $e');
    return null;
  }
}
