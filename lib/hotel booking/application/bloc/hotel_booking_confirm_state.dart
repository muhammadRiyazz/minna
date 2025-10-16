part of 'hotel_booking_confirm_bloc.dart';

@freezed
class HotelBookingConfirmState with _$HotelBookingConfirmState {
  const factory HotelBookingConfirmState.initial() = HotelBookingConfirmInitial;
  
  const factory HotelBookingConfirmState.loading({
    HotelBookingConfirmState? previousState,
  }) = HotelBookingConfirmLoading;

  const factory HotelBookingConfirmState.success({
    required Map<String, dynamic> data,
    required String bookingId,
    required String confirmationNo,
    required String bookingRefNo,
    required String booktableId,
  }) = HotelBookingConfirmSuccess;

  const factory HotelBookingConfirmState.paymentFailed({
    required String message,
    required String orderId,
    required String bookingId,
  }) = HotelBookingConfirmPaymentFailed;
  
  const factory HotelBookingConfirmState.paymentSavedFailed({
    required String message,
    required String orderId,
    required String transactionId,
    required double amount,
    required String bookingId,
    required bool shouldRefund,
  }) = HotelBookingConfirmPaymentSavedFailed;
  
  const factory HotelBookingConfirmState.error({
    required String message,
    required bool shouldRefund,
    required String orderId,
    required String transactionId,
    required double amount,
    required String booktableId,
    required String bookingId,
  }) = HotelBookingConfirmError;
  
  const factory HotelBookingConfirmState.refundProcessing({
    required String orderId,
    required String transactionId,
    required double amount,
    required String booktableId,
    required String bookingId,
  }) = HotelBookingConfirmRefundProcessing;
  
  const factory HotelBookingConfirmState.refundInitiated({
    required String message,
    required String orderId,
    required String transactionId,
    required double amount,
    required String booktableId,
    required String bookingId,
  }) = HotelBookingConfirmRefundInitiated;
  
  const factory HotelBookingConfirmState.refundFailed({
    required String message,
    required String orderId,
    required String transactionId,
    required double amount,
    // required String tableId,
    required String bookingId,
  }) = HotelBookingConfirmRefundFailed;
}