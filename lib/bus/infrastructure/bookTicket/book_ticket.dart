import 'dart:developer';
import 'package:flutter/material.dart';

import '../../pages/screen fail ticket/screen_fail_ticket.dart';
import '../../pages/screen success ticket/screen_Success_ticket.dart';
import '../conformTicket/conform_ticket.dart';
import '../tin updation/tin_updation.dart';

bookNow({
  required String blockKey,
  required String blockID,
  required BuildContext context,
  required int selectedseatsCount,
}) async {
  try {
    log('ConnectivityResult done');
    // final Response resp = await cutwalletbalance(
    //   blockID: blockID,
    //   blockKey: blockKey,
    // );
    // Map<String, dynamic> jsonResponse = jsonDecode(resp.body);
    // int statusCode = jsonResponse['statusCode'];
    // log(statusCode.toString());

    // if (statusCode != 200) {
    //   log('cut wallet api fail');
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) {
    //         return ScreenNoBalance();
    //       },
    //     ),
    //   );
    // } else if (statusCode == 200) {
    log('cut wallet api done');
    final respotin = await conformTicketApi(blockKey: blockKey);
    log('tin gotttttttttttttttttttttttt oneeee ${respotin.body}');
    if (respotin.body ==
        'Error: Authorization  failed  please  send valid consumer key and secret in the api request.') {
      log('conformTicketApi retry');
      booknowRetry(
        blockID: blockID,
        blockKey: blockKey,
        context: context,
        selectedseatsCount: selectedseatsCount,
      );
    } else if (hasIntegerValue(respotin.body)) {
      log('tin gotttttttttttttttttttttttt ${respotin.body}');
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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ScreenFailTicket();
          },
        ),
      );
    }
    // }
  } catch (e) {
    log(e.toString());
  }
}

booknowRetry({
  required String blockKey,
  required String blockID,
  required BuildContext context,
  required int selectedseatsCount,
}) async {
  final respotin = await conformTicketApi(blockKey: blockKey);
  if (respotin.body ==
      'Error: Authorization failed please send valid consumer key and secret in the api request.') {
    log('conformTicketApi retry');
    booknowRetry(
      blockID: blockID,
      blockKey: blockKey,
      context: context,
      selectedseatsCount: selectedseatsCount,
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ScreenFailTicket();
        },
      ),
    );
  }
}

bool hasIntegerValue(String input) {
  final RegExp regex = RegExp(r'\d+');
  return regex.hasMatch(input);
}
