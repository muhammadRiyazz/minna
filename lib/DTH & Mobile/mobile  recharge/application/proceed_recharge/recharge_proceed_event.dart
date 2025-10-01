part of 'recharge_proceed_bloc.dart';

@freezed
class RechargeProceedEvent with _$RechargeProceedEvent {
  const factory RechargeProceedEvent.proceedWithPayment({
    required String phoneNo,
    required String operator,
    required String amount,
    required String orderId,
    required String transactionId,
    required int paymentStatus,
    required String callbackId,
  }) = ProceedWithPayment;

  const factory RechargeProceedEvent.paymentFailed({
    required String orderId,
    required String phoneNo,
    required String operator,
    required String amount,
    required String callbackId,
  }) = PaymentFailed;

  const factory RechargeProceedEvent.initiateRefund({
    required String orderId,
    required String transactionId,
    required String amount,
    required String phoneNo,
    required String callbackId,
  }) = InitiateRefund;

  const factory RechargeProceedEvent.resetStates() = ResetStates;

  const factory RechargeProceedEvent.markRefundAttempted() = MarkRefundAttempted;
}