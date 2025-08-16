part of 'nationality_bloc.dart';

@freezed
class NationalityState with _$NationalityState {
  const factory NationalityState({
    required bool isLoading,
    required List<Country> nationalitList,
  }) = _FetchNaionListState;

  factory NationalityState.initial() =>
      NationalityState(isLoading: false, nationalitList: []);
}
