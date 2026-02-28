import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:minna/comman/core/api.dart';
import '../../domain/plan_model.dart';

part 'plans_event.dart';
part 'plans_state.dart';

class PlansBloc extends Bloc<PlansEvent, PlansState> {
  PlansBloc() : super(PlansStateInitial()) {
    on<FetchPlansEvent>(_onFetchPlans);
  }

  Future<void> _onFetchPlans(
    FetchPlansEvent event,
    Emitter<PlansState> emit,
  ) async {
    emit(PlansStateLoading());
    try {
      final response = await http.post(
        Uri.parse("${baseUrl}plans-callback"),
        body: {'operator': event.operatorName},
      );
      final body = json.decode(response.body);

      if (body['status'] == 'SUCCESS' && body['statusCode'] == 0) {
        var tabsList = body['tabs'] as List? ?? [];
        List<PlanTab> tabs = tabsList
            .map((i) => PlanTab.fromJson(i as Map<String, dynamic>))
            .toList();

        emit(PlansStateLoaded(tabs: tabs));
      } else {
        emit(
          PlansStateError(
            message: body['statusDesc']?.toString() ?? 'Failed to fetch plans',
          ),
        );
      }
    } catch (e) {
      emit(PlansStateError(message: 'Error fetching plans: ${e.toString()}'));
    }
  }
}
