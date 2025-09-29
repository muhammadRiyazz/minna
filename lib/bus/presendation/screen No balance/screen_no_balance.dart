import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class ScreenNoBalance extends StatelessWidget {
  const ScreenNoBalance({super.key});

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
        body: Row(
          children: [
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Lottie.asset(
                    'asset/116089-payment-failed.json',
                    repeat: false,
                  ),
                ),
                Text(
                  'Sorry, we were unable to process your\npayment.Please check your wallet\nbalance and try again',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                Spacer(),
                // SizedBox(
                //   height: 30,
                // ),
                InkWell(
                  onTap: () {
                    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    //   builder: (context) {
                    //     return HomePage();
                    //   },
                    // ), (route) => false);
                  },
                  child: Container(
                    height: 50,
                    // width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: Center(
                          child: Text(
                        'Done',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w300),
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
