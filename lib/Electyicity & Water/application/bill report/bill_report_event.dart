// lib/water_electricity/application/bill_payment_bloc/bill_payment_event.dart

abstract class BillPaymentEvent {
  const BillPaymentEvent();
}

class FetchBillPayments extends BillPaymentEvent {
  final String? billerCategory;
  
  const FetchBillPayments({this.billerCategory});
}