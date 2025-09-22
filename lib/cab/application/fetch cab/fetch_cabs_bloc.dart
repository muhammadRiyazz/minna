import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:minna/cab/application/fetch%20cab/fetch_cabs_state.dart';
import 'package:minna/cab/domain/cab%20list%20model/cab_list_data.dart';
      part 'fetch_cabs_bloc.freezed.dart';                                                                     
part 'fetch_cabs_event.dart';

class FetchCabsBloc extends Bloc<FetchCabsEvent, FetchCabsState> {
  FetchCabsBloc() : super(FetchCabsInitial()) {
    // Fetch Cabs Event
    on<_FetchCabs>((event, emit) async {
      emit(FetchCabsLoading());
      log('call fetch cab');

      try {
        final response = await http.post(
          Uri.parse('http://gozotech2.ddns.net:5192/api/cpapi/booking/getQuote'),
          headers: {
            'Authorization': 'Basic ZjA2MjljNTIxZjE2MjU0NTA2YmIyMDQzNWI4MTJmMmE=',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(event.requestData),
        );

        log(response.body);

        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        if (jsonData['success'] == true) {
          final cabResponse = CabResponse.fromJson(jsonData);
          emit(FetchCabsSuccess(
            data: cabResponse,
            requestData: event.requestData, // store requestData
          ));
        } else {
          final errors = (jsonData['errors'] as List<dynamic>?)
                  ?.map((e) => e.toString())
                  .join(', ') ??
              'Unknown error';
          emit(FetchCabsError(message: errors));
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
        emit(
          currentState.copyWith(selectedCab: event.selectedCabData),
        );
      }else{
                      log(' not.  ---FetchCabsSuccess --');

      }

    });
  }
}


  // final response = await http.post(
  //           Uri.parse('http://gozotech2.ddns.net:5192/api/cpapi/booking/getQuote'),
  //           headers: {
  //             'Authorization': 'Basic ZjA2MjljNTIxZjE2MjU0NTA2YmIyMDQzNWI4MTJmMmE=',
  //             'Content-Type': 'application/json',
  //           },
  //           body: jsonEncode(event.requestData),
  //         );



// import 'dart:convert';
// import 'dart:developer';
// import 'package:bloc/bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:http/http.dart' as http;
// import 'package:minna/cab/application/bloc/fetch_cabs_state.dart';
// import 'package:minna/cab/domain/cab%20list%20model/cab_list_data.dart';
// import 'package:minna/comman/core/api.dart';
//       part 'fetch_cabs_bloc.freezed.dart';                                                                     
// part 'fetch_cabs_event.dart';

// class FetchCabsBloc extends Bloc<FetchCabsEvent, FetchCabsState> {
//   FetchCabsBloc() : super(FetchCabsInitial()) {
//     on<_FetchCabs>((event, emit) async {
//       emit(FetchCabsLoading());
// log('call fetch cab');
//       try {
//         final mainUri = Uri.parse("${baseUrl}cabapi");

//        final response = await http.post(
//   mainUri,
//   body: jsonEncode({
//     "Url":
//         "http://gozotech2.ddns.net:5192/api/cpapi/booking/getQuote",
//     "data": event.requestData
//       }));

// log(response.body);
//         if (response.statusCode == 200) {
//           final Map<String, dynamic> jsonData = jsonDecode(response.body);
//           final cabResponse = CabResponse.fromJson(jsonData);
//           emit(FetchCabsSuccess(data: cabResponse));
//         } else {
//           emit(FetchCabsError(
//               message: 'Server error: ${response.statusCode}'));
//         }
//       } catch (e) {
//         log(e.toString());
//         emit(FetchCabsError(message: e.toString()));
//       }
//     });
//   }
// }