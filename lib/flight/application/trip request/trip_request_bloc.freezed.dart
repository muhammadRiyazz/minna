// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_request_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TripRequestEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(FlightSearchRequest flightRequestData)
    getTripList,
    required TResult Function(
      FlightFare selectedFare,
      FlightOptionElement selectedTrip,
    )
    changeFare,
    required TResult Function(Airport fromAirportinfo, Airport toAirportinfo)
    getFlightinfo,
    required TResult Function(
      double? minPrice,
      double? maxPrice,
      List<int>? stops,
      List<String>? airlines,
      List<int>? departureTimes,
    )
    filterRespo,
    required TResult Function() resetFilter,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(FlightSearchRequest flightRequestData)? getTripList,
    TResult? Function(
      FlightFare selectedFare,
      FlightOptionElement selectedTrip,
    )?
    changeFare,
    TResult? Function(Airport fromAirportinfo, Airport toAirportinfo)?
    getFlightinfo,
    TResult? Function(
      double? minPrice,
      double? maxPrice,
      List<int>? stops,
      List<String>? airlines,
      List<int>? departureTimes,
    )?
    filterRespo,
    TResult? Function()? resetFilter,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FlightSearchRequest flightRequestData)? getTripList,
    TResult Function(FlightFare selectedFare, FlightOptionElement selectedTrip)?
    changeFare,
    TResult Function(Airport fromAirportinfo, Airport toAirportinfo)?
    getFlightinfo,
    TResult Function(
      double? minPrice,
      double? maxPrice,
      List<int>? stops,
      List<String>? airlines,
      List<int>? departureTimes,
    )?
    filterRespo,
    TResult Function()? resetFilter,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetTripList value) getTripList,
    required TResult Function(ChangeFare value) changeFare,
    required TResult Function(GetFlightinfo value) getFlightinfo,
    required TResult Function(FilterRespo value) filterRespo,
    required TResult Function(ResetFilter value) resetFilter,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetTripList value)? getTripList,
    TResult? Function(ChangeFare value)? changeFare,
    TResult? Function(GetFlightinfo value)? getFlightinfo,
    TResult? Function(FilterRespo value)? filterRespo,
    TResult? Function(ResetFilter value)? resetFilter,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetTripList value)? getTripList,
    TResult Function(ChangeFare value)? changeFare,
    TResult Function(GetFlightinfo value)? getFlightinfo,
    TResult Function(FilterRespo value)? filterRespo,
    TResult Function(ResetFilter value)? resetFilter,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripRequestEventCopyWith<$Res> {
  factory $TripRequestEventCopyWith(
    TripRequestEvent value,
    $Res Function(TripRequestEvent) then,
  ) = _$TripRequestEventCopyWithImpl<$Res, TripRequestEvent>;
}

