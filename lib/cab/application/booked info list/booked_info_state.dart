// lib/cab/application/booked_info/booked_info_state.dart
part of 'booked_info_bloc.dart';

@freezed
class BookedInfoState with _$BookedInfoState {
  const factory BookedInfoState.initial() = _Initial;

  const factory BookedInfoState.loading() = _Loading;

  const factory BookedInfoState.success({
    required List<CabBooking> allBookings,
    required List<CabBooking> filteredBookings,
    required String searchQuery,
    required DateTime? selectedDate,
    required String? statusFilter,
  }) = _Success;

  const factory BookedInfoState.error(String message) = _Error;
}