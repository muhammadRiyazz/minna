import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:minna/bus/application/busListfetch/bus_list_fetch_state.dart';
import 'package:minna/bus/domain/location/location_modal.dart';
import 'package:minna/bus/domain/trips%20list%20modal/trip_list_modal.dart';
import 'package:minna/bus/infrastructure/fetch%20tripslist/fetch_triplist.dart';

part 'bus_list_fetch_event.dart';
part 'bus_list_fetch_bloc.freezed.dart';

class BusListFetchBloc extends Bloc<BusListFetchEvent, BusListFetchState> {
  BusListFetchBloc() : super(BusListFetchState.initial()) {
    List<AvailableTrip> _totalTripList = [];
    
    on<FetchTrip>((event, emit) async {
      emit(
        state.copyWith(
          isLoading: true,
          isError: false,
          notripp: false,
          availableTrips: [],
        ),
      );

      try {
        final Response resp = await BusAvailability.getDataAvailabilityBus(
          dateOfJourney: DateFormat('yyyy-MM-dd').format(event.dateOfjurny),
          desti: event.destID.id,
          source: event.sourceID.id,
        );

        log('API Response: ${resp.statusCode} - ${resp.body}');

        if (resp.body ==
            '{"agentMappedToCp":"false","agentMappedToEarning":"false"}') {
          emit(state.copyWith(isLoading: false, notripp: true));
          return;
        }

        if (resp.body ==
            'Error: Authorization failed please send valid consumer key and secret in the api request.') {
          emit(state.copyWith(isLoading: false, isError: true));
          return;
        }

        if (resp.statusCode == 200) {
          try {
            final List<AvailableTrip> availableTriplist =
                busLogFromJson(resp.body).availableTrips
                  ..sort((a, b) => a.departureTime.compareTo(b.departureTime));

            _totalTripList = availableTriplist;

            emit(
              state.copyWith(
                isLoading: false,
                availableTrips: availableTriplist,
                notripp: availableTriplist.isEmpty,
              ),
            );
          } catch (e) {
            log('Error parsing response: $e');
            emit(state.copyWith(isLoading: false, isError: true));
          }
          return;
        }

        emit(state.copyWith(isLoading: false, isError: true));
      } catch (e) {
        log('Unexpected error: $e');
        emit(state.copyWith(isLoading: false, isError: true));
      }
    });

    on<FilterConform>((event, emit) {
      emit(state.copyWith(isLoading: true, isError: false));

      List<AvailableTrip> filteredTrips = _totalTripList;

      // Apply bus type filters
      if (event.sleeper || event.seater || event.ac || event.nonAC) {
        filteredTrips = filteredTrips.where((trip) {
          if (event.sleeper && trip.sleeper == 'true') return true;
          if (event.seater && trip.seater == 'true') return true;
          if (event.ac && trip.ac == 'true') return true;
          if (event.nonAC && trip.nonAc == 'true') return true;
          return false;
        }).toList();
      }

      // Apply departure time filters
      if (event.departureCase1 || event.departureCase2 || event.departureCase3 || event.departureCase4) {
        filteredTrips = filteredTrips.where((trip) {
          if (event.departureCase1 && _isBefore6AM(trip.departureTime)) return true;
          if (event.departureCase2 && _is6AMTo12PM(trip.departureTime)) return true;
          if (event.departureCase3 && _is12PMTo6PM(trip.departureTime)) return true;
          if (event.departureCase4 && _isAfter6PM(trip.departureTime)) return true;
          return false;
        }).toList();
      }

      // Apply arrival time filters
      if (event.arrivalCase1 || event.arrivalCase2 || event.arrivalCase3 || event.arrivalCase4) {
        filteredTrips = filteredTrips.where((trip) {
          if (event.arrivalCase1 && _isBefore6AM(trip.arrivalTime)) return true;
          if (event.arrivalCase2 && _is6AMTo12PM(trip.arrivalTime)) return true;
          if (event.arrivalCase3 && _is12PMTo6PM(trip.arrivalTime)) return true;
          if (event.arrivalCase4 && _isAfter6PM(trip.arrivalTime)) return true;
          return false;
        }).toList();
      }

      // If no filters are selected, show all trips
      final bool noFiltersSelected = !event.sleeper &&
          !event.seater &&
          !event.ac &&
          !event.nonAC &&
          !event.departureCase1 &&
          !event.departureCase2 &&
          !event.departureCase3 &&
          !event.departureCase4 &&
          !event.arrivalCase1 &&
          !event.arrivalCase2 &&
          !event.arrivalCase3 &&
          !event.arrivalCase4;

      if (noFiltersSelected) {
        filteredTrips = _totalTripList;
      }

      log('Filtered trips: ${filteredTrips.length}');

      emit(
        state.copyWith(
          isLoading: false,
          isError: false,
          notripp: filteredTrips.isEmpty,
          availableTrips: filteredTrips,
        ),
      );
    });

    on<SelectTrip>((event, emit) {
      emit(state.copyWith(selectTrip: event.trip));
    });
  }

  bool _isBefore6AM(String time) {
    final hour = _getHourFromTime(time);
    return hour < 6;
  }

  bool _is6AMTo12PM(String time) {
    final hour = _getHourFromTime(time);
    return hour >= 6 && hour < 12;
  }

  bool _is12PMTo6PM(String time) {
    final hour = _getHourFromTime(time);
    return hour >= 12 && hour < 18;
  }

  bool _isAfter6PM(String time) {
    final hour = _getHourFromTime(time);
    return hour >= 18;
  }

  int _getHourFromTime(String time) {
    try {
      final timeInt = int.parse(time);
      final hours = (timeInt / 60).floor();
      return hours % 24;
    } catch (e) {
      return 0;
    }
  }
}