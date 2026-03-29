import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:minna/comman/core/api.dart';

/// Creates a hotel-specific Razorpay order on mttrip.in
/// Returns the order data including order_id if successful, null otherwise.
Future<Map<String, dynamic>?> createHotelRazorpayOrder({
  required String userId,
  required Map<String, dynamic> bookingPayload,
  required double amount,
  required double serviceCharge,
}) async {
  try {
    log("🔹 Calling hotel-api-create-order...");
    log("   userId: $userId");
    log("   amount: $amount");
    log("   service_charge: $serviceCharge");

    final response = await http.post(
      Uri.parse("${baseUrl}hotel-api-create-order"),
      body: {
        "userId": userId,
        "bookingPayload": jsonEncode(bookingPayload),
        "amount": amount.toStringAsFixed(2),
        "service_charge": serviceCharge.toStringAsFixed(2),
      },
    );

    log("📩 Order Create Response: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data['status'] == true && data['data'] != null) {
        return data['data']; // Returns {order_id, booking_id, amount, key}
      } else {
        log("❌ Error creating hotel order: ${data['message']}");
        return null;
      }
    } else {
      log(
        "❌ HTTP Error in createHotelOrder: ${response.statusCode} - ${response.body}",
      );
      return null;
    }
  } catch (e) {
    log("💥 Exception in createHotelRazorpayOrder: $e");
    return null;
  }
}

/// Verifies a hotel Razorpay payment on mttrip.in
/// Returns the response data if successful, null otherwise.
Future<Map<String, dynamic>?> verifyHotelRazorpayPayment({
  required String paymentId,
  required String orderId,
  required String signature,
  required String traceId,
  required String tokenId,
}) async {
  try {
    log("🔹 Calling hotel-api-verify-payment...");
    log("   paymentId: $paymentId");
    log("   orderId: $orderId");
    log("   traceId: $traceId");
    log("   tokenId: $tokenId");
    log("   signature: $signature");

    final response = await http.post(
      Uri.parse("${baseUrl}hotel-api-verify-payment"),
      body: {
        "razorpay_payment_id": paymentId,
        "razorpay_order_id": orderId,
        "razorpay_signature": signature,
        "TraceId": traceId,
        "TokenId": tokenId,
      },
    );

    log("📩 Payment Verify Response: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data['status'] == true) {
        log("✅ Payment verification successful");
        return data; // Returns the full JSON including message and data
      } else {
        log("❌ Payment verification failed: ${data['message']}");
        return data; // Return failure structure to handle message
      }
    } else {
      log(
        "❌ HTTP Error in verifyHotelPayment: ${response.statusCode} - ${response.body}",
      );
      return null;
    }
  } catch (e) {
    log("💥 Exception in verifyHotelRazorpayPayment: $e");
    return null;
  }
}
