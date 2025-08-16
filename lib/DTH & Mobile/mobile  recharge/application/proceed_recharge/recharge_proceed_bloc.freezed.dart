// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recharge_proceed_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RechargeProceedEvent {
  String get phoneNo => throw _privateConstructorUsedError;
  String get operator => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String phoneNo, String operator, String amount)
    proceed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String phoneNo, String operator, String amount)? proceed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String phoneNo, String operator, String amount)? proceed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Proceed value) proceed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Proceed value)? proceed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Proceed value)? proceed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of RechargeProceedEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RechargeProceedEventCopyWith<RechargeProceedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RechargeProceedEventCopyWith<$Res> {
  factory $RechargeProceedEventCopyWith(
    RechargeProceedEvent value,
    $Res Function(RechargeProceedEvent) then,
  ) = _$RechargeProceedEventCopyWithImpl<$Res, RechargeProceedEvent>;
  @useResult
  $Res call({String phoneNo, String operator, String amount});
}

/// @nodoc
class _$RechargeProceedEventCopyWithImpl<
  $Res,
  $Val extends RechargeProceedEvent
>
    implements $RechargeProceedEventCopyWith<$Res> {
  _$RechargeProceedEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RechargeProceedEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNo = null,
    Object? operator = null,
    Object? amount = null,
  }) {
    return _then(
      _value.copyWith(
            phoneNo: null == phoneNo
                ? _value.phoneNo
                : phoneNo // ignore: cast_nullable_to_non_nullable
                      as String,
            operator: null == operator
                ? _value.operator
                : operator // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProceedImplCopyWith<$Res>
    implements $RechargeProceedEventCopyWith<$Res> {
  factory _$$ProceedImplCopyWith(
    _$ProceedImpl value,
    $Res Function(_$ProceedImpl) then,
  ) = __$$ProceedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String phoneNo, String operator, String amount});
}

/// @nodoc
class __$$ProceedImplCopyWithImpl<$Res>
    extends _$RechargeProceedEventCopyWithImpl<$Res, _$ProceedImpl>
    implements _$$ProceedImplCopyWith<$Res> {
  __$$ProceedImplCopyWithImpl(
    _$ProceedImpl _value,
    $Res Function(_$ProceedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RechargeProceedEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNo = null,
    Object? operator = null,
    Object? amount = null,
  }) {
    return _then(
      _$ProceedImpl(
        phoneNo: null == phoneNo
            ? _value.phoneNo
            : phoneNo // ignore: cast_nullable_to_non_nullable
                  as String,
        operator: null == operator
            ? _value.operator
            : operator // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ProceedImpl implements Proceed {
  const _$ProceedImpl({
    required this.phoneNo,
    required this.operator,
    required this.amount,
  });

  @override
  final String phoneNo;
  @override
  final String operator;
  @override
  final String amount;

  @override
  String toString() {
    return 'RechargeProceedEvent.proceed(phoneNo: $phoneNo, operator: $operator, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProceedImpl &&
            (identical(other.phoneNo, phoneNo) || other.phoneNo == phoneNo) &&
            (identical(other.operator, operator) ||
                other.operator == operator) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phoneNo, operator, amount);

  /// Create a copy of RechargeProceedEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProceedImplCopyWith<_$ProceedImpl> get copyWith =>
      __$$ProceedImplCopyWithImpl<_$ProceedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String phoneNo, String operator, String amount)
    proceed,
  }) {
    return proceed(phoneNo, operator, amount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String phoneNo, String operator, String amount)? proceed,
  }) {
    return proceed?.call(phoneNo, operator, amount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String phoneNo, String operator, String amount)? proceed,
    required TResult orElse(),
  }) {
    if (proceed != null) {
      return proceed(phoneNo, operator, amount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Proceed value) proceed,
  }) {
    return proceed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Proceed value)? proceed,
  }) {
    return proceed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Proceed value)? proceed,
    required TResult orElse(),
  }) {
    if (proceed != null) {
      return proceed(this);
    }
    return orElse();
  }
}

abstract class Proceed implements RechargeProceedEvent {
  const factory Proceed({
    required final String phoneNo,
    required final String operator,
    required final String amount,
  }) = _$ProceedImpl;

  @override
  String get phoneNo;
  @override
  String get operator;
  @override
  String get amount;

  /// Create a copy of RechargeProceedEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProceedImplCopyWith<_$ProceedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RechargeProceedState {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get rechargeStatus => throw _privateConstructorUsedError;

  /// Create a copy of RechargeProceedState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RechargeProceedStateCopyWith<RechargeProceedState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RechargeProceedStateCopyWith<$Res> {
  factory $RechargeProceedStateCopyWith(
    RechargeProceedState value,
    $Res Function(RechargeProceedState) then,
  ) = _$RechargeProceedStateCopyWithImpl<$Res, RechargeProceedState>;
  @useResult
  $Res call({bool isLoading, String? rechargeStatus});
}

/// @nodoc
class _$RechargeProceedStateCopyWithImpl<
  $Res,
  $Val extends RechargeProceedState
>
    implements $RechargeProceedStateCopyWith<$Res> {
  _$RechargeProceedStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RechargeProceedState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? isLoading = null, Object? rechargeStatus = freezed}) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            rechargeStatus: freezed == rechargeStatus
                ? _value.rechargeStatus
                : rechargeStatus // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RechargeProceedStateImplCopyWith<$Res>
    implements $RechargeProceedStateCopyWith<$Res> {
  factory _$$RechargeProceedStateImplCopyWith(
    _$RechargeProceedStateImpl value,
    $Res Function(_$RechargeProceedStateImpl) then,
  ) = __$$RechargeProceedStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, String? rechargeStatus});
}

/// @nodoc
class __$$RechargeProceedStateImplCopyWithImpl<$Res>
    extends _$RechargeProceedStateCopyWithImpl<$Res, _$RechargeProceedStateImpl>
    implements _$$RechargeProceedStateImplCopyWith<$Res> {
  __$$RechargeProceedStateImplCopyWithImpl(
    _$RechargeProceedStateImpl _value,
    $Res Function(_$RechargeProceedStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RechargeProceedState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? isLoading = null, Object? rechargeStatus = freezed}) {
    return _then(
      _$RechargeProceedStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        rechargeStatus: freezed == rechargeStatus
            ? _value.rechargeStatus
            : rechargeStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$RechargeProceedStateImpl implements _RechargeProceedState {
  const _$RechargeProceedStateImpl({
    required this.isLoading,
    this.rechargeStatus,
  });

  @override
  final bool isLoading;
  @override
  final String? rechargeStatus;

  @override
  String toString() {
    return 'RechargeProceedState(isLoading: $isLoading, rechargeStatus: $rechargeStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RechargeProceedStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.rechargeStatus, rechargeStatus) ||
                other.rechargeStatus == rechargeStatus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, rechargeStatus);

  /// Create a copy of RechargeProceedState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RechargeProceedStateImplCopyWith<_$RechargeProceedStateImpl>
  get copyWith =>
      __$$RechargeProceedStateImplCopyWithImpl<_$RechargeProceedStateImpl>(
        this,
        _$identity,
      );
}

abstract class _RechargeProceedState implements RechargeProceedState {
  const factory _RechargeProceedState({
    required final bool isLoading,
    final String? rechargeStatus,
  }) = _$RechargeProceedStateImpl;

  @override
  bool get isLoading;
  @override
  String? get rechargeStatus;

  /// Create a copy of RechargeProceedState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RechargeProceedStateImplCopyWith<_$RechargeProceedStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
