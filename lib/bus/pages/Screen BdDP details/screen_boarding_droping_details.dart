import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:minna/bus/pages/Screen%20available%20Trip/screen_available_triplist.dart';
import 'package:minna/bus/pages/screen%20passengers%20input/screen_passengers_input.dart';

import 'package:minna/comman/const/const.dart';
import 'package:minna/bus/domain/seatlayout/seatlayoutmodal.dart';
import 'package:minna/bus/domain/trips%20list%20modal/trip_list_modal.dart';
import 'package:minna/bus/domain/BlockTicket/block_ticket_request_modal.dart';
import 'package:minna/bus/infrastructure/fareCalculation/fare_calculation.dart';
import 'package:minna/bus/presendation/screen%20view%20ticket/screen_view_ticket.dart';

class ScreenBdDpDetails extends StatefulWidget {
  const ScreenBdDpDetails({
    super.key,
    required this.selectedSeats,
    required this.alldata,
    required this.travelsname,
    required this.dropingTimeList,
    required this.boardingTimeList,
    required this.trpinfo,
  });

  final BlockTicketRequest alldata;
  final String trpinfo;
  final String travelsname;
  final List<Seat> selectedSeats;
  final List<BoardingPoint> boardingTimeList;
  final List<BoardingPoint> dropingTimeList;

  @override
  State<ScreenBdDpDetails> createState() => _ScreenBdDpDetailsState();
}

class _ScreenBdDpDetailsState extends State<ScreenBdDpDetails> {
  String? boardingpoint;
  String? droppingpoint;
  String? boardingpointname;
  String? droppingpointname;

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text(message, style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        backgroundColor: Colors.red[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subtitleStyle = TextStyle(
      fontSize: 12,
      color: Color.fromARGB(255, 164, 148, 148),
      fontWeight: FontWeight.w300,
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: maincolor1!,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Column(
          children: [
            Container(
              color: maincolor1!,
              child: TabBar(
                labelColor: Colors.white,
                indicatorColor: Colors.white,
                labelPadding: EdgeInsets.all(15),
                tabs: [
                  _buildTab('Boarding point', boardingpointname),
                  _buildTab('Dropping point', droppingpointname),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildPointList(widget.boardingTimeList, true),
                  _buildPointList(widget.dropingTimeList, false),
                ],
              ),
            ),
            _buildContinueButton(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String label, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 13,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        value == null
            ? Text(
                'Add Location',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 164, 148, 148),
                ),
              )
            : SizedBox(
                width: 180,
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 164, 148, 148),
                  ),
                ),
              ),
      ],
    );
  }

  Widget _buildPointList(List<BoardingPoint> points, bool isBoarding) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ListView.builder(
        itemCount: points.length,
        itemBuilder: (context, index) {
          final point = points[index];
          final selected =
              (isBoarding ? boardingpoint : droppingpoint) == point.bpId;
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: selected ? 1.5 : 1,
                color: selected ? maincolor1! : Colors.grey.shade300,
              ),
            ),
            child: ListTile(
              leading: Radio<String>(
                value: point.bpId,
                groupValue: isBoarding ? boardingpoint : droppingpoint,
                onChanged: (value) {
                  setState(() {
                    if (isBoarding) {
                      boardingpoint = value;
                      boardingpointname = point.bpName;
                    } else {
                      droppingpoint = value;
                      droppingpointname = point.bpName;
                    }
                  });
                },
                activeColor: maincolor1!,
              ),
              title: Text(
                point.bpName,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: selected ? maincolor1! : Colors.black,
                ),
              ),
              subtitle: Text(
                point.landmark,
                style: TextStyle(
                  fontSize: 12,
                  color: selected ? maincolor1! : Colors.grey[600],
                ),
              ),
              trailing: Text(
                changetime(time: point.time),
                style: TextStyle(
                  color: selected ? maincolor1! : Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                setState(() {
                  if (isBoarding) {
                    boardingpoint = point.bpId;
                    boardingpointname = point.bpName;
                  } else {
                    droppingpoint = point.bpId;
                    droppingpointname = point.bpName;
                  }
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildContinueButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: maincolor1!,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 2,
        ),
        onPressed: () {
          if (droppingpoint == null && boardingpoint == null) {
            _showErrorSnackBar(
              'Please select both boarding and dropping points',
            );
          } else if (boardingpoint == null) {
            _showErrorSnackBar('Please select a boarding point');
          } else if (droppingpoint == null) {
            _showErrorSnackBar('Please select a dropping point');
          } else {
            // widget.alldata.boardingPointID = boardingpoint!;
            // widget.alldata.droppingPointID = droppingpoint!;
            // log(widget.alldata.boardingPointID.toString());
            // log(widget.alldata.droppingPointID.toString());

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScreenPassengerInput(
                  selctseat: widget.selectedSeats,
                  alldata: widget.alldata,
                  boardingpoint: boardingpoint!,
                  droppingPoint: droppingpoint!,
                  travelsname: widget.travelsname,
                  trpinfo: widget.trpinfo,
                ),
              ),
            );
          }
        },
        child: const Text(
          'Continue',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
