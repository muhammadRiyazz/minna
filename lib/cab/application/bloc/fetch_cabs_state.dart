import 'package:minna/cab/domain/cab%20list%20model/cab_list_data.dart';

abstract class FetchCabsState {}

class FetchCabsInitial extends FetchCabsState {}

class FetchCabsLoading extends FetchCabsState {}

class FetchCabsSuccess extends FetchCabsState {
  final CabResponse data;

  FetchCabsSuccess({required this.data});
}

class FetchCabsError extends FetchCabsState {
  final String message;

  FetchCabsError({required this.message});
}