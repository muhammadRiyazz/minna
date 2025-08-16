// import 'dart:convert';
// import 'dart:developer';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// import '../cut wallet/cut_wallet.dart';

// checkwalletbalance(
//     {required String blockID,
//     required String blockKey,
//     required double totalFare}) async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

//    var postUrl =
//       Uri.parse('https://maaxusdigitalhub.com/apinew/index.php/CallBackWallet');
//    var responce = await http.post(
//      postUrl,
//      body: {'micro_fr_id': sharedPreferences.getString('userdbid').toString()},
//    );

//     var _res = jsonDecode(responce.body)['balance'];
//    final balance = double.parse(_res);
//    if (balance < totalFare) {
//     log('no balance');
//    } else if (balance >= totalFare) {
    
//    }
//     log(balance.toString());
// }
