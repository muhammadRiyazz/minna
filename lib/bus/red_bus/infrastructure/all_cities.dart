// import 'dart:developer';

// import 'package:dartz/dartz.dart';
// import 'package:http/http.dart';

// import '../constants/urls.dart';
// import '../domain/list_of_city/list_sample_model.dart';

// class ApiAllCities {
//   Future<Either<String, CityModel>> getDataAllDities() async {
//     // var urlAllCities = 'http://api.seatseller.travel/cities';
//     // Response resp = await get(Uri.parse(urlAllCities), headers: {
//     //   'Authorization':
//     //       'OAuth oauth_consumer_key="JYmWyfFg6tSSiDPHLkBnM84Go6PSzM",oauth_signature_method="HMAC-SHA1",oauth_timestamp="1673950093",oauth_nonce="VGIZzhbEvT3",oauth_version="1.0",oauth_signature="XHzHmWnmOD%2FMRFkfEhaSt1NamUw%3D"'
//     // });

//     // print(resp.body);

//     // return resp.statusCode == 200
//     //     ? Right(boardingFromMap(resp.body))
//     //     : Left('error');

//     // var _urlLocaFromPhp = "https://api.maaxusdigitalhub.com/CallAPI";
//         var _urlLocaFromPhp = "${baseUrlRedBus}CallAPI";

//     var _urlBody = {
//       "url": "http://api.seatseller.travel/cities",
//       "method": "GET",
//     };
//     Response _resPonsFroPhp =
//         await post(Uri.parse(_urlLocaFromPhp), body: _urlBody);

//     print('resssssssssssssssssssssss1111');
//     print(_resPonsFroPhp.body);
//     log(_resPonsFroPhp.body.toString());


    
//     return _resPonsFroPhp.body ==
//             'Error: Authorization failed please send valid consumer key and secret in the api request.'
//         ? Left('error')
//         : Right(boardingFromMap(_resPonsFroPhp.body));
//   }
// }
