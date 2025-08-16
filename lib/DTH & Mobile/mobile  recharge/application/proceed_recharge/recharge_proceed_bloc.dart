import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:minna/comman/core/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'recharge_proceed_event.dart';
part 'recharge_proceed_state.dart';
part 'recharge_proceed_bloc.freezed.dart';

class RechargeProceedBloc
    extends Bloc<RechargeProceedEvent, RechargeProceedState> {
  RechargeProceedBloc() : super(RechargeProceedState.initial()) {
    on<Proceed>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final url = Uri.parse('${baseUrl}mobile-recharge');
 SharedPreferences preferences = await SharedPreferences.getInstance();
     final userId = preferences.getString('userId') ?? '';

      final body = {
        "userId": userId,
        "mobNumber": event.phoneNo,
        "operator": event.operator,
        "amount": event.amount,
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
                rechargeStatus: json['data']['rechargeStatus'],
              ),
            );
          } else {
            emit(state.copyWith(isLoading: false, rechargeStatus: 'Error'));
          }
        } else {
          emit(state.copyWith(isLoading: false, rechargeStatus: 'Error'));
        }
      } catch (e) {
        log(e.toString());
        emit(state.copyWith(isLoading: false, rechargeStatus: 'Error'));
      }
    });
  }
}
