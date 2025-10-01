// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fetch_bill_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FetchBillEvent {
  String get providerID => throw _privateConstructorUsedError;
  String get phoneNo => throw _privateConstructorUsedError;
  String get consumerId => throw _privateConstructorUsedError;
  String get providerName => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )
    fetchElectricityBill,
    required TResult Function(
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )
    fetchWaterBill,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )?
    fetchElectricityBill,
    TResult? Function(
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )?
    fetchWaterBill,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )?
    fetchElectricityBill,
    TResult Function(
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )?
    fetchWaterBill,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchElectricityBill value) fetchElectricityBill,
    required TResult Function(FetchWaterBill value) fetchWaterBill,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchElectricityBill value)? fetchElectricityBill,
    TResult? Function(FetchWaterBill value)? fetchWaterBill,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchElectricityBill value)? fetchElectricityBill,
    TResult Function(FetchWaterBill value)? fetchWaterBill,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of FetchBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FetchBillEventCopyWith<FetchBillEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FetchBillEventCopyWith<$Res> {
  factory $FetchBillEventCopyWith(
    FetchBillEvent value,
    $Res Function(FetchBillEvent) then,
  ) = _$FetchBillEventCopyWithImpl<$Res, FetchBillEvent>;
  @useResult
  $Res call({
    String providerID,
    String phoneNo,
    String consumerId,
    String providerName,
  });
}

/// @nodoc
class _$FetchBillEventCopyWithImpl<$Res, $Val extends FetchBillEvent>
    implements $FetchBillEventCopyWith<$Res> {
  _$FetchBillEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FetchBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? providerID = null,
    Object? phoneNo = null,
    Object? consumerId = null,
    Object? providerName = null,
  }) {
    return _then(
      _value.copyWith(
            providerID: null == providerID
                ? _value.providerID
                : providerID // ignore: cast_nullable_to_non_nullable
                      as String,
            phoneNo: null == phoneNo
                ? _value.phoneNo
                : phoneNo // ignore: cast_nullable_to_non_nullable
                      as String,
            consumerId: null == consumerId
                ? _value.consumerId
                : consumerId // ignore: cast_nullable_to_non_nullable
                      as String,
            providerName: null == providerName
                ? _value.providerName
                : providerName // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FetchElectricityBillImplCopyWith<$Res>
    implements $FetchBillEventCopyWith<$Res> {
  factory _$$FetchElectricityBillImplCopyWith(
    _$FetchElectricityBillImpl value,
    $Res Function(_$FetchElectricityBillImpl) then,
  ) = __$$FetchElectricityBillImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String providerID,
    String phoneNo,
    String consumerId,
    String providerName,
  });
}

/// @nodoc
class __$$FetchElectricityBillImplCopyWithImpl<$Res>
    extends _$FetchBillEventCopyWithImpl<$Res, _$FetchElectricityBillImpl>
    implements _$$FetchElectricityBillImplCopyWith<$Res> {
  __$$FetchElectricityBillImplCopyWithImpl(
    _$FetchElectricityBillImpl _value,
    $Res Function(_$FetchElectricityBillImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FetchBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? providerID = null,
    Object? phoneNo = null,
    Object? consumerId = null,
    Object? providerName = null,
  }) {
    return _then(
      _$FetchElectricityBillImpl(
        providerID: null == providerID
            ? _value.providerID
            : providerID // ignore: cast_nullable_to_non_nullable
                  as String,
        phoneNo: null == phoneNo
            ? _value.phoneNo
            : phoneNo // ignore: cast_nullable_to_non_nullable
                  as String,
        consumerId: null == consumerId
            ? _value.consumerId
            : consumerId // ignore: cast_nullable_to_non_nullable
                  as String,
        providerName: null == providerName
            ? _value.providerName
            : providerName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$FetchElectricityBillImpl implements FetchElectricityBill {
  const _$FetchElectricityBillImpl({
    required this.providerID,
    required this.phoneNo,
    required this.consumerId,
    required this.providerName,
  });

  @override
  final String providerID;
  @override
  final String phoneNo;
  @override
  final String consumerId;
  @override
  final String providerName;

  @override
  String toString() {
    return 'FetchBillEvent.fetchElectricityBill(providerID: $providerID, phoneNo: $phoneNo, consumerId: $consumerId, providerName: $providerName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchElectricityBillImpl &&
            (identical(other.providerID, providerID) ||
                other.providerID == providerID) &&
            (identical(other.phoneNo, phoneNo) || other.phoneNo == phoneNo) &&
            (identical(other.consumerId, consumerId) ||
                other.consumerId == consumerId) &&
            (identical(other.providerName, providerName) ||
                other.providerName == providerName));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, providerID, phoneNo, consumerId, providerName);

  /// Create a copy of FetchBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchElectricityBillImplCopyWith<_$FetchElectricityBillImpl>
  get copyWith =>
      __$$FetchElectricityBillImplCopyWithImpl<_$FetchElectricityBillImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )
    fetchElectricityBill,
    required TResult Function(
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )
    fetchWaterBill,
  }) {
    return fetchElectricityBill(providerID, phoneNo, consumerId, providerName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )?
    fetchElectricityBill,
    TResult? Function(
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )?
    fetchWaterBill,
  }) {
    return fetchElectricityBill?.call(
      providerID,
      phoneNo,
      consumerId,
      providerName,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )?
    fetchElectricityBill,
    TResult Function(
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )?
    fetchWaterBill,
    required TResult orElse(),
  }) {
    if (fetchElectricityBill != null) {
      return fetchElectricityBill(
        providerID,
        phoneNo,
        consumerId,
        providerName,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchElectricityBill value) fetchElectricityBill,
    required TResult Function(FetchWaterBill value) fetchWaterBill,
  }) {
    return fetchElectricityBill(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchElectricityBill value)? fetchElectricityBill,
    TResult? Function(FetchWaterBill value)? fetchWaterBill,
  }) {
    return fetchElectricityBill?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchElectricityBill value)? fetchElectricityBill,
    TResult Function(FetchWaterBill value)? fetchWaterBill,
    required TResult orElse(),
  }) {
    if (fetchElectricityBill != null) {
      return fetchElectricityBill(this);
    }
    return orElse();
  }
}

