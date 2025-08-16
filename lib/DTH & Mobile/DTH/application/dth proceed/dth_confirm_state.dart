part of 'dth_confirm_bloc.dart';

@freezed
class DthConfirmState with _$DthConfirmState {
 const factory DthConfirmState({
    required bool isLoading,
    String? dthrechargeStatus,
  }) = _DthConfirmState;

  factory DthConfirmState.initial() {
    return const DthConfirmState(isLoading: false);
  }}
