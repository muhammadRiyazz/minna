part of 'confirm_bill_bloc.dart';

@freezed
class ConfirmBillEvent with _$ConfirmBillEvent {
  const factory ConfirmBillEvent.initiatePayment({
    required ElectricityBillModel bill,
    required String providerID,
    required String phoneNo,
    required String consumerId,
    required String providerName,
    required String receiptId,
  }) = InitiatePayment;
  
  const factory ConfirmBillEvent.processPaymentSuccess({
    required String orderId,
    required String transactionId,
    required String receiptId,
    required String providerID,
    required String phoneNo,
    required String consumerId,
    required ElectricityBillModel? currentBill,
  }) = ProcessPaymentSuccess;
  
  const factory ConfirmBillEvent.processPaymentFailure({
    required String orderId,
    required String transactionId,
    required String receiptId,
    required String errorMessage,
  }) = ProcessPaymentFailure;

  const factory ConfirmBillEvent.initiateRefund({
    required String transactionId,
    required String receiptId,
    required String amount,
    required String reason,
  }) = InitiateRefund;
}