import 'dart:developer';

import 'package:http/http.dart' as http;


 Future<http.Response> cutwalletbalance({required String blockKey, required String blockID}) async {
  log('cut wallet');
  var postUrl = Uri.parse('/confirmTicket');
  var responce = await http.post(
    postUrl,
    body: {'blockKey': blockKey, 'blockID': blockID},
  );

  log(responce.body);
  return responce;
}
