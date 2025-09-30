import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:minna/comman/core/api.dart';

part 'fetch_bill_event.dart';
part 'fetch_bill_state.dart';
part 'fetch_bill_bloc.freezed.dart';

class FetchBillBloc extends Bloc<FetchBillEvent, FetchBillState> {
  FetchBillBloc() : super(const FetchBillState.initial()) {
    on<FetchElectricityBill>(_onFetchElectricityBill);
    on<FetchWaterBill>(_onFetchWaterBill);
    on<InitiatePayment>(_onInitiatePayment);
    on<ProcessPaymentSuccess>(_onProcessPaymentSuccess);
    on<ProcessPaymentFailure>(_onProcessPaymentFailure);
  }

  Future<void> _onFetchWaterBill(
    FetchWaterBill event,
    Emitter<FetchBillState> emit,
  ) async { 
    log("_onFetchWaterBill ---");
    emit(const FetchBillState.loading());

    SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString('userId') ?? '';

    final url = Uri.parse('${baseUrl}fetch-kseb-bill');

    try {
      final response = await http.post(
        url,
        body: {
          'userId': userId,
          'txtMobile': event.phoneNo,
          'txtConsumer': event.consumerId,
          'billerId': event.providerID,
        },
      );
      log(response.body);
      final responseData = json.decode(response.body);

      if (responseData['status'] == 'SUCCESS') {
        final data = responseData['data']['data'];
        final responseCode = data['responseCode'];

        if (responseCode == '000') {
          final billerJson = data['billerResponse'];
          final reqId = responseData['data']['reqId'] ?? '';
          final bill = ElectricityBillModel.fromJson(billerJson, reqId);

          emit(FetchBillState.success(bill: bill));
        } else if (responseCode == '001') {
          final errorMessage =
              data['errorInfo']?['error']?['errorMessage'] ??
              'Unable to fetch bill';
          emit(FetchBillState.error(errorMessage));
        } else {
          emit(const FetchBillState.error('Unexpected bill fetch response.'));
        }
      } else {
        emit(
          FetchBillState.error(responseData['statusDesc'] ?? 'Fetch failed.'),
        );
      }
    } catch (e) {
      emit(FetchBillState.error('Something went wrong. Please try again.'));
    }
  }

  Future<void> _onFetchElectricityBill(
    FetchElectricityBill event,
    Emitter<FetchBillState> emit,
  ) async {
    log("_onFetchElectricityBill ---");
    emit(const FetchBillState.loading());

    SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString('userId') ?? '';

    final url = Uri.parse('${baseUrl}fetch-kseb-bill');

    try {
      final response = await http.post(
        url,
        body: {
          'userId': userId,
          'txtMobile': event.phoneNo,
          'txtConsumer': event.consumerId,
          'billerId': event.providerID,
        },
      );
      log(response.body);
      final responseData = json.decode(response.body);

      if (responseData['status'] == 'SUCCESS') {
        final data = responseData['data']['data'];
        final responseCode = data['responseCode'];

        if (responseCode == '000') {
          final billerJson = data['billerResponse'];
          final reqId = responseData['data']['reqId'] ?? '';
          final bill = ElectricityBillModel.fromJson(billerJson, reqId);

          emit(FetchBillState.success(bill: bill));
        } else if (responseCode == '001') {
          final errorMessage =
              data['errorInfo']?['error']?['errorMessage'] ??
              'Unable to fetch bill';
          emit(FetchBillState.error(errorMessage));
        } else {
          emit(const FetchBillState.error('Unexpected bill fetch response.'));
        }
      } else {
        emit(
          FetchBillState.error(responseData['statusDesc'] ?? 'Fetch failed.'),
        );
      }
    } catch (e) {
      emit(FetchBillState.error('Something went wrong. Please try again.'));
    }
  }

  Future<void> _onInitiatePayment(
    InitiatePayment event,
    Emitter<FetchBillState> emit,
  ) async {
    emit(const FetchBillState.paymentProcessing());

    try {
      // Step 1: Store bill payment temp
      final tempStoreResult = await _storeBillPaymentTemp(event);
      
      if (!tempStoreResult['success']) {
        emit(FetchBillState.paymentError(tempStoreResult['message']));
        return;
      }

      final receiptId = tempStoreResult['receiptId'];

      // Step 2: Create Razorpay order
      final orderResult = await _createRazorpayOrder(event.bill.billAmount);
      
      if (!orderResult['success']) {
        emit(FetchBillState.paymentError(orderResult['message']));
        return;
      }

      final orderId = orderResult['orderId'];

      // Step 3: Save payment details
      final saveResult = await _savePaymentDetails(
        receiptId: receiptId,
        orderId: orderId,
        transactionId: '',
        status: '2', // Initial status as pending
      );

      if (!saveResult['success']) {
        emit(FetchBillState.paymentError(saveResult['message']));
        return;
      }

      emit(FetchBillState.orderCreated(orderId: orderId, receiptId: receiptId));

    } catch (e) {
      emit(FetchBillState.paymentError('Failed to initiate payment: $e'));
    }
  }

