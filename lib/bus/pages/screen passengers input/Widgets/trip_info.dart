import 'package:flutter/material.dart';

class TripInformation extends StatelessWidget {
  const TripInformation(
      {super.key,
      required this.boardingpoint,
      required this.droppingPoint,
      required this.travelsname,
      required this.trpinfo});
  final String boardingpoint;
  final String droppingPoint;
  final String trpinfo;
  final String travelsname;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color.fromARGB(255, 194, 181, 181)),
        ),
        child: Column(children: [
          ListTile(
            contentPadding: EdgeInsets.all(0),
            title: Text(travelsname,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w400)),
            subtitle: Text(trpinfo,
                style: TextStyle(
                    fontSize: 13,
                    color: Color.fromARGB(255, 164, 148, 148),
                    fontWeight: FontWeight.w300)),
            leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 240, 236, 236),
                    borderRadius: BorderRadius.circular(30)),
                child: Icon(
                  Icons.directions_bus_outlined,
                  color: Colors.red,
                )),
          ),
       
        ]),
      ),
    );
  }
}
