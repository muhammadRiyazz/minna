import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/cab/application/fetch%20cab/fetch_cabs_bloc.dart';
import 'package:minna/cab/application/fetch%20cab/fetch_cabs_state.dart';
import 'package:minna/cab/domain/cab%20list%20model/cab_list_data.dart';
import 'package:minna/cab/pages/booking_hold/booking_hold_input.dart';
import 'package:minna/comman/const/const.dart';

class CabsListPage extends StatelessWidget {
  final Map<String, dynamic> requestData;

  const CabsListPage({Key? key, required this.requestData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchCabsBloc()..add(FetchCabsEvent.fetchCabs(requestData: requestData)),
      child: Scaffold(
        appBar: AppBar(
          titleTextStyle: TextStyle(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "Available Cabs",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          backgroundColor: maincolor1,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
        ),
        body: BlocBuilder<FetchCabsBloc, FetchCabsState>(
          builder: (context, state) {
            if (state is FetchCabsLoading) {
              return _buildShimmerLoading();
            } else if (state is FetchCabsError) {
              return _buildErrorState(state.message);
            } else if (state is FetchCabsSuccess) {
              return _buildCabList(state.data);
            } else {
              return _buildInitialState();
            }
          },
        ),
      ),
    );
  }

  Widget _buildInitialState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.directions_car, size: 64, color: maincolor1),
          SizedBox(height: 16),
          Text(
            "Finding the best cabs for you...",
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text(
              "Something went wrong",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
(context) => FetchCabsBloc()..add(FetchCabsEvent.fetchCabs(requestData: requestData));              },
              style: ElevatedButton.styleFrom(
                backgroundColor: maincolor1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text(
                "Try Again",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCabList(CabResponse cabResponse) {
    final cabRateList = cabResponse.data.cabRate;
    
    if (cabRateList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              "No cabs available",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Try changing your search parameters",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: cabRateList.length,
      itemBuilder: (context, index) {
        final cabData = cabRateList[index];
        final cab = cabData.cab;
        final fare = cabData.fare;
    
        return Card(
    
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cab Type + Fare
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Car Image
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: 80,
                      width: 90,
                      child: cab.image.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                cab.image,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.directions_car, 
                                      size: 40, color: maincolor1);
                                },
                              ),
                            )
                          : Icon(Icons.directions_car, size: 40, color: maincolor1),
                    ),
                    const SizedBox(width: 12),
    
                    // Cab Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cab.category,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            cab.model,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(
                                Icons.event_seat,
                                size: 18,
                                color: maincolor1,
                              ),
                              SizedBox(width: 4),
                              Text("${cab.seatingCapacity} seats"),
                              SizedBox(width: 12),
                              Icon(
                                Icons.work,
                                size: 18,
                                color: Colors.orange,
                              ),
                              SizedBox(width: 4),
                              Text("${cab.bagCapacity} bags"),
                            ],
                          ),
                        ],
                      ),
                    ),
    
                    // Fare
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "₹${fare.totalAmount?.toStringAsFixed(0) ?? '0'}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: maincolor1,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Base: ₹${fare.baseFare.toStringAsFixed(0)}",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
    
                const Divider(height: 20),
    
                // Extra Info Row
                Row(
                  children: [
                    Icon(
                      Icons.local_gas_station,
                      size: 16,
                      color: maincolor1,
                    ),
                    SizedBox(width: 4),
                    Text(cab.fuelType ?? "Petrol"),
                    Spacer(),
                    Text(
                      "Policy: ${cabData.cancellationPolicy}",
                      style: TextStyle(color: Colors.red[700], fontSize: 12),
                    ),
                  ],
                ),
    
                const SizedBox(height: 10),
    
                // Instructions
                Wrap(
                  spacing: 6,
                  runSpacing: -6,
                  children: List.generate(
                    cab.instructions.length,
                    (i) => Chip(
                      label: Text(
                        cab.instructions[i],
                        style: TextStyle(fontSize: 11),
                      ),
                      backgroundColor: Colors.blue[50],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: Colors.grey,
                          width: .6,
                        ),
                      ),
                    ),
                  ),
                ),
    
                const SizedBox(height: 12),
    
                // Book Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {

 
                //  context.read<FetchCabsBloc>().add(FetchCabsEvent.cabSelected(selectedCabData: cabData));
Navigator.push(context, MaterialPageRoute(builder: (context) =>  BookingPage(
          selectedCab: cabData,
          requestData: requestData, // pass your trip request
        ),));
log(cabData.toJson().toString());
       
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: maincolor1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      "Book Now",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 4, // Show 4 shimmer items
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cab Type + Fare (Shimmer)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Car Image Shimmer
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: 80,
                      width: 100,
                    ),
                    const SizedBox(width: 12),

                    // Cab Info Shimmer
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 18,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: 120,
                            height: 14,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                width: 60,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              SizedBox(width: 20),
                              Container(
                                width: 60,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Fare Shimmer
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 60,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 80,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                // Divider Shimmer
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 16),

                // Extra Info Row Shimmer
                Row(
                  children: [
                    Container(
                      width: 80,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 120,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Instructions Shimmer
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: List.generate(
                    3,
                    (i) => Container(
                      width: 80,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Book Button Shimmer
                Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}