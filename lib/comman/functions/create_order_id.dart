 import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:minna/comman/core/api.dart';

Future<String?> createOrder(double amount) async {
    try {
      final response = await http.post(
        Uri.parse("${baseUrl}createOrder"),
        body: {
          "amount": (amount * 100).toStringAsFixed(0),
        },
      );
      log(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['statusCode'] == 200) {
          return data['message']['order_id']; // Extract order_id from response
        } else {
          log("Error creating order: ${data['message']}");
          return null;
        }
      } else {
        log("HTTP Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      log("Exception in createOrder: $e");
      return null;
    }
  }