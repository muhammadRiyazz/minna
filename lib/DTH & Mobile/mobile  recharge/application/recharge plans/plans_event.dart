part of 'plans_bloc.dart';

@freezed
class PlansEvent with _$PlansEvent {
  const factory PlansEvent.started() = _Started;
}