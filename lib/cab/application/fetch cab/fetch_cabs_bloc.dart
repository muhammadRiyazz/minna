import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:minna/cab/application/fetch%20cab/fetch_cabs_state.dart';
import 'package:minna/cab/domain/cab%20list%20model/cab_list_data.dart';
import 'package:minna/comman/core/api.dart';
part 'fetch_cabs_bloc.freezed.dart';
part 'fetch_cabs_event.dart';

class FetchCabsBloc extends Bloc<FetchCabsEvent, FetchCabsState> {
  FetchCabsBloc() : super(FetchCabsInitial()) {
    // Fetch Cabs Event
    on<_FetchCabs>((event, emit) async {
      emit(FetchCabsLoading());
      log('call fetch cab');

      try {
        final mainUri = Uri.parse("${baseUrl}Cabapi");

        final response = await http.post(
          mainUri,
          body: {
            "link": "http://gozotech2.ddns.net:5192/api/cpapi/booking/getQuote",
            "data": jsonEncode(event.requestData),
          },
        );

        log(event.requestData.toString());
        log(response.body);

        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final Map<String, dynamic> actualData = jsonData['message'] ?? jsonData;

        if (actualData['success'] == true) {
          final cabResponse = CabResponse.fromJson(actualData);
          if (cabResponse.data.cabRate.isEmpty) {
            emit(FetchCabsError(message: 'No cabs available for this route.'));
          } else {
            emit(
              FetchCabsSuccess(
                data: cabResponse,
                requestData: event.requestData,
              ),
            );
          }
        } else {
          // Extract errors from actualData (Gozotech response)
          final errorMsg = (actualData['errors'] as List<dynamic>?)
                  ?.map((e) => e.toString())
                  .join(', ') ??
              actualData['message']?.toString() ??
              jsonData['message']?.toString() ??
              'Search Interrupted. Please try again.';

          emit(FetchCabsError(message: errorMsg));
        }
      } catch (e) {
        log(e.toString());
        emit(FetchCabsError(message: e.toString()));
      }
    });

    // Cab Selected Event
    on<_CabSelected>((event, emit) {
      if (state is FetchCabsSuccess) {
        log('FetchCabsSuccess --');
        final currentState = state as FetchCabsSuccess;
        emit(currentState.copyWith(selectedCab: event.selectedCabData));
      } else {
        log(' not.  ---FetchCabsSuccess --');
      }
    });
  }
}
