part of 'report_transaction_bloc.dart';




@freezed
class TransactionReportState with _$TransactionReportState {
  const factory TransactionReportState.initial() = _Initial;
  const factory TransactionReportState.loading() = _Loading;
  const factory TransactionReportState.loaded({
    required List<TransactionModel> transactions,
  }) = _Loaded;
  const factory TransactionReportState.empty() = _Empty;
  const factory TransactionReportState.error(String message) = _Error;
}