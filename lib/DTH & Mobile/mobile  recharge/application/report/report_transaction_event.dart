part of 'report_transaction_bloc.dart';


@freezed
class TransactionReportEvent with _$TransactionReportEvent {
  const factory TransactionReportEvent.fetchTransactions({
    required String billerType, // 'Mobile Recharge' or 'DTH Recharge'
    required String fromDate,
    required String toDate,
  }) = FetchTransactions;
}