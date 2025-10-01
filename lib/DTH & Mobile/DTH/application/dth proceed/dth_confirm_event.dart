part of 'dth_confirm_bloc.dart';

@freezed
class DthConfirmEvent with _$DthConfirmEvent {
  const factory DthConfirmEvent.proceedWithPayment({
    required String phoneNo,
    required String operator,
    required String amount,
    required String subcriberNo,
    required String orderId,
    required String transactionId,
    required int paymentStatus,
    required String callbackId,
  }) = ProceedWithPayment;

  const factory DthConfirmEvent.paymentFailed({
    required String orderId,
    required String phoneNo,
    required String operator,
    required String amount,
    required String subcriberNo,
    required String callbackId,
  }) = PaymentFailed;

  const factory DthConfirmEvent.initiateRefund({
    required String orderId,
    required String transactionId,
    required String amount,
    required String phoneNo,
    required String callbackId,
  }) = InitiateRefund;

  const factory DthConfirmEvent.resetStates() = ResetStates;

  const factory DthConfirmEvent.markRefundAttempted() = MarkRefundAttempted;
}