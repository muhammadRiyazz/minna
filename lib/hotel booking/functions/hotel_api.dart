import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:minna/comman/core/api.dart';
import 'package:minna/hotel%20booking/core/core.dart';
import 'package:minna/hotel%20booking/domain/Nation%20and%20city/city.dart';
import 'package:minna/hotel%20booking/domain/Nation%20and%20city/nation';
import 'package:minna/hotel%20booking/domain/hotel%20list/hotel_list.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  String getUserFriendlyMessage() {
    if (statusCode == 401) return 'Authentication failed. Please try again.';
    if (statusCode == 404) return 'Resource not found.';
    if (statusCode == 500) return 'Server error. Please try again later.';
    if (message.contains('timeout'))
      return 'Request timeout. Check your connection.';
    if (message.contains('socket'))
      return 'Network error. Check your internet connection.';
    return message;
  }

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}

class HotelApiService {
  final http.Client _client;

  HotelApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<HotelSearchResponse> searchHotels({
    required String country,
    required String city,
    required String checkIn,
    required String checkOut,
    required List<Map<String, dynamic>> rooms,
    int offset = 0,
    int limit = 200,
  }) async {
    try {
      log('🔍 Hotel Search Request via callback:');
      log('   City: $city');
      log('   Check-in: $checkIn');
      log('   Check-out: $checkOut');
      log('   Rooms: ${rooms.length}');
      log('   Offset: $offset, Limit: $limit');

      // Map rooms to the format expected by the backend
      final mappedRooms = rooms.map((room) {
        return {
          "Adults": room['adults'] as int? ?? 1,
          "Children": room['children'] as int? ?? 0,
          "ChildrenAges": room['childrenAges'] as List<int>? ?? [],
        };
      }).toList();

      final searchUrl = Uri.parse('$baseUrl/hotel-api-search');
      log('📡 Search API URL: $searchUrl');

      final requestBody = {
        "city": jsonEncode({"CityCode": city}),
        "CheckIn": checkIn,
        "CheckOut": checkOut,
        "offset": offset.toString(),
        "limit": limit.toString(),
        "rooms": jsonEncode(mappedRooms),
      };

      log('📡 Search Request body: ${jsonEncode(requestBody)}');

      final response = await _client.post(searchUrl, body: requestBody);

      log('📡 Search Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        log('✅ Search successful, total: ${data['total']}');
        return HotelSearchResponse.fromJson(data);
      } else {
        log('❌ Search API Error: ${response.statusCode} - ${response.body}');
        throw ApiException(
          'API returned status code ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on http.ClientException catch (e) {
      log('❌ Search HTTP Client Error: $e');
      throw ApiException('Network error: ${e.message}');
    } catch (e, stackTrace) {
      log('❌ Search Unexpected Error: $e');
      log('Stack trace: $stackTrace');
      throw ApiException('Failed to search hotels: ${e.toString()}');
    }
  }
  // final http.Client _client = http.Client();

  // Basic Authentication credentials for static APIs
  String get _basicAuth =>
      'Basic ${base64Encode(utf8.encode('$hotelusername:$hoteluserpass'))}';
  // Base64 encoded authorization header
  Future<List<CountryModel>> getCountries() async {
    log("getCountries via callback----");

    try {
      // final response = await _client.get(
      //   Uri.parse(
      //     'http://api.tbotechnology.in/TBOHolidays_HotelAPI/CountryList',
      //   ),
      //   headers: {
      //     'Authorization': _basicAuth,
      //     'Content-Type': 'application/json',
      //   },
      // );

      final response = await _client.post(
        Uri.parse('$baseUrl/hotel-api-call-basic'),
        body: {
          'url': 'CountryList',
          'isLive': liveOrStage.toString(),
          'datas': json.encode(
            [],
          ), // Empty array as per TBO spec for CountryList
        },
      );

      log('Response from callback (CountryList): ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final data = responseData['data'];

        if (data != null && data['Status']['Code'] == 200) {
          final List<dynamic> countryList = data['CountryList'];
          return countryList
              .map((json) => CountryModel.fromJson(json))
              .toList();
        } else {
          final errorMessage = data != null
              ? data['Status']['Description']
              : 'Unknown error from backend';
          throw Exception('Failed to load countries: $errorMessage');
        }
      } else {
        throw Exception(
          'Failed to load countries: Status code ${response.statusCode}',
        );
      }
    } catch (e) {
      log('Error in getCountries: ${e.toString()}');
      throw Exception('Failed to load countries: $e');
    }
  }

  Future<List<HotelCityHotel>> getCities(String countryCode) async {
    log("getCities via callback----");

    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/hotel-api-call-basic'),
        body: {
          'url': 'CityList',
          'isLive': liveOrStage.toString(),
          'datas': json.encode({'CountryCode': countryCode}),
        },
      );

      log('Response from callback (CityList): ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final data = responseData['data'];

        if (data != null && data['Status']['Code'] == 200) {
          final List<dynamic> cityList = data['CityList'];
          return cityList.map((json) => HotelCityHotel.fromJson(json)).toList();
        } else {
          final errorMessage = data != null
              ? data['Status']['Description']
              : 'Unknown error from backend';
          throw Exception('Failed to load cities: $errorMessage');
        }
      } else {
        throw Exception(
          'Failed to load cities: Status code ${response.statusCode}',
        );
      }
    } catch (e) {
      log('Error in getCities: ${e.toString()}');
      throw Exception('Failed to load cities: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}
