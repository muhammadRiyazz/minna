import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingIcon extends StatelessWidget {
  const LoadingIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(90.0),
        // child: Lottie.asset(
        //   'asset/94044-loading-animation.json',
        // ),
      ),
    );
  }
}
