import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:minna/hotel%20booking/functions/hotel_payment_utils.dart';

part 'hotel_booking_confirm_event.dart';
part 'hotel_booking_confirm_state.dart';
part 'hotel_booking_confirm_bloc.freezed.dart';

class HotelBookingConfirmBloc extends Bloc<HotelBookingConfirmEvent, HotelBookingConfirmState> {
  HotelBookingConfirmBloc() : super(const HotelBookingConfirmInitial()) {
    on<_CreateOrder>(_onCreateOrder);
    on<_VerifyPayment>(_onVerifyPayment);
    on<_Reset>(_onReset);
    on<_StartLoading>(_onStartLoading);
    on<_StopLoading>(_onStopLoading);
  }

  Future<void> _onCreateOrder(_CreateOrder event, Emitter<HotelBookingConfirmState> emit) async {
    emit(const HotelBookingConfirmLoading());
    try {
      final orderData = await createHotelRazorpayOrder(
        userId: event.userId,
        bookingPayload: event.bookingPayload,
        amount: event.amount,
        serviceCharge: event.serviceCharge,
      );

      if (orderData != null) {
        emit(HotelBookingConfirmOrderCreated(orderData: orderData));
      } else {
        emit(const HotelBookingConfirmError(message: "Failed to create payment order. Please try again."));
      }
    } catch (e) {
      log('💥 Create Order Error: $e');
      emit(HotelBookingConfirmError(message: "An unexpected error occurred: ${e.toString()}"));
    }
  }

  Future<void> _onVerifyPayment(_VerifyPayment event, Emitter<HotelBookingConfirmState> emit) async {
    emit(const HotelBookingConfirmLoading());
    try {
      final response = await verifyHotelRazorpayPayment(
        paymentId: event.paymentId,
        orderId: event.orderId,
        signature: event.signature,
        traceId: event.traceId,
        tokenId: event.tokenId,
      );

      if (response != null && response['status'] == true) {
        emit(HotelBookingConfirmSuccess(data: response));
      } else {
        final message = response?['message'] ?? "Booking verification failed. If amount was debited, it will be refunded.";
        emit(HotelBookingConfirmError(message: message, data: response));
      }
    } catch (e) {
      log('💥 Verify Payment Error: $e');
      emit(HotelBookingConfirmError(message: "An unexpected error occurred during verification."));
    }
  }

  void _onReset(_Reset event, Emitter<HotelBookingConfirmState> emit) {
    emit(const HotelBookingConfirmInitial());
  }

  void _onStartLoading(_StartLoading event, Emitter<HotelBookingConfirmState> emit) {
    final currentState = state;
    if (currentState is! HotelBookingConfirmLoading) {
      emit(HotelBookingConfirmState.loading(previousState: currentState));
    }
  }

  void _onStopLoading(_StopLoading event, Emitter<HotelBookingConfirmState> emit) {
    if (state is HotelBookingConfirmLoading) {
      final loadingState = state as HotelBookingConfirmLoading;
      if (loadingState.previousState != null) {
        emit(loadingState.previousState!);
      } else {
        emit(const HotelBookingConfirmInitial());
      }
    }
  }
}