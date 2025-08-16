part of 'fetch_bill_bloc.dart';

@freezed
class FetchBillState with _$FetchBillState {
  const factory FetchBillState.initial() = _Initial;
  const factory FetchBillState.loading() = _Loading;
  const factory FetchBillState.success({
    required ElectricityBillModel bill,
  }) = _Success;
  const factory FetchBillState.error(String message) = _Error;
}
