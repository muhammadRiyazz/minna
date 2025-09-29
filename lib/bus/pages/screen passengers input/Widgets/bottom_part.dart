import 'package:flutter/material.dart';

class BottomPart extends StatelessWidget {
  const BottomPart({super.key, 
  //required this.error, required this.isloading
  });
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
