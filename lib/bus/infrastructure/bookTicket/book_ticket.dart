import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:minna/bus/pages/screen%20conform%20ticket/widget/refundinitiated.dart';
import 'package:minna/bus/infrastructure/bookTicket/book_ticket.dart' as bookTicketInfra;
import 'package:minna/comman/core/api.dart';
import 'package:minna/bus/pages/screen%20fail%20ticket/screen_fail_ticket.dart';
import 'package:minna/bus/pages/screen%20success%20ticket/screen_Success_ticket.dart';
import 'package:minna/bus/infrastructure/conformTicket/conform_ticket.dart';
import 'package:minna/bus/infrastructure/tin%20updation/tin_updation.dart';

Future<void> bookNow({
  required String blockKey,
  required String blockID,
  required BuildContext context,
  required int selectedseatsCount,
  required String paymentId,
  required double amount,
}) async {
  try {
    log('Starting booking process for blockKey: $blockKey');
    
    final respotin = await conformTicketApi(blockKey: blockKey);
    
    // Handle HTTP errors first
    if (respotin.statusCode != 200) {
      log('conformTicketApi failed with status: ${respotin.statusCode}, body: ${respotin.body}');
      
      // Initiate refund since API call failed
      final refundResult = await refundPayment(
        transactionId: paymentId,
        amount: amount,
        blockId: blockID,
      );
      
      if (refundResult['success']) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ScreenRefundInitiated()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ScreenFailTicket()),
        );
      }
      return;
    }
    
    if (respotin.body == 'Error: Authorization failed please send valid consumer key and secret in the api request.') {
      log('conformTicketApi authorization failed, retrying...');
      await booknowRetry(
        blockID: blockID,
        blockKey: blockKey,
        context: context,
        selectedseatsCount: selectedseatsCount,
        paymentId: paymentId,
        amount: amount,
      );
    }  else if (hasIntegerValue(respotin.body)) {
  log('TIN received successfully: ${respotin.body}');
  await tinUpdation(status: 1, tableID: blockID, tin: respotin.body);

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => ScreenSuccessTicket(
        passengercount: selectedseatsCount,
        tinid: respotin.body,
      ),
    ),
  );
} else {
      log('TIN API returned invalid response: ${respotin.body}');
      await tinUpdation(status: 0, tableID: blockID, tin: 'null');
      
      // Initiate refund when TIN API returns invalid response
      final refundResult = await refundPayment(
        transactionId: paymentId,
        amount: amount,
        blockId: blockID,
      );
      
      if (refundResult['success']) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ScreenRefundInitiated()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ScreenFailTicket()),
        );
      }
    }
  } catch (e) {
    log('Unexpected error in bookNow: $e');
    
    // Initiate refund on any unexpected error
    final refundResult = await refundPayment(
      transactionId: paymentId,
      amount: amount,
      blockId: blockID,
    );
    
    if (refundResult['success']) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ScreenRefundInitiated()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ScreenFailTicket()),
      );
    }
  }
}

Future<void> booknowRetry({
  required String blockKey,
  required String blockID,
  required BuildContext context,
  required int selectedseatsCount,
  required String paymentId,
  required double amount,
}) async {
  try {
    final respotin = await conformTicketApi(blockKey: blockKey);
    
    // Handle HTTP errors in retry
    if (respotin.statusCode != 200) {
      log('conformTicketApi retry failed with status: ${respotin.statusCode}');
      
      final refundResult = await refundPayment(
        transactionId: paymentId,
        amount: amount,
        blockId: blockID,
      );
      
      if (refundResult['success']) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ScreenRefundInitiated()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ScreenFailTicket()),
        );
      }
      return;
    }
  
    if (respotin.body == 'Error: Authorization failed please send valid consumer key and secret in the api request.') {
      log('conformTicketApi retry failed again with authorization error');
      
      final refundResult = await refundPayment(
        transactionId: paymentId,
        amount: amount,
        blockId: blockID,
      );
      
      if (refundResult['success']) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ScreenRefundInitiated()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ScreenFailTicket()),
        );
      }
    } else if (respotin.body.toString().length <= 12 && hasIntegerValue(respotin.body)) {
  log('TIN received in retry: ${respotin.body}');
  await tinUpdation(status: 1, tableID: blockID, tin: respotin.body);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ScreenSuccessTicket(
            passengercount: selectedseatsCount,
            tinid: respotin.body,
          ),
        ),
      );
    } else {
      log('TIN retry failed with response: ${respotin.body}');
      await tinUpdation(status: 0, tableID: blockID, tin: 'null');
      
      final refundResult = await refundPayment(
        transactionId: paymentId,
        amount: amount,
        blockId: blockID,
      );
      
      if (refundResult['success']) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ScreenRefundInitiated()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ScreenFailTicket()),
        );
      }
    }
  } catch (e) {
    log('Error in booknowRetry: $e');
    
    final refundResult = await refundPayment(
      transactionId: paymentId,
      amount: amount,
      blockId: blockID,
    );
    
    if (refundResult['success']) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ScreenRefundInitiated()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ScreenFailTicket()),
      );
    }
  }
}

// bool hasIntegerValue(String input) {
//   if (input.isEmpty) return false;
//   final RegExp regex = RegExp(r'^\d+$');
//   return regex.hasMatch(input);
// }
bool hasIntegerValue(String input) {
  if (input.isEmpty) return false;
  
  // Check if the response is a valid TIN (alphanumeric and within reasonable length)
  // TIN can be alphanumeric, so we check for reasonable format instead of just digits
  final RegExp validTINRegex = RegExp(r'^[A-Z0-9]{4,12}$');
  return validTINRegex.hasMatch(input);
}
Future<Map<String, dynamic>> refundPayment({
  required String transactionId,
  required double amount,
  required String blockId,
}) async {
  try {
    log('Initiating refund for transaction: $transactionId, amount: $amount');
    
    final response = await http.post(
      Uri.parse('${baseUrl}payrefund'),
      body: {
        'id': blockId,
        'transaction_id': transactionId,
        'amount':  (amount* 100).toString(),
        'table': "bus_blockrequest"
      },
    ).timeout(const Duration(seconds: 30));
    
    log('Refund API response: ${response.statusCode}, ${response.body}');
    
    if (response.statusCode == 200) {
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