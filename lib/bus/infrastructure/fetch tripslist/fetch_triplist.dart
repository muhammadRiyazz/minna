import 'dart:convert';
import 'dart:developer';

import 'package:minna/comman/core/api.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class BusAvailability {
  static Future<Response> getDataAvailabilityBus({
    required String source,
    required String desti,
    required String dateOfJourney,
  }) async {
    try {
      // Validate input parameters
      if (source.isEmpty || desti.isEmpty || dateOfJourney.isEmpty) {
        throw ArgumentError('Source, destination and date cannot be empty');
      }

      log(
        'Fetching bus availability',
        name: 'BusAPI',
        error: 'Source: $source, Destination: $desti, Date: $dateOfJourney',
      );

      final requestBody = {
        "url":
            "http://api.seatseller.travel/availabletrips?source=$source&destination=$desti&doj=$dateOfJourney",
        "url_no_param": "http://api.seatseller.travel/availabletrips",
        "json_params": jsonEncode({
          "source": source,
          "destination": desti,
          "doj": dateOfJourney,
        }),
        "method": "GET",
        "user_id": '',
        "franch_id": '',
      };

      final response = await http
          .post(Uri.parse("${baseUrl}CallBackWithParams"), body: requestBody)
          .timeout(const Duration(seconds: 30));

      // log(
      //   'API Response',
      //   name: 'BusAPI',
      //   error: 'Status: ${response.statusCode}, Body: ${response.body}',
      // );
log(response.body);
      return response;
    } catch (e) {
      log('API Error', name: 'BusAPI', error: e.toString());
      rethrow;
    }
  }
}
