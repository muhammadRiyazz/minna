
import 'package:flutter/material.dart';
import 'package:minna/bus/infrastructure/time.dart';
import 'package:minna/bus/pages/Screen%20available%20Trip/screen_available_triplist.dart';
import 'package:minna/bus/pages/screen%20passengers%20input/screen_passengers_input.dart';

import 'package:minna/comman/const/const.dart';
import 'package:minna/bus/domain/seatlayout/seatlayoutmodal.dart';
import 'package:minna/bus/domain/trips%20list%20modal/trip_list_modal.dart';
import 'package:minna/bus/domain/BlockTicket/block_ticket_request_modal.dart';

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

 
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37); // Gold
  final Color _accentColor = Color(0xFFC19B3C); // Darker Gold
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);
  final Color _errorColor = Color(0xFFE53935);

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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: _primaryColor!,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Column(
          children: [
            Container(
              color: _primaryColor,
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.1),
        //     blurRadius: 10,
        //     spreadRadius: 2,
        //     offset: Offset(0, 4),
        //   ),
        // ],
      ),
      child: 

       ListView.builder(
      padding: EdgeInsets.all(12),
      itemCount: points.length,
      itemBuilder: (context, index) {
        final point = points[index];
        final selected =
            (isBoarding ? boardingpoint : droppingpoint) == point.bpId;
        return Container(
          margin: EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: _cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                spreadRadius: 1,
                offset: Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: selected ? _secondaryColor : Colors.transparent,
              width: selected ? 1 : 0,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
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
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color:  _secondaryColor.withOpacity(.1)
                           ,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:  _secondaryColor ,
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        
                            Icons.place_outlined,
                        color: _secondaryColor ,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            point.bpName,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: selected ? _primaryColor : _textPrimary,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            point.landmark,
                            style: TextStyle(
                              fontSize: 12,
                              color: selected ? _textSecondary : _textLight,
                            ),
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 14,
                                color: selected ? _secondaryColor : _textLight,
                              ),
                              SizedBox(width: 4),
                              Text(
                                changetime(time: point.time),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: selected ? _secondaryColor : _textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selected ? _secondaryColor : _textLight,
                          width: 2,
                        ),
                        color: selected ? _secondaryColor : Colors.transparent,
                      ),
                      child: selected
                          ? Icon(
                              Icons.check,
                              size: 14,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ),
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
          backgroundColor: _primaryColor,
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
   void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.error_outline, color: _errorColor, size: 20),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Selection Required',
                    style: TextStyle(
                      color: _textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    message,
                    style: TextStyle(
                      color: _textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: _cardColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: _errorColor.withOpacity(0.2), width: 1),
        ),
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        duration: Duration(seconds: 4),
        elevation: 8,
        action: SnackBarAction(
          label: 'OK',
          textColor: _primaryColor,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );}




}




