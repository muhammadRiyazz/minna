import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:minna/bus/pages/screen%20conform%20ticket/widget/refundinitiated.dart';

import '../../pages/screen fail ticket/screen_fail_ticket.dart';
import '../../pages/screen success ticket/screen_Success_ticket.dart';
import '../conformTicket/conform_ticket.dart';
import '../tin updation/tin_updation.dart';

Future<void> bookNow({
  required String blockKey,
  required String blockID,
  required BuildContext context,
  required int selectedseatsCount,
  String? paymentId, // Add paymentId parameter for refund handling
}) async {
  try {
    log('ConnectivityResult done');
    
    final respotin = await conformTicketApi(blockKey: blockKey);
    
    if (respotin.body == 'Error: Authorization failed please send valid consumer key and secret in the api request.') {
      log('conformTicketApi retry');
      await booknowRetry(
        blockID: blockID,
        blockKey: blockKey,
        context: context,
        selectedseatsCount: selectedseatsCount,
        paymentId: paymentId, // Pass paymentId for potential refund
      );
    } else if (hasIntegerValue(respotin.body)) {
      log('tin received: ${respotin.body}');
      tinUpdation(status: 1, tableID: blockID, tin: respotin.body);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ScreenSuccessTicket(
              passengercount: selectedseatsCount,
              tinid: respotin.body,
            );
          },
        ),
      );
    } else {
      tinUpdation(status: 0, tableID: blockID, tin: 'null');
      log('tin failed: ${respotin.body}');
      
      // If payment was made but booking failed, navigate to refund screen
      if (paymentId != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ScreenRefundInitiated(),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ScreenFailTicket(),
          ),
        );
      }
    }
  } catch (e) {
    log(e.toString());
    
    // If payment was made but booking failed, navigate to refund screen
    if (paymentId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ScreenRefundInitiated(),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ScreenFailTicket(),
        ),
      );
    }
  }
}

// Updated booknowRetry function with paymentId parameter
Future<void> booknowRetry({
  required String blockKey,
  required String blockID,
  required BuildContext context,
  required int selectedseatsCount,
  String? paymentId, // Add the missing paymentId parameter
}) async {
  final respotin = await conformTicketApi(blockKey: blockKey);
  
  if (respotin.body == 'Error: Authorization failed please send valid consumer key and secret in the api request.') {
    log('conformTicketApi retry');
    // Recursive call with all required parameters including paymentId
    await booknowRetry(
      blockID: blockID,
      blockKey: blockKey,
      context: context,
      selectedseatsCount: selectedseatsCount,
      paymentId: paymentId,
    );
  } else if (respotin.body.toString().characters.length.toInt() <= 12) {
    log('tin got ${respotin.body}');
    tinUpdation(status: 1, tableID: blockID, tin: respotin.body);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ScreenSuccessTicket(
            passengercount: selectedseatsCount,
            tinid: respotin.body,
          );
        },
      ),
    );
  } else {
    tinUpdation(status: 0, tableID: blockID, tin: 'null');
    log('tin got fail respo ${respotin.body}');
    
    // If payment was made but booking failed, navigate to refund screen
    if (paymentId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ScreenRefundInitiated(),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ScreenFailTicket(),
        ),
      );
    }
  }
}

bool hasIntegerValue(String input) {
  final RegExp regex = RegExp(r'\d+');
  return regex.hasMatch(input);
}