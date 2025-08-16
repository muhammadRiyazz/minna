// import 'dart:developer';

// import 'package:dartz/dartz.dart';
// import 'package:http/http.dart' as http;

// import 'package:maaxusminihub/screen/red_bus/domain/search_location/search_location.dart';

// import '../application/first_bloc/bloc/bloc/wallet_bloc_bloc.dart';
// import '../constants/urls.dart';

// class SearchLocationClass {
// //  Future<Either<String, List<ModelSearchLocation>>>
//   static Future getSearchLocationData() async {
//     var _urlLocaFromPhp = "${baseUrlRedBus}CallAPI";

//     print(_urlLocaFromPhp);

//     var _urlBody = {
//       "url": "http://api.seatseller.travel/aliases",
//       "method": "GET",
//     };
//     print('resssssssssssssssssssssss1');
//     final resPonsFroPhp =
//         await http.post(Uri.parse(_urlLocaFromPhp), body: _urlBody);

//     // print('resssssssssssssssssssssss2');
//     // print(
//     //     'Error: Authorization failed please send valid consumer key and secret in the api request.');

//     // print(_resPonsFroPhp.body);

//     // try {
//     //   Response _resPonsFro =
//     //       await post(Uri.parse(_urlLocaFromPhp), body: _urlBody);
//     //   log(_resPonsFro.body.toString());
//     // } catch (e) {
//     //   log(e.toString());
//     // }
//     // return _resPonsFroPhp.body ==
//     //         'Error: Authorization failed please send valid consumer key and secret in the api request.'
//     //     ? Left('error')
//     //     : Right(modelSearchLocationFromJson(_resPonsFroPhp.body));
//     return resPonsFroPhp;
//   }
// }

// class BlocProvider {}



// // ui designs 20
// // deveolopment 50
// // testing 5 