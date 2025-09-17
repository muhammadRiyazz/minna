part of 'hold_cab_bloc.dart';





abstract class HoldCabState {}

class HoldCabInitial extends HoldCabState {}

class HoldCabLoading extends HoldCabState {}

class HoldCabSuccess extends HoldCabState {
  final BookingData data;

  HoldCabSuccess({
    required this.data,
  
  });

  HoldCabSuccess copyWith({
    BookingData? data,
  
  }) {
    return HoldCabSuccess(
      data: data ?? this.data,
     
    );
  }
}

class HoldCabError extends HoldCabState {
  final String message;

  HoldCabError({required this.message});
}