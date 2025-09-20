part of 'hold_cab_bloc.dart';





abstract class HoldCabState {}

class HoldCabInitial extends HoldCabState {}

class HoldCabLoading extends HoldCabState {}

class HoldCabSuccess extends HoldCabState {
  final BookingData data;   // API hold response
  final String tableID;
  final String bookingId;
  final Map<String, dynamic> requestData; // ✅ original booking data

  HoldCabSuccess({
    required this.data,
    required this.tableID,
    required this.bookingId,
    required this.requestData,
  });

  HoldCabSuccess copyWith({
    BookingData? data,
    String? tableID,
    String? bookingId,
    Map<String, dynamic>? requestData,
  }) {
    return HoldCabSuccess(
      data: data ?? this.data,
      bookingId: bookingId ?? this.bookingId,
      tableID: tableID ?? this.tableID,
      requestData: requestData ?? this.requestData,
    );
  }
}


class HoldCabError extends HoldCabState {
  final String message;

  HoldCabError({required this.message});
}