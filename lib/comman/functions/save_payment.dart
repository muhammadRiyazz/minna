 import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:minna/comman/core/api.dart';

Future<Map<String, dynamic>> savePaymentDetails(
      { required String orderId,required String transactionId,required int status,required String tableid,required String table}) async {
    log("_savePaymentDetails --called");

    try {
      final response = await http.post(
        Uri.parse('${baseUrl}paysave'),
        body: {
          'id': tableid,
          'order_id': orderId,
          'transaction_id': transactionId,
          'status': status.toString(),
          'table':table
        },
      );
      log(response.body.toString());
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return {
          'success': jsonResponse['statusCode'] == 200,
          'message': jsonResponse['message']
        };
      }
      return {'success': false, 'message': 'Failed to save payment details'};
    } catch (e) {
      log('savePaymentDetails error');
      log(e.toString());
      return {'success': false, 'message': 'Error: $e'};
    }
  }