/// @nodoc
class _$TripRequestEventCopyWithImpl<$Res, $Val extends TripRequestEvent>
    implements $TripRequestEventCopyWith<$Res> {
  _$TripRequestEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$GetTripListImplCopyWith<$Res> {
  factory _$$GetTripListImplCopyWith(
    _$GetTripListImpl value,
    $Res Function(_$GetTripListImpl) then,
  ) = __$$GetTripListImplCopyWithImpl<$Res>;
  @useResult
  $Res call({FlightSearchRequest flightRequestData});
}

/// @nodoc
class __$$GetTripListImplCopyWithImpl<$Res>
    extends _$TripRequestEventCopyWithImpl<$Res, _$GetTripListImpl>
    implements _$$GetTripListImplCopyWith<$Res> {
  __$$GetTripListImplCopyWithImpl(
    _$GetTripListImpl _value,
    $Res Function(_$GetTripListImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? flightRequestData = null}) {
    return _then(
      _$GetTripListImpl(
        flightRequestData: null == flightRequestData
            ? _value.flightRequestData
            : flightRequestData // ignore: cast_nullable_to_non_nullable
                  as FlightSearchRequest,
      ),
    );
  }
}

/// @nodoc

class _$GetTripListImpl implements GetTripList {
  const _$GetTripListImpl({required this.flightRequestData});

  @override
  final FlightSearchRequest flightRequestData;

  @override
  String toString() {
    return 'TripRequestEvent.getTripList(flightRequestData: $flightRequestData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetTripListImpl &&
            (identical(other.flightRequestData, flightRequestData) ||
                other.flightRequestData == flightRequestData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, flightRequestData);

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetTripListImplCopyWith<_$GetTripListImpl> get copyWith =>
      __$$GetTripListImplCopyWithImpl<_$GetTripListImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(FlightSearchRequest flightRequestData)
    getTripList,
    required TResult Function(
      FlightFare selectedFare,
      FlightOptionElement selectedTrip,
    )
    changeFare,
    required TResult Function(Airport fromAirportinfo, Airport toAirportinfo)
    getFlightinfo,
    required TResult Function(
      double? minPrice,
      double? maxPrice,
      List<int>? stops,
      List<String>? airlines,
      List<int>? departureTimes,
    )
    filterRespo,
    required TResult Function() resetFilter,
  }) {
    return getTripList(flightRequestData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(FlightSearchRequest flightRequestData)? getTripList,
    TResult? Function(
      FlightFare selectedFare,
      FlightOptionElement selectedTrip,
    )?
    changeFare,
    TResult? Function(Airport fromAirportinfo, Airport toAirportinfo)?
    getFlightinfo,
    TResult? Function(
      double? minPrice,
      double? maxPrice,
      List<int>? stops,
      List<String>? airlines,
      List<int>? departureTimes,
    )?
    filterRespo,
    TResult? Function()? resetFilter,
  }) {
    return getTripList?.call(flightRequestData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FlightSearchRequest flightRequestData)? getTripList,
    TResult Function(FlightFare selectedFare, FlightOptionElement selectedTrip)?
    changeFare,
    TResult Function(Airport fromAirportinfo, Airport toAirportinfo)?
    getFlightinfo,
    TResult Function(
      double? minPrice,
      double? maxPrice,
      List<int>? stops,
      List<String>? airlines,
      List<int>? departureTimes,
    )?
    filterRespo,
    TResult Function()? resetFilter,
    required TResult orElse(),
  }) {
    if (getTripList != null) {
      return getTripList(flightRequestData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetTripList value) getTripList,
    required TResult Function(ChangeFare value) changeFare,
    required TResult Function(GetFlightinfo value) getFlightinfo,
    required TResult Function(FilterRespo value) filterRespo,
    required TResult Function(ResetFilter value) resetFilter,
  }) {
    return getTripList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetTripList value)? getTripList,
    TResult? Function(ChangeFare value)? changeFare,
    TResult? Function(GetFlightinfo value)? getFlightinfo,
    TResult? Function(FilterRespo value)? filterRespo,
    TResult? Function(ResetFilter value)? resetFilter,
  }) {
    return getTripList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetTripList value)? getTripList,
    TResult Function(ChangeFare value)? changeFare,
    TResult Function(GetFlightinfo value)? getFlightinfo,
    TResult Function(FilterRespo value)? filterRespo,
    TResult Function(ResetFilter value)? resetFilter,
    required TResult orElse(),
  }) {
    if (getTripList != null) {
      return getTripList(this);
    }
    return orElse();
  }
}

abstract class GetTripList implements TripRequestEvent {
  const factory GetTripList({
    required final FlightSearchRequest flightRequestData,
  }) = _$GetTripListImpl;

  FlightSearchRequest get flightRequestData;

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetTripListImplCopyWith<_$GetTripListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChangeFareImplCopyWith<$Res> {
  factory _$$ChangeFareImplCopyWith(
    _$ChangeFareImpl value,
    $Res Function(_$ChangeFareImpl) then,
  ) = __$$ChangeFareImplCopyWithImpl<$Res>;
  @useResult
  $Res call({FlightFare selectedFare, FlightOptionElement selectedTrip});
}

/// @nodoc
class __$$ChangeFareImplCopyWithImpl<$Res>
    extends _$TripRequestEventCopyWithImpl<$Res, _$ChangeFareImpl>
    implements _$$ChangeFareImplCopyWith<$Res> {
  __$$ChangeFareImplCopyWithImpl(
    _$ChangeFareImpl _value,
    $Res Function(_$ChangeFareImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? selectedFare = null, Object? selectedTrip = null}) {
    return _then(
      _$ChangeFareImpl(
        selectedFare: null == selectedFare
            ? _value.selectedFare
            : selectedFare // ignore: cast_nullable_to_non_nullable
                  as FlightFare,
        selectedTrip: null == selectedTrip
            ? _value.selectedTrip
            : selectedTrip // ignore: cast_nullable_to_non_nullable
                  as FlightOptionElement,
      ),
    );
  }
}

/// @nodoc

class _$ChangeFareImpl implements ChangeFare {
  const _$ChangeFareImpl({
    required this.selectedFare,
    required this.selectedTrip,
  });

