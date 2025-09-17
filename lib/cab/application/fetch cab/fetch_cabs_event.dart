part of 'fetch_cabs_bloc.dart';

@freezed
class FetchCabsEvent with _$FetchCabsEvent {
  const factory FetchCabsEvent.fetchCabs({
  required Map<String, dynamic> requestData,
}) = _FetchCabs;

const factory FetchCabsEvent.cabSelected({
  required CabRate selectedCabData,
}) = _CabSelected;
}
