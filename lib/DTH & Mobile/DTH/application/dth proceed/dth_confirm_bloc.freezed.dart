// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dth_confirm_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DthConfirmEvent {
  String get phoneNo => throw _privateConstructorUsedError;
  String get operator => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  String get subcriberNo => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
    )
    proceed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
    )?
    proceed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
    )?
    proceed,
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

  /// Create a copy of DthConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DthConfirmEventCopyWith<DthConfirmEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DthConfirmEventCopyWith<$Res> {
  factory $DthConfirmEventCopyWith(
    DthConfirmEvent value,
    $Res Function(DthConfirmEvent) then,
  ) = _$DthConfirmEventCopyWithImpl<$Res, DthConfirmEvent>;
  @useResult
  $Res call({
    String phoneNo,
    String operator,
    String amount,
    String subcriberNo,
  });
}

/// @nodoc
class _$DthConfirmEventCopyWithImpl<$Res, $Val extends DthConfirmEvent>
    implements $DthConfirmEventCopyWith<$Res> {
  _$DthConfirmEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DthConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNo = null,
    Object? operator = null,
    Object? amount = null,
    Object? subcriberNo = null,
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
            subcriberNo: null == subcriberNo
                ? _value.subcriberNo
                : subcriberNo // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProceedImplCopyWith<$Res>
    implements $DthConfirmEventCopyWith<$Res> {
  factory _$$ProceedImplCopyWith(
    _$ProceedImpl value,
    $Res Function(_$ProceedImpl) then,
  ) = __$$ProceedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String phoneNo,
    String operator,
    String amount,
    String subcriberNo,
  });
}

/// @nodoc
class __$$ProceedImplCopyWithImpl<$Res>
    extends _$DthConfirmEventCopyWithImpl<$Res, _$ProceedImpl>
    implements _$$ProceedImplCopyWith<$Res> {
  __$$ProceedImplCopyWithImpl(
    _$ProceedImpl _value,
    $Res Function(_$ProceedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DthConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNo = null,
    Object? operator = null,
    Object? amount = null,
    Object? subcriberNo = null,
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
        subcriberNo: null == subcriberNo
            ? _value.subcriberNo
            : subcriberNo // ignore: cast_nullable_to_non_nullable
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
    required this.subcriberNo,
  });

  @override
  final String phoneNo;
  @override
  final String operator;
  @override
  final String amount;
  @override
  final String subcriberNo;

  @override
  String toString() {
    return 'DthConfirmEvent.proceed(phoneNo: $phoneNo, operator: $operator, amount: $amount, subcriberNo: $subcriberNo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProceedImpl &&
            (identical(other.phoneNo, phoneNo) || other.phoneNo == phoneNo) &&
            (identical(other.operator, operator) ||
                other.operator == operator) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.subcriberNo, subcriberNo) ||
                other.subcriberNo == subcriberNo));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, phoneNo, operator, amount, subcriberNo);

  /// Create a copy of DthConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProceedImplCopyWith<_$ProceedImpl> get copyWith =>
      __$$ProceedImplCopyWithImpl<_$ProceedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
    )
    proceed,
  }) {
    return proceed(phoneNo, operator, amount, subcriberNo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
    )?
    proceed,
  }) {
    return proceed?.call(phoneNo, operator, amount, subcriberNo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String phoneNo,
      String operator,
      String amount,
      String subcriberNo,
    )?
    proceed,
    required TResult orElse(),
  }) {
    if (proceed != null) {
      return proceed(phoneNo, operator, amount, subcriberNo);
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

abstract class Proceed implements DthConfirmEvent {
  const factory Proceed({
    required final String phoneNo,
    required final String operator,
    required final String amount,
    required final String subcriberNo,
  }) = _$ProceedImpl;

  @override
  String get phoneNo;
  @override
  String get operator;
  @override
  String get amount;
  @override
  String get subcriberNo;

  /// Create a copy of DthConfirmEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProceedImplCopyWith<_$ProceedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DthConfirmState {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get dthrechargeStatus => throw _privateConstructorUsedError;

  /// Create a copy of DthConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DthConfirmStateCopyWith<DthConfirmState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DthConfirmStateCopyWith<$Res> {
  factory $DthConfirmStateCopyWith(
    DthConfirmState value,
    $Res Function(DthConfirmState) then,
  ) = _$DthConfirmStateCopyWithImpl<$Res, DthConfirmState>;
  @useResult
  $Res call({bool isLoading, String? dthrechargeStatus});
}

/// @nodoc
class _$DthConfirmStateCopyWithImpl<$Res, $Val extends DthConfirmState>
    implements $DthConfirmStateCopyWith<$Res> {
  _$DthConfirmStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DthConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? isLoading = null, Object? dthrechargeStatus = freezed}) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            dthrechargeStatus: freezed == dthrechargeStatus
                ? _value.dthrechargeStatus
                : dthrechargeStatus // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DthConfirmStateImplCopyWith<$Res>
    implements $DthConfirmStateCopyWith<$Res> {
  factory _$$DthConfirmStateImplCopyWith(
    _$DthConfirmStateImpl value,
    $Res Function(_$DthConfirmStateImpl) then,
  ) = __$$DthConfirmStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, String? dthrechargeStatus});
}

/// @nodoc
class __$$DthConfirmStateImplCopyWithImpl<$Res>
    extends _$DthConfirmStateCopyWithImpl<$Res, _$DthConfirmStateImpl>
    implements _$$DthConfirmStateImplCopyWith<$Res> {
  __$$DthConfirmStateImplCopyWithImpl(
    _$DthConfirmStateImpl _value,
    $Res Function(_$DthConfirmStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DthConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? isLoading = null, Object? dthrechargeStatus = freezed}) {
    return _then(
      _$DthConfirmStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        dthrechargeStatus: freezed == dthrechargeStatus
            ? _value.dthrechargeStatus
            : dthrechargeStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$DthConfirmStateImpl implements _DthConfirmState {
  const _$DthConfirmStateImpl({
    required this.isLoading,
    this.dthrechargeStatus,
  });

  @override
  final bool isLoading;
  @override
  final String? dthrechargeStatus;

  @override
  String toString() {
    return 'DthConfirmState(isLoading: $isLoading, dthrechargeStatus: $dthrechargeStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DthConfirmStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.dthrechargeStatus, dthrechargeStatus) ||
                other.dthrechargeStatus == dthrechargeStatus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, dthrechargeStatus);

  /// Create a copy of DthConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DthConfirmStateImplCopyWith<_$DthConfirmStateImpl> get copyWith =>
      __$$DthConfirmStateImplCopyWithImpl<_$DthConfirmStateImpl>(
        this,
        _$identity,
      );
}

abstract class _DthConfirmState implements DthConfirmState {
  const factory _DthConfirmState({
    required final bool isLoading,
    final String? dthrechargeStatus,
  }) = _$DthConfirmStateImpl;

  @override
  bool get isLoading;
  @override
  String? get dthrechargeStatus;

  /// Create a copy of DthConfirmState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DthConfirmStateImplCopyWith<_$DthConfirmStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
