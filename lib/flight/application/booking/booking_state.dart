part of 'booking_bloc.dart';

@freezed
class BookingState with _$BookingState {
  const factory BookingState({
    required bool isLoading,
    BBBookingRequest? bookingdata,
    String? bookingError,
    bool? isBookingConfirmed,
    String? alhindPnr,
  }) = _BookingState;

  factory BookingState.initial() => const BookingState(
        isLoading: false,
        bookingError: null,
        isBookingConfirmed: false,
        alhindPnr: null,
      );
}