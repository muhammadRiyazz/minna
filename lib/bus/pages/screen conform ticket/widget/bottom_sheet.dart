import 'dart:async';

import 'package:flutter/material.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/pages/main%20home/home.dart';


Future<dynamic> showBottomSheetbooking({
  required BuildContext context,
  required Timer timer,
  required String busORFlight

}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return SizedBox(
        height: 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            children: [
              Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 215, 205, 205),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Are You sure you want to go back ?',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
              ),
              SizedBox(height: 10),
              Text(
                'This $busORFlight seems popular! Hurry, book before all the seats get filled',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
              ),
              Spacer(),
              // SizedBox(
              //     height: 300,
              //     child:
              //         Lottie.asset('asset/19618-bus-pop (1).json')),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: maincolor1,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Continue Booking',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomePage();
                      },
                    ),
                    (route) => false,
                  );
                  timer.cancel();
                },
                child: Text('Back'),
              ),
              // Container(
              //   height: 55,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //       color: Colors.red,
              //       borderRadius: BorderRadius.circular(10)),
              // )
            ],
          ),
        ),
      );
    },
  );
}
