part of 'hotel_booking_confirm_bloc.dart';

@freezed
class HotelBookingConfirmEvent with _$HotelBookingConfirmEvent {
  const factory HotelBookingConfirmEvent.createOrder({
    required String userId,
    required Map<String, dynamic> bookingPayload,
    required double amount,
    required double serviceCharge,
  }) = _CreateOrder;

  const factory HotelBookingConfirmEvent.verifyPayment({
    required String paymentId,
    required String orderId,
    required String signature,
    required String traceId,
    required String tokenId,
  }) = _VerifyPayment;

  const factory HotelBookingConfirmEvent.reset() = _Reset;
  const factory HotelBookingConfirmEvent.startLoading() = _StartLoading;
  const factory HotelBookingConfirmEvent.stopLoading() = _StopLoading;
}