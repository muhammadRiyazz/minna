// confirm_booking_event.dart
part of 'confirm_booking_bloc.dart';

@freezed
class ConfirmBookingEvent with _$ConfirmBookingEvent {
  const factory ConfirmBookingEvent.paymentDone({
    required String orderId,
    required String transactionId,
    required int status,
    required String tableid,
    required String table,
    required String bookingid,
    required double amount,
  }) = _PaymentDone;

  const factory ConfirmBookingEvent.paymentFail({
    required String orderId,
    required String tableid,
    required String bookingid,
  }) = _PaymentFail;

  const factory ConfirmBookingEvent.initiateRefund({
    required String orderId,
    required String transactionId,
    required double amount,
    required String tableid,
    required String bookingid,
  }) = _InitiateRefund;
}