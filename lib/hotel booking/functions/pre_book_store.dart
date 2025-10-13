// pre_book_service.dart
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:minna/comman/core/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreBookService {
  static const String _baseUrl = '${baseUrl}hotel-api-call-prebook';

  Future<Map<String, dynamic>> callPrebookCallback({
    required String bookingCode,
    required int noOfRooms,
    required String hotelCode,
    required Map<String, dynamic> response,
    required double serviceCharge,
    required double amount,
  }) async {
    try {


  SharedPreferences preferences = await SharedPreferences.getInstance();
       final userId = preferences.getString('userId') ?? '';




      final Map<String, dynamic> requestBody = {
        'userId': userId,
        'bookingCode': bookingCode,
        'noOfRooms': noOfRooms.toString(),
        'hotelCode': hotelCode,
        'response': json.encode(response), // Convert to JSON string
        'serviceCharge': serviceCharge.toString(),
        'amount': amount.toString(),
      };
      log(requestBody.toString());
      final http.Response httpResponse = await http.post(
        Uri.parse(_baseUrl),
        // headers: {
        //   'Content-Type': 'application/json',
        // },
        body: requestBody,
      );
log(httpResponse.body);
      if (httpResponse.statusCode == 200) {
        return json.decode(httpResponse.body);
      } else {
        return {
          'status': 'ERROR',
          'statusCode': httpResponse.statusCode,
          'statusDesc': 'HTTP Error: ${httpResponse.statusCode}',
        };
      }
    } catch (e) {
      log(e.toString());
      return {
        'status': 'ERROR',
        'statusCode': -1,
        'statusDesc': 'Network Error: $e',
      };
    }
  }
}