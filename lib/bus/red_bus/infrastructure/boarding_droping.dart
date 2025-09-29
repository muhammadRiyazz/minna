import 'dart:convert';
import 'dart:developer';

import 'package:minna/bus/red_bus/domain/model_bus_seats/mod_test.dart'
    show BoardDropingPointModelClass, boardDropingPointModelClassFromMap;
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';


// class DpBpApi {
//   Future<Either<String, BoardingDroping>> getDataBoarding() async {
//     String urlDpBp =
//         'http://api.seatseller.travel/tripdetails?id=1000855444136054640'; // 1000855443878819057

//     Response resDpBp = await get(
//       Uri.parse(urlDpBp),
//       headers: {
//         'Authorization':
//             'OAuth oauth_consumer_key="JYmWyfFg6tSSiDPHLkBnM84Go6PSzM",oauth_signature_method="HMAC-SHA1",oauth_timestamp="1672988520",oauth_nonce="31fc1aff031db0f3be6b15548fbfe91f",oauth_version="1.0",oauth_signature="HzKx%2BJTvZLrqen%2Fm1fzAaeBX4rE%3D"'
//       },
//     );

//     print('boarding ${resDpBp.body}');
//     print('jsonnnn');
//     print('Json ${boardingDropingFromJson(resDpBp.body)}');

//     return resDpBp.statusCode == 200
//         ? Right(boardingDropingFromJson(resDpBp.body))
//         : Left('error');
//   }
// }

//BoardDropingPointModelClass  //BoardingDropingList live
class DpBpApiNew {
  Future<Either<String, BoardDropingPointModelClass>> getDataBoardingnew({
    tripIdee,
  }) async {
    var urlPhpAvaiBus = "}CallBackWithParams";

    var bodyBackend = {
      "url": "http://api.seatseller.travel/bpdpDetails?id=$tripIdee",
      "url_no_param": "http://api.seatseller.travel/bpdpDetails",
      "json_params": jsonEncode({"id": "$tripIdee"}),
      "method": "GET",
    };

    Response resp = await post(Uri.parse(urlPhpAvaiBus), body: bodyBackend);

    log(resp.body.toString());

    return resp.body ==
            'Error: Authorization failed please send valid consumer key and secret in the api request.'
        ? Left('error')
        : Right(boardDropingPointModelClassFromMap(resp.body));
  }
}
