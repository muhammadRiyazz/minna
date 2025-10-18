part of 'booking_bloc.dart';

@freezed
class BookingEvent with _$BookingEvent {
 const factory BookingEvent.getRePrice({
    required bool reprice,
    required String tripMode,
    required FFlightOption fareReData,
    required List<Map<String, dynamic>> passengerDataList,
    required String token,

    required FFlightResponse lastRespo,
  }) = _GetRePrice;
  // Booking confirmation events
  const factory BookingEvent.confirmFlightBooking({
    required String paymentId,
    required String orderId,

    required String signature,
  }) = _ConfirmFlightBooking;

 


  const factory BookingEvent.saveFinalBooking({
    required String alhindPnr,
    required String tableID,
    required String orderId,
    required String signature,
    required String paymentId,
    required Map<String, dynamic> finalResponse,
    required Map<String, dynamic> razorpayResponse,
  }) = _SaveFinalBooking;

  // Refund events
  const factory BookingEvent.initiateRefund({
    required String orderId,
    required String paymentId,
    required double amount,
    required String tableID,
    required String reason,
  }) = _InitiateRefund;

  const factory BookingEvent.resetBooking() = _ResetBooking;
}



