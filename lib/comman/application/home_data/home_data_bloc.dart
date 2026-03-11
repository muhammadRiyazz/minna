import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:minna/comman/application/home_data/destination_model.dart';
import 'package:minna/comman/application/home_data/home_data_event.dart';
import 'package:minna/comman/application/home_data/home_data_state.dart';
import 'package:minna/comman/application/home_data/visa_model.dart';
import 'package:minna/comman/core/api.dart';

class HomeDataBloc extends Bloc<HomeDataEvent, HomeDataState> {
  HomeDataBloc() : super(HomeDataState.initial()) {
    on<FetchDestinations>(_onFetchDestinations);
    on<FetchVisaCountries>(_onFetchVisaCountries);
  }

  Future<void> _onFetchDestinations(
    FetchDestinations event,
    Emitter<HomeDataState> emit,
  ) async {
    emit(state.copyWith(isDestinationsLoading: true));
    try {
      final response = await http.post(
        Uri.parse("${baseUrl}destinations-callback"),
      );
      final body = json.decode(response.body);

      if (body['status'] == 'SUCCESS' && body['data'] != null) {
        final List<DestinationModel> destinations = (body['data'] as List)
            .map((e) => DestinationModel.fromJson(e as Map<String, dynamic>))
            .toList();
        emit(
          state.copyWith(
            isDestinationsLoading: false,
            popularDestinations: destinations,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isDestinationsLoading: false,
            popularDestinations: [], // Emitting empty list on error
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(isDestinationsLoading: false, popularDestinations: []),
      );
    }
  }

  Future<void> _onFetchVisaCountries(
    FetchVisaCountries event,
    Emitter<HomeDataState> emit,
  ) async {
    emit(state.copyWith(isVisaLoading: true));
    try {
      final response = await http.post(Uri.parse("${baseUrl}visa-callback"));
      final body = json.decode(response.body);

      if (body['status'] == 'SUCCESS' && body['data'] != null) {
        final List<VisaModel> visas = (body['data'] as List)
            .map((e) => VisaModel.fromJson(e as Map<String, dynamic>))
            .toList();
        emit(state.copyWith(isVisaLoading: false, visaCountries: visas));
      } else {
        emit(state.copyWith(isVisaLoading: false, visaCountries: []));
      }
    } catch (e) {
      emit(state.copyWith(isVisaLoading: false, visaCountries: []));
    }
  }
}
