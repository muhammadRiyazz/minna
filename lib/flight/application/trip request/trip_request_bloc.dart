import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:minna/flight/domain/airport/airport.dart';
import 'package:minna/flight/domain/trip%20resp/trip_respo.dart';
import 'package:minna/flight/domain/triplist%20request/search_request.dart';
import 'package:minna/flight/infrastracture/city%20sugg/city_list.dart';
import 'package:minna/flight/infrastracture/get%20flight%20info/flight_info.dart';
import 'package:minna/flight/infrastracture/trip%20request/trip_request.dart';
part 'trip_request_event.dart';
part 'trip_request_state.dart';
part 'trip_request_bloc.freezed.dart';


class TripRequestBloc extends Bloc<TripRequestEvent, TripRequestState> {
  TripRequestBloc() : super(TripRequestState.initial()) {
    on<GetTripList>((event, emit) async {
      emit(state.copyWith(isLoading: true, getdata: 0));

      try {
        final FlightResponse respo = await flightTripListRequest(
          event.flightRequestData,
        );

        List<FlightOptionElement> flightList = respo.journy!.flightOptions!;

        List<FlightOptionElement> processedFlightList = [];

        for (var option in flightList) {
          List<FlightLeg> onwardLegs = [];
          List<FlightLeg> returnLegs = [];

          for (var leg in option.flightLegs ?? []) {
            if (leg.type == '0') {
              onwardLegs.add(leg);
            } else if (leg.type == '1') {
              returnLegs.add(leg);
            }
          }

          processedFlightList.add(
            option.copyWith(
              selectedFare: option.flightFares?[0],
              flightLegs: [...?option.flightLegs],
              onwardLegs: onwardLegs,
              returnLegs: returnLegs,
            ),
          );
        }

        emit(
          state.copyWith(
            token: respo.token,
            isLoading: false,
            respo: processedFlightList,
            getdata: 1,
          ),
        );
      } catch (e) {
        log('GetTripList error: $e');
        emit(state.copyWith(isLoading: false, getdata: -1));
      }
    });

    on<ChangeFare>((event, emit) async {
      try {
        final updatedData = state.respo?.map((element) {
          if (element == event.selectedTrip) {
            return element.copyWith(selectedFare: event.selectedFare);
          }
          return element;
        }).toList();

        emit(state.copyWith(isLoading: false, respo: updatedData));
      } catch (e) {
        log('ChangeFare error: $e');
      }
    });

    on<GetFlightinfo>((event, emit) async {
      emit(state.copyWith(isflightLoading: true, getdata: 0));

      final flightInfoCache = <String, FlightInfo>{};
      final airportInfoFutures = <String, Future<Airport?>>{};
      final flightInfoFutures = <String, Future<FlightInfo?>>{};

      try {
        final from = event.fromAirportinfo;
        final to = event.toAirportinfo;

        final updatedList = await Future.wait(
          state.respo!.map((trip) async {
            final tripCode = trip.ticketingCarrier ?? '';
            final tripFlightInfo = await _fetchCachedFlightInfo(
              tripCode,
              flightInfoCache,
              flightInfoFutures,
            );

            final allLegs = <FlightLeg>{
              ...?trip.flightLegs,
              ...?trip.onwardLegs,
              ...?trip.returnLegs,
            }.toList();

            final updatedLegsMap = <String, FlightLeg>{};

            await Future.wait(
              allLegs.map((leg) async {
                final legCode = leg.airlineCode ?? '';
                final legFlightInfo = (legCode == tripCode)
                    ? tripFlightInfo
                    : await _fetchCachedFlightInfo(
                        legCode,
                        flightInfoCache,
                        flightInfoFutures,
                      );

                final updatedOrigin =
                    leg.originName ??
                    (await _fetchCachedAirportInfo(
                      leg.origin ?? '',
                      airportInfoFutures,
                    ))?.name;
                final updatedDest =
                    leg.destinationName ??
                    (await _fetchCachedAirportInfo(
                      leg.destination ?? '',
                      airportInfoFutures,
                    ))?.name;

                final updatedLeg = leg.copyWith(
                  originName:
                      _matchAirportName(leg.origin, from, to, isOrigin: true) ??
                      updatedOrigin,
                  destinationName:
                      _matchAirportName(
                        leg.destination,
                        from,
                        to,
                        isOrigin: false,
                      ) ??
                      updatedDest,
                  flightName: legFlightInfo?.name,
                  flightimg: legFlightInfo?.img,
                );

                updatedLegsMap[_getLegKey(leg)] = updatedLeg;
              }),
            );

            List<FlightLeg> getUpdatedLegs(List<FlightLeg>? legs) {
              return legs
                      ?.map((leg) => updatedLegsMap[_getLegKey(leg)] ?? leg)
                      .toList() ??
                  [];
            }

            return trip.copyWith(
              flightName: tripFlightInfo?.name,
              flightimg: tripFlightInfo?.img,
              flightLegs: getUpdatedLegs(trip.flightLegs),
              onwardLegs: getUpdatedLegs(trip.onwardLegs),
              returnLegs: getUpdatedLegs(trip.returnLegs),
            );
          }),
        );

        emit(state.copyWith(isflightLoading: false, respo: updatedList));
      } catch (e) {
        log('GetFlightinfo error: $e');
        emit(state.copyWith(isflightLoading: false));
      }
    });
  }

  /// Global airport cache (only created once per Bloc instance)
  final Map<String, Airport?> _airportCache = {};

  Future<Airport?> _fetchCachedAirportInfo(
    String code,
    Map<String, Future<Airport?>> futuresMap,
  ) {
    if (code.isEmpty) return Future.value(null);
    if (_airportCache.containsKey(code)) {
      return Future.value(_airportCache[code]);
    }
    if (futuresMap.containsKey(code)) return futuresMap[code]!;

    final future = AirportService.searchAirports(code)
        .then((airports) {
          final result = airports.isNotEmpty ? airports.first : null;
          _airportCache[code] = result;
          return result;
        })
        .catchError((e) {
          log('Airport fetch error: $e');
          return null;
        });

    futuresMap[code] = future;
    return future;
  }

  Future<FlightInfo?> _fetchCachedFlightInfo(
    String code,
    Map<String, FlightInfo> cache,
    Map<String, Future<FlightInfo?>> futuresMap,
  ) {
    if (cache.containsKey(code)) return Future.value(cache[code]);
    if (futuresMap.containsKey(code)) return futuresMap[code]!;

    final future = fetchFlightInfo(code).then((info) {
      if (info != null) cache[code] = info;
      return info;
    });

    futuresMap[code] = future;
    return future;
  }

  String _getLegKey(FlightLeg leg) {
    return '${leg.origin}-${leg.destination}-${leg.departureTime}-${leg.airlineCode}';
  }

  String? _matchAirportName(
    String? code,
    dynamic from,
    dynamic to, {
    required bool isOrigin,
  }) {
    if (code == null) return null;
    if (isOrigin && code == from.code) return from.name;
    if (!isOrigin && code == to.code) return to.name;
    if (isOrigin && code == to.code) return to.name;
    if (!isOrigin && code == from.code) return from.name;
    return null;
  }
}
