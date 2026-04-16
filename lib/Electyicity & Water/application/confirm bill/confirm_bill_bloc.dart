import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:minna/Electyicity%20&%20Water/application/fetch%20bill/fetch_bill_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:minna/comman/core/api.dart';
import 'package:minna/comman/core/wallet_service.dart';

part 'confirm_bill_event.dart';
part 'confirm_bill_state.dart';
part 'confirm_bill_bloc.freezed.dart';

class ConfirmBillBloc extends Bloc<ConfirmBillEvent, ConfirmBillState> {
  ConfirmBillBloc() : super(_Initial()) {
    on<InitiatePayment>(_onInitiatePayment);

    on<ProcessPaymentSuccess>(_onProcessPaymentSuccess);

    on<ProcessPaymentFailure>(_onProcessPaymentFailure);

    on<InitiateRefund>(_onInitiateRefund);
  }

  Future<void> _onInitiatePayment(
    InitiatePayment event,
    Emitter<ConfirmBillState> emit,
  ) async {
    emit(const ConfirmBillState.paymentProcessing());

    try {
      // Step 0: Check Wallet Balance
      final walletCheckResult = await WalletService.checkWalletBalance(
        event.bill.billAmount.toString(),
      );

      if (!walletCheckResult['success']) {
        emit(ConfirmBillState.walletBalanceError(walletCheckResult['message']));
        return;
      }

      // Step 2: Create Razorpay order
      final orderResult = await _createRazorpayOrder(event);

      if (!orderResult['success']) {
        emit(ConfirmBillState.paymentError(orderResult['message']));
        return;
      }

      final orderId = orderResult['orderId'];
      final receiptId = orderResult['receiptId'];

      // Include bill in the orderCreated state
      emit(
        ConfirmBillState.orderCreated(
          orderId: orderId,
          receiptId: receiptId,
          bill: event.bill,
        ),
      );
    } catch (e) {
      log(e.toString());
      emit(ConfirmBillState.paymentError('Failed to initiate payment: $e'));
    }
  }

  Future<void> _onProcessPaymentSuccess(
    ProcessPaymentSuccess event,
    Emitter<ConfirmBillState> emit,
  ) async {
    emit(const ConfirmBillState.paymentProcessing());

    try {
      // Process final bill payment & verify
      final paymentResult = await _verifyRazorpayPayment(event);

      if (paymentResult['success']) {
        emit(ConfirmBillState.billPaymentResponse(paymentResult['data'] ?? {}));
      } else {
        log("Bill payment failed: ${paymentResult['message']}");
        emit(
          ConfirmBillState.billPaymentError(
            paymentResult['message'] ?? 'Bill payment failed',
            transactionId: event.transactionId,
          ),
        );
      }
    } catch (e) {
      log("Payment processing error: $e");
      emit(ConfirmBillState.paymentError('Payment processing error: $e'));
    }
  }

  Future<void> _onProcessPaymentFailure(
    ProcessPaymentFailure event,
    Emitter<ConfirmBillState> emit,
  ) async {
    emit(ConfirmBillState.paymentError(event.errorMessage));
  }

  Future<void> _onInitiateRefund(
    InitiateRefund event,
    Emitter<ConfirmBillState> emit,
  ) async {
    log("Refund obsolete in this flow. Not executing");
  }

  // API Helper Methods

  Future<Map<String, dynamic>> _createRazorpayOrder(
    InitiatePayment event,
  ) async {
    log("_createRazorpayOrder---");

    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString('userId') ?? '';

    final url = Uri.parse(
      '${baseUrl}bill-payment-create-razorpay-order-api',
    );

    try {
      final response = await http.post(
        url,
        body: {
          'userId': userId,
          'txtMobile': event.phoneNo,
          'txtConsumer': event.consumerId,
          'txtAmount': event.bill.billAmount,
          'txtBillerName': event.providerName,
          'txtBillPeriod': event.bill.billPeriod,
          'txtBillNumber': event.bill.billNumber,
          'txtCustomerName': event.bill.customerName,
          'txtBillDueDate': event.bill.dueDate,
          'txtBillDate': event.bill.billDate,
          'txtreqId': event.bill.reqId,
          'billerId': event.providerID,
        },
      );
      log(response.body);
      final responseData = json.decode(response.body);
      log(responseData.toString());
      if (responseData['status'] == "SUCCESS") {
        return {
          'success': true,
          'orderId': responseData['data']['order_id'],
          'receiptId': responseData['data']['receiptId'].toString(),
        };
      } else {
        return {
          'success': false,
          'message': responseData['statusDesc'] ?? 'Failed to create order',
        };
      }
    } catch (e) {
      log(e.toString());
      return {'success': false, 'message': 'Order creation failed: $e'};
    }
  }

  Future<Map<String, dynamic>> _verifyRazorpayPayment(
    ProcessPaymentSuccess event,
  ) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString('userId') ?? '';

    final url = Uri.parse(
      '${baseUrl}bill-payment-verify-razorpay-api',
    );

    try {
      final response = await http.post(
        url,
        body: {
          'razorpay_payment_id': event.transactionId,
          'razorpay_order_id': event.orderId,
          'razorpay_signature': event.signature,
          'userId': userId,
          'billerId': event.providerID,
          'receiptId': event.receiptId,
        },
      );
      log(
        {
          'razorpay_payment_id': event.transactionId,
          'razorpay_order_id': event.orderId,
          'razorpay_signature': event.signature,
          'userId': userId,
          'billerId': event.providerID,
          'receiptId': event.receiptId,
        }.toString(),
      );
      log('_verifyRazorpayPayment response: ${response.body}');

      final responseData = json.decode(response.body);

      if (responseData['status'] == 'SUCCESS') {
        return {'success': true, 'data': responseData};
      } else {
        return {
          'success': false,
          'message':
              responseData['statusDesc'] ?? 'Bill payment verification failed',
        };
      }
    } catch (e) {
      log("_verifyRazorpayPayment error: $e");
      return {
        'success': false,
        'message': 'Bill payment processing failed: $e',
      };
    }
  }
}
