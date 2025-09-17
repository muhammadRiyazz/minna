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
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
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
                  "${bookingData.estimatedDuration} mins",
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
  }

  Widget _buildOneWayTrip(BookingData bookingData) {
    final route = bookingData.routes.isNotEmpty ? bookingData.routes.first : null;
    
    return Column(
      children: [
        if (route != null) ...[
          _buildEnhancedLocationRow(
            "Pickup Location",
            route.source.address,
            Icons.location_on,
            Colors.green,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Container(
              margin: EdgeInsets.only(left: 14),
              height: 20,
              width: 2,
              color: maincolor1?.withOpacity(0.3),
            ),
          ),
          _buildEnhancedLocationRow(
            "Drop Location",
            route.destination.address,
            Icons.flag,
            Colors.red,
          ),
        ],
      ],
    );
  }

  Widget _buildRoundTrip(BookingData bookingData) {
    return Column(
      children: [
        if (bookingData.routes.length >= 2) ...[
          _buildEnhancedLocationRow(
            "Outbound - From",
            bookingData.routes[0].source.address,
            Icons.location_on,
            Colors.green,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Container(
              margin: EdgeInsets.only(left: 14),
              height: 10,
              width: 2,
              color: maincolor1!.withOpacity(0.3),
            ),
          ),
          _buildEnhancedLocationRow(
            "Outbound - To",
            bookingData.routes[0].destination.address,
            Icons.flag,
            Colors.blue,
          ),
          SizedBox(height: 16),
          _buildEnhancedLocationRow(
            "Return - From",
            bookingData.routes[1].source.address,
            Icons.location_on,
            Colors.orange,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Container(
              margin: EdgeInsets.only(left: 14),
              height: 10,
              width: 2,
              color: maincolor1!.withOpacity(0.3),
            ),
          ),
          _buildEnhancedLocationRow(
            "Return - To",
            bookingData.routes[1].destination.address,
            Icons.flag,
            Colors.purple,
          ),
        ],
      ],
    );
  }

  Widget _buildMultiCityTrip(BookingData bookingData) {
    return Column(
      children: [
        for (int i = 0; i < bookingData.routes.length; i++)
          Column(
            children: [
              if (i > 0) SizedBox(height: 16),
              Text(
                "Stop ${i + 1}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: maincolor1,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 8),
              _buildEnhancedLocationRow(
                "From",
                bookingData.routes[i].source.address,
                Icons.location_on,
                Colors.blue,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Container(
                  margin: EdgeInsets.only(left: 14),
                  height: 10,
                  width: 2,
                  color: maincolor1!.withOpacity(0.3),
                ),
              ),
              _buildEnhancedLocationRow(
                "To",
                bookingData.routes[i].destination.address,
                Icons.flag,
                Colors.green,
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildAirportTransfer(BookingData bookingData) {
    final route = bookingData.routes.isNotEmpty ? bookingData.routes.first : null;
    final isAirportPickup = route?.source.address.toLowerCase().contains("airport") ?? false;
    
    return Column(
      children: [
        if (route != null) ...[
          _buildEnhancedLocationRow(
            isAirportPickup ? "Airport" : "Pickup Location",
            route.source.address,
            isAirportPickup ? Icons.airplanemode_active : Icons.location_on,
            isAirportPickup ? Colors.blue : Colors.green,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Container(
              margin: EdgeInsets.only(left: 14),
              height: 20,
              width: 2,
              color: maincolor1!.withOpacity(0.3),
            ),
          ),
          _buildEnhancedLocationRow(
            isAirportPickup ? "Drop Location" : "Airport",
            route.destination.address,
            isAirportPickup ? Icons.flag : Icons.airplanemode_active,
            isAirportPickup ? Colors.red : Colors.blue,
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue, size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    isAirportPickup 
                      ? "Airport pickup with flight tracking included"
                      : "Airport drop with flight details",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDayRental(BookingData bookingData) {
    final route = bookingData.routes.isNotEmpty ? bookingData.routes.first : null;
    
    return Column(
      children: [
        if (route != null) ...[
          _buildEnhancedLocationRow(
            "Starting Location",
            route.source.address,
            Icons.location_on,
            Colors.green,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Container(
              margin: EdgeInsets.only(left: 14),
              height: 20,
              width: 2,
              // ignore: deprecated_member_use
              color: maincolor1!.withOpacity(0.3),
            ),
          ),
          _buildEnhancedLocationRow(
            "Ending Location",
            route.destination.address,
            Icons.flag,
            Colors.red,
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange[50],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(Icons.timer, color: Colors.orange, size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Day rental package: ${bookingData.totalDistance} km / ${bookingData.estimatedDuration ~/ 60} hours",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.orange[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildEnhancedLocationRow(String title, String address, IconData icon, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 18, color: color),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                address,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
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
      elevation: 2,
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
                      color: Colors.blue.shade100,
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
      elevation: 2,
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