  @override
  final FlightFare selectedFare;
  @override
  final FlightOptionElement selectedTrip;

  @override
  String toString() {
    return 'TripRequestEvent.changeFare(selectedFare: $selectedFare, selectedTrip: $selectedTrip)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeFareImpl &&
            (identical(other.selectedFare, selectedFare) ||
                other.selectedFare == selectedFare) &&
            (identical(other.selectedTrip, selectedTrip) ||
                other.selectedTrip == selectedTrip));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedFare, selectedTrip);

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeFareImplCopyWith<_$ChangeFareImpl> get copyWith =>
      __$$ChangeFareImplCopyWithImpl<_$ChangeFareImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(FlightSearchRequest flightRequestData)
    getTripList,
    required TResult Function(
      FlightFare selectedFare,
      FlightOptionElement selectedTrip,
    )
    changeFare,
    required TResult Function(Airport fromAirportinfo, Airport toAirportinfo)
    getFlightinfo,
    required TResult Function(
      double? minPrice,
      double? maxPrice,
      List<int>? stops,
      List<String>? airlines,
      List<int>? departureTimes,
    )
    filterRespo,
    required TResult Function() resetFilter,
  }) {
    return changeFare(selectedFare, selectedTrip);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(FlightSearchRequest flightRequestData)? getTripList,
    TResult? Function(
      FlightFare selectedFare,
      FlightOptionElement selectedTrip,
    )?
    changeFare,
    TResult? Function(Airport fromAirportinfo, Airport toAirportinfo)?
    getFlightinfo,
    TResult? Function(
      double? minPrice,
      double? maxPrice,
      List<int>? stops,
      List<String>? airlines,
      List<int>? departureTimes,
    )?
    filterRespo,
    TResult? Function()? resetFilter,
  }) {
    return changeFare?.call(selectedFare, selectedTrip);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FlightSearchRequest flightRequestData)? getTripList,
    TResult Function(FlightFare selectedFare, FlightOptionElement selectedTrip)?
    changeFare,
    TResult Function(Airport fromAirportinfo, Airport toAirportinfo)?
    getFlightinfo,
    TResult Function(
      double? minPrice,
      double? maxPrice,
      List<int>? stops,
      List<String>? airlines,
      List<int>? departureTimes,
    )?
    filterRespo,
    TResult Function()? resetFilter,
    required TResult orElse(),
  }) {
    if (changeFare != null) {
      return changeFare(selectedFare, selectedTrip);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetTripList value) getTripList,
    required TResult Function(ChangeFare value) changeFare,
    required TResult Function(GetFlightinfo value) getFlightinfo,
    required TResult Function(FilterRespo value) filterRespo,
    required TResult Function(ResetFilter value) resetFilter,
  }) {
    return changeFare(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetTripList value)? getTripList,
    TResult? Function(ChangeFare value)? changeFare,
    TResult? Function(GetFlightinfo value)? getFlightinfo,
    TResult? Function(FilterRespo value)? filterRespo,
    TResult? Function(ResetFilter value)? resetFilter,
  }) {
    return changeFare?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetTripList value)? getTripList,
    TResult Function(ChangeFare value)? changeFare,
    TResult Function(GetFlightinfo value)? getFlightinfo,
    TResult Function(FilterRespo value)? filterRespo,
    TResult Function(ResetFilter value)? resetFilter,
    required TResult orElse(),
  }) {
    if (changeFare != null) {
      return changeFare(this);
    }
    return orElse();
  }
}

abstract class ChangeFare implements TripRequestEvent {
  const factory ChangeFare({
    required final FlightFare selectedFare,
    required final FlightOptionElement selectedTrip,
  }) = _$ChangeFareImpl;

  FlightFare get selectedFare;
  FlightOptionElement get selectedTrip;

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangeFareImplCopyWith<_$ChangeFareImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetFlightinfoImplCopyWith<$Res> {
  factory _$$GetFlightinfoImplCopyWith(
    _$GetFlightinfoImpl value,
    $Res Function(_$GetFlightinfoImpl) then,
  ) = __$$GetFlightinfoImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Airport fromAirportinfo, Airport toAirportinfo});
}

