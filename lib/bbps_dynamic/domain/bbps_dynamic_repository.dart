import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:minna/comman/core/api.dart';
import 'package:minna/bbps_dynamic/domain/models/bbps_models.dart';

class BbpsDynamicRepository {
  Future<List<BbpsDynamicBiller>> getBillers(String category) async {
    final url = '${baseUrlLive}api/bbps/billers/$category';
    log('API Request (getBillers): GET $url');
    final response = await http.get(Uri.parse(url));
    log(
      'API Response (getBillers - $category): ${response.statusCode} - ${response.body}',
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success'] == true) {
        return (data['billers'] as List)
            .map((e) => BbpsDynamicBiller.fromJson(e))
            .toList();
      }
    }
    throw Exception('Failed to load billers');
  }

  Future<BbpsDynamicBillerInfo> getBillerInfo(
    String category,
    String billerId,
  ) async {
    final url = '${baseUrlLive}api/bbps/biller-info/$category';
    final requestBody = {'billerId': billerId};
    log('API Request (getBillerInfo): POST $url | Body: $requestBody');

    final response = await http.post(Uri.parse(url), body: requestBody);
    log(
      'API Response (getBillerInfo - $category): ${response.statusCode} - ${response.body}',
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return BbpsDynamicBillerInfo.fromJson(data);
    }
    throw Exception('Failed to get biller info');
  }

  Future<BbpsDynamicBillResponse> fetchBill({
    required String category,
    required String userId,
    required String operatorId,
    required String number,
    required Map<String, String> dynamicParams,
  }) async {
    final Map<String, String> body = {
      'userId': userId,
      'operator': operatorId,
      'number': number,
    };

    int index = 0;
    dynamicParams.forEach((key, value) {
      body['param_names[$index]'] = key;
      body['param_values[$index]'] = value;
      index++;
    });

    final url = '${baseUrlLive}api/bbps/fetch/$category';
    log('API Request (fetchBill): POST $url | Body: $body');

    final response = await http.post(Uri.parse(url), body: body);
    log(
      'API Response (fetchBill - $category): ${response.statusCode} - ${response.body}',
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return BbpsDynamicBillResponse.fromJson(data);
    }
    throw Exception('Failed to fetch bill');
  }

  Future<Map<String, dynamic>> createOrder({
    required String category,
    required String userId,
    required String reqId,
    required String amount,
    required String consumerNo,
    String? billNumber,
  }) async {
    final url = '${baseUrlLive}api/bbps/create-order/$category';
    final body = {
      'userId': userId,
      'reqId': reqId,
      'amount': amount,
      'consumerNo': consumerNo,
      if (billNumber != null) 'billNumber': billNumber,
    };
    log('API Request (createOrder): POST $url | Body: $body');

    final response = await http.post(Uri.parse(url), body: body);
    log(
      'API Response (createOrder - $category): ${response.statusCode} - ${response.body}',
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success'] == true) {
        return data;
      }
      throw Exception(data['message'] ?? 'Failed to create order');
    }
    throw Exception('Server error during create order');
  }

  Future<Map<String, dynamic>> verifyPayment({
    required String category,
    required String userId,
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
  }) async {
    final url = '${baseUrlLive}api/bbps/verify/$category';
    final body = {
      'userId': userId,
      'razorpay_order_id': razorpayOrderId,
      'razorpay_payment_id': razorpayPaymentId,
      'razorpay_signature': razorpaySignature,
    };
    log('API Request (verifyPayment): POST $url | Body: $body');

    final response = await http.post(Uri.parse(url), body: body);
    log(
      'API Response (verifyPayment - $category): ${response.statusCode} - ${response.body}',
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Server error during payment verification');
  }
}
