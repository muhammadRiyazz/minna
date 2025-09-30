part of 'recharge_proceed_bloc.dart';

@freezed
class RechargeProceedEvent with _$RechargeProceedEvent {
  // const factory RechargeProceedEvent.proceed({
  //   required String phoneNo,
  //   required String operator,
  //   required String amount,
  //  required  String callbackId,
  // }) = Proceed;

 const factory RechargeProceedEvent.proceedWithPayment({
    required String phoneNo,
    required String operator,
    required String amount,
    required String orderId,
    required String transactionId,
    required int paymentStatus,
    required String callbackId, // Add this parameter
  }) = ProceedWithPayment;

  const factory RechargeProceedEvent.paymentFailed({
    required String orderId,
    required String phoneNo,
    required String operator,
    required String amount,
    // String? callbackId, // Add this parameter
  }) = PaymentFailed;

  const factory RechargeProceedEvent.initiateRefund({
    required String orderId,
    required String transactionId,
    required String amount,
    required String phoneNo,
    // String? callbackId, // Add this parameter
  }) = InitiateRefund;
}