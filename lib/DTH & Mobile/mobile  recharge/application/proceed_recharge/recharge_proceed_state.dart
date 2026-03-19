part of 'recharge_proceed_bloc.dart';

@freezed
class RechargeProceedState with _$RechargeProceedState {
  const factory RechargeProceedState({
    required bool isLoading,
    String? rechargeStatus,
    String? paymentSavedStatus,
    String? orderId,
    String? transactionId,
    String? amount,
    String? actualStatus,
    String? errorMessage,
  }) = _RechargeProceedState;

  factory RechargeProceedState.initial() {
    return const RechargeProceedState(
      isLoading: false,
    );
  }
}