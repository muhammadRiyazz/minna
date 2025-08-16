part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
 const factory LoginEvent.numbnerLogin({required String phoneNo}) = NumbnerLogin;
  const factory LoginEvent.otpVerification({required String otp}) = OtpVerification;
  const factory LoginEvent.loginInfo() = LoginInfo;
  const factory LoginEvent.logout() = Logout;
  
  }