import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:minna/comman/core/api.dart';

Future<void> tinUpdation({
  required String tableID,
  required String tin,
  required status,
}) async {
  log(tin);
  log(tableID);
  log(status.toString());
  log('all  done');
  var postUrl = Uri.parse('${baseUrl}getTin');
  var responce = await http.post(
    postUrl,
    body: {'blockID': tableID, 'tin': tin, 'status': status.toString()},
  );
  log(responce.body);
}
