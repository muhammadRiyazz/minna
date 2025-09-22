part of 'booked_details_bloc.dart';

@freezed
class BookedDetailsState with _$BookedDetailsState {
  const factory BookedDetailsState.initial() = _Initial;
  const factory BookedDetailsState.loading() = _Loading;
  
    const factory BookedDetailsState.success(BookingDetails details) = _Success;

    const factory BookedDetailsState.error(String message) = _Error;

  
  
  }
