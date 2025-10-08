//  import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:minna/hotel%20booking/domain/authentication/authendication.dart';

// Future<ApiResult<PreBookResponse>> preBookRoom({
//     required String bookingCode,
//   }) async {
//     try {
//       final request = PreBookRequest(bookingCode: bookingCode);

//       final response = await http.post(
//         Uri.parse('https://affiliate.tektravels.com/HotelAPI/PreBook'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(request.toJson()),
//       );
      

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         final preBookResponse = PreBookResponse.fromJson(data);
        
//         if (preBookResponse.isSuccess) {
//           return ApiResult.success(preBookResponse);
//         } else {
//           return ApiResult.error('Pre-book failed: ${preBookResponse.status.description}');
//         }
//       } else {
//         return ApiResult.error('HTTP Error: ${response.statusCode}');
//       }
//     } catch (e) {
//       return ApiResult.error('Network error: $e');
//     }
//   }
