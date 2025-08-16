part of 'dth_confirm_bloc.dart';

@freezed
class DthConfirmEvent with _$DthConfirmEvent {
    const factory DthConfirmEvent.proceed({
    required String phoneNo,
    required String operator,
    required String amount,
        required String subcriberNo,

  }) = Proceed;
}