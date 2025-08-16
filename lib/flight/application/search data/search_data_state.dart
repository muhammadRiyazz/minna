part of 'search_data_bloc.dart';

@freezed
class SearchDataState with _$SearchDataState {
 const factory SearchDataState({
    required bool isLoading,
    required bool oneWay,
    required String seatClass,
    required DateTime departureDate,
    DateTime? returnDate,

    required Map<String, int> travellers,
    required List<Airport> airports,

    Airport? from,
    Airport? to,
  }) = _SearchDataState;

  factory SearchDataState.initial() => SearchDataState(
    airports: [],
    departureDate: DateTime.now(),

    isLoading: false,
    oneWay: true,
    seatClass: 'Economy',
    travellers: const {'adults': 1, 'children': 0, 'infants': 0},
    from: null,
    to: null,
  );}
