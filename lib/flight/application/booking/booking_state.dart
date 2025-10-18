part of 'booking_bloc.dart';

@freezed
class BookingState with _$BookingState {
  const factory BookingState({
    required bool isLoading,
    required bool isRepriceLoading,
    required bool isRepriceCompleted,
    
    // Booking Data
    BBBookingRequest? bookingdata,
    String? bookingError,
    bool? isBookingConfirmed,
    String? alhindPnr,
    String? tableID,
    
    // Razorpay Data
    String? razorpayOrderId,
    String? razorpayPaymentId,
    String? razorpaySignature,
    
    // Process Flags
    bool? isCreatingOrder,
    bool? isPaymentProcessing,
    bool? isConfirmingBooking,
    bool? isSavingFinalBooking,
    bool? isRefundProcessing,
    
    // Status Flags
    bool? paymentFailed,
    bool? bookingFailed,
    bool? refundRequired,
    bool? refundInitiated,
    bool? refundFailed,
    bool? isBookingCompleted,
    
    // Temporary data
    String? tempBookingId,
    double? tempAmount,
  }) = _BookingState;

  factory BookingState.initial() => const BookingState(
    tableID: null,
    isRepriceLoading: false,
    isRepriceCompleted: false,
    isLoading: false,
    bookingError: null,
    isBookingConfirmed: false,
    alhindPnr: null,
    razorpayOrderId: null,
    razorpayPaymentId: null,
    razorpaySignature: null,
    isCreatingOrder: false,
    isPaymentProcessing: false,
    isConfirmingBooking: false,
    isSavingFinalBooking: false,
    isRefundProcessing: false,
    paymentFailed: false,
    bookingFailed: false,
    refundRequired: false,
    refundInitiated: false,
    refundFailed: false,
    isBookingCompleted: false,
    tempBookingId: null,
    tempAmount: null,
  );
}