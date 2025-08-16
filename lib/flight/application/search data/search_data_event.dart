part of 'search_data_bloc.dart';

@freezed
class SearchDataEvent with _$SearchDataEvent {
  const factory SearchDataEvent.oneWayOrRound({required String oneWayOrRound}) =
      OneWayOrRound;

  const factory SearchDataEvent.classChange({required String seatClass}) =
      ClassChange; // Fixed typo in class name (was CalssChange)

  const factory SearchDataEvent.fromOrTo({
    required String fromOrTo,
    required Airport airport,
  }) = FromOrTo; // Fixed to use PascalCase

  const factory SearchDataEvent.passengers({
    // Fixed spelling (was Passangers)
    required Map<String, int> travellers,
  }) = Passengers;

  const factory SearchDataEvent.getAirports({required String searchKey}) =
      GetAirports;
  const factory SearchDataEvent.departureDateChange({
    required DateTime departureDate,
  }) = DepartureDateChange;
  const factory SearchDataEvent.returnDateChange({
    required DateTime returnDate,
  }) = ReturnDateChange;
   const factory SearchDataEvent.clearSearchAirports(
  ) = ClearSearchAirports;}