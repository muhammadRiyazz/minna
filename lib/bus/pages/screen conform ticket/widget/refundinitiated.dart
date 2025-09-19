// screen_refund_initiated.dart
import 'package:flutter/material.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/pages/main%20home/home.dart';

class ScreenRefundInitiated extends StatelessWidget {
  const ScreenRefundInitiated({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        ), (route) => false);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          
          title: const Text('Booking Status',style: TextStyle(color: Colors.white,fontSize: 18),),
          backgroundColor:  maincolor1,

           leading: BackButton(color: Colors.white,
            onPressed: () {
             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        ), (route) => false);
            
            },
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Icon(
                  Icons.error_outline,
                  size: 80,
                  color:  maincolor1,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Booking Not Confirmed',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  'We apologize for the inconvenience. Your booking could not be confirmed due to a technical issue.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  'A refund has been initiated and will be processed within 5-7 business days.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  maincolor1,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: const Text(
                    'Return to Home',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}