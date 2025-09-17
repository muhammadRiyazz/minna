import 'package:minna/cab/domain/cab%20list%20model/cab_list_data.dart';

abstract class FetchCabsState {}

class FetchCabsInitial extends FetchCabsState {}

class FetchCabsLoading extends FetchCabsState {}

class FetchCabsSuccess extends FetchCabsState {
  final CabResponse data;
  final Map<String, dynamic>? requestData;
  final CabRate? selectedCab;

  FetchCabsSuccess({
    required this.data,
    this.requestData,
    this.selectedCab,
  });

  FetchCabsSuccess copyWith({
    CabResponse? data,
    Map<String, dynamic>? requestData,
    CabRate? selectedCab,
  }) {
    return FetchCabsSuccess(
      data: data ?? this.data,
      requestData: requestData ?? this.requestData,
      selectedCab: selectedCab ?? this.selectedCab,
    );
  }
}

class FetchCabsError extends FetchCabsState {
  final String message;

  FetchCabsError({required this.message});
}