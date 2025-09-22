import 'dart:developer';

import 'package:minna/bus/application/busListfetch/bus_list_fetch_bloc.dart';
import 'package:minna/bus/application/busListfetch/bus_list_fetch_state.dart';
import 'package:minna/bus/application/change%20location/location_bloc.dart';
import 'package:minna/bus/pages/Screen%20available%20Trip/widgets/trip_container.dart';
import 'package:minna/bus/presendation/widgets/error_widget.dart';
import 'package:minna/bus/domain/trips%20list%20modal/trip_list_modal.dart';
import 'package:minna/comman/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ScreenAvailableTrips extends StatelessWidget {
  const ScreenAvailableTrips({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedData = context.read<LocationBloc>().state;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      appBar: AppBar(
        backgroundColor: maincolor1,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Row(
            children: [
              Text(
                DateFormat('d MMMM yyyy').format(selectedData.dateOfJourney),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              const SizedBox(width: 5),
              const Icon(Icons.date_range, color: Colors.white, size: 17),
              const SizedBox(width: 15),
            ],
          ),
        ],
      ),
      body: BlocBuilder<BusListFetchBloc, BusListFetchState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const BusListloadingPage();
          }

          if (state.isError) {
            return Erroricon(
              ontap: () {
                // Add retry logic here if needed
                context.read<BusListFetchBloc>().add(
                  FetchTrip(
                    dateOfjurny: selectedData.dateOfJourney,
                    destID: selectedData.to!,
                    sourceID: selectedData.from!,
                  ),
                );
              },
            );
          }

          if (state.notripp! ||
              state.availableTrips == null ||
              state.availableTrips!.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Main message
                    Text(
                      'Oops! No buses found',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Sub message
                    Text(
                      'We couldn\'t find any buses for your selected route and date',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            );
          }

          return SafeArea(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(color: maincolor1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedData.from?.name ?? '--',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const SizedBox(height: 5),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                  ),
                                  child: Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: maincolor1,
                                  ),
                                  padding: const EdgeInsets.all(6),
                                  child: const Icon(
                                    Icons.directions_bus_outlined,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              selectedData.to?.name ?? '--',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.availableTrips!.length,
                    itemBuilder: (context, index) {
                      final startfare = faredecode(
                        fare: state.availableTrips![index].fareDetails,
                      );
                      final arrivalTime = changetime(
                        time: state.availableTrips![index].arrivalTime,
                      );
                      final departureTime = changetime(
                        time: state.availableTrips![index].departureTime,
                      );
                      return TripCountainer(
                        index: index,
                        availableTriplist: state.availableTrips!,
                        startfare: startfare,
                        departureTime: departureTime,
                        arrivalTime: arrivalTime,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String changetime({required String time}) {
    final int tim = int.parse(time);
    int journeyDay = tim ~/ (24 * 60);
    int remainingTime = tim % (24 * 60);
    int hour = remainingTime ~/ 60;
    int minutes = remainingTime % 60;

    String timePeriod = hour >= 12 ? 'P.M' : 'A.M';
    hour = hour > 12 ? hour - 12 : hour;
    hour = hour == 0 ? 12 : hour;

    return '${hour.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} $timePeriod';
  }

  double faredecode({required dynamic fare}) {
    List<FareDetail> fareList;

    if (fare is List<FareDetail>) {
      fareList = fare;
    } else if (fare is FareDetail) {
      fareList = [fare];
    } else {
      return 0.0;
    }

    if (fareList.isEmpty) return 0.0;

    num smallestValue = double.parse(fareList[0].baseFare);

    for (int i = 1; i < fareList.length; i++) {
      num currentValue = double.parse(fareList[i].baseFare);
      if (currentValue < smallestValue) {
        smallestValue = currentValue;
      }
    }

    return double.parse(smallestValue.toString());
  }
}

String changetime({required String time}) {
  final int tim = int.parse(time);
  int journeyDay = tim ~/ (24 * 60);
  int remainingTime = tim % (24 * 60);
  int hour = remainingTime ~/ 60;
  int minutes = remainingTime % 60;

  String timePeriod = hour >= 12 ? 'P.M' : 'A.M';
  hour = hour > 12 ? hour - 12 : hour;
  hour = hour == 0 ? 12 : hour;

  String formattedTime =
      '${hour.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} $timePeriod';

  print('Exact Time Format: $formattedTime');
  print('Journey Day: $journeyDay');

  // final double count = int.parse(time) / 60;
  // int decimalPart = ((count - count.floor()) * 100).toInt();

  // final hour = count.toInt() % 24;

  // String time24 = '$hour:$decimalPart';

  // DateFormat format24 = DateFormat('HH:mm');
  // DateFormat format12 = DateFormat('h:mm a');

  // DateTime dateTime = format24.parse(time24);
  // String time12 = format12.format(dateTime);
  return formattedTime;
}

double faredecode({required dynamic fare}) {
  List<FareDetail> fareList;

  // Handle both single FareDetail and List<FareDetail>
  if (fare is List<FareDetail>) {
    fareList = fare;
  } else if (fare is FareDetail) {
    fareList = [fare];
  } else {
    // Default value if fare is neither type
    return 0.0;
  }

  if (fareList.isEmpty) return 0.0;

  num smallestValue = double.parse(fareList[0].baseFare);

  for (int i = 1; i < fareList.length; i++) {
    num currentValue = double.parse(fareList[i].baseFare);
    log(fareList[i].baseFare);

    if (currentValue < smallestValue) {
      smallestValue = currentValue;
    }
  }

  return double.parse(smallestValue.toString());
}

// state.isError
//               ? Erroricon(
//                 ontap: () {
//                   log('errrororooror');
//                 },
//               )
//               : state.notripp!
//               ? Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Lottie.asset('asset/90333-error.json'),
//                     SizedBox(height: 10),
//                     Text(
//                       'Trip is not available.\n Please select another location or date',
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               )
//               : state.availableTrips!.isEmpty
//               ? Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(13.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Trip is not available.\nTo view more results, try changing the search filters you applied',
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 10),
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: ElevatedButton(
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all<Color>(
//                               maincolor1,
//                             ),
//                           ),
//                           onPressed: () {
//                             BlocProvider.of<BusFilterSelectionBloc>(
//                               context,
//                             ).add(
//                               SelectFilter(
//                                 arrivalTimes: [false, false, false, false],
//                                 busTypeslist: [false, false, false, false],
//                                 departureTimes: [false, false, false, false],
//                               ),
//                             );
//                             // BlocProvider.of<BusTripListBloc>(context).add(
//                             //   FetchTrip(
//                             //     dateOfjurny: globalPostRedBus.dateOfJurny,
//                             //     destID: globalPostRedBus.idToLocation,
//                             //     sourceID: globalPostRedBus.idFromLocation,
//                             //   ),
//                             // );
//                           },
//                           child: SizedBox(
//                             height: 50,
//                             width: double.infinity,
//                             child: Center(
//                               child: Text(
//                                 'Clear All Filter',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//
class BusListloadingPage extends StatelessWidget {
  const BusListloadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              // Airline logo and flight code
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 70,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 80,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Flight route and timing
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 110,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 70,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Duration and plane icon
                  Column(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 50,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Icon(
                          Icons.directions_bus_filled_rounded,
                          size: 15,
                        ),
                      ),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 120,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 80,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Price and buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 80,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),

                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 100,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
