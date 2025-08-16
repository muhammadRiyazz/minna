// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$LoginEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String phoneNo) numbnerLogin,
    required TResult Function(String otp) otpVerification,
    required TResult Function() loginInfo,
    required TResult Function() logout,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String phoneNo)? numbnerLogin,
    TResult? Function(String otp)? otpVerification,
    TResult? Function()? loginInfo,
    TResult? Function()? logout,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String phoneNo)? numbnerLogin,
    TResult Function(String otp)? otpVerification,
    TResult Function()? loginInfo,
    TResult Function()? logout,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NumbnerLogin value) numbnerLogin,
    required TResult Function(OtpVerification value) otpVerification,
    required TResult Function(LoginInfo value) loginInfo,
    required TResult Function(Logout value) logout,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NumbnerLogin value)? numbnerLogin,
    TResult? Function(OtpVerification value)? otpVerification,
    TResult? Function(LoginInfo value)? loginInfo,
    TResult? Function(Logout value)? logout,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NumbnerLogin value)? numbnerLogin,
    TResult Function(OtpVerification value)? otpVerification,
    TResult Function(LoginInfo value)? loginInfo,
    TResult Function(Logout value)? logout,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginEventCopyWith<$Res> {
  factory $LoginEventCopyWith(
    LoginEvent value,
    $Res Function(LoginEvent) then,
  ) = _$LoginEventCopyWithImpl<$Res, LoginEvent>;
}

/// @nodoc
class _$LoginEventCopyWithImpl<$Res, $Val extends LoginEvent>
    implements $LoginEventCopyWith<$Res> {
  _$LoginEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$NumbnerLoginImplCopyWith<$Res> {
  factory _$$NumbnerLoginImplCopyWith(
    _$NumbnerLoginImpl value,
    $Res Function(_$NumbnerLoginImpl) then,
  ) = __$$NumbnerLoginImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String phoneNo});
}

/// @nodoc
class __$$NumbnerLoginImplCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$NumbnerLoginImpl>
    implements _$$NumbnerLoginImplCopyWith<$Res> {
  __$$NumbnerLoginImplCopyWithImpl(
    _$NumbnerLoginImpl _value,
    $Res Function(_$NumbnerLoginImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? phoneNo = null}) {
    return _then(
      _$NumbnerLoginImpl(
        phoneNo: null == phoneNo
            ? _value.phoneNo
            : phoneNo // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$NumbnerLoginImpl implements NumbnerLogin {
  const _$NumbnerLoginImpl({required this.phoneNo});

  @override
  final String phoneNo;

  @override
  String toString() {
    return 'LoginEvent.numbnerLogin(phoneNo: $phoneNo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NumbnerLoginImpl &&
            (identical(other.phoneNo, phoneNo) || other.phoneNo == phoneNo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phoneNo);

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NumbnerLoginImplCopyWith<_$NumbnerLoginImpl> get copyWith =>
      __$$NumbnerLoginImplCopyWithImpl<_$NumbnerLoginImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String phoneNo) numbnerLogin,
    required TResult Function(String otp) otpVerification,
    required TResult Function() loginInfo,
    required TResult Function() logout,
  }) {
    return numbnerLogin(phoneNo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String phoneNo)? numbnerLogin,
    TResult? Function(String otp)? otpVerification,
    TResult? Function()? loginInfo,
    TResult? Function()? logout,
  }) {
    return numbnerLogin?.call(phoneNo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String phoneNo)? numbnerLogin,
    TResult Function(String otp)? otpVerification,
    TResult Function()? loginInfo,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (numbnerLogin != null) {
      return numbnerLogin(phoneNo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NumbnerLogin value) numbnerLogin,
    required TResult Function(OtpVerification value) otpVerification,
    required TResult Function(LoginInfo value) loginInfo,
    required TResult Function(Logout value) logout,
  }) {
    return numbnerLogin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NumbnerLogin value)? numbnerLogin,
    TResult? Function(OtpVerification value)? otpVerification,
    TResult? Function(LoginInfo value)? loginInfo,
    TResult? Function(Logout value)? logout,
  }) {
    return numbnerLogin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NumbnerLogin value)? numbnerLogin,
    TResult Function(OtpVerification value)? otpVerification,
    TResult Function(LoginInfo value)? loginInfo,
    TResult Function(Logout value)? logout,
    required TResult orElse(),
  }) {
    if (numbnerLogin != null) {
      return numbnerLogin(this);
    }
    return orElse();
  }
}

