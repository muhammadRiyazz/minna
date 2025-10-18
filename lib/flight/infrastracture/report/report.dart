// services/api_service.dart
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:minna/comman/core/api.dart';
import 'package:minna/flight/domain/report/report_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportApiService {
  
  Future<ReportResponse> fetchReports() async {
    try {
      log("fetchReports ----");

      SharedPreferences preferences = await SharedPreferences.getInstance();
      final userId = preferences.getString('userId') ?? '';

      final response = await http.post(
        Uri.parse('${baseUrl}flight-report'),
        body: {
          'userId': userId,
        }
      );
      
      log(jsonEncode({
        'userId': userId,
      }).toString());
      
      log(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return ReportResponse.fromJson(data);
      } else {
        log('log error - Status Code: ${response.statusCode}');
        throw Exception('Failed to load reports: ${response.statusCode}');
      }
    } catch (e) {
      log('API Error: $e');
      throw Exception('Failed to load reports: $e');
    }
  }
}