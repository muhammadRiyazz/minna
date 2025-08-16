// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bus_location_fetch_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BusLocationFetchEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getData,
    required TResult Function(String query) searchLocations,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getData,
    TResult? Function(String query)? searchLocations,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getData,
    TResult Function(String query)? searchLocations,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetData value) getData,
    required TResult Function(SearchLocations value) searchLocations,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetData value)? getData,
    TResult? Function(SearchLocations value)? searchLocations,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetData value)? getData,
    TResult Function(SearchLocations value)? searchLocations,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusLocationFetchEventCopyWith<$Res> {
  factory $BusLocationFetchEventCopyWith(
    BusLocationFetchEvent value,
    $Res Function(BusLocationFetchEvent) then,
  ) = _$BusLocationFetchEventCopyWithImpl<$Res, BusLocationFetchEvent>;
}

/// @nodoc
class _$BusLocationFetchEventCopyWithImpl<
  $Res,
  $Val extends BusLocationFetchEvent
>
    implements $BusLocationFetchEventCopyWith<$Res> {
  _$BusLocationFetchEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusLocationFetchEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$GetDataImplCopyWith<$Res> {
  factory _$$GetDataImplCopyWith(
    _$GetDataImpl value,
    $Res Function(_$GetDataImpl) then,
  ) = __$$GetDataImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetDataImplCopyWithImpl<$Res>
    extends _$BusLocationFetchEventCopyWithImpl<$Res, _$GetDataImpl>
    implements _$$GetDataImplCopyWith<$Res> {
  __$$GetDataImplCopyWithImpl(
    _$GetDataImpl _value,
    $Res Function(_$GetDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BusLocationFetchEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GetDataImpl implements GetData {
  const _$GetDataImpl();

  @override
  String toString() {
    return 'BusLocationFetchEvent.getData()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GetDataImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getData,
    required TResult Function(String query) searchLocations,
  }) {
    return getData();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getData,
    TResult? Function(String query)? searchLocations,
  }) {
    return getData?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getData,
    TResult Function(String query)? searchLocations,
    required TResult orElse(),
  }) {
    if (getData != null) {
      return getData();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetData value) getData,
    required TResult Function(SearchLocations value) searchLocations,
  }) {
    return getData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetData value)? getData,
    TResult? Function(SearchLocations value)? searchLocations,
  }) {
    return getData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetData value)? getData,
    TResult Function(SearchLocations value)? searchLocations,
    required TResult orElse(),
  }) {
    if (getData != null) {
      return getData(this);
    }
    return orElse();
  }
}

abstract class GetData implements BusLocationFetchEvent {
  const factory GetData() = _$GetDataImpl;
}

/// @nodoc
abstract class _$$SearchLocationsImplCopyWith<$Res> {
  factory _$$SearchLocationsImplCopyWith(
    _$SearchLocationsImpl value,
    $Res Function(_$SearchLocationsImpl) then,
  ) = __$$SearchLocationsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$$SearchLocationsImplCopyWithImpl<$Res>
    extends _$BusLocationFetchEventCopyWithImpl<$Res, _$SearchLocationsImpl>
    implements _$$SearchLocationsImplCopyWith<$Res> {
  __$$SearchLocationsImplCopyWithImpl(
    _$SearchLocationsImpl _value,
    $Res Function(_$SearchLocationsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BusLocationFetchEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? query = null}) {
    return _then(
      _$SearchLocationsImpl(
        query: null == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SearchLocationsImpl implements SearchLocations {
  const _$SearchLocationsImpl({required this.query});

  @override
  final String query;

  @override
  String toString() {
    return 'BusLocationFetchEvent.searchLocations(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchLocationsImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  /// Create a copy of BusLocationFetchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchLocationsImplCopyWith<_$SearchLocationsImpl> get copyWith =>
      __$$SearchLocationsImplCopyWithImpl<_$SearchLocationsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getData,
    required TResult Function(String query) searchLocations,
  }) {
    return searchLocations(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getData,
    TResult? Function(String query)? searchLocations,
  }) {
    return searchLocations?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getData,
    TResult Function(String query)? searchLocations,
    required TResult orElse(),
  }) {
    if (searchLocations != null) {
      return searchLocations(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetData value) getData,
    required TResult Function(SearchLocations value) searchLocations,
  }) {
    return searchLocations(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetData value)? getData,
    TResult? Function(SearchLocations value)? searchLocations,
  }) {
    return searchLocations?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetData value)? getData,
    TResult Function(SearchLocations value)? searchLocations,
    required TResult orElse(),
  }) {
    if (searchLocations != null) {
      return searchLocations(this);
    }
    return orElse();
  }
}

