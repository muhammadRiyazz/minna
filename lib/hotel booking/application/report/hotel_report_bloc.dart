import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:minna/hotel booking/domain/report/hotel_report_model.dart';
import '../../functions/hotel_api.dart';

// Events
abstract class HotelReportEvent {}

class FetchHotelReports extends HotelReportEvent {}

class CancelHotelBooking extends HotelReportEvent {
  final String bookingId;
  final String remarks;
  CancelHotelBooking({required this.bookingId, required this.remarks});
}

// States
abstract class HotelReportState {}

class HotelReportInitial extends HotelReportState {}

class HotelReportLoading extends HotelReportState {}

class HotelReportLoaded extends HotelReportState {
  final List<HotelBookingRecord> reports;
  HotelReportLoaded(this.reports);
}

class HotelReportError extends HotelReportState {
  final String message;
  HotelReportError(this.message);
}

class HotelCancelLoading extends HotelReportState {}

class HotelCancelSuccess extends HotelReportState {
  final String message;
  final dynamic data;
  HotelCancelSuccess(this.message, this.data);
}

class HotelCancelError extends HotelReportState {
  final String message;
  HotelCancelError(this.message);
}

// Bloc
class HotelReportBloc extends Bloc<HotelReportEvent, HotelReportState> {
  final HotelApiService _apiService = HotelApiService();

  HotelReportBloc() : super(HotelReportInitial()) {
    on<FetchHotelReports>((event, emit) async {
      emit(HotelReportLoading());
      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final String? userId = prefs.getString('userId');

        if (userId == null) {
          emit(HotelReportError("User not logged in"));
          return;
        }

        final response = await http.post(
          Uri.parse("https://tictechnologies.in/stage/minna/hotel-api-call-report"),
          body: {"userId": userId},
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['status'] == true) {
            final reportResponse = HotelReportResponse.fromJson(data);
            emit(HotelReportLoaded(reportResponse.data));
          } else {
            emit(HotelReportError(data['message'] ?? "Failed to fetch reports"));
          }
        } else {
          emit(HotelReportError("Server error: ${response.statusCode}"));
        }
      } catch (e) {
        emit(HotelReportError("Connection error: $e"));
      }
    });

    on<CancelHotelBooking>((event, emit) async {
      final currentState = state;
      List<HotelBookingRecord>? previousReports;
      if (currentState is HotelReportLoaded) {
        previousReports = currentState.reports;
      }

      emit(HotelCancelLoading());
      try {
        final response = await _apiService.cancelHotelBooking(
          bookingId: event.bookingId,
          remarks: event.remarks,
        );

        if (response['status'] == true) {
          emit(HotelCancelSuccess(
            response['message'] ?? "Cancel request sent successfully",
            response['data'],
          ));
          // Refresh reports after success
          add(FetchHotelReports());
        } else {
          emit(HotelCancelError(response['message'] ?? "Failed to cancel booking"));
          if (previousReports != null) {
            emit(HotelReportLoaded(previousReports));
          }
        }
      } catch (e) {
        emit(HotelCancelError("Error: $e"));
        if (previousReports != null) {
          emit(HotelReportLoaded(previousReports));
        }
      }
    });
  }

  @override
  Future<void> close() {
    _apiService.dispose();
    return super.close();
  }
}