  Future<void> _onProcessPaymentSuccess(
    ProcessPaymentSuccess event,
    Emitter<FetchBillState> emit,
  ) async {
    emit(const FetchBillState.paymentProcessing());

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
        await _initiateRefund(event.transactionId, event.receiptId);
        emit(FetchBillState.paymentError('Payment update failed. Refund initiated.'));
        return;
      }

      // Step 2: Process final bill payment
      final paymentResult = await _processBillPayment(event);

      if (paymentResult['success']) {
        emit(FetchBillState.paymentSuccess(
          'Payment completed successfully!',
          paymentResult['receiptId'] ?? event.receiptId,
        ));
      } else {
        // If final payment fails, initiate refund
        await _initiateRefund(event.transactionId, event.receiptId);
        emit(FetchBillState.paymentError(
          paymentResult['message'] ?? 'Payment failed. Refund initiated.'
        ));
      }

    } catch (e) {
      emit(FetchBillState.paymentError('Payment processing failed: $e'));
    }
  }

  Future<void> _onProcessPaymentFailure(
    ProcessPaymentFailure event,
    Emitter<FetchBillState> emit,
  ) async {
    // Update payment details as failure
    await _savePaymentDetails(
      receiptId: event.receiptId,
      orderId: event.orderId,
      transactionId: event.transactionId,
      status: '2', // Failure
    );

    emit(FetchBillState.paymentError(event.errorMessage));
  }

  // API Helper Methods
  Future<Map<String, dynamic>> _storeBillPaymentTemp(InitiatePayment event) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString('userId') ?? '';

    final url = Uri.parse('${baseUrl}kseb-bill-payment-temp-store');
    
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

      final responseData = json.decode(response.body);
      
      if (responseData['status'] == 'SUCCESS') {
        return {
          'success': true,
          'receiptId': responseData['data']['receiptId'].toString(),
        };
      } else {
        return {
          'success': false,
          'message': responseData['statusDesc'] ?? 'Failed to store bill details',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: $e',
      };
    }
  }

  Future<Map<String, dynamic>> _createRazorpayOrder(String amount) async {
    final amountInPaise = (double.tryParse(amount) ?? 0 * 100).toInt();
    final url = Uri.parse('${baseUrl}createOrder');

    try {
      final response = await http.post(
        url,
        body: {'amount': amountInPaise.toString()},
      );

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
      final response = await http.post(
        url,
        body: {
          'id': receiptId,
          'order_id': orderId,
          'transaction_id': transactionId,
          'status': status,
          'table': 'kseb',
        },
      );

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
          'txtAmount': '0', // You might want to pass actual amount
          'txtBillerName': event.providerID, // Adjust as needed
          'txtBillPeriod': '',
          'txtBillNumber': '',
          'txtCustomerName': '',
          'txtBillDueDate': '',
          'txtBillDate': '',
          'txtreqId': '',
          'billerId': event.providerID,
          'receiptId': event.receiptId,
          'orderId': event.orderId,
          'paymentStatus': '1',
          'transactionId': event.transactionId,
        },
      );

      final responseData = json.decode(response.body);
      
      if (responseData['status'] == 'SUCCESS') {
        return {
          'success': true,
          'receiptId': responseData['data']['receiptId'].toString(),
        };
      } else {
        return {
          'success': false,
          'message': responseData['statusDesc'] ?? 'Bill payment failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Bill payment processing failed: $e',
      };
    }
  }

  Future<void> _initiateRefund(String transactionId, String receiptId) async {
    final url = Uri.parse('${baseUrl}payrefund');
    final amount = '0'; // You might want to pass actual amount

    try {
      await http.post(
        url,
        body: {
          'id': receiptId,
          'transaction_id': transactionId,
          'amount': amount,
          'table': 'kseb',
        },
      );
    } catch (e) {
      log('Refund initiation failed: $e');
    }
  }
}

class ElectricityBillModel {
  final String billAmount;
  final String billDate;
  final String billNumber;
  final String billPeriod;
  final String customerName;
  final String dueDate;
  final String reqId;

  ElectricityBillModel({
    required this.billAmount,
    required this.billDate,
    required this.billNumber,
    required this.billPeriod,
    required this.customerName,
    required this.dueDate,
    required this.reqId,
  });

  factory ElectricityBillModel.fromJson(
    Map<String, dynamic> json,
    String reqId,
  ) {
    final rawAmount = json['billAmount'];
    final doubleAmount = (double.tryParse(rawAmount ?? '0') ?? 0) / 100;
    final formattedAmount = doubleAmount.toStringAsFixed(2);

    return ElectricityBillModel(
      billAmount: formattedAmount,
      billDate: json['billDate'] ?? '',
      billNumber: json['billNumber'] ?? '',
      billPeriod: json['billPeriod'] ?? '',
      customerName: json['customerName'] ?? '',
      dueDate: json['dueDate'] ?? '',
      reqId: reqId,
    );
  }
}