abstract class SearchLocations implements BusLocationFetchEvent {
  const factory SearchLocations({required final String query}) =
      _$SearchLocationsImpl;

  String get query;

  /// Create a copy of BusLocationFetchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchLocationsImplCopyWith<_$SearchLocationsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BusLocationFetchState {
  bool get isLoading => throw _privateConstructorUsedError;
  CityModelList? get allCitydata => throw _privateConstructorUsedError;
  List<City>? get filteredCities => throw _privateConstructorUsedError;

  /// Create a copy of BusLocationFetchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusLocationFetchStateCopyWith<BusLocationFetchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusLocationFetchStateCopyWith<$Res> {
  factory $BusLocationFetchStateCopyWith(
    BusLocationFetchState value,
    $Res Function(BusLocationFetchState) then,
  ) = _$BusLocationFetchStateCopyWithImpl<$Res, BusLocationFetchState>;
  @useResult
  $Res call({
    bool isLoading,
    CityModelList? allCitydata,
    List<City>? filteredCities,
  });
}

/// @nodoc
class _$BusLocationFetchStateCopyWithImpl<
  $Res,
  $Val extends BusLocationFetchState
>
    implements $BusLocationFetchStateCopyWith<$Res> {
  _$BusLocationFetchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusLocationFetchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? allCitydata = freezed,
    Object? filteredCities = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            allCitydata: freezed == allCitydata
                ? _value.allCitydata
                : allCitydata // ignore: cast_nullable_to_non_nullable
                      as CityModelList?,
            filteredCities: freezed == filteredCities
                ? _value.filteredCities
                : filteredCities // ignore: cast_nullable_to_non_nullable
                      as List<City>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LocationFetchStateImplCopyWith<$Res>
    implements $BusLocationFetchStateCopyWith<$Res> {
  factory _$$LocationFetchStateImplCopyWith(
    _$LocationFetchStateImpl value,
    $Res Function(_$LocationFetchStateImpl) then,
  ) = __$$LocationFetchStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    CityModelList? allCitydata,
    List<City>? filteredCities,
  });
}

/// @nodoc
class __$$LocationFetchStateImplCopyWithImpl<$Res>
    extends _$BusLocationFetchStateCopyWithImpl<$Res, _$LocationFetchStateImpl>
    implements _$$LocationFetchStateImplCopyWith<$Res> {
  __$$LocationFetchStateImplCopyWithImpl(
    _$LocationFetchStateImpl _value,
    $Res Function(_$LocationFetchStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BusLocationFetchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? allCitydata = freezed,
    Object? filteredCities = freezed,
  }) {
    return _then(
      _$LocationFetchStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        allCitydata: freezed == allCitydata
            ? _value.allCitydata
            : allCitydata // ignore: cast_nullable_to_non_nullable
                  as CityModelList?,
        filteredCities: freezed == filteredCities
            ? _value._filteredCities
            : filteredCities // ignore: cast_nullable_to_non_nullable
                  as List<City>?,
      ),
    );
  }
}

/// @nodoc

class _$LocationFetchStateImpl implements _LocationFetchState {
  _$LocationFetchStateImpl({
    required this.isLoading,
    this.allCitydata,
    final List<City>? filteredCities,
  }) : _filteredCities = filteredCities;

  @override
  final bool isLoading;
  @override
  final CityModelList? allCitydata;
  final List<City>? _filteredCities;
  @override
  List<City>? get filteredCities {
    final value = _filteredCities;
    if (value == null) return null;
    if (_filteredCities is EqualUnmodifiableListView) return _filteredCities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'BusLocationFetchState(isLoading: $isLoading, allCitydata: $allCitydata, filteredCities: $filteredCities)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationFetchStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.allCitydata, allCitydata) ||
                other.allCitydata == allCitydata) &&
            const DeepCollectionEquality().equals(
              other._filteredCities,
              _filteredCities,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    allCitydata,
    const DeepCollectionEquality().hash(_filteredCities),
  );

  /// Create a copy of BusLocationFetchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationFetchStateImplCopyWith<_$LocationFetchStateImpl> get copyWith =>
      __$$LocationFetchStateImplCopyWithImpl<_$LocationFetchStateImpl>(
        this,
        _$identity,
      );
}

abstract class _LocationFetchState implements BusLocationFetchState {
  factory _LocationFetchState({
    required final bool isLoading,
    final CityModelList? allCitydata,
    final List<City>? filteredCities,
  }) = _$LocationFetchStateImpl;

  @override
  bool get isLoading;
  @override
  CityModelList? get allCitydata;
  @override
  List<City>? get filteredCities;

  /// Create a copy of BusLocationFetchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationFetchStateImplCopyWith<_$LocationFetchStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
