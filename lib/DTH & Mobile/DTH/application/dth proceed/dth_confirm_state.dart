part of 'dth_confirm_bloc.dart';

@freezed
class DthConfirmState with _$DthConfirmState {
  const factory DthConfirmState({
    required bool isLoading,
    String? rechargeStatus,
    String? paymentSavedStatus,
    String? orderId,
    String? transactionId,
    String? amount,
    String? actualStatus,
    String? errorMessage,
    @Default(false) bool hasRechargeFailedHandled,
    @Default(false) bool hasPaymentSaveFailedHandled,
  }) = _DthConfirmState;

  factory DthConfirmState.initial() {
    return const DthConfirmState(
      isLoading: false,
      hasRechargeFailedHandled: false,
      hasPaymentSaveFailedHandled: false,
    );
  }
}