import 'package:flutter/material.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/pages/main%20home/home.dart';

class ScreenSuccessTicket extends StatefulWidget {
  final String tinid;
  final int passengercount;

  const ScreenSuccessTicket({
    super.key,
    required this.tinid,
    required this.passengercount,
  });

  @override
  State<ScreenSuccessTicket> createState() => _ScreenSuccessTicketState();
}

class _ScreenSuccessTicketState extends State<ScreenSuccessTicket> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: maincolor1,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 70,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Ticket Booked Successfully!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Ticket ID: ${widget.tinid}',
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 15),

                  const Text(
                    'Your ticket has been sent to your\nregistered mobile number and email.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: maincolor1,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                      shadowColor: maincolor1!.withOpacity(0.3),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => HomePage()),
                        (route) => false,
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.confirmation_num, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          'Go Home',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void _showConfirmationDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         elevation: 5,
  //         child: Padding(
  //           padding: const EdgeInsets.all(20),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Container(
  //                 padding: const EdgeInsets.all(12),
  //                 decoration: BoxDecoration(
  //                   color: maincolor1!.withOpacity(0.2),
  //                   shape: BoxShape.circle,
  //                 ),
  //                 child: Icon(
  //                   Icons.confirmation_num,
  //                   size: 40,
  //                   color: maincolor1,
  //                 ),
  //               ),
  //               const SizedBox(height: 20),
  //               const Text(
  //                 'View Your Ticket?',
  //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //               ),
  //               const SizedBox(height: 10),
  //               const Text(
  //                 'Would you like to see your bus ticket details now?',
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(fontSize: 16, color: Colors.grey),
  //               ),
  //               const SizedBox(height: 30),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: OutlinedButton(
  //                       style: OutlinedButton.styleFrom(
  //                         padding: const EdgeInsets.symmetric(vertical: 15),
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(10),
  //                         ),
  //                         side: BorderSide(color: Colors.grey.shade300),
  //                       ),
  //                       onPressed: () {
  //                         Navigator.pushAndRemoveUntil(
  //                           context,
  //                           MaterialPageRoute(builder: (_) => HomePage()),
  //                           (route) => false,
  //                         );
  //                       },
  //                       child: const Text(
  //                         'Go Home',
  //                         style: TextStyle(fontSize: 14, color: Colors.black87),
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(width: 15),
  //                   Expanded(
  //                     child: ElevatedButton(
  //                       style: ElevatedButton.styleFrom(
  //                         backgroundColor: maincolor1,
  //                         padding: const EdgeInsets.symmetric(vertical: 15),
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(10),
  //                         ),
  //                       ),
  //                       onPressed: () {
  //                         Navigator.pop(context); // Close dialog
  //                         Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                             builder: (_) => ScreenViewTicket(
  //                               tinid: widget.tinid,
  //                               passengercount: widget.passengercount,
  //                             ),
  //                           ),
  //                         );
  //                       },
  //                       child: const Text(
  //                         'View Ticket',
  //                         style: TextStyle(fontSize: 16, color: Colors.white),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
