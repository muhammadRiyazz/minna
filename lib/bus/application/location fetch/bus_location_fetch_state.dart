part of 'bus_location_fetch_bloc.dart';

@freezed
class BusLocationFetchState with _$BusLocationFetchState {
factory BusLocationFetchState({
    required bool isLoading,
    CityModelList? allCitydata,
        List<City>? filteredCities,

  }) = _LocationFetchState;
  factory BusLocationFetchState.initial() {
    return BusLocationFetchState(
      isLoading: true,
    );
  }}
