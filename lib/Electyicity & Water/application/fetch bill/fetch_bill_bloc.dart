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
          'txtConsumer': event.cunsumerid,
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
          'txtConsumer': event.cunsumerid,
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
}

class ElectricityBillModel {
  final String billAmount; // already formatted as rupee string
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
    final formattedAmount = doubleAmount.toStringAsFixed(2); // e.g., 2777.00

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
