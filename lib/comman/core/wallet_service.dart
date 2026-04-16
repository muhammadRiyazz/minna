import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:minna/comman/core/api.dart';

class WalletService {
  /// Checks if the user's wallet has enough balance to cover the [requiredAmountStr].
  /// Returns a Map with 'success' boolean and an optional 'message'.
  static Future<Map<String, dynamic>> checkWalletBalance(String requiredAmountStr) async {
    log("WalletService: checkWalletBalance for amount $requiredAmountStr ---");

    final url = Uri.parse('${baseUrl}wallet-balance');

    try {
      final response = await http.post(url);

      log("Wallet balance response: ${response.body}");
      final responseData = json.decode(response.body);

      if (responseData['status'] == 'SUCCESS') {
        final walletBalanceStr = responseData['data']['walletBalance'].toString();
        final walletBalance = double.tryParse(walletBalanceStr) ?? 0.0;
        final amountRequired = double.tryParse(requiredAmountStr) ?? 0.0;

        if (walletBalance >= amountRequired) {
          return {'success': true, 'walletBalance': walletBalance};
        } else {
          return {
            'success': false, 
            'message': 'Insufficient wallet balance. Available: ₹${walletBalance.toStringAsFixed(2)}, Required: ₹${amountRequired.toStringAsFixed(2)}'
          };
        }
      } else {
        return {
          'success': false, 
          'message': responseData['statusDesc'] ?? 'Failed to fetch wallet balance.'
        };
      }
    } catch (e) {
      log(e.toString());
      return {
        'success': false, 
        'message': 'Network error while checking wallet balance: $e'
      };
    }
  }
}
