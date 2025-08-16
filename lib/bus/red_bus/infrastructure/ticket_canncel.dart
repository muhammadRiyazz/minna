import 'dart:convert';

import 'package:http/http.dart';

import '../constants/urls.dart';

class TicketCancelApi {
  getDataTicketCance({required tIn, required seatsCancel}) async {
    var _urlPhp = 'CallAPI';

    var _bodyParams = {
      "tin": "${tIn}",
      "seatsToCancel": "${seatsCancel}",
    };
    print(_bodyParams);
    print('json encode');
    print(jsonEncode(_bodyParams));
    var bodyBackend = {
      "url": "http://api.seatseller.travel/cancelticket",
      "method": "POST",
      "data": jsonEncode(_bodyParams),
    };
    Response _resCanel = await post(Uri.parse(_urlPhp), body: bodyBackend);

    print('Blocke key issssssssssss${_resCanel.body}');

    // _res.statusCode == 200
    //     ? globalPostRedBus = globalPostRedBus.copyWith(blockKey: _res.body)
    //     : globalPostRedBus = globalPostRedBus.copyWith(blockKey: _res.body);

    // print('postmodel issssssssssss${globalPostRedBus.blockKey}');//

    // return _res.statusCode == 200 ? _res.body : false;
  }
}
