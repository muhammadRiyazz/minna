import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:minna/comman/core/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<NumbnerLogin>(_onNumberLogin);
    on<OtpVerification>(_onOtpVerification);
    on<LoginInfo>(_onLoginInfo);

    on<Logout>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('isLoggedIn');
      await prefs.remove('userId');
      emit(state.copyWith(isLoggedIn: false, userId: null));
    });
  }

  Future<void> _onNumberLogin(
    NumbnerLogin event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
      isLoading: true,
      errorMessage: null, // 🔁 Clear error
      isLoggedIn: false,  // 🔁 Reset success
    ));
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}user-registration-otp'),
        body: {'phoneNo': event.phoneNo},
      );
      log(response.body);
      final data = json.decode(response.body);
      if (data['status'] == 'SUCCESS') {
        emit(state.copyWith(
          isLoading: false,
          userRegVerificationId: data['data']['userRegVarificationId'],
          phoneNumber: event.phoneNo,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: data['statusDesc'],
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Network error occurred. Please try again.',
      ));
    }
  }

  Future<void> _onOtpVerification(
    OtpVerification event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
      isLoading: true,
      errorMessage: null, // 🔁 Clear error
      isLoggedIn: false,  // 🔁 Reset flag
    ));
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}user-registration-varification'),
        body: {
          'userRegVarificationId': state.userRegVerificationId.toString(),
          'otp': event.otp,
        },
      );
      log(response.body);

      final data = json.decode(response.body);
      if (data['status'] == 'SUCCESS') {
        final userId = data['data'][0]['userId'].toString();
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', userId);
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('phoneNo', state.phoneNumber ?? '');

        emit(state.copyWith(
          isLoading: false,
          isLoggedIn: true,
          userId: userId,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: data['statusDesc'],
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Network error occurred. Please try again.',
      ));
    }
  }

  Future<void> _onLoginInfo(LoginInfo event, Emitter<LoginState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final userId = prefs.getString('userId') ?? '';
    final phoneNo = prefs.getString('phoneNo') ?? '';

    emit(state.copyWith(
      isLoggedIn: isLoggedIn,
      userId: userId,
      phoneNumber: phoneNo,
    ));
  }
}
