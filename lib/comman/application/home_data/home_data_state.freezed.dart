// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$HomeDataState {
  bool get isDestinationsLoading => throw _privateConstructorUsedError;
  List<DestinationModel>? get popularDestinations =>
      throw _privateConstructorUsedError;
  bool get isVisaLoading => throw _privateConstructorUsedError;
  List<VisaModel>? get visaCountries => throw _privateConstructorUsedError;

  /// Create a copy of HomeDataState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeDataStateCopyWith<HomeDataState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeDataStateCopyWith<$Res> {
  factory $HomeDataStateCopyWith(
    HomeDataState value,
    $Res Function(HomeDataState) then,
  ) = _$HomeDataStateCopyWithImpl<$Res, HomeDataState>;
  @useResult
  $Res call({
    bool isDestinationsLoading,
    List<DestinationModel>? popularDestinations,
    bool isVisaLoading,
    List<VisaModel>? visaCountries,
  });
}

/// @nodoc
class _$HomeDataStateCopyWithImpl<$Res, $Val extends HomeDataState>
    implements $HomeDataStateCopyWith<$Res> {
  _$HomeDataStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeDataState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDestinationsLoading = null,
    Object? popularDestinations = freezed,
    Object? isVisaLoading = null,
    Object? visaCountries = freezed,
  }) {
    return _then(
      _value.copyWith(
            isDestinationsLoading: null == isDestinationsLoading
                ? _value.isDestinationsLoading
                : isDestinationsLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            popularDestinations: freezed == popularDestinations
                ? _value.popularDestinations
                : popularDestinations // ignore: cast_nullable_to_non_nullable
                      as List<DestinationModel>?,
            isVisaLoading: null == isVisaLoading
                ? _value.isVisaLoading
                : isVisaLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            visaCountries: freezed == visaCountries
                ? _value.visaCountries
                : visaCountries // ignore: cast_nullable_to_non_nullable
                      as List<VisaModel>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HomeDataStateImplCopyWith<$Res>
    implements $HomeDataStateCopyWith<$Res> {
  factory _$$HomeDataStateImplCopyWith(
    _$HomeDataStateImpl value,
    $Res Function(_$HomeDataStateImpl) then,
  ) = __$$HomeDataStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isDestinationsLoading,
    List<DestinationModel>? popularDestinations,
    bool isVisaLoading,
    List<VisaModel>? visaCountries,
  });
}

/// @nodoc
class __$$HomeDataStateImplCopyWithImpl<$Res>
    extends _$HomeDataStateCopyWithImpl<$Res, _$HomeDataStateImpl>
    implements _$$HomeDataStateImplCopyWith<$Res> {
  __$$HomeDataStateImplCopyWithImpl(
    _$HomeDataStateImpl _value,
    $Res Function(_$HomeDataStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeDataState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDestinationsLoading = null,
    Object? popularDestinations = freezed,
    Object? isVisaLoading = null,
    Object? visaCountries = freezed,
  }) {
    return _then(
      _$HomeDataStateImpl(
        isDestinationsLoading: null == isDestinationsLoading
            ? _value.isDestinationsLoading
            : isDestinationsLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        popularDestinations: freezed == popularDestinations
            ? _value._popularDestinations
            : popularDestinations // ignore: cast_nullable_to_non_nullable
                  as List<DestinationModel>?,
        isVisaLoading: null == isVisaLoading
            ? _value.isVisaLoading
            : isVisaLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        visaCountries: freezed == visaCountries
            ? _value._visaCountries
            : visaCountries // ignore: cast_nullable_to_non_nullable
                  as List<VisaModel>?,
      ),
    );
  }
}

/// @nodoc

class _$HomeDataStateImpl implements _HomeDataState {
  const _$HomeDataStateImpl({
    required this.isDestinationsLoading,
    final List<DestinationModel>? popularDestinations,
    required this.isVisaLoading,
    final List<VisaModel>? visaCountries,
  }) : _popularDestinations = popularDestinations,
       _visaCountries = visaCountries;

  @override
  final bool isDestinationsLoading;
  final List<DestinationModel>? _popularDestinations;
  @override
  List<DestinationModel>? get popularDestinations {
    final value = _popularDestinations;
    if (value == null) return null;
    if (_popularDestinations is EqualUnmodifiableListView)
      return _popularDestinations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool isVisaLoading;
  final List<VisaModel>? _visaCountries;
  @override
  List<VisaModel>? get visaCountries {
    final value = _visaCountries;
    if (value == null) return null;
    if (_visaCountries is EqualUnmodifiableListView) return _visaCountries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'HomeDataState(isDestinationsLoading: $isDestinationsLoading, popularDestinations: $popularDestinations, isVisaLoading: $isVisaLoading, visaCountries: $visaCountries)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeDataStateImpl &&
            (identical(other.isDestinationsLoading, isDestinationsLoading) ||
                other.isDestinationsLoading == isDestinationsLoading) &&
            const DeepCollectionEquality().equals(
              other._popularDestinations,
              _popularDestinations,
            ) &&
            (identical(other.isVisaLoading, isVisaLoading) ||
                other.isVisaLoading == isVisaLoading) &&
            const DeepCollectionEquality().equals(
              other._visaCountries,
              _visaCountries,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isDestinationsLoading,
    const DeepCollectionEquality().hash(_popularDestinations),
    isVisaLoading,
    const DeepCollectionEquality().hash(_visaCountries),
  );

  /// Create a copy of HomeDataState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeDataStateImplCopyWith<_$HomeDataStateImpl> get copyWith =>
      __$$HomeDataStateImplCopyWithImpl<_$HomeDataStateImpl>(this, _$identity);
}

abstract class _HomeDataState implements HomeDataState {
  const factory _HomeDataState({
    required final bool isDestinationsLoading,
    final List<DestinationModel>? popularDestinations,
    required final bool isVisaLoading,
    final List<VisaModel>? visaCountries,
  }) = _$HomeDataStateImpl;

  @override
  bool get isDestinationsLoading;
  @override
  List<DestinationModel>? get popularDestinations;
  @override
  bool get isVisaLoading;
  @override
  List<VisaModel>? get visaCountries;

  /// Create a copy of HomeDataState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeDataStateImplCopyWith<_$HomeDataStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
