part of 'fare_request_bloc.dart';

@freezed
class FareRequestState with _$FareRequestState {
  const factory FareRequestState({
    required bool isLoading,
    String? tokan,

    FFlightResponse? respo,
  }) = _BookingState;

  factory FareRequestState.initial() => FareRequestState(isLoading: false);}
