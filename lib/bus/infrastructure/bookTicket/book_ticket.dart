import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:minna/bus/pages/screen%20conform%20ticket/widget/refundinitiated.dart';
import 'package:minna/bus/pages/screen%20fail%20ticket/screen_fail_ticket.dart';
import 'package:minna/bus/pages/screen%20success%20ticket/screen_Success_ticket.dart';
import 'package:minna/bus/infrastructure/conformTicket/conform_ticket.dart';
import 'package:minna/bus/infrastructure/tin%20updation/tin_updation.dart';
import 'package:minna/comman/functions/refund_payment.dart';

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
       tableId: blockID, table: 'bus_blockrequest',
      );
      
      if (refundResult['success']) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  ScreenRefundInitiated()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  ScreenFailTicket()),
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
       tableId: blockID, table: 'bus_blockrequest',
      );
      
      if (refundResult['success']) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  ScreenRefundInitiated()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  ScreenFailTicket()),
        );
      }
    }
  } catch (e) {
    log('Unexpected error in bookNow: $e');
    
    // Initiate refund on any unexpected error
    final refundResult = await refundPayment(
        transactionId: paymentId,
        amount: amount,
       tableId: blockID, table: 'bus_blockrequest',
      );
    
    if (refundResult['success']) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  ScreenRefundInitiated()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  ScreenFailTicket()),
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
       tableId: blockID, table: 'bus_blockrequest',
      );
      
      if (refundResult['success']) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  ScreenRefundInitiated()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  ScreenFailTicket()),
        );
      }
      return;
    }
  
    if (respotin.body == 'Error: Authorization failed please send valid consumer key and secret in the api request.') {
      log('conformTicketApi retry failed again with authorization error');
      
     final refundResult = await refundPayment(
        transactionId: paymentId,
        amount: amount,
       tableId: blockID, table: 'bus_blockrequest',
      );
      
      if (refundResult['success']) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  ScreenRefundInitiated()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  ScreenFailTicket()),
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
       tableId: blockID, table: 'bus_blockrequest',
      );
      
      if (refundResult['success']) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  ScreenRefundInitiated()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  ScreenFailTicket()),
        );
      }
    }
  } catch (e) {
    log('Error in booknowRetry: $e');
    
    final refundResult = await refundPayment(
      transactionId: paymentId,
      amount: amount,
      table: "bus_blockrequest",
      tableId: blockID
    );
    
    if (refundResult['success']) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  ScreenRefundInitiated()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  ScreenFailTicket()),
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
