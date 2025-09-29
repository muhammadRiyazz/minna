// lib/cab/application/booked_info/booked_info_bloc.dart
import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:minna/cab/domain/cab%20report/cab_booked_list.dart';
import 'package:minna/comman/core/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'booked_info_event.dart';
part 'booked_info_state.dart';
part 'booked_info_bloc.freezed.dart';

class BookedInfoBloc extends Bloc<BookedInfoEvent, BookedInfoState> {
  BookedInfoBloc() : super(const BookedInfoState.initial()) {
    on<_FetchList>(_onFetchList);
    on<_SearchChanged>(_onSearchChanged);
    on<_DateFilterChanged>(_onDateFilterChanged);
    on<_StatusFilterChanged>(_onStatusFilterChanged);
  }
Future<void> _onFetchList(
  _FetchList event,
  Emitter<BookedInfoState> emit,
) async {
  emit(const BookedInfoState.loading());

  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString('userId') ?? '';

    /// Step 1: Call HO
    final response = await http.post(
      Uri.parse('${baseUrl}cab-report'),
      body: {
        'user_id': userId,
        if (event.fromDate != null) 'from': event.fromDate!,
        if (event.toDate != null) 'to': event.toDate!,
      },
    );
log(response.body.toString());
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final cabResponse = CabBookingResponse.fromJson(jsonResponse);

      if (cabResponse.status == 'success') {
        // ✅ Update bookingId based on status & tripType
        final updatedBookings = cabResponse.bookings.map((booking) {
          if (booking.status.toLowerCase() == "confirmed") {
            String prefix = "QT"; // default fallback
            switch (booking.tripType.toUpperCase()) {
              case "ONE WAY":
                prefix = "OW";
                break;
              case "ROUND TRIP":
                prefix = "RT";
                break;
              case "AIRPORT TRANSFER":
                prefix = "AP";
                break;
              case "MULTI CITY":
                prefix = "MW";
                break;
            }

            // bookingId already has QTxxxxx → replace first 2 chars
            String newBookingId = booking.bookingId;
            if (newBookingId.length > 2) {
              newBookingId = prefix + newBookingId.substring(2);
            }

            return CabBooking(
              id: booking.id,
              tripType: booking.tripType,
              cabType: booking.cabType,
              total: booking.total,
              firstName: booking.firstName,
              lastName: booking.lastName,
              priContactCode: booking.priContactCode,
              priContact: booking.priContact,
              email: booking.email,
              referenceId: booking.referenceId,
              date: booking.date,
              time: booking.time,
              bookingId: newBookingId,
              paymentId: booking.paymentId,
              orderId: booking.orderId,
              status: booking.status,
              paidStatus: booking.paidStatus,
            );
          } else {
            return booking;
          }
        }).toList();

        emit(BookedInfoState.success(
          allBookings: updatedBookings.reversed.toList(),
          filteredBookings: updatedBookings.reversed.toList(),
          searchQuery: '',
          selectedDate: null,
          statusFilter: null,
        ));
      } else {
        emit(BookedInfoState.error(cabResponse.errorMessage ?? 'Unknown error'));
      }
    } else {
      emit(BookedInfoState.error('Failed to load data: ${response.statusCode}'));
    }
  } catch (e) {
    emit(BookedInfoState.error('Error: $e'));
  }
}


  void _onSearchChanged(
    _SearchChanged event,
    Emitter<BookedInfoState> emit,
  ) {
    state.maybeWhen(
      success: (allBookings, filteredBookings, searchQuery, selectedDate, statusFilter) {
        final filtered = _applyFilters(allBookings, event.query, selectedDate, statusFilter);
        emit(BookedInfoState.success(
          allBookings: allBookings,
          filteredBookings: filtered,
          searchQuery: event.query,
          selectedDate: selectedDate,
          statusFilter: statusFilter,
        ));
      },
      orElse: () {},
    );
  }

  void _onDateFilterChanged(
    _DateFilterChanged event,
    Emitter<BookedInfoState> emit,
  ) {
    state.maybeWhen(
      success: (allBookings, filteredBookings, searchQuery, selectedDate, statusFilter) {
        final filtered = _applyFilters(allBookings, searchQuery, event.date, statusFilter);
        emit(BookedInfoState.success(
          allBookings: allBookings,
          filteredBookings: filtered,
          searchQuery: searchQuery,
          selectedDate: event.date,
          statusFilter: statusFilter,
        ));
      },
      orElse: () {},
    );
  }

  void _onStatusFilterChanged(
    _StatusFilterChanged event,
    Emitter<BookedInfoState> emit,
  ) {
    state.maybeWhen(
      success: (allBookings, filteredBookings, searchQuery, selectedDate, statusFilter) {
        final filtered = _applyFilters(allBookings, searchQuery, selectedDate, event.status);
        emit(BookedInfoState.success(
          allBookings: allBookings,
          filteredBookings: filtered,
          searchQuery: searchQuery,
          selectedDate: selectedDate,
          statusFilter: event.status,
        ));
      },
      orElse: () {},
    );
  }

  List<CabBooking> _applyFilters(
    List<CabBooking> bookings,
    String searchQuery,
    DateTime? selectedDate,
    String? statusFilter,
  ) {
    return bookings.where((booking) {
      final matchesSearch = searchQuery.isEmpty ||
          booking.firstName.toLowerCase().contains(searchQuery.toLowerCase()) ||
          booking.bookingId.toLowerCase().contains(searchQuery.toLowerCase());

      final matchesDate = selectedDate == null ||
          booking.date == DateFormat("yyyy-MM-dd").format(selectedDate);

      final matchesStatus = statusFilter == null ||
          statusFilter == "All" ||
          booking.status.toLowerCase() == statusFilter.toLowerCase();

      return matchesSearch && matchesDate && matchesStatus;
    }).toList();
  }

  // Helper function to format time to 12-hour format
  String formatTimeTo12Hour(String time24) {
    try {
      final timeParts = time24.split(':');
      if (timeParts.length >= 2) {
        int hour = int.parse(timeParts[0]);
        int minute = int.parse(timeParts[1]);
        
        String period = hour >= 12 ? 'PM' : 'AM';
        hour = hour % 12;
        hour = hour == 0 ? 12 : hour;
        
        return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
      }
      return time24;
    } catch (e) {
      return time24;
    }
  }
}