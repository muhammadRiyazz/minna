import 'dart:developer';
import 'package:minna/bus/domain/BlockTicket/block_ticket_request_modal.dart';
import 'package:http/http.dart';
import 'package:minna/comman/core/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../red_bus/constants/urls.dart';

Future<Response> getblockticket({required String data}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final userId = preferences.getString('userId') ?? '';

  var urlPhp = '${baseUrl}CallAPI';

  var bodyBackend = {
    "path": "http://api.seatseller.travel/blockTicket",
    "method": "POST",
    "user_id": userId,
    "franch_id": '',
    "data": data,
  };
  Response resRedBus = await post(Uri.parse(urlPhp), body: bodyBackend);

  return resRedBus;
}
