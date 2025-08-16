import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:minna/comman/core/api.dart';

part 'providers_event.dart';
part 'providers_state.dart';
      part 'providers_bloc.freezed.dart';                                                  
class ProvidersBloc extends Bloc<ProvidersEvent, ProvidersState> {
  ProvidersBloc() : super(ProvidersState.initial()) {
      on<getWaterProviders>(getWaterProviderslist);
    on<GeElectryCirtProviders>(geElectryCirtProviderslist);
  }



  Future<void> getWaterProviderslist(
  getWaterProviders event,
  Emitter<ProvidersState> emit,
) async {
  emit(state.copyWith(isLoading: true));
  try {
    final response = await http.post(
      Uri.parse("${baseUrl}get-live-biller"),
      body: {"billerCategory": 'Water'},
    );
    final body = json.decode(response.body);
    log("Water Providers Response: ${response.body}");

    if (body['status'] == 'SUCCESS') {
      final List<BillerModel> providers = (body['data'] as List)
          .map((item) => BillerModel.fromJson(item))
          .toList();

      emit(state.copyWith(isLoading: false, waterList: providers));
    } else {
      emit(state.copyWith(isLoading: false, waterList: []));
    }
  } catch (e) {
    log("Water Providers Error: ${e.toString()}");
    emit(state.copyWith(isLoading: false, waterList: []));
  }
}

Future<void> geElectryCirtProviderslist(
  GeElectryCirtProviders event,
  Emitter<ProvidersState> emit,
) async {
  emit(state.copyWith(isLoading: true));
  try {
    final response = await http.post(
      Uri.parse("${baseUrl}get-live-biller"),
      body: {"billerCategory": 'Electricity'},
    );
    final body = json.decode(response.body);
    log("Electricity Providers Response: ${response.body}");

    if (body['status'] == 'SUCCESS') {
      final List<BillerModel> providers = (body['data'] as List)
          .map((item) => BillerModel.fromJson(item))
          .toList();

      emit(state.copyWith(isLoading: false, electricityList: providers));
    } else {
      emit(state.copyWith(isLoading: false, electricityList: []));
    }
  } catch (e) {
    log("Electricity Providers Error: ${e.toString()}");
    emit(state.copyWith(isLoading: false, electricityList: []));
  }
}
}
class BillerModel {
  final String id;
  final String name;

  BillerModel({required this.id, required this.name});

  factory BillerModel.fromJson(Map<String, dynamic> json) {
    return BillerModel(
      id: json['billerId'].toString(),
      name: json['billerName'].toString(),
    );
  }
}
