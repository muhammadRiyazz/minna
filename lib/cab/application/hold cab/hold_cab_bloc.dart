import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:minna/cab/domain/hold%20data/hold_data.dart';
import 'package:minna/comman/core/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
         SharedPreferences preferences = await SharedPreferences.getInstance();
  final userId = preferences.getString('userId') ?? '';

        /// Step 1: Call HOLD API
        final response = await http.post(
          Uri.parse('http://gozotech2.ddns.net:5192/api/cpapi/booking/hold'),
          headers: {
            'Authorization':
                'Basic ZjA2MjljNTIxZjE2MjU0NTA2YmIyMDQzNWI4MTJmMmE=',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(event.requestData),
        );

        log("Hold API Response: ${response.body}");

        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final holdResponse = BookingResponse.fromJson(jsonData);

        if (holdResponse.success) {
          /// Step 2: Save Hold Data to backend
          try {
            final saveResponse = await http.post(
              Uri.parse('${baseUrl}cab-hold'),
             
              body: {
                "request": jsonEncode(event.requestData,) , // ✅ request JSON
                "hold":jsonEncode(jsonData) , // ✅ raw hold API response JSON
                "user_id":userId, // ✅ user id from event
              },
            );

            log("Cab-Hold Save Response: ${saveResponse.body}");

            final saveJson = jsonDecode(saveResponse.body);

            if (saveJson["status"] == "success") {
              emit(HoldCabSuccess(data: holdResponse.data!));
            } else {
              emit(HoldCabError(
                  message: saveJson["message"] ??
                      "Failed to save booking. Please try again."));
            }
          } catch (e) {
            log("Cab-Hold Save Error: $e");
            emit(HoldCabError(
                message: "Booking succeeded, but saving failed: $e"));
          }
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