/// @nodoc
class __$$GetFlightinfoImplCopyWithImpl<$Res>
    extends _$TripRequestEventCopyWithImpl<$Res, _$GetFlightinfoImpl>
    implements _$$GetFlightinfoImplCopyWith<$Res> {
  __$$GetFlightinfoImplCopyWithImpl(
    _$GetFlightinfoImpl _value,
    $Res Function(_$GetFlightinfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fromAirportinfo = null, Object? toAirportinfo = null}) {
    return _then(
      _$GetFlightinfoImpl(
        fromAirportinfo: null == fromAirportinfo
            ? _value.fromAirportinfo
            : fromAirportinfo // ignore: cast_nullable_to_non_nullable
                  as Airport,
        toAirportinfo: null == toAirportinfo
            ? _value.toAirportinfo
            : toAirportinfo // ignore: cast_nullable_to_non_nullable
                  as Airport,
      ),
    );
  }
}

/// @nodoc

class _$GetFlightinfoImpl implements GetFlightinfo {
  const _$GetFlightinfoImpl({
    required this.fromAirportinfo,
    required this.toAirportinfo,
  });

  @override
  final Airport fromAirportinfo;
  @override
  final Airport toAirportinfo;

  @override
  String toString() {
    return 'TripRequestEvent.getFlightinfo(fromAirportinfo: $fromAirportinfo, toAirportinfo: $toAirportinfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetFlightinfoImpl &&
            (identical(other.fromAirportinfo, fromAirportinfo) ||
                other.fromAirportinfo == fromAirportinfo) &&
            (identical(other.toAirportinfo, toAirportinfo) ||
                other.toAirportinfo == toAirportinfo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fromAirportinfo, toAirportinfo);

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetFlightinfoImplCopyWith<_$GetFlightinfoImpl> get copyWith =>
      __$$GetFlightinfoImplCopyWithImpl<_$GetFlightinfoImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(FlightSearchRequest flightRequestData)
    getTripList,
    required TResult Function(
      FlightFare selectedFare,
      FlightOptionElement selectedTrip,
    )
    changeFare,
    required TResult Function(Airport fromAirportinfo, Airport toAirportinfo)
    getFlightinfo,
    required TResult Function(
      double? minPrice,
      double? maxPrice,
      List<int>? stops,
      List<String>? airlines,
      List<int>? departureTimes,
    )
    filterRespo,
    required TResult Function() resetFilter,
  }) {
    return getFlightinfo(fromAirportinfo, toAirportinfo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(FlightSearchRequest flightRequestData)? getTripList,
    TResult? Function(
      FlightFare selectedFare,
      FlightOptionElement selectedTrip,
    )?
    changeFare,
    TResult? Function(Airport fromAirportinfo, Airport toAirportinfo)?
    getFlightinfo,
    TResult? Function(
      double? minPrice,
      double? maxPrice,
      List<int>? stops,
      List<String>? airlines,
      List<int>? departureTimes,
    )?
    filterRespo,
    TResult? Function()? resetFilter,
  }) {
    return getFlightinfo?.call(fromAirportinfo, toAirportinfo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FlightSearchRequest flightRequestData)? getTripList,
    TResult Function(FlightFare selectedFare, FlightOptionElement selectedTrip)?
    changeFare,
    TResult Function(Airport fromAirportinfo, Airport toAirportinfo)?
    getFlightinfo,
    TResult Function(
      double? minPrice,
      double? maxPrice,
      List<int>? stops,
      List<String>? airlines,
      List<int>? departureTimes,
    )?
    filterRespo,
    TResult Function()? resetFilter,
    required TResult orElse(),
  }) {
    if (getFlightinfo != null) {
      return getFlightinfo(fromAirportinfo, toAirportinfo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetTripList value) getTripList,
    required TResult Function(ChangeFare value) changeFare,
    required TResult Function(GetFlightinfo value) getFlightinfo,
    required TResult Function(FilterRespo value) filterRespo,
    required TResult Function(ResetFilter value) resetFilter,
  }) {
    return getFlightinfo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetTripList value)? getTripList,
    TResult? Function(ChangeFare value)? changeFare,
    TResult? Function(GetFlightinfo value)? getFlightinfo,
    TResult? Function(FilterRespo value)? filterRespo,
    TResult? Function(ResetFilter value)? resetFilter,
  }) {
    return getFlightinfo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetTripList value)? getTripList,
    TResult Function(ChangeFare value)? changeFare,
    TResult Function(GetFlightinfo value)? getFlightinfo,
    TResult Function(FilterRespo value)? filterRespo,
    TResult Function(ResetFilter value)? resetFilter,
    required TResult orElse(),
  }) {
    if (getFlightinfo != null) {
      return getFlightinfo(this);
    }
    return orElse();
  }
}

