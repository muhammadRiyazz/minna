import 'package:flutter/material.dart';

class Erroricon extends StatelessWidget {
  const Erroricon({super.key, required this.ontap});
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
