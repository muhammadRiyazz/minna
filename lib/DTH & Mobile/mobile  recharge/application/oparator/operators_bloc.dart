import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:minna/comman/core/api.dart';

part 'operators_event.dart';
part 'operators_state.dart';
part 'operators_bloc.freezed.dart';

class OperatorsBloc extends Bloc<OperatorsEvent, OperatorsState> {
  OperatorsBloc() : super(OperatorsState.initial()) {
    on<Getop>(_onGetOp);
    on<GetDTHop>(_onGetDTHOp);
  }

  // For Mobile Operators
  Future<void> _onGetOp(Getop event, Emitter<OperatorsState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await http.post(Uri.parse("${baseUrl}get-operator"));
      final body = json.decode(response.body);
      log("Mobile Operators Response: ${response.body}");

      if (body['status'] == 'SUCCESS') {
        final List<String> operators = (body['data'] as List)
            .map<String>((item) => item['name'].toString())
            .toList();

        emit(state.copyWith(isLoading: false, opList: operators));
      } else {
        emit(state.copyWith(isLoading: false, opList: []));
      }
    } catch (e) {
      log("Mobile Operators Error: ${e.toString()}");
      emit(state.copyWith(isLoading: false, opList: []));
    }
  }

  // For DTH Operators
  Future<void> _onGetDTHOp(GetDTHop event, Emitter<OperatorsState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await http.post(Uri.parse("${baseUrl}get-dth-operator"));
      final body = json.decode(response.body);
      log("DTH Operators Response: ${response.body}");

      if (body['status'] == 'SUCCESS') {
       final List<String> operators = (body['data'] as List)
          .map<String>((item) => item['name'].toString())
          .toList();


        emit(state.copyWith(isLoading: false, opDTHList: operators));
      } else {
        emit(state.copyWith(isLoading: false, opDTHList: []));
      }
    } catch (e) {
      log("DTH Operators Error: ${e.toString()}");
      emit(state.copyWith(isLoading: false, opDTHList: []));
    }
  }
}