abstract class NumbnerLogin implements LoginEvent {
  const factory NumbnerLogin({required final String phoneNo}) =
      _$NumbnerLoginImpl;

  String get phoneNo;

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NumbnerLoginImplCopyWith<_$NumbnerLoginImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OtpVerificationImplCopyWith<$Res> {
  factory _$$OtpVerificationImplCopyWith(
    _$OtpVerificationImpl value,
    $Res Function(_$OtpVerificationImpl) then,
  ) = __$$OtpVerificationImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String otp});
}

/// @nodoc
class __$$OtpVerificationImplCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$OtpVerificationImpl>
    implements _$$OtpVerificationImplCopyWith<$Res> {
  __$$OtpVerificationImplCopyWithImpl(
    _$OtpVerificationImpl _value,
    $Res Function(_$OtpVerificationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? otp = null}) {
    return _then(
      _$OtpVerificationImpl(
        otp: null == otp
            ? _value.otp
            : otp // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$OtpVerificationImpl implements OtpVerification {
  const _$OtpVerificationImpl({required this.otp});

  @override
  final String otp;

  @override
  String toString() {
    return 'LoginEvent.otpVerification(otp: $otp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpVerificationImpl &&
            (identical(other.otp, otp) || other.otp == otp));
  }

  @override
  int get hashCode => Object.hash(runtimeType, otp);

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpVerificationImplCopyWith<_$OtpVerificationImpl> get copyWith =>
      __$$OtpVerificationImplCopyWithImpl<_$OtpVerificationImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String phoneNo) numbnerLogin,
    required TResult Function(String otp) otpVerification,
    required TResult Function() loginInfo,
    required TResult Function() logout,
  }) {
    return otpVerification(otp);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String phoneNo)? numbnerLogin,
    TResult? Function(String otp)? otpVerification,
    TResult? Function()? loginInfo,
    TResult? Function()? logout,
  }) {
    return otpVerification?.call(otp);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String phoneNo)? numbnerLogin,
    TResult Function(String otp)? otpVerification,
    TResult Function()? loginInfo,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (otpVerification != null) {
      return otpVerification(otp);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NumbnerLogin value) numbnerLogin,
    required TResult Function(OtpVerification value) otpVerification,
    required TResult Function(LoginInfo value) loginInfo,
    required TResult Function(Logout value) logout,
  }) {
    return otpVerification(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NumbnerLogin value)? numbnerLogin,
    TResult? Function(OtpVerification value)? otpVerification,
    TResult? Function(LoginInfo value)? loginInfo,
    TResult? Function(Logout value)? logout,
  }) {
    return otpVerification?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NumbnerLogin value)? numbnerLogin,
    TResult Function(OtpVerification value)? otpVerification,
    TResult Function(LoginInfo value)? loginInfo,
    TResult Function(Logout value)? logout,
    required TResult orElse(),
  }) {
    if (otpVerification != null) {
      return otpVerification(this);
    }
    return orElse();
  }
}

abstract class OtpVerification implements LoginEvent {
  const factory OtpVerification({required final String otp}) =
      _$OtpVerificationImpl;

