part of 'bus_location_fetch_bloc.dart';

@freezed
class BusLocationFetchEvent with _$BusLocationFetchEvent {
 const factory BusLocationFetchEvent.getData() = GetData;
    const factory BusLocationFetchEvent.searchLocations({required String query}) = SearchLocations;
}