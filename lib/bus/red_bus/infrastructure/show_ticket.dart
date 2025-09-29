import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

import '../domain/pdf_model/model_pdf.dart';
import '../domain/pdf_model/model_pdf2.dart';

class TicketShowClass {
  Future<Either<String, ModelTickePerson2>> getDataTicketShowMany(
      {required tIn}) async {
    var urlPhpAvaiBus = "CallBackWithParams";

    var bodyBackend = {
      "url": "http://api.seatseller.travel/ticket?tin=$tIn", //VZpx3W4CCQ
      "url_no_param": "http://api.seatseller.travel/ticket",
      "json_params": jsonEncode({
        "tin": tIn,
      }),
      "method": "GET",
    };

    Response res = await post(Uri.parse(urlPhpAvaiBus), body: bodyBackend);

    return res.body ==
            'Error: Authorization failed please send valid consumer key and secret in the api request.'
        ? Left(' Refresh ')
        : Right(modelTickePerson2FromJson(res.body));
  }
}

class TicketDetailsClass {
  Future<Either<String, ModelTicket>> getDataTicketDetailsPersonOne(
      {required tIn}) async {
    var urlTicketShow = "CallBackWithParams";

    print(urlTicketShow);
    var bodyBackend = {
      "url": "http://api.seatseller.travel/ticket?tin=$tIn", //VZpx3W4CCQ
      "url_no_param": "http://api.seatseller.travel/ticket",
      "json_params": jsonEncode({
        "tin": tIn,
      }),
      "method": "GET",
    };
    Response res = await post(Uri.parse(urlTicketShow), body: bodyBackend);
    print(
        'llllllllllllllllllllllllllllllrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
    print(res.body);
    return res.body ==
            'Error: Authorization failed please send valid consumer key and secret in the api request.'
        ? Left(' Refresh ')
        : Right(modelTicketFromMap(res.body));
  }
}
