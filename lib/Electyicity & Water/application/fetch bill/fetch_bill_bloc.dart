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
      // final response = await http.post(
      //   url,
      //   body: {
      //     'userId': userId,
      //     'txtMobile': event.phoneNo,
      //     'txtConsumer': event.consumerId,
      //     'billerId': event.providerID,
      //   },
      // );
      // log(response.body);
       final testdata = '''
      {
        "status": "SUCCESS",
        "statusCode": 0,
        "statusDesc": "Bill successfully fetched.",
        "data": {
          "data": {
            "responseCode": "000",
            "inputParams": {
              "input": {
                "paramName": "Consumer Number",
                "paramValue": "1157443002603"
              }
            },
            "billerResponse": {
              "billAmount": "170100",
              "billDate": "2025-07-02",
              "billNumber": "5744250700277",
              "billPeriod": "NA",
              "customerName": "RAKHIYANATH FRAKRUDEEN",
              "dueDate": "2025-07-12"
            }
          },
          "reqId": "26EXAAZDDGXX3WLAWITCTV609FT9WNPYALE"
        }
      }''';

      final responseData = json.decode(testdata);

      if (responseData['status'] == 'SUCCESS') {
        final data = responseData['data']['data'];
        final responseCode = data['responseCode'];

        if (responseCode == '000') {
          final billerJson = data['billerResponse'];
          final reqId = responseData['data']['reqId'] ?? '';
          final bill = ElectricityBillModel.fromJson(billerJson, reqId);

          // Store bill payment temp
          final tempStoreResult = await _storeBillPaymentTemp(
            bill: bill,
            event: event,
          );
      
          if (!tempStoreResult['success']) {
            emit(FetchBillState.error(tempStoreResult['message'] ?? 'Failed to store bill details'));
            return;
          }

          final receiptId = tempStoreResult['receiptId'];
          emit(FetchBillState.success(bill: bill, receiptId: receiptId));
        } else if (responseCode == '001') {
          final errorMessage = data['errorInfo']?['error']?['errorMessage'] ?? 'Unable to fetch bill';
          emit(FetchBillState.error(errorMessage));
        } else {
          emit(const FetchBillState.error('Unexpected bill fetch response.'));
        }
      } else {
        emit(FetchBillState.error(responseData['statusDesc'] ?? 'Fetch failed.'));
      }
    } catch (e) {
      log(e.toString());
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

      // Use test data for now
      // final testdata = '''
      // {
      //   "status": "SUCCESS",
      //   "statusCode": 0,
      //   "statusDesc": "Bill successfully fetched.",
      //   "data": {
      //     "data": {
      //       "responseCode": "000",
      //       "inputParams": {
      //         "input": {
      //           "paramName": "Consumer Number",
      //           "paramValue": "1157443002603"
      //         }
      //       },
      //       "billerResponse": {
      //         "billAmount": "170100",
      //         "billDate": "2025-07-02",
      //         "billNumber": "5744250700277",
      //         "billPeriod": "NA",
      //         "customerName": "RAKHIYANATH FRAKRUDEEN",
      //         "dueDate": "2025-07-12"
      //       }
      //     },
      //     "reqId": "26EXAAZDDGXX3WLAWITCTV609FT9WNPYALE"
      //   }
      // }''';


      if (responseData['status'] == 'SUCCESS') {
        final data = responseData['data']['data'];
        final responseCode = data['responseCode'];

        if (responseCode == '000') {
          final billerJson = data['billerResponse'];
          final reqId = responseData['data']['reqId'] ?? '';
          final bill = ElectricityBillModel.fromJson(billerJson, reqId);
          
          // Store bill payment temp
          final tempStoreResult = await _storeBillPaymentTemp(
            bill: bill,
            event: event,
          );
      
          if (!tempStoreResult['success']) {
            emit(FetchBillState.error(tempStoreResult['message'] ?? 'Failed to store bill details'));
            return;
          }

          final receiptId = tempStoreResult['receiptId'];
          emit(FetchBillState.success(bill: bill, receiptId: receiptId));
        } else if (responseCode == '001') {
          final errorMessage = data['errorInfo']?['error']?['errorMessage'] ?? 'Unable to fetch bill';
          emit(FetchBillState.error(errorMessage));
        } else {
          emit(const FetchBillState.error('Unexpected bill fetch response.'));
        }
      } else {
        emit(FetchBillState.error(responseData['statusDesc'] ?? 'Fetch failed.'));
      }
    } catch (e) {
      log(e.toString());
      emit(FetchBillState.error('Something went wrong. Please try again.'));
    }
  }

  Future<Map<String, dynamic>> _storeBillPaymentTemp({
    required ElectricityBillModel bill,
    required FetchBillEvent event,
  }) async {
    log("_storeBillPaymentTemp ---");
    
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString('userId') ?? '';

    // Extract common parameters based on event type
    String phoneNo;
    String consumerId;
    String providerID;
    String providerName;

    if (event is FetchElectricityBill) {
      phoneNo = event.phoneNo;
      consumerId = event.consumerId;
      providerID = event.providerID;
      providerName = event.providerName;
    } else if (event is FetchWaterBill) {
      phoneNo = event.phoneNo;
      consumerId = event.consumerId;
      providerID = event.providerID;
      providerName = event.providerName;
    } else {
      return {
        'success': false,
        'message': 'Invalid event type',
      };
    }

    final url = Uri.parse('${baseUrl}kseb-bill-payment-temp-store');
    
    try {
      final response = await http.post(
        url,
        body: {
          'userId': userId,
          'txtMobile': phoneNo,
          'txtConsumer': consumerId,
          'txtAmount': bill.billAmount,
          'txtBillerName': providerName,
          'txtBillPeriod': bill.billPeriod,
          'txtBillNumber': bill.billNumber,
          'txtCustomerName': bill.customerName,
          'txtBillDueDate': bill.dueDate,
          'txtBillDate': bill.billDate,
          'txtreqId': bill.reqId,
          'billerId': providerID,
        }
      );

      log("Store bill temp response: ${response.body}");
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
      log(e.toString());
      return {
        'success': false,
        'message': 'Network error: $e',
      };
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