part of 'recharge_proceed_bloc.dart';

@freezed
class RechargeProceedEvent with _$RechargeProceedEvent {
  const factory RechargeProceedEvent.proceed({
    required String phoneNo,
    required String operator,
    required String amount,
  }) = Proceed;
}
