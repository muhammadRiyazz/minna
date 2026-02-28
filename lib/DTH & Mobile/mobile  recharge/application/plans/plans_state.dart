part of 'plans_bloc.dart';

abstract class PlansState {}

class PlansStateInitial extends PlansState {}

class PlansStateLoading extends PlansState {}

class PlansStateLoaded extends PlansState {
  final List<PlanTab> tabs;
  PlansStateLoaded({required this.tabs});
}

class PlansStateError extends PlansState {
  final String message;
  PlansStateError({required this.message});
}