abstract class GetFlightinfo implements TripRequestEvent {
  const factory GetFlightinfo({
    required final Airport fromAirportinfo,
    required final Airport toAirportinfo,
  }) = _$GetFlightinfoImpl;

  Airport get fromAirportinfo;
  Airport get toAirportinfo;

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetFlightinfoImplCopyWith<_$GetFlightinfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FilterRespoImplCopyWith<$Res> {
  factory _$$FilterRespoImplCopyWith(
    _$FilterRespoImpl value,
    $Res Function(_$FilterRespoImpl) then,
  ) = __$$FilterRespoImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    double? minPrice,
    double? maxPrice,
    List<int>? stops,
    List<String>? airlines,
    List<int>? departureTimes,
  });
}

/// @nodoc
class __$$FilterRespoImplCopyWithImpl<$Res>
    extends _$TripRequestEventCopyWithImpl<$Res, _$FilterRespoImpl>
    implements _$$FilterRespoImplCopyWith<$Res> {
  __$$FilterRespoImplCopyWithImpl(
    _$FilterRespoImpl _value,
    $Res Function(_$FilterRespoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minPrice = freezed,
    Object? maxPrice = freezed,
    Object? stops = freezed,
    Object? airlines = freezed,
    Object? departureTimes = freezed,
  }) {
    return _then(
      _$FilterRespoImpl(
        minPrice: freezed == minPrice
            ? _value.minPrice
            : minPrice // ignore: cast_nullable_to_non_nullable
                  as double?,
        maxPrice: freezed == maxPrice
            ? _value.maxPrice
            : maxPrice // ignore: cast_nullable_to_non_nullable
                  as double?,
        stops: freezed == stops
            ? _value._stops
            : stops // ignore: cast_nullable_to_non_nullable
                  as List<int>?,
        airlines: freezed == airlines
            ? _value._airlines
            : airlines // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        departureTimes: freezed == departureTimes
            ? _value._departureTimes
            : departureTimes // ignore: cast_nullable_to_non_nullable
                  as List<int>?,
      ),
    );
  }
}

/// @nodoc

class _$FilterRespoImpl implements FilterRespo {
  const _$FilterRespoImpl({
    this.minPrice,
    this.maxPrice,
    final List<int>? stops,
    final List<String>? airlines,
    final List<int>? departureTimes,
  }) : _stops = stops,
       _airlines = airlines,
       _departureTimes = departureTimes;

