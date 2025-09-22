// lib/cab/application/booked_info/booked_info_event.dart
part of 'booked_info_bloc.dart';

@freezed
class BookedInfoEvent with _$BookedInfoEvent {
  const factory BookedInfoEvent.fetchList({
    String? fromDate,
    String? toDate,
  }) = _FetchList;

  const factory BookedInfoEvent.searchChanged(String query) = _SearchChanged;

  const factory BookedInfoEvent.dateFilterChanged(DateTime? date) = _DateFilterChanged;

  const factory BookedInfoEvent.statusFilterChanged(String? status) = _StatusFilterChanged;
}