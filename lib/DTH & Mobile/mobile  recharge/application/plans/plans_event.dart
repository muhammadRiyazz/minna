part of 'plans_bloc.dart';

abstract class PlansEvent {}

class FetchPlansEvent extends PlansEvent {
  final String operatorName;
  FetchPlansEvent({required this.operatorName});
}
