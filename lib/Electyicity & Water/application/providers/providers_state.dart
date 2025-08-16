part of 'providers_bloc.dart';

@freezed
class ProvidersState with _$ProvidersState {
  const factory ProvidersState({
    required bool isLoading,
    List<BillerModel>? electricityList,
    List<BillerModel>? waterList,
  }) = _ProvidersState;

  factory ProvidersState.initial() =>
      ProvidersState(isLoading: false, electricityList: [], waterList: []);
}
