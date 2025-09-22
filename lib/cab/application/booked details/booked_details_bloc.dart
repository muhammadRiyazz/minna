import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:minna/cab/domain/cab%20list%20model/cab_booked_details.dart';

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
      log(event.bookingId);
      final response = await http.post(
        Uri.parse('http://gozotech2.ddns.net:5192/api/cpapi/booking/getDetails'),
        headers: {
          'Content-Type': 'text/plain',
          'Authorization': 'Basic ZjA2MjljNTIxZjE2MjU0NTA2YmIyMDQzNWI4MTJmMmE=',
        },
        body: json.encode({'bookingId': "QT503908208"}),
      );
log(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final detailsResponse = BookingDetailsResponse.fromJson(jsonResponse);

        if (detailsResponse.success && detailsResponse.data != null) {
          emit(BookedDetailsState.success(detailsResponse.data!));
        } else {
          emit(BookedDetailsState.error(
            detailsResponse.errorMessage ?? 'Failed to fetch booking details',
          ));
        }
      } else {
        emit(BookedDetailsState.error(
          'Failed to load booking details: ${response.statusCode}',
        ));
      }
    } catch (e) {
      log(e.toString());
      emit(BookedDetailsState.error('Error: $e'));
    }
  }

  void _onReset(
    _Reset event,
    Emitter<BookedDetailsState> emit,
  ) {
    emit(const BookedDetailsState.initial());
  }
}
