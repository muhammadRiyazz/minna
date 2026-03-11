import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:minna/comman/application/home_data/destination_model.dart';
import 'package:minna/comman/application/home_data/visa_model.dart';

part 'home_data_state.freezed.dart';

@freezed
class HomeDataState with _$HomeDataState {
  const factory HomeDataState({
    required bool isDestinationsLoading,
    List<DestinationModel>? popularDestinations,
    required bool isVisaLoading,
    List<VisaModel>? visaCountries,
  }) = _HomeDataState;

  factory HomeDataState.initial() => const HomeDataState(
    isDestinationsLoading: false,
    popularDestinations: null,
    isVisaLoading: false,
    visaCountries: null,
  );
}
