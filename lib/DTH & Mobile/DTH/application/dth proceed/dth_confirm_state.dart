part of 'dth_confirm_bloc.dart';

@freezed
class DthConfirmState with _$DthConfirmState {
  const factory DthConfirmState({
    required bool isLoading,
    String? rechargeStatus,
    String? refundStatus,
    String? paymentSavedStatus,
    String? orderId,
    String? transactionId,
    String? amount,
    String? errorMessage,
    bool? shouldRefund,
    @Default(false) bool isRefundInProgress,
    @Default(false) bool hasRefundBeenAttempted,
    @Default(false) bool hasRechargeFailedHandled,
    @Default(false) bool hasPaymentSaveFailedHandled,
  }) = _DthConfirmState;

  factory DthConfirmState.initial() {
    return const DthConfirmState(
      isLoading: false,
      shouldRefund: false,
      isRefundInProgress: false,
      hasRefundBeenAttempted: false,
      hasRechargeFailedHandled: false,
      hasPaymentSaveFailedHandled: false,
    );
  }
}