import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:minna/bbps_dynamic/domain/bbps_dynamic_repository.dart';
import 'package:minna/bbps_dynamic/domain/models/bbps_models.dart';

part 'bbps_dynamic_event.dart';
part 'bbps_dynamic_state.dart';

class BbpsDynamicBloc extends Bloc<BbpsDynamicEvent, BbpsDynamicState> {
  final BbpsDynamicRepository repository;

  BbpsDynamicBloc({required this.repository}) : super(BbpsDynamicInitial()) {
    on<GetBillersEvent>(_onGetBillers);
    on<GetBillerInfoEvent>(_onGetBillerInfo);
    on<FetchBillEvent>(_onFetchBill);
  }

  Future<void> _onGetBillers(
    GetBillersEvent event,
    Emitter<BbpsDynamicState> emit,
  ) async {
    emit(BbpsDynamicLoading());
    try {
      final billers = await repository.getBillers(event.category);
      emit(BbpsDynamicBillersLoaded(billers: billers));
    } catch (e) {
      emit(BbpsDynamicError(message: 'Failed to load billers: $e'));
    }
  }

  Future<void> _onGetBillerInfo(
    GetBillerInfoEvent event,
    Emitter<BbpsDynamicState> emit,
  ) async {
    emit(BbpsDynamicLoading());
    try {
      final billerInfo = await repository.getBillerInfo(event.category, event.billerId);
      emit(BbpsDynamicBillerInfoLoaded(
        billerInfo: billerInfo,
        billerId: event.billerId,
        billerName: event.billerName,
      ));
    } catch (e) {
      emit(BbpsDynamicError(message: 'Failed to get biller info: $e'));
    }
  }

  Future<void> _onFetchBill(
    FetchBillEvent event,
    Emitter<BbpsDynamicState> emit,
  ) async {
    emit(BbpsDynamicLoading());
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final userId = preferences.getString('userId') ?? '';

      final billResponse = await repository.fetchBill(
        category: event.category,
        userId: userId,
        operatorId: event.billerId,
        number: event.number,
        dynamicParams: event.dynamicParams,
      );

      if (billResponse.success && billResponse.bill != null) {
        emit(BbpsDynamicBillFetched(billResponse: billResponse));
      } else {
        emit(BbpsDynamicError(message: 'Failed to fetch bill.'));
      }
    } catch (e) {
      emit(BbpsDynamicError(message: 'Failed to fetch bill: $e'));
    }
  }
}
