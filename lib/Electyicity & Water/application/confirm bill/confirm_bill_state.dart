part of 'confirm_bill_bloc.dart';

@freezed
class ConfirmBillState with _$ConfirmBillState {
  const factory ConfirmBillState.initial() = _Initial;
  const factory ConfirmBillState.paymentProcessing() = _PaymentProcessing;
  const factory ConfirmBillState.orderCreated({
    required String orderId,
    required String receiptId,
    required ElectricityBillModel bill,
  }) = _OrderCreated;
  const factory ConfirmBillState.paymentSuccess(
    String message,
    String receiptId,
  ) = _PaymentSuccess;
  const factory ConfirmBillState.paymentError(String message) = _PaymentError;
  const factory ConfirmBillState.walletBalanceError(String message) =
      _WalletBalanceError;
  const factory ConfirmBillState.billPaymentResponse(
    Map<String, dynamic> responseData,
  ) = _BillPaymentResponse;
  const factory ConfirmBillState.billPaymentError(
    String message, {
    String? transactionId,
  }) = _BillPaymentError;
  const factory ConfirmBillState.refundProcessing() = _RefundProcessing;
  const factory ConfirmBillState.refundSuccess(
    String message,
    String receiptId,
  ) = _RefundSuccess;
  const factory ConfirmBillState.refundFailed(
    String message,
    String receiptId,
  ) = _RefundFailed;
}
