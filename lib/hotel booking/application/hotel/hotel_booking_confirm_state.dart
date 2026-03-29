part of 'hotel_booking_confirm_bloc.dart';

@freezed
class HotelBookingConfirmState with _$HotelBookingConfirmState {
  const factory HotelBookingConfirmState.initial() = HotelBookingConfirmInitial;

  const factory HotelBookingConfirmState.loading({
    HotelBookingConfirmState? previousState,
  }) = HotelBookingConfirmLoading;

  const factory HotelBookingConfirmState.orderCreated({
    required Map<String, dynamic> orderData,
  }) = HotelBookingConfirmOrderCreated;

  const factory HotelBookingConfirmState.success({
    required Map<String, dynamic> data,
  }) = HotelBookingConfirmSuccess;

  const factory HotelBookingConfirmState.error({
    required String message,
    Map<String, dynamic>? data,
  }) = HotelBookingConfirmError;
}