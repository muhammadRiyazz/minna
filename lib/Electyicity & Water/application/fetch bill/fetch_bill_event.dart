part of 'fetch_bill_bloc.dart';

@freezed
class FetchBillEvent with _$FetchBillEvent {
  const factory FetchBillEvent.fetchElectricityBill({
    required String providerID,
    required String phoneNo,
    required String consumerId,
  }) = FetchElectricityBill;
  
  const factory FetchBillEvent.fetchWaterBill({
    required String providerID,
    required String phoneNo,
    required String consumerId,
  }) = FetchWaterBill;
  
  const factory FetchBillEvent.initiatePayment({
    required ElectricityBillModel bill,
    required String providerID,
    required String phoneNo,
    required String consumerId,
    required String providerName,
  }) = InitiatePayment;
  
  const factory FetchBillEvent.processPaymentSuccess({
    required String orderId,
    required String transactionId,
    required String receiptId,
    required String providerID,
    required String phoneNo,
    required String consumerId,
  }) = ProcessPaymentSuccess;
  
  const factory FetchBillEvent.processPaymentFailure({
    required String orderId,
    required String transactionId,
    required String receiptId,
    required String errorMessage,
  }) = ProcessPaymentFailure;
}