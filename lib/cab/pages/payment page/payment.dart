import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/cab/application/hold%20cab/hold_cab_bloc.dart';
import 'package:minna/cab/domain/hold%20data/hold_data.dart';
import 'package:minna/comman/const/const.dart';
import 'package:shimmer/shimmer.dart';

class BookingConfirmationPage extends StatelessWidget {
  const BookingConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Booking Confirmation",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: maincolor1,
        iconTheme: IconThemeData(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      body: BlocBuilder<HoldCabBloc, HoldCabState>(
        builder: (context, state) {
          if (state is HoldCabLoading) {
            return _buildShimmerLoading();
          } else if (state is HoldCabSuccess) {
            final bookingData = state.data;
            return _buildContent(bookingData, context);
          } else if (state is HoldCabError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.red),
                    SizedBox(height: 16),
                    Text(
                      "Error Occurred",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Go Back"),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildContent(BookingData bookingData, BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTripInformation(bookingData),
                SizedBox(height: 10),
                _buildCabDetails(bookingData),
                SizedBox(height: 10),
                _buildFareBreakdown(bookingData),
              ],
            ),
          ),
        ),
        _buildPaymentButton(bookingData, context),
      ],
    );
  }

  Widget _buildShimmerLoading() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          SizedBox(height: 20),
          
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(height: 20),
          
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(height: 20),
          
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(height: 20),
          
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(height: 20),
          
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripInformation(BookingData bookingData) {
    log(bookingData.tripType.toString());
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          // BoxShadow(
          //   color: Colors.black12,
          //   blurRadius: 8,
          //   offset: Offset(0, 2),
          // ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.route, color: maincolor1, size: 22),
                SizedBox(width: 10),
                Text(
                  "Trip Information",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: maincolor1,
                  ),
                ),
              ],
            ),
            // SizedBox(height: 20),
            
            // Display different UI based on trip type
            if (bookingData.tripType == 1) // One Way
              _buildOneWayTrip(bookingData),
            
            if (bookingData.tripType == 2) // Round Trip
              _buildRoundTrip(bookingData),
            
            if (bookingData.tripType == 3) // Multi City
              _buildMultiCityTrip(bookingData),
            
            if (bookingData.tripType == 4) // Airport Transfer
              _buildAirportTransfer(bookingData),
            
            if (bookingData.tripType == 10) // Day Rental
              _buildDayRental(bookingData),
            
            Divider(
              height: 30,
              thickness: 1,
              color: Colors.grey[200],
            ),
            
            // Common trip details
            Wrap(
              spacing: 20,
              runSpacing: 15,
              children: [
                _buildInfoChip(
                  Icons.calendar_today,
                  "Date",
                  bookingData.startDate,
                ),

                _buildInfoChip(
                  Icons.access_time,
                  "Time",
                  bookingData.startTime,
                ),
                _buildInfoChip(
                  Icons.alt_route,
                  "Distance",
                  "${bookingData.totalDistance} km",
                ),
              _buildInfoChip(
  Icons.timer,
  "Duration",
  formatDuration(bookingData.estimatedDuration.toInt()),
),

                _buildInfoChip(
                  Icons.directions_car,
                  "Trip Type",
                  bookingData.tripDesc,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }String formatDuration(int minutes) {
  final hours = minutes ~/ 60; // integer division
  final mins = minutes % 60;   // remainder
  if (hours > 0 && mins > 0) {
    return "$hours hr $mins min";
  } else if (hours > 0) {
    return "$hours hr";
  } else {
    return "$mins min";
  }
}

// ✅ One Way Trip UI
Widget _buildOneWayTrip(BookingData bookingData) {
  final route = bookingData.routes.first;
  return _buildHorizontalRouteCard(
    route.source.address,
    route.destination.address,
  );
}

// ✅ Round Trip UI
Widget _buildRoundTrip(BookingData bookingData) {
  final route = bookingData.routes.first;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildHorizontalRouteCard(
        route.source.address,
        route.destination.address,
        label: "Onward",
      ),
      SizedBox(height: 10),
      _buildHorizontalRouteCard(
        route.destination.address,
        route.source.address,
        label: "Return",
      ),
    ],
  );
}

