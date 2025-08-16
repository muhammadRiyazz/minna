import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BottomPart extends StatelessWidget {
  const BottomPart({Key? key, 
  //required this.error, required this.isloading
  })
      : super(key: key);
 // final bool isloading;
 // final bool error;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.red,
      ),
      child: Center(
        child:
        
            Text(
                'Proceed'.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
      ),
    );
  }
}
