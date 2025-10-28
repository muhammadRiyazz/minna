import 'package:minna/comman/const/const.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../domain/seatlayout/seatlayoutmodal.dart';
import '../../../infrastructure/seats/seatcalculation.dart';

class BerthGridView extends StatefulWidget {
  const BerthGridView({
    super.key,
    required this.seatlist,
    required this.selectedseats,
    required this.onSeatSelected,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
    required this.backgroundColor,
    required this.cardColor,
    required this.textPrimary,
    required this.textSecondary,
    required this.textLight,
  });

  final List<Seat> seatlist;
  final List<Seat> selectedseats;
  final Function(Seat, bool) onSeatSelected;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;
  final Color backgroundColor;
  final Color cardColor;
  final Color textPrimary;
  final Color textSecondary;
  final Color textLight;

  @override
  State<BerthGridView> createState() => _BerthGridViewState();
}

class _BerthGridViewState extends State<BerthGridView> {
  late int totalRowno;
  late int totalcolumn;
  bool showSeatInfo = true;

  @override
  void initState() {
    super.initState();
    totalRowno = totalRow(seatsList: widget.seatlist) + 1;
    totalcolumn = totalColumn(seatsList: widget.seatlist) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration: BoxDecoration(
              color: widget.cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: widget.seatlist.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100),
                        Lottie.asset('asset/90333-error.json',
                            width: 120, height: 120),
                        const SizedBox(height: 16),
                        Text(
                          'No Seats Available',
                          style: TextStyle(
                            fontSize: 16,
                            color: widget.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Please try another berth type',
                          style: TextStyle(
                            fontSize: 14,
                            color: widget.textSecondary.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: _getPaddingBasedOnRows(totalRowno),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: totalRowno * totalcolumn,
                      itemBuilder: (context, index) {
                        final seat = _getSeatForIndex(index);
                        if (seat == null) return Container();
                        return _buildSeatWidget(seat);
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: .9,
                        crossAxisCount: totalRowno,
                      ),
                    ),
                  ),
          ),
                    _buildSeatInfoSection(),
                    SizedBox(height: 10,)

        ],
      ),
    );
  }

  EdgeInsets _getPaddingBasedOnRows(int rows) {
    switch (rows) {
      case 1:
        return const EdgeInsets.symmetric(horizontal: 130, vertical: 20);
      case 2:
        return const EdgeInsets.symmetric(horizontal: 100, vertical: 20);
      case 3:
        return const EdgeInsets.symmetric(horizontal: 70, vertical: 20);
      case 4:
        return const EdgeInsets.symmetric(horizontal: 40, vertical: 20);
      case 5:
      case 6:
        return const EdgeInsets.all(20);
      default:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 20);
    }
  }

  Seat? _getSeatForIndex(int index) {
    final row = index % totalRowno;
    final column = index ~/ totalRowno;

    for (final seat in widget.seatlist) {
      final seatRow = int.parse(seat.row);
      final seatColumn = int.parse(seat.column);
      if (row == seatRow && column == seatColumn) {
        return seat;
      }
    }
    return null;
  }

  Widget _buildSeatWidget(Seat seat) {
    final isSelected = widget.selectedseats.any((s) => s.name == seat.name);
    final isAvailable = seat.available == 'true';

    return InkWell(
      onTap: () {
        if (isAvailable) {
          widget.onSeatSelected(seat, !isSelected);
        }
      },
      child: _getSeatImage(seat, isSelected, isAvailable),
    );
  }

  Widget _getSeatImage(Seat seat, bool isSelected, bool isAvailable) {
    if (!isAvailable) {
      return _getUnavailableSeatImage(seat);
    }

    if (isSelected) {
      return _getSelectedSeatImage(seat);
    }

    if (seat.ladiesSeat == 'true') {
      return _buildSeatContainer(
        width: seat.width,
        length: seat.length,
        borderColor: Colors.pink,
        fillColor: Colors.transparent,
        seatColor: Colors.pink,
        isSelected: isSelected,
      );
    }

    if (seat.malesSeat == 'true') {
      return _buildSeatContainer(
        width: seat.width,
        length: seat.length,
        borderColor: Colors.blue,
        fillColor: Colors.transparent,
        seatColor: Colors.blue,
        isSelected: isSelected,
      );
    }

    return _buildSeatContainer(
      width: seat.width,
      length: seat.length,
      borderColor: widget.primaryColor.withOpacity(0.5),
      fillColor: Colors.transparent,
      seatColor: widget.primaryColor,
      isSelected: isSelected,
    );
  }

  Widget _getUnavailableSeatImage(Seat seat) {
    return _buildSeatContainer(
      width: seat.width,
      length: seat.length,
      borderColor: Colors.grey.withOpacity(0.3),
      fillColor: Colors.grey.withOpacity(0.1),
      seatColor: Colors.grey,
      isSelected: false,
    );
  }

  Widget _getSelectedSeatImage(Seat seat) {
    return _buildSeatContainer(
      width: seat.width,
      length: seat.length,
      borderColor: widget.secondaryColor,
      fillColor: widget.secondaryColor.withOpacity(0.1),
      seatColor: widget.secondaryColor,
      isSelected: true,
    );
  }

  Widget _buildSeatContainer({
    required String width,
    required String length,
    required Color borderColor,
    required Color fillColor,
    required Color seatColor,
    required bool isSelected,
  }) {
    bool sleeper = width == '2' || length == '2';
    double containerHeight = sleeper ? 60 : 50;

    return Padding(
      padding: EdgeInsets.only(top: sleeper ? 0 : 8),
      child: Container(
        margin: const EdgeInsets.all(4),
        width: 45,
        height: containerHeight,
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(
            color: borderColor,
            width: 1
          ),
          // boxShadow: isSelected
          //     ? [
          //         BoxShadow(
          //           color: widget.secondaryColor.withOpacity(0.3),
          //           blurRadius: 8,
          //           spreadRadius: 1,
          //         ),
          //       ]
          //     : null,
        ),
        child: Column(
          children: [
            if (sleeper) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: seatColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(2),
                      topRight: Radius.circular(2),
                    ),
                  ),
                  height: 15,
                  width: double.infinity,
                ),
              ),
            ],
            const Spacer(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: seatColor,
                borderRadius: BorderRadius.circular(2),
              ),
              height: 6,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeatInfoSection() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: widget.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                showSeatInfo = !showSeatInfo;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      
                      
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        
                        color: widget.secondaryColor.withOpacity(0.1)),
                      child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.info_outline, color: widget.secondaryColor, size: 15),
                    )),
                    const SizedBox(width: 8),
                    Text(
                      'Seat Information',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: widget.textPrimary,
                      ),
                    ),
                  ],
                ),
                Icon(
                  showSeatInfo ? Icons.expand_less : Icons.expand_more,
                  color: widget.textSecondary,
                ),
              ],
            ),
          ),
          

          
          if (showSeatInfo) ...[
SizedBox(height: 10,),
Divider(height: 25,),


Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,

 children: [

    Text(
                      'Seat Types',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: widget.textPrimary,
                      ),
                    ),
   Row(children: [

 Text(
                      'Seater',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: widget.textPrimary,
                      ),
                    ), 
                    
                    SizedBox(width: 10,),
                    
                    Text(
                      'Sleeper ',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: widget.textPrimary,
                      ),
                    ),

   ],),
 ],
),
Divider(height: 25,),


                        _buildBerthTypeInfo(),

            // const SizedBox(height: 16),
            // _buildSeatTypeIndicators(),
            // const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }

 

  Widget _buildIndicatorItem(Color color, String title, String subtitle) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: widget.textPrimary,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10,
                color: widget.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

