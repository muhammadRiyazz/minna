part of 'hotel_booking_confirm_bloc.dart';

@freezed
class HotelBookingConfirmEvent with _$HotelBookingConfirmEvent {
  const factory HotelBookingConfirmEvent.paymentDone({
    required String orderId,
    required String transactionId,
    required String tableId,
    required String bookingId,
    required double amount,
      required String prebookId,

    required Map<String, dynamic> bookingRequest,
  }) = _PaymentDone;

  const factory HotelBookingConfirmEvent.paymentFail({
    required String orderId,
    required String tableId,
    required String bookingId,
  }) = _PaymentFail;

  const factory HotelBookingConfirmEvent.initiateRefund({
    required String orderId,
    required String transactionId,
    required double amount,
    required String tableId,
    required String bookingId,
  }) = _InitiateRefund;

  const factory HotelBookingConfirmEvent.startLoading() = _StartLoading;
  
  const factory HotelBookingConfirmEvent.stopLoading() = _StopLoading;

}



// hotel_booking_event.dart
// part of 'hotel_booking_bloc.dart';

// @freezed
// class HotelBookingEvent with _$HotelBookingEvent {
//   const factory HotelBookingEvent.paymentDone({
//     required String orderId,
//     required String transactionId,
//     required String tableId,
//     required String bookingId,
//     required double amount,
//     required Map<String, dynamic> bookingRequest,
//   }) = _PaymentDone;

//   const factory HotelBookingEvent.paymentFail({
//     required String orderId,
//     required String tableId,
//     required String bookingId,
//   }) = _PaymentFail;

//   const factory HotelBookingEvent.initiateRefund({
//     required String orderId,
//     required String transactionId,
//     required double amount,
//     required String tableId,
//     required String bookingId,
//   }) = _InitiateRefund;

//   const factory HotelBookingEvent.startLoading() = _StartLoading;
  
//   const factory HotelBookingEvent.stopLoading() = _StopLoading;
// }