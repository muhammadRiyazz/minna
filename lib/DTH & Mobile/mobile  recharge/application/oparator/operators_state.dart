part of 'operators_bloc.dart';

@freezed
class OperatorsState with _$OperatorsState {
  const factory OperatorsState({
    required bool isLoading,
     List<String>? opList,
          List<String>? opDTHList,

  }) = _OperatorsState;

  factory OperatorsState.initial() =>
      OperatorsState(isLoading: false,);}
