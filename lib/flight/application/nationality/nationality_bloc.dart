import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:minna/flight/domain/nation/nations.dart';
import 'package:minna/flight/infrastracture/get%20nationality/nationality.dart';

part 'nationality_event.dart';
part 'nationality_state.dart';
part 'nationality_bloc.freezed.dart';

class NationalityBloc extends Bloc<NationalityEvent, NationalityState> {
  NationalityBloc() : super(NationalityState.initial()) {
     on<GetList>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final List<Country> nationalityList = await getNationality();

      emit(state.copyWith(nationalitList: nationalityList));
    });
  }
}
