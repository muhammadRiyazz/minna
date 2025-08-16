part of 'operators_bloc.dart';

@freezed
class OperatorsEvent with _$OperatorsEvent {
  const factory OperatorsEvent.getop() = Getop;
    const factory OperatorsEvent.getDTHop() = GetDTHop;

}
