import 'dart:convert';
import 'dart:developer';

class Network {
  static void cancelrequest({required String id, required List<String> seats}) {
    //  final List<String> seats = ["12A", "12B"];
    log(seats.toString());
    final bodyBackend = {
      "url": "http://api.seatseller.travel/cancelticket",
      "json_params": jsonEncode({
        "tin": id,
        "seatsToCancel": seats,
      }),
      "method": "Post",
    };
    log(bodyBackend.toString());
  }
}