Widget _buildBerthTypeInfo() {
  return Column(
    children: [
      seatinfoRow(
        txt: 'Available'
        ,colorinfo: widget.primaryColor
      ),seatinfoRow(
        txt: 'Available only for male passenger'
        ,colorinfo:Colors.blue
      ),seatinfoRow(
        txt: 'Already booked'
        ,colorinfo: Colors.grey
      ),seatinfoRow(
        txt: 'Selected by you'
        ,colorinfo: widget.secondaryColor
      ),seatinfoRow(
        txt: 'Available only for female passenger'
        ,colorinfo:Colors.pink
      ),
    ],
  );
}

Widget seatinfoRow(


  {required String txt,
      required Color colorinfo,

  
  }
) {
  return 
  
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        Expanded(child: Text(txt,style: TextStyle(fontSize: 12),)),
    
    
    
            Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

              
              children: [
        
        SeaterIn(colorinfo: colorinfo),
        SizedBox(width: 
        10),
            // Sleeper Section
            SleaperIn(colorinfo:colorinfo),
            ],)
            // Seater Section
          
          ],
        ),
  );
}

}

class SleaperIn extends StatelessWidget {
  const SleaperIn({
    super.key,
    required this.colorinfo,
  });

    final Color colorinfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border.all(color:colorinfo.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          Container(
            height: 7,
            width: 25,
            color: colorinfo,
          ),
          const SizedBox(height: 14),
          Container(
            height: 3,
            width: 20,
            color: colorinfo,
          ),
        ],
      ),
    );
  }
}

class SeaterIn extends StatelessWidget {
  const SeaterIn({
    super.key,
    required this.colorinfo,
  });

  final Color colorinfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border.all(color: colorinfo.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
         
          const SizedBox(height: 15),
          Container(
            height: 3,
            width: 20,
            color: colorinfo,
          ),
        ],
      ),
    );
  }
}