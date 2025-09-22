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
     List<AvailableTrip> totalTripList = [];
    on<FetchTrip>((event, emit) async {
      // Set loading state
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

        // Case 1: No trips available (specific empty response)
        if (resp.body ==
            '{"agentMappedToCp":"false","agentMappedToEarning":"false"}') {
          emit(state.copyWith(isLoading: false, notripp: true));
          return;
        }

        // Case 2: Authorization error
        if (resp.body ==
            'Error: Authorization failed please send valid consumer key and secret in the api request.') {
          emit(state.copyWith(isLoading: false, isError: true));
          return;
        }

        // Case 3: Successful response with trips
        if (resp.statusCode == 200) {
          try {
            final List<AvailableTrip> availableTriplist =
                busLogFromJson(resp.body).availableTrips
                  ..sort((a, b) => a.departureTime.compareTo(b.departureTime));

            totalTripList =
                availableTriplist; // Update the master list for filtering

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

        // Case 4: Other error responses
        emit(state.copyWith(isLoading: false, isError: true));
      } catch (e) {
        log('Unexpected error: $e');
        emit(state.copyWith(isLoading: false, isError: true));
      }
    });

    on<FilterConform>((event, emit) {
      emit(BusListFetchState(isLoading: true, isError: false));

      List<AvailableTrip> filterTripp = [];

      List<AvailableTrip> useList = filterTripp.isEmpty
          ? totalTripList
          : filterTripp;

      if (event.sleeper) {
        filterTripp = useList.where((trip) => trip.sleeper == 'true').toList();
      }

      if (event.seater) {
        filterTripp = useList.where((trip) => trip.seater == 'true').toList();
      }

      if (event.ac) {
        filterTripp = useList.where((trip) => trip.ac == 'true').toList();
      }

      if (event.nonAC) {
        filterTripp = useList.where((trip) => trip.nonAc == 'true').toList();
      }

      if (event.departureCase1) {
        filterTripp = useList
            .where((trip) => case1(time: trip.departureTime))
            .toList();
      }

      if (event.departureCase2) {
        filterTripp = useList
            .where((trip) => case2(time: trip.departureTime))
            .toList();
      }

      if (event.departureCase3) {
        filterTripp = useList
            .where((trip) => case3(time: trip.departureTime))
            .toList();
      }

      if (event.departureCase4) {
        filterTripp = useList
            .where((trip) => case4(time: trip.departureTime))
            .toList();
      }

      if (event.arrivalCase1) {
        filterTripp = useList
            .where((trip) => case1(time: trip.arrivalTime))
            .toList();
      }

      if (event.arrivalCase2) {
        filterTripp = useList
            .where((trip) => case2(time: trip.arrivalTime))
            .toList();
      }

      if (event.arrivalCase3) {
        filterTripp = useList
            .where((trip) => case3(time: trip.arrivalTime))
            .toList();
      }

      if (event.arrivalCase4) {
        filterTripp = useList
            .where((trip) => case4(time: trip.arrivalTime))
            .toList();
      }

      if (!event.ac &&
          !event.nonAC &&
          !event.seater &&
          !event.sleeper &&
          !event.departureCase1 &&
          !event.departureCase2 &&
          !event.departureCase3 &&
          !event.departureCase4 &&
          !event.arrivalCase1 &&
          !event.arrivalCase2 &&
          !event.arrivalCase3 &&
          !event.arrivalCase4) {
        log('message');
        emit(
          BusListFetchState(
            isLoading: false,
            isError: false,
            notripp: false,
            availableTrips: totalTripList,
          ),
        );
      } else {
        emit(
          BusListFetchState(
            isLoading: false,
            isError: false,
            notripp: false,
            availableTrips: filterTripp,
          ),
        );
      }

      log(filterTripp.length.toString());
    });
  }
}
bool case1({required String time}) {
  final currentHour = changetimeFilter(time: time);

  if (currentHour < 6) {
    return true;
  } else {
    return false;
  }
}

bool case2({required String time}) {
  final currentHour = changetimeFilter(time: time);

  if (currentHour >= 6 && currentHour < 12) {
    return true;
  } else {
    return false;
  }
}

bool case3({required String time}) {
  final currentHour = changetimeFilter(time: time);

  if (currentHour >= 12 && currentHour < 18) {
    return true;
  } else {
    return false;
  }
}

bool case4({required String time}) {
  final currentHour = changetimeFilter(time: time);

  if (currentHour >= 18) {
    return true;
  } else {
    return false;
  }
}

int changetimeFilter({required String time}) {
  final double count = int.parse(time) / 60;
  int decimalPart = ((count - count.floor()) * 100).toInt();

  final hour = count.toInt() % 24;

  return hour;
}
