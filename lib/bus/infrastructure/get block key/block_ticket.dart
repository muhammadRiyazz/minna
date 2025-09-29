import 'package:http/http.dart';
import 'package:minna/comman/core/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Response> getblockticket({required String data}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final userId = preferences.getString('userId') ?? '';

  var urlPhp = '${baseUrl}CallAPI';

  var bodyBackend = {
    "path": "https://api.seatseller.travel/blockTicketV2",
    "method": "POST",
    "user_id": userId,
    "franch_id": '',
    "data": data,
  };
  Response resRedBus = await post(Uri.parse(urlPhp), body: bodyBackend);

  return resRedBus;
}
