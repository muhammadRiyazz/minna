import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/pages/main%20home/home.dart';

import '../../domain/cancel succes modal/cancel_succes_modal.dart';

class ScreenCancelSucces extends StatelessWidget {
  const ScreenCancelSucces({
    Key? key,
    required this.cancelSuccesdata,
  }) : super(key: key);

  final CancelSuccesModal cancelSuccesdata;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Column(
                    children: [
                    // ✅ Replace Lottie animation with Icon
 Icon(
  Icons.check_circle,
  color: maincolor1,
  size: 120,
),

                      const SizedBox(height: 20),
                      const Text(
                        'Cancellation Completed',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Your cancellation has been processed successfully.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Refund Initiated',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "₹ ${cancelSuccesdata.refundAmount}",
                        textAlign: TextAlign.center,
                        style:  TextStyle(
                          color: maincolor1,
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'The refund will be credited to your account shortly.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
