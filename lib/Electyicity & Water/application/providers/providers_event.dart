part of 'providers_bloc.dart';

@freezed
class ProvidersEvent with _$ProvidersEvent {
  const factory ProvidersEvent.getWaterProviders() = getWaterProviders;
  const factory ProvidersEvent.getElectryCirtProviders() =
      GeElectryCirtProviders;
}
