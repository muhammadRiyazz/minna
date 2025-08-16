part of 'location_bloc.dart';

@freezed
class LocationEvent with _$LocationEvent {
const factory LocationEvent.addLocation(City? from, City? to) =
      AddLocation;

  const factory LocationEvent.updateDate({required DateTime date}) =
      UpdateDate;

  const factory LocationEvent.swapLocations() = SwapLocations;}