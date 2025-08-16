part of 'location_bloc.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState({
    City? from,
    City? to,
    required DateTime dateOfJourney,
  }) = _LocationState;

  factory LocationState.initial() {
    return LocationState(
      from: null,
      to: null,
      dateOfJourney: DateTime.now(),
    );
  }}
