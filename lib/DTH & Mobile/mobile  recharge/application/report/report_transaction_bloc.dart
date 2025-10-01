import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:minna/DTH%20&%20Mobile/mobile%20%20recharge/domain/report_model.dart';
import 'package:minna/comman/core/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'report_transaction_event.dart';
part 'report_transaction_state.dart';
      part 'report_transaction_bloc.freezed.dart';                                                                     


class TransactionReportBloc extends Bloc<TransactionReportEvent, TransactionReportState> {
  TransactionReportBloc() : super(const TransactionReportState.initial()) {
    on<FetchTransactions>(_onFetchTransactions);
  }

  Future<void> _onFetchTransactions(
    FetchTransactions event,
    Emitter<TransactionReportState> emit,
  ) async {
    emit(const TransactionReportState.loading());

    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      final userId = preferences.getString('userId') ?? '';

      final url = Uri.parse('${baseUrl}utility_report');

      final response = await http.post(
        url,
        body: {
          'user_id': userId,
          'billerid': event.billerType,
          'from': event.fromDate,
          'to': event.toDate,
        },
      );
log( {
          'user_id': userId,
          'billerid': event.billerType,
          'from': event.fromDate,
          'to': event.toDate,
        }.toString());
      log('Transaction Report Response: ${response.body}');

      final responseData = json.decode(response.body);
      final transactionResponse = TransactionResponse.fromJson(responseData);

      if (transactionResponse.isSuccess) {
        if (transactionResponse.transactions.isNotEmpty) {
          emit(TransactionReportState.loaded(transactions: transactionResponse.transactions));
        } else {
          emit(const TransactionReportState.empty());
        }
      } else {
        emit(TransactionReportState.error(
          transactionResponse.errorMessage ?? 'Failed to fetch transactions'
        ));
      }
    } catch (e) {
      log('Transaction Report Error: $e');
      emit(TransactionReportState.error('Network error: Please check your connection'));
    }
  }
}