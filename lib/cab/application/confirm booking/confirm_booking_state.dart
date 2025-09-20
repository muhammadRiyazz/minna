// confirm_booking_state.dart
part of 'confirm_booking_bloc.dart';

@freezed
class ConfirmBookingState with _$ConfirmBookingState {
  const factory ConfirmBookingState.initial() = ConfirmBookingInitial;
  const factory ConfirmBookingState.loading() = ConfirmBookingLoading;
  const factory ConfirmBookingState.success({
    required BookingConfirmData data,
  }) = ConfirmBookingSuccess;
  const factory ConfirmBookingState.paymentFailed({
    required String message,
    required String orderId,
    required String tableid,
    required String bookingid,
  }) = ConfirmBookingPaymentFailed;
  const factory ConfirmBookingState.paymentSavedFailed({
    required String message,
    required String orderId,
    required String transactionId,
    required double amount,
    required String tableid,
    required String bookingid,
  }) = ConfirmBookingPaymentSavedFailed;
  const factory ConfirmBookingState.error({
    required String message,
    required bool shouldRefund,
    required String orderId,
    required String transactionId,
    required double amount,
    required String tableid,
    required String bookingid,
  }) = ConfirmBookingError;
  const factory ConfirmBookingState.refundProcessing({
    required String orderId,
    required String transactionId,
    required double amount,
    required String tableid,
    required String bookingid,
  }) = ConfirmBookingRefundProcessing;
  const factory ConfirmBookingState.refundInitiated({
    required String message,
    required String orderId,
    required String transactionId,
    required double amount,
    required String tableid,
    required String bookingid,
  }) = ConfirmBookingRefundInitiated;
  const factory ConfirmBookingState.refundFailed({
    required String message,
    required String orderId,
    required String transactionId,
    required double amount,
    required String tableid,
    required String bookingid,
  }) = ConfirmBookingRefundFailed;
}