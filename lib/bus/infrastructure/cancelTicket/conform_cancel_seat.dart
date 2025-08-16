import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:minna/comman/core/api.dart'; // Ensure baseUrl is correct
import '../../domain/Ticket details/ticket_details_more1.dart';

Future<http.Response?> cancelSeats({
  required String tin,
  required List<InventoryItem> seats,
}) async {
  try {
    log('Starting seat cancellation request for TIN: $tin');

    // Prepare seat list
    final seatList = seats.map((e) => e.seatName).toList();
    log('Seats to cancel: ${seatList.join(', ')}');

    // Get user credentials
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('userId');

    if (userId == null) {
      log("User credentials not found in SharedPreferences");
      return null;
    }

    log("User ID: $userId");

    // Prepare request
    const String endpoint = "CallAPI";
    final String url = "$baseUrl$endpoint";

    final Map<String, dynamic> requestBody = {
      "url": "http://api.seatseller.travel/cancelticket",
      "method": "POST",
      "user_id": userId,
      "franch_id": "",
      "data": jsonEncode({"tin": tin, "seatsToCancel": seatList}),
    };

    log("Sending seat cancellation request to: $url");
    final response = await http.post(Uri.parse(url), body: requestBody);

    log("Seat cancellation response received: ${response.statusCode}");
    log("Response body: ${response.body}");

    return response;
  } catch (e, stackTrace) {
    log("Error in cancelSeats: $e", stackTrace: stackTrace);
    return null;
  }
}
