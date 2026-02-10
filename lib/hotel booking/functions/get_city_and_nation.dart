// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import 'package:minna/hotel%20booking/core/core.dart' show hotelusername, hoteluserpass;
// import 'package:minna/hotel%20booking/domain/Nation%20and%20city/city.dart';
// import 'package:minna/hotel%20booking/domain/Nation%20and%20city/nation';

// class ApiService {
//   final http.Client _client = http.Client();
  
//   // Basic Authentication credentials for static APIs
 
//   // Base64 encoded authorization header
//   String get _basicAuth => 'Basic ${base64Encode(utf8.encode('$hotelusername:$hoteluserpass'))}';

//   Future<List<CountryModel>> getCountries() async {
//     log("getCountries----");
    
//     try {
//       final response = await _client.get(
//         Uri.parse('http://api.tbotechnology.in/TBOHolidays_HotelAPI/CountryList'),
//         headers: {
//           'Authorization': _basicAuth,
//           'Content-Type': 'application/json',
//         },
//       );
      
//       log(response.body);
      
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['Status']['Code'] == 200) {
//           final List<dynamic> countryList = data['CountryList'];
//           return countryList.map((json) => CountryModel.fromJson(json)).toList();
//         } else {
//           throw Exception('Failed to load countries: ${data['Status']['Description']}');
//         }
//       } else {
//         throw Exception('Failed to load countries: Status code ${response.statusCode}');
//       }
//     } catch (e) {
//       log(e.toString());
//       throw Exception('Failed to load countries: $e');
//     }
//   }

//   Future<List<HotelCityHotel>> getCities(String countryCode) async {
//     log("getCities----");
    
//     try {
//       final response = await _client.post(
//         Uri.parse('http://api.tbotechnology.in/TBOHolidays_HotelAPI/CityList'),
//         headers: {
//           'Authorization': _basicAuth,
//           'Content-Type': 'application/json',
//         },
//         body: json.encode({'CountryCode': countryCode}),
//       );
      
//       log(response.body);
      
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['Status']['Code'] == 200) {
//           final List<dynamic> cityList = data['CityList'];
//           return cityList.map((json) => HotelCityHotel.fromJson(json)).toList();
//         } else {
//           throw Exception('Failed to load cities: ${data['Status']['Description']}');
//         }
//       } else {
//         throw Exception('Failed to load cities: Status code ${response.statusCode}');
//       }
//     } catch (e) {
//       log(e.toString());
//       throw Exception('Failed to load cities: $e');
//     }
//   }

//   // Optional: Close the client when it's no longer needed
//   void close() {
//     _client.close();
//   }
// }