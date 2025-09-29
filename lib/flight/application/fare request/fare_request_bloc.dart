import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:minna/flight/domain/fare%20request%20and%20respo/fare_request.dart';
import 'package:minna/flight/domain/fare%20request%20and%20respo/fare_respo.dart';
import 'package:minna/flight/domain/trip%20resp/trip_respo.dart';
import 'package:minna/flight/infrastracture/fare%20request/fare_request.dart';

part 'fare_request_event.dart';
part 'fare_request_state.dart';
part 'fare_request_bloc.freezed.dart';

class FareRequestBloc extends Bloc<FareRequestEvent, FareRequestState> {
  FareRequestBloc() : super(FareRequestState.initial()) {
   on<GetFareRequestApi>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      try {
        final FlightOptionElement tripinfo = event.flightTrip;

        // Convert flight legs
        final List<RFlightLeg> flightLegs =
            tripinfo.flightLegs?.map((element) {
              return RFlightLeg(
                type: element.type ?? '',
                key: element.key ?? '',
                origin: element.origin ?? '',
                destination: element.destination ?? '',
                departureTime: element.departureTime ?? '',
                arrivalTime: element.arrivalTime ?? '',
                flightNo: element.flightNo ?? '',
                airlineCode: element.airlineCode ?? '',
                distance: element.distance ?? 0.0,
              );
            }).toList() ??
            [];

        // Prepare fares
        final List<FlightFare> flightfare = [];
        if (tripinfo.selectedFare != null) {
          flightfare.add(tripinfo.selectedFare!);
        }

        // Create journey
        final journey = Journy(
          flightOptions: [],
          flightOption: FlightOption(
            key: tripinfo.key ?? '',
            ticketingCarrier: tripinfo.ticketingCarrier ?? '',
            apiType: tripinfo.apiType ?? '',
            providerCode: tripinfo.providerCode ?? '',
            availableSeat: tripinfo.availableSeat ?? 0,
            flightFares: flightfare,
            flightLegs: flightLegs,
                        seatEnabled: false,

            // seatEnabled: tripinfo.seatEnabled ?? false,
            reprice: tripinfo.reprice ?? false,
            ffNoEnabled: tripinfo.ffNoEnabled ?? false,
          ),
          hostTokens: [],
          errors: [],
        );

        // Create fare request
        final fareRequest = FareRequest(
          userId: 'INCCJ029000000',
          token: event.token,
          tripMode: event.tripMode,
          error: null,
          journy: journey,
        );
        
// Call API
        FFlightResponse respo = await flightFareRequestApi(fareRequest);

        // First update all legs with additional details
        final updatedLegs = respo.journey?.flightOption?.flightLegs?.map((
          felement,
        ) {
          // Find matching leg from tripinfo
          final matchingLeg = tripinfo.flightLegs?.firstWhere(
            (element) =>
                felement.airlineCode == element.airlineCode &&
                felement.flightNo == element.flightNo &&
                felement.departureTime == element.departureTime,
            orElse: () => FlightLeg(), // Return empty if not found
          );

          return felement.copyWith(
            flightimg: matchingLeg?.flightimg ?? felement.flightimg,
            flightName: matchingLeg?.flightName ?? felement.flightName,
            originName: matchingLeg?.originName ?? felement.originName,
            destinationName:
                matchingLeg?.destinationName ?? felement.destinationName,
          );
        }).toList();

        // Now separate into onward and return legs after updating
        List<FFlightLeg> onwardLegs = [];
        List<FFlightLeg> returnLegs = [];

        for (var leg in updatedLegs ?? []) {
          if (leg.type == '0') {
            onwardLegs.add(leg);
          } else if (leg.type == '1') {
            returnLegs.add(leg);
          }
        }

        // Create a new flight option with updated fields
        final updatedFlightOption = respo.journey?.flightOption?.copyWith(
          flightName: tripinfo.flightName,
          flightimg: tripinfo.flightimg,
          flightLegs: updatedLegs,
          flightOnwardLegs: onwardLegs,
          flightRetunLegs: returnLegs,
        );

        // Create a new journey with updated flight option
        final updatedJourney = respo.journey?.copyWith(
          flightOption: updatedFlightOption,
        );

        // Create a new response with the updated journey
        respo = respo.copyWith(journey: updatedJourney);

        // ✅ Log the final JSON
        log(jsonEncode(respo.journey?.flightOption?.toJson()));

        emit(state.copyWith(respo: respo, isLoading: false));
      } catch (e, stack) {
        log('❌ Error while building fare request: $e\n$stack');
        emit(state.copyWith(isLoading: true));
      }
    });
  }
}
