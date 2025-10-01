import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:minna/Electyicity%20&%20Water/application/fetch%20bill/fetch_bill_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:minna/comman/core/api.dart';

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
      // // Step 1: Store bill payment temp
      // final tempStoreResult = await _storeBillPaymentTemp(event);
      
      // if (!tempStoreResult['success']) {
      //   emit(ConfirmBillState.paymentError(tempStoreResult['message']));
      //   return;
      // }

      // final receiptId = tempStoreResult['receiptId'];

      // Step 2: Create Razorpay order
      final orderResult = await _createRazorpayOrder(event.bill.billAmount);
      
      if (!orderResult['success']) {
        emit(ConfirmBillState.paymentError(orderResult['message']));
        return;
      }

      final orderId = orderResult['orderId'];

      // Step 3: Save payment details
      final saveResult = await _savePaymentDetails(
        receiptId:event. receiptId,
        orderId: orderId,
        transactionId: '',
        status: '2', // Initial status as pending
      );

      if (!saveResult['success']) {
        emit(ConfirmBillState.paymentError(saveResult['message']));
        return;
      }

      // Include bill in the orderCreated state
      emit(ConfirmBillState.orderCreated(
        orderId: orderId, 
        receiptId:event. receiptId,
        bill: event.bill,
      ));

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
      // Step 1: Update payment details as success
      final updateResult = await _savePaymentDetails(
        receiptId: event.receiptId,
        orderId: event.orderId,
        transactionId: event.transactionId,
        status: '1', // Success
      );

      if (!updateResult['success']) {
        // If update fails, initiate refund
        log("Payment update failed, initiating refund");
        add(InitiateRefund(
          transactionId: event.transactionId,
          receiptId: event.receiptId,
          amount: event.currentBill!.billAmount,
          reason: 'Payment update failed',
        ));
        return;
      }

      // Step 2: Process final bill payment
      final paymentResult = await _processBillPayment(event);

      if (paymentResult['success']) {
        emit(ConfirmBillState.paymentSuccess(
          'Payment completed successfully!',
          paymentResult['receiptId'] ?? event.receiptId,
        ));
      } else {
        // If final payment fails, initiate refund
        log("Bill payment failed, initiating refund: ${paymentResult['message']}");
        add(InitiateRefund(
          transactionId: event.transactionId,
          receiptId: event.receiptId,
          amount: event.currentBill!.billAmount,
          reason: paymentResult['message'] ?? 'Bill payment failed',
        ));
      }

    } catch (e) {
      log("Payment processing error: $e");
      // If any error occurs, initiate refund
      add(InitiateRefund(
        transactionId: event.transactionId,
        receiptId: event.receiptId,
        amount: event.currentBill!.billAmount,
        reason: 'Payment processing error: $e',
      ));
    }
  }

  Future<void> _onProcessPaymentFailure(
    ProcessPaymentFailure event,
    Emitter<ConfirmBillState> emit,
  ) async {
    // Update payment details as failure
    await _savePaymentDetails(
      receiptId: event.receiptId,
      orderId: event.orderId,
      transactionId: event.transactionId,
      status: '2', // Failure
    );

    emit(ConfirmBillState.paymentError(event.errorMessage));
  }

  Future<void> _onInitiateRefund(
    InitiateRefund event,
    Emitter<ConfirmBillState> emit,
  ) async {
    log("Initiating refund for transaction: ${event.transactionId}");
    emit(const ConfirmBillState.refundProcessing());

    try {
      final refundResult = await _processRefund(
        transactionId: event.transactionId,
        receiptId: event.receiptId,
        amount: event.amount,
      );

      if (refundResult['success']) {
        // Update payment status to refunded
        await _savePaymentDetails(
          receiptId: event.receiptId,
          orderId: '',
          transactionId: event.transactionId,
          status: '3', // Refunded
        );
        
        emit(ConfirmBillState.refundSuccess(
          'Refund initiated successfully. Amount will be credited to your account within 5-7 business days.',
          event.receiptId,
        ));
      } else {
        emit(ConfirmBillState.refundFailed(
          'Refund failed: ${refundResult['message']}. Please contact customer support.',
          event.receiptId,
        ));
      }
    } catch (e) {
      log("Refund processing error: $e");
      emit(ConfirmBillState.refundFailed(
        'Refund processing failed: $e. Please contact customer support.',
        event.receiptId,
      ));
    }
  }

  // API Helper Methods


  Future<Map<String, dynamic>> _createRazorpayOrder(String amount) async {
    log("_createRazorpayOrder---");
    final amountInPaise = (double.tryParse(amount) ?? 0 * 100).toInt();
    final url = Uri.parse('${baseUrl}createOrder');

    try {
      final response = await http.post(
        url,
        body: {'amount': amountInPaise.toString()},
      );
      log(response.body);
      final responseData = json.decode(response.body);
      
      if (responseData['statusCode'] == 200) {
        return {
          'success': true,
          'orderId': responseData['message']['order_id'],
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to create order',
        };
      }
    } catch (e) {
      log(e.toString());
      return {
        'success': false,
        'message': 'Order creation failed: $e',
      };
    }
  }

  Future<Map<String, dynamic>> _savePaymentDetails({
    required String receiptId,
    required String orderId,
    required String transactionId,
    required String status,
  }) async {
    final url = Uri.parse('${baseUrl}paysave');

    try {
      log("_savePaymentDetails ---- ");
      final response = await http.post(
        url,
        body: {
          'id': receiptId,
          'order_id': orderId,
          'transaction_id': transactionId,
          'status': status,
          'table': 'mm_bbpspayment',
        },
      );
      log(response.body);
      final responseData = json.decode(response.body);
      
      if (responseData['statusCode'] == 200) {
        return {'success': true};
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to save payment details',
        };
      }
    } catch (e) {
      log(e.toString());
      return {
        'success': false,
        'message': 'Payment save failed: $e',
      };
    }
  }

  Future<Map<String, dynamic>> _processBillPayment(ProcessPaymentSuccess event) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString('userId') ?? '';

    final url = Uri.parse('${baseUrl}kseb-bill-payment');

    try {
      final response = await http.post(
        url,
        body: {
          'userId': userId,
          'txtMobile': event.phoneNo,
          'txtConsumer': event.consumerId,
          'txtAmount': event.currentBill!.billAmount,
          'txtBillerName': event.providerID,
          'txtBillPeriod': event.currentBill!.billPeriod,
          'txtBillNumber': event.currentBill!.billNumber,
          'txtCustomerName': event.currentBill!.customerName,
          'txtBillDueDate': event.currentBill!.dueDate,
          'txtBillDate': event.currentBill!.billDate,
          'txtreqId': event.currentBill!.reqId,
          'billerId': event.providerID,
          'receiptId': event.receiptId,
          'orderId': event.orderId,
          'paymentStatus': '1',
          'transactionId': event.transactionId,
        },
      );
      
      log('_processBillPayment response: ${response.body}');

      final responseData = json.decode(response.body);
      
      if (responseData['status'] == 'SUCCESS') {
        return {
          'success': true,
          'receiptId': responseData['data']['receiptId'].toString(),
                    // 'receiptId':  event.receiptId,

        };
      } else {
        return {
          'success': false,
          'message': responseData['statusDesc'] ?? 'Bill payment failed',
        };
      }
    } catch (e) {
      log("_processBillPayment error: $e");
      return {
        'success': false,
        'message': 'Bill payment processing failed: $e',
      };
    }
  }

  Future<Map<String, dynamic>> _processRefund({
    required String transactionId,
    required String receiptId,
    required String amount,
  }) async {
    final url = Uri.parse('${baseUrl}payrefund');
    
    try {
      log("Processing refund for transaction: $transactionId, amount: $amount");
      final response = await http.post(
        url,
        body: {
          'id': receiptId,
          'transaction_id': transactionId,
          'amount': amount,
          'table': 'mm_bbpspayment',
        },
      );

      log("Refund response: ${response.body}");
      final responseData = json.decode(response.body);
      
      if (responseData['statusCode'] == 200) {
        return {
          'success': true,
          'message': responseData['message'] ?? 'Refund initiated successfully',
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Refund initiation failed',
        };
      }
    } catch (e) {
      log('Refund processing failed: $e');
      return {
        'success': false,
        'message': 'Refund processing failed',
      };
    }
  }
}