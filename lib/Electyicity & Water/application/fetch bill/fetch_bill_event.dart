part of 'fetch_bill_bloc.dart';

@freezed
class FetchBillEvent with _$FetchBillEvent {
  const factory FetchBillEvent.fetchElectricityBill({required String providerID,required String phoneNo,required String cunsumerid}) = FetchElectricityBill;
  const factory FetchBillEvent.fetchWaterBill({required String providerID,required String phoneNo,required String cunsumerid}) = FetchWaterBill;
}
