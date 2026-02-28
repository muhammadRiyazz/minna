import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:minna/comman/core/api.dart';
import 'package:minna/DTH & Mobile/mobile  recharge/domain/plan_model.dart';

// --- Events ---
abstract class DTHPlansEvent {}

class FetchDTHPlansEvent extends DTHPlansEvent {
  final String operatorName;
  FetchDTHPlansEvent({required this.operatorName});
}

// --- States ---
abstract class DTHPlansState {}

class DTHPlansStateInitial extends DTHPlansState {}

class DTHPlansStateLoading extends DTHPlansState {}

class DTHPlansStateLoaded extends DTHPlansState {
  final List<PlanTab> tabs;
  DTHPlansStateLoaded({required this.tabs});
}

class DTHPlansStateError extends DTHPlansState {
  final String message;
  DTHPlansStateError({required this.message});
}

// --- BLoC ---
class DTHPlansBloc extends Bloc<DTHPlansEvent, DTHPlansState> {
  DTHPlansBloc() : super(DTHPlansStateInitial()) {
    on<FetchDTHPlansEvent>((event, emit) async {
      emit(DTHPlansStateLoading());
      try {
        final uri = Uri.parse('${baseUrl}dth-plans-callback');
        final response = await http.post(
          uri,
          body: {'operator': event.operatorName},
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data['status'] == 'SUCCESS') {
            final tabsList = data['tabs'] as List? ?? [];
            final tabs = tabsList.map((t) => PlanTab.fromJson(t)).toList();
            emit(DTHPlansStateLoaded(tabs: tabs));
          } else {
            emit(
              DTHPlansStateError(
                message: data['statusDesc'] ?? 'Failed to load plans',
              ),
            );
          }
        } else {
          emit(
            DTHPlansStateError(message: 'Server Error: ${response.statusCode}'),
          );
        }
      } catch (e) {
        emit(DTHPlansStateError(message: 'Error fetching plans: $e'));
      }
    });
  }
}
