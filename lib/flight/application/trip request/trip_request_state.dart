part of 'trip_request_bloc.dart';

@freezed
class TripRequestState with _$TripRequestState {
  const factory TripRequestState({
    required bool isLoading,
    String? token,
    required int getdata,
    List<FlightOptionElement>? respo,
    required bool isflightLoading,
  }) = _TripRequestState;

  factory TripRequestState.initial() => const TripRequestState(
        isLoading: false,
        isflightLoading: false,
        getdata: 0,
        token: null,
        respo: null,
      );}
