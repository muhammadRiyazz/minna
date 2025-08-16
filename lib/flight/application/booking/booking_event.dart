part of 'booking_bloc.dart';

@freezed
class BookingEvent with _$BookingEvent {
 const factory BookingEvent.getRePrice({
    required bool reprice,
    required String tripMode,
    required FFlightOption fareReData,
    required List<Map<String, dynamic>> passengerDataList,
    required String token,
  }) = _GetRePrice;
  const factory BookingEvent.confirmBooking() = ConfirmBooking;
  const factory BookingEvent.resetBooking() = ResetBooking;
}
