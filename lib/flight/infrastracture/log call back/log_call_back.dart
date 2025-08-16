import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:minna/comman/core/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 🔹 Log API Function with Headers and Encoding
Future<void> logApi({
  required String responseType,
  required String token,
  required String response,
}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final userId = preferences.getString('userId') ?? '';

  final logUri = Uri.parse('${baseUrl}flight-log');

  try {
    final res = await http.post(
      logUri,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded', // important
      },
      body: {
        'responceType': responseType, // spelling matches your backend
        'userId': userId.isEmpty ? '0' : userId,
        'Token': token,
        'responce': response,
      },
    );

    log('✅ API Log Sent: ${res.statusCode}');
    log('📦 Response Body: ${res.body}');
  } catch (e) {
    log('❌ Logging failed: $e');
  }
}
