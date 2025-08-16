import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:minna/flight/domain/airport/airport.dart';
import 'package:minna/flight/infrastracture/city%20sugg/city_list.dart';

part 'search_data_event.dart';
part 'search_data_state.dart';
part 'search_data_bloc.freezed.dart';

class SearchDataBloc extends Bloc<SearchDataEvent, SearchDataState> {
  SearchDataBloc() : super(SearchDataState.initial()) {
    on<OneWayOrRound>(_handleOneWayOrRound);
    on<ClassChange>(_handleClassChange);
    on<FromOrTo>(_handleFromOrTo);
    on<Passengers>(_handlePassengers);
    on<GetAirports>(_handleGetAirports);
    on<DepartureDateChange>(_handledepartureDateChange);
    on<ReturnDateChange>(_handlereturnDateChange);
    on<ClearSearchAirports>(_handleclearAirports);
  }

  void _handledepartureDateChange(
    DepartureDateChange event,
    Emitter<SearchDataState> emit,
  ) {
    emit(
      state.copyWith(
        departureDate: event.departureDate,
        // departureDate: event. == 'oneWay',
      ),
    );
  }

  void _handlereturnDateChange(
    ReturnDateChange event,
    Emitter<SearchDataState> emit,
  ) {
    emit(
      state.copyWith(
        returnDate: event.returnDate,
        // oneWay: event.oneWayOrRound == 'oneWay',
      ),
    );
  }

  void _handleOneWayOrRound(
    OneWayOrRound event,
    Emitter<SearchDataState> emit,
  ) {
    emit(state.copyWith(oneWay: event.oneWayOrRound == 'oneWay'));
  }

  void _handleClassChange(ClassChange event, Emitter<SearchDataState> emit) {
    emit(state.copyWith(seatClass: event.seatClass));
  }

  void _handleFromOrTo(FromOrTo event, Emitter<SearchDataState> emit) {
    if (event.fromOrTo == 'from') {
      emit(state.copyWith(from: event.airport));
    } else {
      emit(state.copyWith(to: event.airport));
    }
  }

  void _handleclearAirports(
    ClearSearchAirports event,
    Emitter<SearchDataState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
  }

  void _handlePassengers(Passengers event, Emitter<SearchDataState> emit) {
    emit(state.copyWith(travellers: event.travellers));
  }

  void _handleGetAirports(
    GetAirports event,
    Emitter<SearchDataState> emit,
  ) async {
    // Here you would typically:
    // 1. Set loading state
    // 2. Fetch airports from repository
    // 3. Update state with results
    emit(state.copyWith(isLoading: true));

    // Mock implementation - replace with actual API call
    try {
      final List<Airport> airports = await AirportService.searchAirports(
        event.searchKey,
      );

      // final airports = await airportRepository.search(event.searchKey);
      emit(state.copyWith(isLoading: false, airports: airports));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(isLoading: false));
      // Handle error
    }
  }
}

