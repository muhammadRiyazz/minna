part of 'bbps_dynamic_bloc.dart';

abstract class BbpsDynamicEvent {}

class GetBillersEvent extends BbpsDynamicEvent {
  final String category;
  GetBillersEvent({required this.category});
}

class GetBillerInfoEvent extends BbpsDynamicEvent {
  final String category;
  final String billerId;
  final String billerName;

  GetBillerInfoEvent({
    required this.category,
    required this.billerId,
    required this.billerName,
  });
}

class FetchBillEvent extends BbpsDynamicEvent {
  final String category;
  final String billerId;
  final String number;
  final Map<String, String> dynamicParams;

  FetchBillEvent({
    required this.category,
    required this.billerId,
    required this.number,
    required this.dynamicParams,
  });
}
