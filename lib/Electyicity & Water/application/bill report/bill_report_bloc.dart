
import 'package:bloc/bloc.dart';
import 'package:minna/Electyicity%20&%20Water/application/bill%20report/bill_report_event.dart';
import 'package:minna/Electyicity%20&%20Water/application/bill%20report/bill_report_state.dart';
import 'package:minna/Electyicity%20&%20Water/function/report_api.dart';

class BillPaymentBloc extends Bloc<BillPaymentEvent, BillPaymentState> {
  final BillPaymentRepository _repository;

  BillPaymentBloc(this._repository) : super(const BillPaymentInitial()) {
    on<FetchBillPayments>(_onFetchBillPayments);
  }

  Future<void> _onFetchBillPayments(
    FetchBillPayments event,
    Emitter<BillPaymentState> emit,
  ) async {
    emit(const BillPaymentLoading());

    try {
      final response = await _repository.getBillPaymentReport();
      
      // Filter by biller category if provided
      final filteredData = event.billerCategory != null
          ? response.data.where((item) => 
              item.billerCategory.toLowerCase() == event.billerCategory!.toLowerCase())
              .toList()
          : response.data;

      if (filteredData.isNotEmpty) {
        emit(BillPaymentLoaded(transactions: filteredData));
      } else {
        emit(const BillPaymentEmpty());
      }
    } catch (e) {
      emit(BillPaymentError(e.toString()));
    }
  }
}