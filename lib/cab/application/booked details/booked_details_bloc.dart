import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:minna/cab/domain/cab%20list%20model/cab_booked_details.dart';
import 'package:minna/cab/domain/cab%20report/cab_driver_model.dart';
import 'package:minna/comman/core/api.dart';

part 'booked_details_event.dart';
part 'booked_details_state.dart';
part 'booked_details_bloc.freezed.dart';

class BookedDetailsBloc extends Bloc<BookedDetailsEvent, BookedDetailsState> {
  BookedDetailsBloc() : super(BookedDetailsState.initial()) {
    on<_FetchDetails>(_onFetchDetails);
    on<_Reset>(_onReset);
  }

  Future<void> _onFetchDetails(
    _FetchDetails event,
    Emitter<BookedDetailsState> emit,
  ) async {
    emit(const BookedDetailsState.loading());

    try {
      // 🔹 Log request details
      log('➡️ PROXY API REQUEST');
      log('URL: ${baseUrl}Cabapi');

      final response = await http.post(
        Uri.parse('${baseUrl}Cabapi'),
        body: {
          "link": "${cabBaseUrl}api/cpapi/booking/getDetails",
          "data": jsonEncode({"bookingId": event.bookingId}),
        },
      );

      // 🔹 Log response details
      log('⬅️ PROXY API RESPONSE');
      log('Status Code: ${response.statusCode}');
      log('Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        var actualData = jsonResponse['message'] ?? jsonResponse;

        // 🔹 Handle cases where 'message' might be a JSON-encoded string
        if (actualData is String) {
          try {
            actualData = json.decode(actualData);
          } catch (e) {
            log('Wait, message is a string but not JSON: $actualData');
          }
        }

        final detailsResponse = BookingDetailsResponse.fromJson(actualData);

        if (detailsResponse.success && detailsResponse.data != null) {
          // 🚘 Fetch Driver Info Sequentially
          CabDriverResponse? driverInfo;
          try {
            log('➡️ DRIVER INFO API REQUEST');
            final driverResponse = await http.post(
              Uri.parse('${baseUrl}cab_driver'),
              body: {"bookingid": event.bookingId},
            );

            log('⬅️ DRIVER INFO API RESPONSE: ${driverResponse.statusCode}');
            if (driverResponse.statusCode == 200) {
              final driverJson = json.decode(driverResponse.body);
              driverInfo = CabDriverResponse.fromJson(driverJson);
            }
          } catch (e) {
            log('❌ Error fetching driver info: $e');
          }

          emit(
            BookedDetailsState.success(
              detailsResponse.data!,
              driverInfo: driverInfo,
            ),
          );
        } else {
          emit(
            BookedDetailsState.error(
              detailsResponse.errorMessage ??
                  'Current status: No booking details found.',
            ),
          );
        }
      } else {
        emit(
          BookedDetailsState.error(
            'Failed to load booking details: ${response.statusCode}',
          ),
        );
      }
    } catch (e, stackTrace) {
      // 🔹 Log error with stack trace for debugging
      log('❌ API CALL ERROR: $e', stackTrace: stackTrace);
      emit(BookedDetailsState.error('Error: $e'));
    }
  }

  void _onReset(_Reset event, Emitter<BookedDetailsState> emit) {
    emit(const BookedDetailsState.initial());
  }
}
