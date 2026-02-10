part of 'hotel_booking_confirm_bloc.dart';

@freezed
class HotelBookingConfirmEvent with _$HotelBookingConfirmEvent {
  const factory HotelBookingConfirmEvent.paymentDone({
    required String orderId,
    required String transactionId,
    required String bookingId,
    required double amount,
    required String prebookId,
    required Map<String, dynamic> bookingRequest,
  }) = _PaymentDone;

  const factory HotelBookingConfirmEvent.paymentFail({
    required String orderId,
    required String prebookId,
    required String bookingId,
  }) = _PaymentFail;

  const factory HotelBookingConfirmEvent.initiateRefund({
    required String orderId,
    required String transactionId,
    required double amount,

        required String booktableId,

    required String bookingId,
  }) = _InitiateRefund;

  const factory HotelBookingConfirmEvent.startLoading() = _StartLoading;
  
  const factory HotelBookingConfirmEvent.stopLoading() = _StopLoading;
}