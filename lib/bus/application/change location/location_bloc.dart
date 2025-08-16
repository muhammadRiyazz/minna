import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:minna/bus/domain/location/location_modal.dart';

part 'location_event.dart';
part 'location_state.dart';
part 'location_bloc.freezed.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationState.initial() ) {
  on<AddLocation>((event, emit) {
      emit(state.copyWith(from: event.from, to: event.to));
    });

    on<UpdateDate>((event, emit) {
      emit(state.copyWith(dateOfJourney: event.date));
    });

    on<SwapLocations>((event, emit) {
      emit(state.copyWith(from: state.to, to: state.from));
    });
  }
}