  @override
  final double? minPrice;
  @override
  final double? maxPrice;
  final List<int>? _stops;
  @override
  List<int>? get stops {
    final value = _stops;
    if (value == null) return null;
    if (_stops is EqualUnmodifiableListView) return _stops;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _airlines;
  @override
  List<String>? get airlines {
    final value = _airlines;
    if (value == null) return null;
    if (_airlines is EqualUnmodifiableListView) return _airlines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<int>? _departureTimes;
  @override
  List<int>? get departureTimes {
    final value = _departureTimes;
    if (value == null) return null;
    if (_departureTimes is EqualUnmodifiableListView) return _departureTimes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'TripRequestEvent.filterRespo(minPrice: $minPrice, maxPrice: $maxPrice, stops: $stops, airlines: $airlines, departureTimes: $departureTimes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterRespoImpl &&
            (identical(other.minPrice, minPrice) ||
                other.minPrice == minPrice) &&
            (identical(other.maxPrice, maxPrice) ||
                other.maxPrice == maxPrice) &&
            const DeepCollectionEquality().equals(other._stops, _stops) &&
            const DeepCollectionEquality().equals(other._airlines, _airlines) &&
            const DeepCollectionEquality().equals(
              other._departureTimes,
              _departureTimes,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    minPrice,
    maxPrice,
    const DeepCollectionEquality().hash(_stops),
    const DeepCollectionEquality().hash(_airlines),
    const DeepCollectionEquality().hash(_departureTimes),
  );

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterRespoImplCopyWith<_$FilterRespoImpl> get copyWith =>
      __$$FilterRespoImplCopyWithImpl<_$FilterRespoImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(FlightSearchRequest flightRequestData)
    getTripList,
    required TResult Function(
      FlightFare selectedFare,
      FlightOptionElement selectedTrip,
    )
    changeFare,
    required TResult Function(Airport fromAirportinfo, Airport toAirportinfo)
    getFlightinfo,
    required TResult Function(
      double? minPrice,
      double? maxPrice,
      List<int>? stops,
      List<String>? airlines,
      List<int>? departureTimes,
    )
    filterRespo,
    required TResult Function() resetFilter,
  }) {
    return filterRespo(minPrice, maxPrice, stops, airlines, departureTimes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(FlightSearchRequest flightRequestData)? getTripList,
    TResult? Function(
      FlightFare selectedFare,
      FlightOptionElement selectedTrip,
    )?
    changeFare,
    TResult? Function(Airport fromAirportinfo, Airport toAirportinfo)?
    getFlightinfo,
    TResult? Function(
      double? minPrice,
      double? maxPrice,
      List<int>? stops,
      List<String>? airlines,
      List<int>? departureTimes,
    )?
    filterRespo,
    TResult? Function()? resetFilter,
  }) {
    return filterRespo?.call(
      minPrice,
      maxPrice,
      stops,
      airlines,
      departureTimes,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FlightSearchRequest flightRequestData)? getTripList,
    TResult Function(FlightFare selectedFare, FlightOptionElement selectedTrip)?
    changeFare,
    TResult Function(Airport fromAirportinfo, Airport toAirportinfo)?
    getFlightinfo,
    TResult Function(
      double? minPrice,
      double? maxPrice,
      List<int>? stops,
      List<String>? airlines,
      List<int>? departureTimes,
    )?
    filterRespo,
    TResult Function()? resetFilter,
    required TResult orElse(),
  }) {
    if (filterRespo != null) {
      return filterRespo(minPrice, maxPrice, stops, airlines, departureTimes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetTripList value) getTripList,
    required TResult Function(ChangeFare value) changeFare,
    required TResult Function(GetFlightinfo value) getFlightinfo,
    required TResult Function(FilterRespo value) filterRespo,
    required TResult Function(ResetFilter value) resetFilter,
  }) {
    return filterRespo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetTripList value)? getTripList,
    TResult? Function(ChangeFare value)? changeFare,
    TResult? Function(GetFlightinfo value)? getFlightinfo,
    TResult? Function(FilterRespo value)? filterRespo,
    TResult? Function(ResetFilter value)? resetFilter,
  }) {
    return filterRespo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetTripList value)? getTripList,
    TResult Function(ChangeFare value)? changeFare,
    TResult Function(GetFlightinfo value)? getFlightinfo,
    TResult Function(FilterRespo value)? filterRespo,
    TResult Function(ResetFilter value)? resetFilter,
    required TResult orElse(),
  }) {
    if (filterRespo != null) {
      return filterRespo(this);
    }
    return orElse();
  }
}

abstract class FilterRespo implements TripRequestEvent {
  const factory FilterRespo({
    final double? minPrice,
    final double? maxPrice,
    final List<int>? stops,
    final List<String>? airlines,
    final List<int>? departureTimes,
  }) = _$FilterRespoImpl;

