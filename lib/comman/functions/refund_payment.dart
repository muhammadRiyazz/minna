import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:minna/comman/core/api.dart';

Future<Map<String, dynamic>> refundPayment({
  required String transactionId,
  required double amount,
  required String tableId,
  required String table
}) async {
  try {
    log('Initiating refund for transaction: $transactionId, amount: $amount');
    
    final response = await http.post(
      Uri.parse('${baseUrl}payrefund'),
      body: {
        'id': tableId,
        'transaction_id': transactionId,
        'amount':  (amount* 100).toString(),
        'table': table
      },
    );
    log( {
        'id': tableId,
        'transaction_id': transactionId,
        'amount':  (amount* 100).toString(),
        'table': table
      }.toString());
    log('Refund API response: ${response.statusCode}, ${response.body}');
          final jsonResponse = jsonDecode(response.body);

    if (jsonResponse['statusCode']== 200) {
      final jsonResponse = jsonDecode(response.body);
      return {
        'success': jsonResponse['statusCode'] == 200,
        'message': jsonResponse['message'] ?? 'Refund processed successfully'
      };
    }
    return {
      'success': false, 
      'message': 'Failed to process refund. HTTP Status: ${response.statusCode}'
    };
  } on TimeoutException {
    log('Refund API timeout');
    return {
      'success': false, 
      'message': 'Refund request timed out. Please check with support.'
    };
  } catch (e) {
    log('Refund API error: $e');
    return {
      'success': false, 
      'message': 'Error processing refund: ${e.toString()}'
    };
  }
}