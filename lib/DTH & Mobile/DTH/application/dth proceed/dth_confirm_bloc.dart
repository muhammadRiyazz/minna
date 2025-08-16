import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:minna/comman/core/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'dth_confirm_event.dart';
part 'dth_confirm_state.dart';
part 'dth_confirm_bloc.freezed.dart';

class DthConfirmBloc extends Bloc<DthConfirmEvent, DthConfirmState> {
  DthConfirmBloc() : super(DthConfirmState.initial()) {
    on<Proceed>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final url = Uri.parse('${baseUrl}dth-recharge');

 SharedPreferences preferences = await SharedPreferences.getInstance();
     final userId = preferences.getString('userId') ?? '';




      final body = {



        "userId": userId,
        "mobNumber": event.phoneNo,
        "operator": event.operator,
        "amount": event.amount,
        "subcriberNo": event.subcriberNo,
      };

      try {
        final response = await http.post(url, body: body);

        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);
          log(response.body);
          if (json['status'] == 'SUCCESS') {
            emit(
              state.copyWith(
                isLoading: false,
                dthrechargeStatus: json['data']['rechargeStatus'],
              ),
            );
          } else {
            emit(state.copyWith(isLoading: false, dthrechargeStatus: 'Error'));
          }
        } else {
          emit(state.copyWith(isLoading: false, dthrechargeStatus: 'Error'));
        }
      } catch (e) {
        log(e.toString());
        emit(state.copyWith(isLoading: false, dthrechargeStatus: 'Error'));
      }
    });
  }
}
