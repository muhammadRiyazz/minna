part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
 const factory LoginState({
    required bool isLoading,
    bool? isLoggedIn,
    String? errorMessage,
    String? phoneNumber,
    int? userRegVerificationId,
    String? userId,
  }) = _LoginState;

  factory LoginState.initial() {
    return const LoginState(
      isLoading: false,
      isLoggedIn: false,
      errorMessage: null,
      phoneNumber: null,
      userRegVerificationId: null,
      userId: null,
    );
  }}
