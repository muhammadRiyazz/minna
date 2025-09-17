part of 'hold_cab_bloc.dart';

@freezed
class HoldCabEvent with _$HoldCabEvent {
  const factory HoldCabEvent.holdCab({
  required Map<String, dynamic> requestData,
}) = _HoldCab;

}