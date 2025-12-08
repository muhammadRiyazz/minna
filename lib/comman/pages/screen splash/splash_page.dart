import 'dart:async';
import 'package:flutter/material.dart';
import 'package:minna/comman/pages/main%20home/home.dart';

class GradientSplashScreen extends StatelessWidget {
  const GradientSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    });

    // Get device size
    final size = MediaQuery.of(context).size;

    return Scaffold(backgroundColor: Colors.black,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        // Optional: nice gradient background
       
        child: Center(
          child: SizedBox(
            width: size.width * 0.4, // 60% of screen width
            height: size.width * 0.4, // Keep square
            child: Image.asset(
              'asset/mtlogo.jpg',
              fit: BoxFit.contain, // Keep aspect ratio
            ),
          ),
        ),
      ),
    );
  }
}
