part of 'trip_request_bloc.dart';

@freezed
class TripRequestEvent with _$TripRequestEvent {
 const factory TripRequestEvent.getTripList({
    required FlightSearchRequest flightRequestData,
  }) = GetTripList;

  const factory TripRequestEvent.changeFare({
    required FlightFare selectedFare,
    required FlightOptionElement selectedTrip
  }) = ChangeFare;
  const factory TripRequestEvent.getFlightinfo({
    required Airport fromAirportinfo,
    required Airport toAirportinfo,
  }) = GetFlightinfo;}