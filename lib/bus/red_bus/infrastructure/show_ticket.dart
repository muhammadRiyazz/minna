import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

import '../constants/urls.dart';
import '../domain/pdf_model/model_pdf.dart';
import '../domain/pdf_model/model_pdf2.dart';
import '../domain/ticket/ticket_model.dart';

class TicketShowClass {
  Future<Either<String, ModelTickePerson2>> getDataTicketShowMany(
      {required tIn}) async {
    var _urlPhpAvaiBus = "CallBackWithParams";

    var bodyBackend = {
      "url": "http://api.seatseller.travel/ticket?tin=$tIn", //VZpx3W4CCQ
      "url_no_param": "http://api.seatseller.travel/ticket",
      "json_params": jsonEncode({
        "tin": tIn,
      }),
      "method": "GET",
    };

    Response _res = await post(Uri.parse(_urlPhpAvaiBus), body: bodyBackend);

    return _res.body ==
            'Error: Authorization failed please send valid consumer key and secret in the api request.'
        ? Left(' Refresh ')
        : Right(modelTickePerson2FromJson(_res.body));
  }
}

class TicketDetailsClass {
  Future<Either<String, ModelTicket>> getDataTicketDetailsPersonOne(
      {required tIn}) async {
    var _urlTicketShow = "CallBackWithParams";

    print(_urlTicketShow);
    var _bodyBackend = {
      "url": "http://api.seatseller.travel/ticket?tin=${tIn}", //VZpx3W4CCQ
      "url_no_param": "http://api.seatseller.travel/ticket",
      "json_params": jsonEncode({
        "tin": tIn,
      }),
      "method": "GET",
    };
    Response _res = await post(Uri.parse(_urlTicketShow), body: _bodyBackend);
    print(
        'llllllllllllllllllllllllllllllrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
    print(_res.body);
    return _res.body ==
            'Error: Authorization failed please send valid consumer key and secret in the api request.'
        ? Left(' Refresh ')
        : Right(modelTicketFromMap(_res.body));
  }
}
