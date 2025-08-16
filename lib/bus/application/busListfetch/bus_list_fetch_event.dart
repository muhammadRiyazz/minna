part of 'bus_list_fetch_bloc.dart';

@freezed
class BusListFetchEvent with _$BusListFetchEvent {
  const factory BusListFetchEvent.filterConform({
    required bool sleeper,
    required bool seater,
    required bool ac,
    required bool nonAC,
    required bool departureCase1,
    required bool departureCase2,
    required bool departureCase3,
    required bool departureCase4,
    required bool arrivalCase1,
    required bool arrivalCase2,
    required bool arrivalCase3,
    required bool arrivalCase4,
    required List<AvailableTrip> availableTrips,
  }) = FilterConform;
  const factory BusListFetchEvent.fetchTrip({
    required DateTime dateOfjurny,
    required City destID,
    required City sourceID,
  }) = FetchTrip;

  const factory BusListFetchEvent.selectTrip({
    required AvailableTrip trip,
    required City destID,
    required City sourceID,
  }) = SelectTrip;
}
