// import 'dart:convert';
// import 'dart:developer';

// import 'package:dartz/dartz.dart';
// import 'package:http/http.dart';
// import 'package:maaxusminihub/screen/red_bus/domain/model_bus_seats/model_bus_seats.dart';
// import 'package:maaxusminihub/screen/red_bus/domain/model_bus_seats/test_model.dart';

// import '../constants/urls.dart';

// class SeatingBusApi {
//   Future<Either<String, ModelBusSeats>> getDataBusSeats({tripIds}) async {
//     var _urlSeating =
//         '${baseUrlRedBus}CallBackWithParams'; //1000855444147064168

//     print(_urlSeating);
//     print('prints             ${tripIds}');
//     var bodyBackend = {
//       "url": "http://api.seatseller.travel/tripdetails?id=${tripIds}",
//       "url_no_param": "http://api.seatseller.travel/tripdetails",
//       "json_params": jsonEncode({
//         "id": "${tripIds}",
//       }),
//       "method": "GET",
//     };

//     Response resp = await post(Uri.parse(_urlSeating), body: bodyBackend);
//     log(resp.body);
//     return resp.body ==
//             'Error: Authorization failed please send valid consumer key and secret in the api request.'
//         ? Left('error')
//         : Right(modelBusSeatsFromJson(resp.body));
//   }
// }


// //"travels": "Jabbar  Travels",