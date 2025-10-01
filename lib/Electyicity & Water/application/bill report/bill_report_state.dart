// lib/water_electricity/application/bill_payment_bloc/bill_payment_state.dart

import 'package:minna/Electyicity%20&%20Water/domain/water_electricity_model.dart';

abstract class BillPaymentState {
  const BillPaymentState();
}

class BillPaymentInitial extends BillPaymentState {
  const BillPaymentInitial();
}

class BillPaymentLoading extends BillPaymentState {
  const BillPaymentLoading();
}

class BillPaymentLoaded extends BillPaymentState {
  final List<BillPaymentModel> transactions;
  
  const BillPaymentLoaded({required this.transactions});
}

class BillPaymentEmpty extends BillPaymentState {
  const BillPaymentEmpty();
}

class BillPaymentError extends BillPaymentState {
  final String message;
  
  const BillPaymentError(this.message);
}