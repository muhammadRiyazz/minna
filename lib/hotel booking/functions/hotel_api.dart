import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
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
    if (message.contains('timeout')) return 'Request timeout. Check your connection.';
    if (message.contains('socket')) return 'Network error. Check your internet connection.';
    return message;
  }

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}

class HotelApiService {
  static const String _baseUrl = 'http://tictechnologies.in/stage/minna';
 
  final http.Client _client;

  HotelApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<HotelSearchResponse> searchHotels({
    required String country,
    required String city,
    required String checkIn,
    required String checkOut,
    required List<Map<String, dynamic>> rooms,
  }) async {

    try {
      log('🔍 Hotel Search Request:');
      log('   Country: $country');
      log('   City: $city');
      log('   Check-in: $checkIn');
      log('   Check-out: $checkOut');
      log('   Rooms: ${rooms.length}');

      // final request = HotelSearchRequest(
      //   country: country,
      //   city: city,
      //   checkIn: checkIn,
      //   checkOut: checkOut,
      //   rooms: rooms,
      // );

      final url = Uri.parse('$_baseUrl/hotel-api-search');
      log('📡 API URL: $url');

     final response = await _client.post(
  url,

  body: {
    "country": country,
    "city": city,
    "CheckIn": checkIn,
    "CheckOut": checkOut,
    "rooms": jsonEncode(rooms) , 
  },
);


      log('📡 Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        log('✅ Search successful, total hotels: ${data['totalHotels']}');
        return HotelSearchResponse.fromJson(data);
      } else {
        log('❌ API Error: ${response.statusCode} - ${response.body}');
        throw ApiException(
          'API returned status code ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on http.ClientException catch (e) {
      log('❌ HTTP Client Error: $e');
      throw ApiException('Network error: ${e.message}');
    } catch (e, stackTrace) {
      log('❌ Unexpected Error: $e');
      log('Stack trace: $stackTrace');
      throw ApiException('Failed to search hotels: ${e.toString()}');
    }
  }
  // final http.Client _client = http.Client();
  
  // Basic Authentication credentials for static APIs
 
  // Base64 encoded authorization header
  String get _basicAuth => 'Basic ${base64Encode(utf8.encode('$hotelusername:$hoteluserpass'))}';

  Future<List<CountryModel>> getCountries() async {
    log("getCountries----");
    
    try {
      final response = await _client.get(
        Uri.parse('http://api.tbotechnology.in/TBOHolidays_HotelAPI/CountryList'),
        headers: {
          'Authorization': _basicAuth,
          'Content-Type': 'application/json',
        },
      );
      
      log(response.body);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['Status']['Code'] == 200) {
          final List<dynamic> countryList = data['CountryList'];
          return countryList.map((json) => CountryModel.fromJson(json)).toList();
        } else {
          throw Exception('Failed to load countries: ${data['Status']['Description']}');
        }
      } else {
        throw Exception('Failed to load countries: Status code ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to load countries: $e');
    }
  }

  Future<List<HotelCityHotel>> getCities(String countryCode) async {
    log("getCities----");
    
    try {
      final response = await _client.post(
        Uri.parse('http://api.tbotechnology.in/TBOHolidays_HotelAPI/CityList'),
        headers: {
          'Authorization': _basicAuth,
          'Content-Type': 'application/json',
        },
        body: json.encode({'CountryCode': countryCode}),
      );
      
      log(response.body);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['Status']['Code'] == 200) {
          final List<dynamic> cityList = data['CityList'];
          return cityList.map((json) => HotelCityHotel.fromJson(json)).toList();
        } else {
          throw Exception('Failed to load cities: ${data['Status']['Description']}');
        }
      } else {
        throw Exception('Failed to load cities: Status code ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to load cities: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}