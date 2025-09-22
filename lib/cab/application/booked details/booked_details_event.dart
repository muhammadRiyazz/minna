part of 'booked_details_bloc.dart';

@freezed
class BookedDetailsEvent with _$BookedDetailsEvent {
  // const factory BookedDetailsEvent.started() = _Started;
    const factory BookedDetailsEvent.fetchDetails(String bookingId) = _FetchDetails;
  const factory BookedDetailsEvent.reset() = _Reset;
}