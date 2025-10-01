part of 'recharge_proceed_bloc.dart';

@freezed
class RechargeProceedState with _$RechargeProceedState {
  const factory RechargeProceedState({
    required bool isLoading,
    String? rechargeStatus,
    String? refundStatus,
    String? paymentSavedStatus,
    String? orderId,
    String? transactionId,
    String? amount,
    bool? shouldRefund,
    @Default(false) bool isRefundInProgress,
    @Default(false) bool hasRefundBeenAttempted,
    @Default(false) bool hasRechargeFailedHandled,
    @Default(false) bool hasPaymentSaveFailedHandled,
  }) = _RechargeProceedState;

  factory RechargeProceedState.initial() {
    return const RechargeProceedState(
      isLoading: false,
      shouldRefund: false,
      isRefundInProgress: false,
      hasRefundBeenAttempted: false,
      hasRechargeFailedHandled: false,
      hasPaymentSaveFailedHandled: false,
    );
  }
}