part of 'fare_request_bloc.dart';

@freezed
class FareRequestEvent with _$FareRequestEvent {
const factory FareRequestEvent.getFareRequestApi({
    required FlightOptionElement flightTrip,
    required String token,
    required String tripMode,
  }) = GetFareRequestApi;}