import 'dart:convert';

import 'package:http/http.dart';

import '../constants/urls.dart';

class TicketCancelApi {
  Future<void> getDataTicketCance({required tIn, required seatsCancel}) async {
    var urlPhp = 'CallAPI';

    var bodyParams = {
      "tin": "$tIn",
      "seatsToCancel": "$seatsCancel",
    };
    print(bodyParams);
    print('json encode');
    print(jsonEncode(bodyParams));
    var bodyBackend = {
      "url": "http://api.seatseller.travel/cancelticket",
      "method": "POST",
      "data": jsonEncode(bodyParams),
    };
    Response resCanel = await post(Uri.parse(urlPhp), body: bodyBackend);

    print('Blocke key issssssssssss${resCanel.body}');

    // _res.statusCode == 200
    //     ? globalPostRedBus = globalPostRedBus.copyWith(blockKey: _res.body)
    //     : globalPostRedBus = globalPostRedBus.copyWith(blockKey: _res.body);

    // print('postmodel issssssssssss${globalPostRedBus.blockKey}');//

    // return _res.statusCode == 200 ? _res.body : false;
  }
}
