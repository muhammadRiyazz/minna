// import 'dart:convert';

// import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:maaxusminihub/screen/red_bus/domain/data_post_redBus.dart';

// import '../constants/urls.dart';

// class TinClass {
//   Future<Either<String, String>> getDataTinssss({required blockKey}) async {
//     var _urlPhpAvaiBus = "${baseUrlRedBus}CallBackWithParams";

//     var bodyBackend = {
//       "url":
//           "http://api.seatseller.travel/bookticket?blockKey=${blockKey}", //VZpx3W4CCQ
//       "url_no_param": "http://api.seatseller.travel/bookticket",
//       "json_params": jsonEncode({
//         "blockKey": blockKey,
     
//       }),
//       "method": "POST",
//     };

//     Response resp = await post(Uri.parse(_urlPhpAvaiBus), body: bodyBackend);
//     if (resp.body.toString().characters.length.toInt() <= 12) {
//       // String _urlFromBackend = 

//     }else{}

//     return resp.body ==
//             'Error: Authorization failed please send valid consumer key and secret in the api request.'
//         ? Left('error')
//         : Right(resp.body);
//   }
// }
