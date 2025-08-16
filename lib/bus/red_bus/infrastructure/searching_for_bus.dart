// import 'dart:convert';
// import 'dart:developer';

// import 'package:dartz/dartz.dart';

// import 'package:http/http.dart';

// import 'package:maaxusminihub/screen/red_bus/domain/bus_details/detail_bus.dart';
// import 'package:maaxusminihub/screen/red_bus/domain/bus_details/modelForPhp.dart';
// import 'package:maaxusminihub/screen/red_bus/domain/data_post_redBus.dart';

// import '../constants/urls.dart';
// import '../screen/new/domain/trips list modal/trip_list_modal.dart';

// class SearchForBusAvailabilityClass {
//   Future<Either<String, ModelForPhp>> getDataAvailabilityBus(
//       {required source, required desti, required dateOfjurny}) async {
//     var _urlPhpAvaiBus = "${baseUrlRedBus}CallBackWithParams";
//     log(source);
//     log(desti);
//     log(dateOfjurny);

//     var bodyBackend = {
//       "url":
//           "http://api.seatseller.travel/availabletrips?source=${source}&destination=${desti}&doj=${dateOfjurny}",
//       "url_no_param": "http://api.seatseller.travel/availabletrips",
//       "json_params": jsonEncode({
//         "source": "$source",
//         "destination": "$desti",
//         "doj": "$dateOfjurny"
//       }),
//       "method": "GET",
//     };

//     Response resp = await post(Uri.parse(_urlPhpAvaiBus), body: bodyBackend);
//     log('message');
//     log(resp.body);
//     return resp.body ==
//             'Error: Authorization failed please send valid consumer key and secret in the api request.'
//         ? Left('error')
//         : Right(modelForPhpFromMap(resp.body));
//   }
// }