  String get otp;

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtpVerificationImplCopyWith<_$OtpVerificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginInfoImplCopyWith<$Res> {
  factory _$$LoginInfoImplCopyWith(
    _$LoginInfoImpl value,
    $Res Function(_$LoginInfoImpl) then,
  ) = __$$LoginInfoImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginInfoImplCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$LoginInfoImpl>
    implements _$$LoginInfoImplCopyWith<$Res> {
  __$$LoginInfoImplCopyWithImpl(
    _$LoginInfoImpl _value,
    $Res Function(_$LoginInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoginInfoImpl implements LoginInfo {
  const _$LoginInfoImpl();

  @override
  String toString() {
    return 'LoginEvent.loginInfo()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoginInfoImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String phoneNo) numbnerLogin,
    required TResult Function(String otp) otpVerification,
    required TResult Function() loginInfo,
    required TResult Function() logout,
  }) {
    return loginInfo();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String phoneNo)? numbnerLogin,
    TResult? Function(String otp)? otpVerification,
    TResult? Function()? loginInfo,
    TResult? Function()? logout,
  }) {
    return loginInfo?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String phoneNo)? numbnerLogin,
    TResult Function(String otp)? otpVerification,
    TResult Function()? loginInfo,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (loginInfo != null) {
      return loginInfo();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NumbnerLogin value) numbnerLogin,
    required TResult Function(OtpVerification value) otpVerification,
    required TResult Function(LoginInfo value) loginInfo,
    required TResult Function(Logout value) logout,
  }) {
    return loginInfo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NumbnerLogin value)? numbnerLogin,
    TResult? Function(OtpVerification value)? otpVerification,
    TResult? Function(LoginInfo value)? loginInfo,
    TResult? Function(Logout value)? logout,
  }) {
    return loginInfo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NumbnerLogin value)? numbnerLogin,
    TResult Function(OtpVerification value)? otpVerification,
    TResult Function(LoginInfo value)? loginInfo,
    TResult Function(Logout value)? logout,
    required TResult orElse(),
  }) {
    if (loginInfo != null) {
      return loginInfo(this);
    }
    return orElse();
  }
}

abstract class LoginInfo implements LoginEvent {
  const factory LoginInfo() = _$LoginInfoImpl;
}

/// @nodoc
abstract class _$$LogoutImplCopyWith<$Res> {
  factory _$$LogoutImplCopyWith(
    _$LogoutImpl value,
    $Res Function(_$LogoutImpl) then,
  ) = __$$LogoutImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LogoutImplCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$LogoutImpl>
    implements _$$LogoutImplCopyWith<$Res> {
  __$$LogoutImplCopyWithImpl(
    _$LogoutImpl _value,
    $Res Function(_$LogoutImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LogoutImpl implements Logout {
  const _$LogoutImpl();

  @override
  String toString() {
    return 'LoginEvent.logout()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LogoutImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String phoneNo) numbnerLogin,
    required TResult Function(String otp) otpVerification,
    required TResult Function() loginInfo,
    required TResult Function() logout,
  }) {
    return logout();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String phoneNo)? numbnerLogin,
    TResult? Function(String otp)? otpVerification,
    TResult? Function()? loginInfo,
    TResult? Function()? logout,
  }) {
    return logout?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String phoneNo)? numbnerLogin,
    TResult Function(String otp)? otpVerification,
    TResult Function()? loginInfo,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (logout != null) {
      return logout();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NumbnerLogin value) numbnerLogin,
    required TResult Function(OtpVerification value) otpVerification,
    required TResult Function(LoginInfo value) loginInfo,
    required TResult Function(Logout value) logout,
  }) {
    return logout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NumbnerLogin value)? numbnerLogin,
    TResult? Function(OtpVerification value)? otpVerification,
    TResult? Function(LoginInfo value)? loginInfo,
    TResult? Function(Logout value)? logout,
  }) {
    return logout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NumbnerLogin value)? numbnerLogin,
    TResult Function(OtpVerification value)? otpVerification,
    TResult Function(LoginInfo value)? loginInfo,
    TResult Function(Logout value)? logout,
    required TResult orElse(),
  }) {
    if (logout != null) {
      return logout(this);
    }
    return orElse();
  }
}

abstract class Logout implements LoginEvent {
  const factory Logout() = _$LogoutImpl;
}

