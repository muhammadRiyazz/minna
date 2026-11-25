part of 'bbps_dynamic_bloc.dart';

abstract class BbpsDynamicState {}

class BbpsDynamicInitial extends BbpsDynamicState {}

class BbpsDynamicLoading extends BbpsDynamicState {}

class BbpsDynamicBillersLoaded extends BbpsDynamicState {
  final List<BbpsDynamicBiller> billers;

  BbpsDynamicBillersLoaded({required this.billers});
}

class BbpsDynamicBillerInfoLoaded extends BbpsDynamicState {
  final BbpsDynamicBillerInfo billerInfo;
  final String billerId;
  final String billerName;

  BbpsDynamicBillerInfoLoaded({
    required this.billerInfo,
    required this.billerId,
    required this.billerName,
  });
}

class BbpsDynamicBillFetched extends BbpsDynamicState {
  final BbpsDynamicBillResponse billResponse;

  BbpsDynamicBillFetched({required this.billResponse});
}

class BbpsDynamicError extends BbpsDynamicState {
  final String message;

  BbpsDynamicError({required this.message});
}