  double? get minPrice;
  double? get maxPrice;
  List<int>? get stops;
  List<String>? get airlines;
  List<int>? get departureTimes;

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterRespoImplCopyWith<_$FilterRespoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResetFilterImplCopyWith<$Res> {
  factory _$$ResetFilterImplCopyWith(
    _$ResetFilterImpl value,
    $Res Function(_$ResetFilterImpl) then,
  ) = __$$ResetFilterImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetFilterImplCopyWithImpl<$Res>
    extends _$TripRequestEventCopyWithImpl<$Res, _$ResetFilterImpl>
    implements _$$ResetFilterImplCopyWith<$Res> {
  __$$ResetFilterImplCopyWithImpl(
    _$ResetFilterImpl _value,
    $Res Function(_$ResetFilterImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TripRequestEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetFilterImpl implements ResetFilter {
  const _$ResetFilterImpl();

  @override
  String toString() {
    return 'TripRequestEvent.resetFilter()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResetFilterImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(FlightSearchRequest flightRequestData)
    getTripList,
    required TResult Function(
      FlightFare selectedFare,
      FlightOptionElement selectedTrip,
    )
    changeFare,
    required TResult Function(Airport fromAirportinfo, Airport toAirportinfo)
    getFlightinfo,
    required TResult Function(
      double? minPrice,
      double? maxPrice,
      List<int>? stops,
      List<String>? airlines,
      List<int>? departureTimes,
    )
    filterRespo,
    required TResult Function() resetFilter,
  }) {
    return resetFilter();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(FlightSearchRequest flightRequestData)? getTripList,
    TResult? Function(
      FlightFare selectedFare,
      FlightOptionElement selectedTrip,
    )?
    changeFare,
    TResult? Function(Airport fromAirportinfo, Airport toAirportinfo)?
    getFlightinfo,
    TResult? Function(
      double? minPrice,
      double? maxPrice,
      List<int>? stops,
      List<String>? airlines,
      List<int>? departureTimes,
    )?
    filterRespo,
    TResult? Function()? resetFilter,
  }) {
    return resetFilter?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FlightSearchRequest flightRequestData)? getTripList,
    TResult Function(FlightFare selectedFare, FlightOptionElement selectedTrip)?
    changeFare,
    TResult Function(Airport fromAirportinfo, Airport toAirportinfo)?
    getFlightinfo,
    TResult Function(
      double? minPrice,
      double? maxPrice,
      List<int>? stops,
      List<String>? airlines,
      List<int>? departureTimes,
    )?
    filterRespo,
    TResult Function()? resetFilter,
    required TResult orElse(),
  }) {
    if (resetFilter != null) {
      return resetFilter();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetTripList value) getTripList,
    required TResult Function(ChangeFare value) changeFare,
    required TResult Function(GetFlightinfo value) getFlightinfo,
    required TResult Function(FilterRespo value) filterRespo,
    required TResult Function(ResetFilter value) resetFilter,
  }) {
    return resetFilter(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetTripList value)? getTripList,
    TResult? Function(ChangeFare value)? changeFare,
    TResult? Function(GetFlightinfo value)? getFlightinfo,
    TResult? Function(FilterRespo value)? filterRespo,
    TResult? Function(ResetFilter value)? resetFilter,
  }) {
    return resetFilter?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetTripList value)? getTripList,
    TResult Function(ChangeFare value)? changeFare,
    TResult Function(GetFlightinfo value)? getFlightinfo,
    TResult Function(FilterRespo value)? filterRespo,
    TResult Function(ResetFilter value)? resetFilter,
    required TResult orElse(),
  }) {
    if (resetFilter != null) {
      return resetFilter(this);
    }
    return orElse();
  }
}

abstract class ResetFilter implements TripRequestEvent {
  const factory ResetFilter() = _$ResetFilterImpl;
}

/// @nodoc
mixin _$TripRequestState {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  int get getdata => throw _privateConstructorUsedError;
  List<FlightOptionElement>? get respo => throw _privateConstructorUsedError;
  List<FlightOptionElement>? get allRespo => throw _privateConstructorUsedError;
  bool get isflightLoading => throw _privateConstructorUsedError;

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TripRequestStateCopyWith<TripRequestState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripRequestStateCopyWith<$Res> {
  factory $TripRequestStateCopyWith(
    TripRequestState value,
    $Res Function(TripRequestState) then,
  ) = _$TripRequestStateCopyWithImpl<$Res, TripRequestState>;
  @useResult
  $Res call({
    bool isLoading,
    String? token,
    int getdata,
    List<FlightOptionElement>? respo,
    List<FlightOptionElement>? allRespo,
    bool isflightLoading,
  });
}

/// @nodoc
class _$TripRequestStateCopyWithImpl<$Res, $Val extends TripRequestState>
    implements $TripRequestStateCopyWith<$Res> {
  _$TripRequestStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? token = freezed,
    Object? getdata = null,
    Object? respo = freezed,
    Object? allRespo = freezed,
    Object? isflightLoading = null,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            token: freezed == token
                ? _value.token
                : token // ignore: cast_nullable_to_non_nullable
                      as String?,
            getdata: null == getdata
                ? _value.getdata
                : getdata // ignore: cast_nullable_to_non_nullable
                      as int,
            respo: freezed == respo
                ? _value.respo
                : respo // ignore: cast_nullable_to_non_nullable
                      as List<FlightOptionElement>?,
            allRespo: freezed == allRespo
                ? _value.allRespo
                : allRespo // ignore: cast_nullable_to_non_nullable
                      as List<FlightOptionElement>?,
            isflightLoading: null == isflightLoading
                ? _value.isflightLoading
                : isflightLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TripRequestStateImplCopyWith<$Res>
    implements $TripRequestStateCopyWith<$Res> {
  factory _$$TripRequestStateImplCopyWith(
    _$TripRequestStateImpl value,
    $Res Function(_$TripRequestStateImpl) then,
  ) = __$$TripRequestStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    String? token,
    int getdata,
    List<FlightOptionElement>? respo,
    List<FlightOptionElement>? allRespo,
    bool isflightLoading,
  });
}