/// @nodoc
mixin _$LoginState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool? get isLoggedIn => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  int? get userRegVerificationId => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginStateCopyWith<LoginState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
    LoginState value,
    $Res Function(LoginState) then,
  ) = _$LoginStateCopyWithImpl<$Res, LoginState>;
  @useResult
  $Res call({
    bool isLoading,
    bool? isLoggedIn,
    String? errorMessage,
    String? phoneNumber,
    int? userRegVerificationId,
    String? userId,
  });
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res, $Val extends LoginState>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoggedIn = freezed,
    Object? errorMessage = freezed,
    Object? phoneNumber = freezed,
    Object? userRegVerificationId = freezed,
    Object? userId = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoggedIn: freezed == isLoggedIn
                ? _value.isLoggedIn
                : isLoggedIn // ignore: cast_nullable_to_non_nullable
                      as bool?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            phoneNumber: freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            userRegVerificationId: freezed == userRegVerificationId
                ? _value.userRegVerificationId
                : userRegVerificationId // ignore: cast_nullable_to_non_nullable
                      as int?,
            userId: freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LoginStateImplCopyWith<$Res>
    implements $LoginStateCopyWith<$Res> {
  factory _$$LoginStateImplCopyWith(
    _$LoginStateImpl value,
    $Res Function(_$LoginStateImpl) then,
  ) = __$$LoginStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    bool? isLoggedIn,
    String? errorMessage,
    String? phoneNumber,
    int? userRegVerificationId,
    String? userId,
  });
}

/// @nodoc
class __$$LoginStateImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoginStateImpl>
    implements _$$LoginStateImplCopyWith<$Res> {
  __$$LoginStateImplCopyWithImpl(
    _$LoginStateImpl _value,
    $Res Function(_$LoginStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoggedIn = freezed,
    Object? errorMessage = freezed,
    Object? phoneNumber = freezed,
    Object? userRegVerificationId = freezed,
    Object? userId = freezed,
  }) {
    return _then(
      _$LoginStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoggedIn: freezed == isLoggedIn
            ? _value.isLoggedIn
            : isLoggedIn // ignore: cast_nullable_to_non_nullable
                  as bool?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        phoneNumber: freezed == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        userRegVerificationId: freezed == userRegVerificationId
            ? _value.userRegVerificationId
            : userRegVerificationId // ignore: cast_nullable_to_non_nullable
                  as int?,
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$LoginStateImpl implements _LoginState {
  const _$LoginStateImpl({
    required this.isLoading,
    this.isLoggedIn,
    this.errorMessage,
    this.phoneNumber,
    this.userRegVerificationId,
    this.userId,
  });

  @override
  final bool isLoading;
  @override
  final bool? isLoggedIn;
  @override
  final String? errorMessage;
  @override
  final String? phoneNumber;
  @override
  final int? userRegVerificationId;
  @override
  final String? userId;

  @override
  String toString() {
    return 'LoginState(isLoading: $isLoading, isLoggedIn: $isLoggedIn, errorMessage: $errorMessage, phoneNumber: $phoneNumber, userRegVerificationId: $userRegVerificationId, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoggedIn, isLoggedIn) ||
                other.isLoggedIn == isLoggedIn) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.userRegVerificationId, userRegVerificationId) ||
                other.userRegVerificationId == userRegVerificationId) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isLoggedIn,
    errorMessage,
    phoneNumber,
    userRegVerificationId,
    userId,
  );

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      __$$LoginStateImplCopyWithImpl<_$LoginStateImpl>(this, _$identity);
}

abstract class _LoginState implements LoginState {
  const factory _LoginState({
    required final bool isLoading,
    final bool? isLoggedIn,
    final String? errorMessage,
    final String? phoneNumber,
    final int? userRegVerificationId,
    final String? userId,
  }) = _$LoginStateImpl;

  @override
  bool get isLoading;
  @override
  bool? get isLoggedIn;
  @override
  String? get errorMessage;
  @override
  String? get phoneNumber;
  @override
  int? get userRegVerificationId;
  @override
  String? get userId;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
