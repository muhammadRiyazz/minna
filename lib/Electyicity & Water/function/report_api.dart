// lib/water_electricity/infrastructure/bill_payment_repository.dart

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:minna/Electyicity%20&%20Water/domain/water_electricity_model.dart';
import 'package:minna/comman/core/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BillPaymentRepository {

  Future<BillPaymentResponse> getBillPaymentReport() async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      final userId = preferences.getString('userId') ?? '';

      final url = Uri.parse('$baseUrl/bill-payment-report');
      
      log('Bill Payment API Call: $url');
      log('User ID: $userId');

      final response = await http.post(
        url,
        body: {
          'userId': userId,
        },
      );

      log('Bill Payment Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        
        // Check if the response is successful
        if (responseData['status'] == 'SUCCESS') {
          return BillPaymentResponse.fromJson(responseData);
        } else {
          throw Exception(responseData['statusDesc'] ?? 'Failed to fetch bill payments');
        }
      } else {
        throw Exception('Failed to load bill payment report: ${response.statusCode}');
      }
    } catch (e) {
      log('Bill Payment Repository Error: $e');
      throw Exception('Network error: Please check your connection');
    }
  }
}