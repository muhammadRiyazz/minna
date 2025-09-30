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
  }) = _RechargeProceedState;

  factory RechargeProceedState.initial() {
    return const RechargeProceedState(
      isLoading: false,
      shouldRefund: false,
    );
  }
}