// ✅ Multi-City Trip UI
Widget _buildMultiCityTrip(BookingData bookingData) {
  return SizedBox(
    height: 100,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: bookingData.routes.length,
      itemBuilder: (context, index) {
        final route = bookingData.routes[index];
        return _buildHorizontalRouteCard(
          route.source.address,
          route.destination.address,
          label: "Leg ${index + 1}",
        );
      },
    ),
  );
}

// ✅ Airport Transfer UI
Widget _buildAirportTransfer(BookingData bookingData) {
  final route = bookingData.routes.first;
  return _buildHorizontalRouteCard(
    route.source.address,
    route.destination.address,
    label: "Airport Transfer",
  );
}

// ✅ Day Rental UI
Widget _buildDayRental(BookingData bookingData) {
  final route = bookingData.routes.first;
  return _buildHorizontalRouteCard(
    route.source.address,
    route.destination.address,
    label: "Day Rental",
  );
}

/// 🔥 Reusable Horizontal Route Card
Widget _buildHorizontalRouteCard(
  String source,
  String destination, {
  String? label,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Column(
          children: [
            Icon(Icons.circle, size: 10, color: Colors.green),
            Container(
              width: 2,
              height: 30,
              color: Colors.grey,
            ),
            Icon(Icons.location_on, size: 18, color: Colors.red),
          ],
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (label != null)
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey,
                  ),
                ),
              Text(
                source,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey)),
                  Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
                  Expanded(child: Divider(color: Colors.grey)),
                ],
              ),
              Text(
                destination,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


  Widget _buildInfoChip(IconData icon, String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: maincolor1),
          SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCabDetails(BookingData bookingData) {
    final cab = bookingData.cabRate?.cab;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Cab Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: maincolor1,
              ),
            ),
            SizedBox(height: 16),
            if (cab != null) ...[
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: cab.image.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(cab.image, fit: BoxFit.contain),
                          )
                        : Icon(
                            Icons.directions_car,
                            size: 30,
                            color: maincolor1,
                          ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cab.type,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          cab.category,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  _buildFeatureChip(
                    "${cab.seatingCapacity} Seats",
                    Icons.people,
                  ),
                  _buildFeatureChip("${cab.bagCapacity} Bags", Icons.luggage),
                  if (cab.isAssured == "1")
                    _buildFeatureChip("Assured", Icons.verified),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFareBreakdown(BookingData bookingData) {
    final fare = bookingData.cabRate?.fare;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Fare Breakdown",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: maincolor1,
              ),
            ),
            SizedBox(height: 16),
            if (fare != null) ...[
              _buildFareRow("Base Fare", "₹${fare.baseFare}"),
              if (fare.driverAllowance > 0)
                _buildFareRow("Driver Allowance", "₹${fare.driverAllowance}"),
              if (fare.gst > 0) _buildFareRow("GST", "₹${fare.gst}"),
              if (fare.stateTax > 0)
                _buildFareRow("State Tax", "₹${fare.stateTax}"),
              if (fare.tollTax > 0)
                _buildFareRow("Toll Tax", "₹${fare.tollTax}"),
              if (fare.airportFee > 0)
                _buildFareRow("Airport Fee", "₹${fare.airportFee}"),
              if (fare.additionalCharge > 0)
                _buildFareRow(
                  "Additional Charges",
                  "₹${fare.additionalCharge}",
                ),
              Divider(height: 24),
              _buildFareRow(
                "Total Amount",
                "₹${fare.totalAmount}",
                isTotal: true,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentButton(BookingData bookingData, BuildContext context) {
    final fare = bookingData.cabRate?.fare;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Amount to Pay:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                "₹${fare?.totalAmount ?? 0}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: maincolor1,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // Handle payment
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: maincolor1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: Text(
                "PROCEED TO PAYMENT",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFareRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isTotal ? Colors.black : Colors.grey[600],
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: isTotal ? maincolor1 : Colors.black,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(String text, IconData icon) {
    return Chip(
      label: Text(text),
      avatar: Icon(icon, size: 16),
      backgroundColor: Colors.blue.shade50,
      labelStyle: TextStyle(fontSize: 12),
      visualDensity: VisualDensity.compact,
    );
  }
}