/// @nodoc
class __$$TripRequestStateImplCopyWithImpl<$Res>
    extends _$TripRequestStateCopyWithImpl<$Res, _$TripRequestStateImpl>
    implements _$$TripRequestStateImplCopyWith<$Res> {
  __$$TripRequestStateImplCopyWithImpl(
    _$TripRequestStateImpl _value,
    $Res Function(_$TripRequestStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? token = freezed,
    Object? getdata = null,
    Object? respo = freezed,
    Object? allRespo = freezed,
    Object? isflightLoading = null,
  }) {
    return _then(
      _$TripRequestStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        token: freezed == token
            ? _value.token
            : token // ignore: cast_nullable_to_non_nullable
                  as String?,
        getdata: null == getdata
            ? _value.getdata
            : getdata // ignore: cast_nullable_to_non_nullable
                  as int,
        respo: freezed == respo
            ? _value._respo
            : respo // ignore: cast_nullable_to_non_nullable
                  as List<FlightOptionElement>?,
        allRespo: freezed == allRespo
            ? _value._allRespo
            : allRespo // ignore: cast_nullable_to_non_nullable
                  as List<FlightOptionElement>?,
        isflightLoading: null == isflightLoading
            ? _value.isflightLoading
            : isflightLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$TripRequestStateImpl implements _TripRequestState {
  const _$TripRequestStateImpl({
    required this.isLoading,
    this.token,
    required this.getdata,
    final List<FlightOptionElement>? respo,
    final List<FlightOptionElement>? allRespo,
    required this.isflightLoading,
  }) : _respo = respo,
       _allRespo = allRespo;

  @override
  final bool isLoading;
  @override
  final String? token;
  @override
  final int getdata;
  final List<FlightOptionElement>? _respo;
  @override
  List<FlightOptionElement>? get respo {
    final value = _respo;
    if (value == null) return null;
    if (_respo is EqualUnmodifiableListView) return _respo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<FlightOptionElement>? _allRespo;
  @override
  List<FlightOptionElement>? get allRespo {
    final value = _allRespo;
    if (value == null) return null;
    if (_allRespo is EqualUnmodifiableListView) return _allRespo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool isflightLoading;

  @override
  String toString() {
    return 'TripRequestState(isLoading: $isLoading, token: $token, getdata: $getdata, respo: $respo, allRespo: $allRespo, isflightLoading: $isflightLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TripRequestStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.getdata, getdata) || other.getdata == getdata) &&
            const DeepCollectionEquality().equals(other._respo, _respo) &&
            const DeepCollectionEquality().equals(other._allRespo, _allRespo) &&
            (identical(other.isflightLoading, isflightLoading) ||
                other.isflightLoading == isflightLoading));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    token,
    getdata,
    const DeepCollectionEquality().hash(_respo),
    const DeepCollectionEquality().hash(_allRespo),
    isflightLoading,
  );

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TripRequestStateImplCopyWith<_$TripRequestStateImpl> get copyWith =>
      __$$TripRequestStateImplCopyWithImpl<_$TripRequestStateImpl>(
        this,
        _$identity,
      );
}

abstract class _TripRequestState implements TripRequestState {
  const factory _TripRequestState({
    required final bool isLoading,
    final String? token,
    required final int getdata,
    final List<FlightOptionElement>? respo,
    final List<FlightOptionElement>? allRespo,
    required final bool isflightLoading,
  }) = _$TripRequestStateImpl;

  @override
  bool get isLoading;
  @override
  String? get token;
  @override
  int get getdata;
  @override
  List<FlightOptionElement>? get respo;
  @override
  List<FlightOptionElement>? get allRespo;
  @override
  bool get isflightLoading;

  /// Create a copy of TripRequestState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TripRequestStateImplCopyWith<_$TripRequestStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