abstract class FetchElectricityBill implements FetchBillEvent {
  const factory FetchElectricityBill({
    required final String providerID,
    required final String phoneNo,
    required final String consumerId,
    required final String providerName,
  }) = _$FetchElectricityBillImpl;

  @override
  String get providerID;
  @override
  String get phoneNo;
  @override
  String get consumerId;
  @override
  String get providerName;

  /// Create a copy of FetchBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchElectricityBillImplCopyWith<_$FetchElectricityBillImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchWaterBillImplCopyWith<$Res>
    implements $FetchBillEventCopyWith<$Res> {
  factory _$$FetchWaterBillImplCopyWith(
    _$FetchWaterBillImpl value,
    $Res Function(_$FetchWaterBillImpl) then,
  ) = __$$FetchWaterBillImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String providerID,
    String phoneNo,
    String consumerId,
    String providerName,
  });
}

/// @nodoc
class __$$FetchWaterBillImplCopyWithImpl<$Res>
    extends _$FetchBillEventCopyWithImpl<$Res, _$FetchWaterBillImpl>
    implements _$$FetchWaterBillImplCopyWith<$Res> {
  __$$FetchWaterBillImplCopyWithImpl(
    _$FetchWaterBillImpl _value,
    $Res Function(_$FetchWaterBillImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FetchBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? providerID = null,
    Object? phoneNo = null,
    Object? consumerId = null,
    Object? providerName = null,
  }) {
    return _then(
      _$FetchWaterBillImpl(
        providerID: null == providerID
            ? _value.providerID
            : providerID // ignore: cast_nullable_to_non_nullable
                  as String,
        phoneNo: null == phoneNo
            ? _value.phoneNo
            : phoneNo // ignore: cast_nullable_to_non_nullable
                  as String,
        consumerId: null == consumerId
            ? _value.consumerId
            : consumerId // ignore: cast_nullable_to_non_nullable
                  as String,
        providerName: null == providerName
            ? _value.providerName
            : providerName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$FetchWaterBillImpl implements FetchWaterBill {
  const _$FetchWaterBillImpl({
    required this.providerID,
    required this.phoneNo,
    required this.consumerId,
    required this.providerName,
  });

  @override
  final String providerID;
  @override
  final String phoneNo;
  @override
  final String consumerId;
  @override
  final String providerName;

  @override
  String toString() {
    return 'FetchBillEvent.fetchWaterBill(providerID: $providerID, phoneNo: $phoneNo, consumerId: $consumerId, providerName: $providerName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchWaterBillImpl &&
            (identical(other.providerID, providerID) ||
                other.providerID == providerID) &&
            (identical(other.phoneNo, phoneNo) || other.phoneNo == phoneNo) &&
            (identical(other.consumerId, consumerId) ||
                other.consumerId == consumerId) &&
            (identical(other.providerName, providerName) ||
                other.providerName == providerName));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, providerID, phoneNo, consumerId, providerName);

  /// Create a copy of FetchBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchWaterBillImplCopyWith<_$FetchWaterBillImpl> get copyWith =>
      __$$FetchWaterBillImplCopyWithImpl<_$FetchWaterBillImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )
    fetchElectricityBill,
    required TResult Function(
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )
    fetchWaterBill,
  }) {
    return fetchWaterBill(providerID, phoneNo, consumerId, providerName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )?
    fetchElectricityBill,
    TResult? Function(
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )?
    fetchWaterBill,
  }) {
    return fetchWaterBill?.call(providerID, phoneNo, consumerId, providerName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )?
    fetchElectricityBill,
    TResult Function(
      String providerID,
      String phoneNo,
      String consumerId,
      String providerName,
    )?
    fetchWaterBill,
    required TResult orElse(),
  }) {
    if (fetchWaterBill != null) {
      return fetchWaterBill(providerID, phoneNo, consumerId, providerName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchElectricityBill value) fetchElectricityBill,
    required TResult Function(FetchWaterBill value) fetchWaterBill,
  }) {
    return fetchWaterBill(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchElectricityBill value)? fetchElectricityBill,
    TResult? Function(FetchWaterBill value)? fetchWaterBill,
  }) {
    return fetchWaterBill?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchElectricityBill value)? fetchElectricityBill,
    TResult Function(FetchWaterBill value)? fetchWaterBill,
    required TResult orElse(),
  }) {
    if (fetchWaterBill != null) {
      return fetchWaterBill(this);
    }
    return orElse();
  }
}

