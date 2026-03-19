part of 'booking_bloc.dart';

@freezed
class BookingEvent with _$BookingEvent {
 const factory BookingEvent.getRePrice({
    required bool reprice,
    required String tripMode,
    required FFlightOption fareReData,
    required List<Map<String, dynamic>> passengerDataList,
    required String token,
    required String triptype,
    required FFlightResponse lastRespo,
  }) = _GetRePrice;
  // Booking confirmation events
  const factory BookingEvent.verifyFlightPayment({
    required String paymentId,
    required String orderId,
    required String signature,
  }) = _VerifyFlightPayment;


  const factory BookingEvent.resetBooking() = _ResetBooking;
}
