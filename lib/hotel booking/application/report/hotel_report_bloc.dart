import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:minna/hotel booking/domain/report/hotel_report_model.dart';

// Events
abstract class HotelReportEvent {}

class FetchHotelReports extends HotelReportEvent {}

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

// Bloc
class HotelReportBloc extends Bloc<HotelReportEvent, HotelReportState> {
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
  }
}
