// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bus_list_fetch_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BusListFetchState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;
  List<AvailableTrip>? get availableTrips => throw _privateConstructorUsedError;
  AvailableTrip? get selectTrip => throw _privateConstructorUsedError;
  bool? get notripp => throw _privateConstructorUsedError;

  /// Create a copy of BusListFetchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusListFetchStateCopyWith<BusListFetchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusListFetchStateCopyWith<$Res> {
  factory $BusListFetchStateCopyWith(
    BusListFetchState value,
    $Res Function(BusListFetchState) then,
  ) = _$BusListFetchStateCopyWithImpl<$Res, BusListFetchState>;
  @useResult
  $Res call({
    bool isLoading,
    bool isError,
    List<AvailableTrip>? availableTrips,
    AvailableTrip? selectTrip,
    bool? notripp,
  });
}

/// @nodoc
class _$BusListFetchStateCopyWithImpl<$Res, $Val extends BusListFetchState>
    implements $BusListFetchStateCopyWith<$Res> {
  _$BusListFetchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusListFetchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isError = null,
    Object? availableTrips = freezed,
    Object? selectTrip = freezed,
    Object? notripp = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isError: null == isError
                ? _value.isError
                : isError // ignore: cast_nullable_to_non_nullable
                      as bool,
            availableTrips: freezed == availableTrips
                ? _value.availableTrips
                : availableTrips // ignore: cast_nullable_to_non_nullable
                      as List<AvailableTrip>?,
            selectTrip: freezed == selectTrip
                ? _value.selectTrip
                : selectTrip // ignore: cast_nullable_to_non_nullable
                      as AvailableTrip?,
            notripp: freezed == notripp
                ? _value.notripp
                : notripp // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BusListFetchStateImplCopyWith<$Res>
    implements $BusListFetchStateCopyWith<$Res> {
  factory _$$BusListFetchStateImplCopyWith(
    _$BusListFetchStateImpl value,
    $Res Function(_$BusListFetchStateImpl) then,
  ) = __$$BusListFetchStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    bool isError,
    List<AvailableTrip>? availableTrips,
    AvailableTrip? selectTrip,
    bool? notripp,
  });
}

/// @nodoc
class __$$BusListFetchStateImplCopyWithImpl<$Res>
    extends _$BusListFetchStateCopyWithImpl<$Res, _$BusListFetchStateImpl>
    implements _$$BusListFetchStateImplCopyWith<$Res> {
  __$$BusListFetchStateImplCopyWithImpl(
    _$BusListFetchStateImpl _value,
    $Res Function(_$BusListFetchStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BusListFetchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isError = null,
    Object? availableTrips = freezed,
    Object? selectTrip = freezed,
    Object? notripp = freezed,
  }) {
    return _then(
      _$BusListFetchStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isError: null == isError
            ? _value.isError
            : isError // ignore: cast_nullable_to_non_nullable
                  as bool,
        availableTrips: freezed == availableTrips
            ? _value._availableTrips
            : availableTrips // ignore: cast_nullable_to_non_nullable
                  as List<AvailableTrip>?,
        selectTrip: freezed == selectTrip
            ? _value.selectTrip
            : selectTrip // ignore: cast_nullable_to_non_nullable
                  as AvailableTrip?,
        notripp: freezed == notripp
            ? _value.notripp
            : notripp // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc

class _$BusListFetchStateImpl implements _BusListFetchState {
  const _$BusListFetchStateImpl({
    required this.isLoading,
    required this.isError,
    final List<AvailableTrip>? availableTrips,
    this.selectTrip,
    this.notripp,
  }) : _availableTrips = availableTrips;

  @override
  final bool isLoading;
  @override
  final bool isError;
  final List<AvailableTrip>? _availableTrips;
  @override
  List<AvailableTrip>? get availableTrips {
    final value = _availableTrips;
    if (value == null) return null;
    if (_availableTrips is EqualUnmodifiableListView) return _availableTrips;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final AvailableTrip? selectTrip;
  @override
  final bool? notripp;

  @override
  String toString() {
    return 'BusListFetchState(isLoading: $isLoading, isError: $isError, availableTrips: $availableTrips, selectTrip: $selectTrip, notripp: $notripp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusListFetchStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isError, isError) || other.isError == isError) &&
            const DeepCollectionEquality().equals(
              other._availableTrips,
              _availableTrips,
            ) &&
            (identical(other.selectTrip, selectTrip) ||
                other.selectTrip == selectTrip) &&
            (identical(other.notripp, notripp) || other.notripp == notripp));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isError,
    const DeepCollectionEquality().hash(_availableTrips),
    selectTrip,
    notripp,
  );

  /// Create a copy of BusListFetchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusListFetchStateImplCopyWith<_$BusListFetchStateImpl> get copyWith =>
      __$$BusListFetchStateImplCopyWithImpl<_$BusListFetchStateImpl>(
        this,
        _$identity,
      );
}

abstract class _BusListFetchState implements BusListFetchState {
  const factory _BusListFetchState({
    required final bool isLoading,
    required final bool isError,
    final List<AvailableTrip>? availableTrips,
    final AvailableTrip? selectTrip,
    final bool? notripp,
  }) = _$BusListFetchStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isError;
  @override
  List<AvailableTrip>? get availableTrips;
  @override
  AvailableTrip? get selectTrip;
  @override
  bool? get notripp;

  /// Create a copy of BusListFetchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusListFetchStateImplCopyWith<_$BusListFetchStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
