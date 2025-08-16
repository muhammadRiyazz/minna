import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';

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
        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        //   builder: (context) {
        //     return HomePage();
        //   },
        // ), (route) => false);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(),
              Container(
                child: Column(children: [
                  Lottie.asset('asset/75937-success.json', repeat: false),
                  Text(
                    'Your Cancellation Successfully\nCompleted',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w300),
                  ),
                ]),
              ),
              Column(
                children: [
                  Text(
                    'Successfully Refunded ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ),
                  Text(
                    cancelSuccesdata.refundAmount,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 30),
                  ),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
