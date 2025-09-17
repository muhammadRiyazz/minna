import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:minna/cab/domain/hold%20data/hold_data.dart';

part 'hold_cab_event.dart';
part 'hold_cab_state.dart';
part 'hold_cab_bloc.freezed.dart';

// Bloc
class HoldCabBloc extends Bloc<HoldCabEvent, HoldCabState> {
  HoldCabBloc() : super(HoldCabInitial()) {
    on<_HoldCab>((event, emit) async {
      emit(HoldCabLoading());
      log('Calling hold cab API...');

      try {
        final response = await http.post(
          Uri.parse('http://gozotech2.ddns.net:5192/api/cpapi/booking/hold'),
          headers: {
            'Authorization':
                'Basic ZjA2MjljNTIxZjE2MjU0NTA2YmIyMDQzNWI4MTJmMmE=',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(event.requestData),
        );

        log("Response: ${response.body}");

        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final holdResponse = BookingResponse.fromJson(jsonData);

        if (holdResponse.success) {
          emit(HoldCabSuccess(data: holdResponse.data!));
        } else {
          final errors = (jsonData['errors'] as List<dynamic>?)
                  ?.map((e) => e.toString())
                  .join(', ') ??
              'Unknown error';
          emit(HoldCabError(message: errors));
        }
      } catch (e) {
        log("Error: $e");
        emit(HoldCabError(message: e.toString()));
      }
    });
  }
}