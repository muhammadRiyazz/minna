import 'dart:async';
import 'package:flutter/material.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/pages/main%20home/home.dart';

Future<dynamic> showBottomSheetbooking({
  required BuildContext context,
  required Timer timer,
  required String busORFlight,
  required Color primaryColor,
  required Color secondaryColor,
}) {
  final Color backgroundColor = Color(0xFFF8F9FA);
  final Color cardColor = Colors.white;
  final Color textPrimary = Colors.black;
  final Color textSecondary = Color(0xFF666666);

  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: textSecondary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.warning_amber_rounded,
                  color: secondaryColor,
                  size: 32,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Are you sure you want to go back?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(

                busORFlight
              ,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: textSecondary,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Continue Booking',
                    style: TextStyle(
                      fontSize: 16,

                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                    (route) => false,
                  );
                  timer.cancel();
                },
                child: Text(
                  'Cancel Booking',
                  style: TextStyle(
                    color: textSecondary,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}