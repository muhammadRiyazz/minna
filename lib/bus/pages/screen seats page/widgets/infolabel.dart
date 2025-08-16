import 'package:flutter/cupertino.dart';

class Infolabel extends StatelessWidget {
  const Infolabel(
      {Key? key,
      required this.bordercolor,
      required this.color,
      required this.infotext})
      : super(key: key);
  final String infotext;
  final color;
  final bordercolor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 16,
          width: 16,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: color,
              border: Border.all(width: 1.2, color: bordercolor)),
        ),
        SizedBox(
          width: 22,
        ),
        Text(
          infotext,
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