abstract class FetchWaterBill implements FetchBillEvent {
  const factory FetchWaterBill({
    required final String providerID,
    required final String phoneNo,
    required final String consumerId,
    required final String providerName,
  }) = _$FetchWaterBillImpl;

  @override
  String get providerID;
  @override
  String get phoneNo;
  @override
  String get consumerId;
  @override
  String get providerName;

  /// Create a copy of FetchBillEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchWaterBillImplCopyWith<_$FetchWaterBillImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FetchBillState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ElectricityBillModel bill, String receiptId)
    success,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ElectricityBillModel bill, String receiptId)? success,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ElectricityBillModel bill, String receiptId)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FetchBillStateCopyWith<$Res> {
  factory $FetchBillStateCopyWith(
    FetchBillState value,
    $Res Function(FetchBillState) then,
  ) = _$FetchBillStateCopyWithImpl<$Res, FetchBillState>;
}

/// @nodoc
class _$FetchBillStateCopyWithImpl<$Res, $Val extends FetchBillState>
    implements $FetchBillStateCopyWith<$Res> {
  _$FetchBillStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FetchBillState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$FetchBillStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FetchBillState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'FetchBillState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ElectricityBillModel bill, String receiptId)
    success,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ElectricityBillModel bill, String receiptId)? success,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ElectricityBillModel bill, String receiptId)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements FetchBillState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
    _$LoadingImpl value,
    $Res Function(_$LoadingImpl) then,
  ) = __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$FetchBillStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FetchBillState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'FetchBillState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ElectricityBillModel bill, String receiptId)
    success,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ElectricityBillModel bill, String receiptId)? success,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ElectricityBillModel bill, String receiptId)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements FetchBillState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
    _$SuccessImpl value,
    $Res Function(_$SuccessImpl) then,
  ) = __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ElectricityBillModel bill, String receiptId});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$FetchBillStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
    _$SuccessImpl _value,
    $Res Function(_$SuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FetchBillState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? bill = null, Object? receiptId = null}) {
    return _then(
      _$SuccessImpl(
        bill: null == bill
            ? _value.bill
            : bill // ignore: cast_nullable_to_non_nullable
                  as ElectricityBillModel,
        receiptId: null == receiptId
            ? _value.receiptId
            : receiptId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl({required this.bill, required this.receiptId});

  @override
  final ElectricityBillModel bill;
  @override
  final String receiptId;

  @override
  String toString() {
    return 'FetchBillState.success(bill: $bill, receiptId: $receiptId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.bill, bill) || other.bill == bill) &&
            (identical(other.receiptId, receiptId) ||
                other.receiptId == receiptId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, bill, receiptId);

  /// Create a copy of FetchBillState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ElectricityBillModel bill, String receiptId)
    success,
    required TResult Function(String message) error,
  }) {
    return success(bill, receiptId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ElectricityBillModel bill, String receiptId)? success,
    TResult? Function(String message)? error,
  }) {
    return success?.call(bill, receiptId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ElectricityBillModel bill, String receiptId)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(bill, receiptId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements FetchBillState {
  const factory _Success({
    required final ElectricityBillModel bill,
    required final String receiptId,
  }) = _$SuccessImpl;

  ElectricityBillModel get bill;
  String get receiptId;

  /// Create a copy of FetchBillState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
    _$ErrorImpl value,
    $Res Function(_$ErrorImpl) then,
  ) = __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$FetchBillStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FetchBillState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'FetchBillState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of FetchBillState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ElectricityBillModel bill, String receiptId)
    success,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ElectricityBillModel bill, String receiptId)? success,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ElectricityBillModel bill, String receiptId)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements FetchBillState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of FetchBillState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
