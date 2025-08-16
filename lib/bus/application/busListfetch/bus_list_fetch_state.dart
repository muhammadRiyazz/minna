import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:minna/bus/domain/trips%20list%20modal/trip_list_modal.dart';
part 'bus_list_fetch_state.freezed.dart';

@freezed
class BusListFetchState with _$BusListFetchState {
  const factory BusListFetchState({
    required bool isLoading,
    required bool isError,
    List<AvailableTrip>? availableTrips,
    AvailableTrip? selectTrip,
    bool? notripp,
  }) = _BusListFetchState;
  factory BusListFetchState.initial() {
    return const BusListFetchState(
      isLoading: true,
      isError: false,
      availableTrips: null,
      selectTrip: null,
      notripp: null,
    );
  }
}
