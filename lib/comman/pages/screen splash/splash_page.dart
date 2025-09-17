import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/bus/application/location%20fetch/bus_location_fetch_bloc.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/pages/main%20home/home.dart';
import 'package:minna/comman/pages/screen_home.dart';

class GradientSplashScreen extends StatelessWidget {
  const GradientSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger location fetch

    // Navigate after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white, // White background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo
            // Image.asset(
            //   'assets/images/logo.png', // 👉 replace with your logo path
            //   height: 100,
            //   width: 100,
            // ),

            // App name
            Text(
              'MINNA',
              style: TextStyle(
                height: 0,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: maincolor1,
                letterSpacing: 1.5,
              ),
            ),

            // Tagline
            const Text(
              'Tours and Travels',
              style: TextStyle(
                height: 0,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
