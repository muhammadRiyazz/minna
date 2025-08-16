import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Erroricon extends StatelessWidget {
  const Erroricon({Key? key, required this.ontap}) : super(key: key);
  final ontap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          ElevatedButton(onPressed: ontap, child: Text('  Retry  ')),
        ],
      ),
    );
  }
}
