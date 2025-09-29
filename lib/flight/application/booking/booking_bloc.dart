import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:minna/flight/domain/booking%20request%20/booking_request.dart';
import 'package:minna/flight/domain/fare%20request%20and%20respo/fare_respo.dart';
import 'package:minna/flight/domain/reprice%20/re_price.dart';
import 'package:minna/flight/domain/reprice%20/reprice_respo.dart';
import 'package:minna/flight/infrastracture/booking%20confirm/booking.dart';
import 'package:minna/flight/infrastracture/reprice/call_reprice_api.dart';

part 'booking_event.dart';
part 'booking_state.dart';
part 'booking_bloc.freezed.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingState.initial()) {
    on<_GetRePrice>(_onGetRePrice);
    on<ConfirmBooking>(_onConfirmBooking);
    on<ResetBooking>(_onResetBooking);
  }

  Future<void> _onGetRePrice(
    _GetRePrice event,
    Emitter<BookingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, bookingError: null));

    try {
      final List<Map<String, dynamic>> passengerDataList =
          event.passengerDataList;

      final List<RePassenger> passengers = passengerDataList.map((
        passengerData,
      ) {
        final mealInfoList = <ReMealInfo>[];
        final baggageInfoList = <ReBaggageInfo>[];
        final seatInfoList = <ReSeatInfo>[];

        // Handle meal data
        final mealData = passengerData['meal'];
        if (mealData != null && mealData is Map) {
          mealInfoList.add(
            ReMealInfo(
              meals: [
                ReMeal(
                  code: mealData['code'],
                  name: mealData['name'],
                  amount: (mealData['amount'] as num).toDouble(),
                  currency: mealData['currency'],
                  legKey: mealData['legKey'],
                ),
              ],
            ),
          );
        }

        // Handle baggage data
        final baggageData = passengerData['baggage'];
        if (baggageData != null && baggageData is Map) {
          baggageInfoList.add(
            ReBaggageInfo(
              baggages: [
                ReBaggage(
                  code: baggageData['code'],
                  name: baggageData['name'],
                  amount: (baggageData['amount'] as num).toDouble(),
                  currency: baggageData['currency'],
                  legKey: baggageData['legKey'],
                ),
              ],
            ),
          );
        }

        return RePassenger(
          frequentFlyerNo: '',
          ticketNo: '',
          ticketNoReturn: '',
          paxNo: passengerData['paxNo'] ?? '',
          paxKey: passengerData['paxKey'] ?? '',
          paxType: passengerData['passengerType'] ?? '',
          title: passengerData['title'] ?? '',
          firstName: passengerData['firstName']?? '',
          countryCode: passengerData['CountryCode']??"0091",
          lastName: passengerData['lastName'] ?? '',
          dob: formatDateForApi(passengerData['dob']),
          contact: passengerData['contact'] ?? '',
          email: passengerData['email'] ?? '',
          address: passengerData['address'] ?? '',
          nationality: passengerData['nationality'] ?? '',
          passportNo: passengerData['passportNumber'],
          countryOfIssue: passengerData['countryOfIssue'],
          dateOfExpiry: formatDateForApi(passengerData['passportExpiry']),
          pinCode: passengerData['pincode'],
          ssrAvailability: ReSsrAvailability(
            mealInfo: mealInfoList,
            baggageInfo: baggageInfoList,
            seatInfo: seatInfoList,
          ),
        );
      }).toList();

      if (event.reprice) {
        log('Reprice call initiated');
        final FFlightOption fareRequestData = event.fareReData;

        final List<PFlightLeg> flightLegs =
            fareRequestData.flightLegs?.map((element) {
              return PFlightLeg(
                type: element.type ?? '',
                key: element.key ?? '',
                origin: element.origin ?? '',
                destination: element.destination ?? '',
                departureTime: element.departureTime ?? '',
                arrivalTime: element.arrivalTime ?? '',
                flightNo: element.flightNo ?? '',
                airlineCode: element.airlineCode ?? '',
              );
            }).toList() ??
            [];

        final List<Passenger> passengerss = passengerDataList.map((
          passengerData,
        ) {
          final mealInfoList = <PMealInfo>[];
          final baggageInfoList = <PBaggageInfo>[];
          final seatInfoList = <PSeatInfo>[];

          if (passengerData['meal'] != null && passengerData['meal'] is Map) {
            mealInfoList.add(
              PMealInfo(
                meals: [
                  PMeal(
                    code: passengerData['meal']['code'],
                    name: passengerData['meal']['name'],
                    amount: passengerData['meal']['amount'].toDouble(),
                    currency: passengerData['meal']['currency'],
                    legKey: passengerData['meal']['legKey'],
                  ),
                ],
              ),
            );
          }

          if (passengerData['baggage'] != null &&
              passengerData['baggage'] is Map) {
            baggageInfoList.add(
              PBaggageInfo(
                baggages: [
                  PBaggage(
                    code: passengerData['baggage']['code'],
                    name: passengerData['baggage']['name'],
                    amount: (passengerData['baggage']['amount'] as num)
                        .toDouble(),
                    currency: passengerData['baggage']['currency'],
                    legKey: passengerData['baggage']['legKey'],
                  ),
                ],
              ),
            );
          }

          return Passenger(
            paxType: passengerData['passengerType'] ?? '',
            title: passengerData['title'] ?? '',
            firstName: passengerData['firstName'] ?? '',
            lastName: passengerData['lastName'] ?? '',
            dob: formatDateForApi(passengerData['dob']),
            contact: passengerData['contact'] ?? '',
            email: passengerData['email'] ?? '',
            nationality: passengerData['nationality'] ?? '',
            ssrAvailability: PSSRAvailability(
              mealInfo: mealInfoList,
              baggageInfo: baggageInfoList,
              seatInfo: seatInfoList,
            ),
          );
        }).toList();

        final RepriceRequest rePrice = RepriceRequest(
          token: event.token,
          userId: 'INCCJ029000000',
          tripMode: event.tripMode,
          journy: Journey(
            flightOptions: [],
            flightOption: RFlightOption(
              key: fareRequestData.key ?? '',
              ticketingCarrier: fareRequestData.ticketingCarrier ?? '',
              apiType: fareRequestData.apiType ?? '',
              seatEnabled: false,
              reprice: fareRequestData.reprice ?? false,
              ffNoEnabled: fareRequestData.ffNoEnabled ?? false,
              availableSeat: fareRequestData.availableSeat ?? 0,
              flightFares: fareRequestData.flightFares ?? [],
              flightLegs: flightLegs,
            ),
            hostTokens: [],
            errors: [],
          ),
          passengers: passengerss,
        );

        log('Reprice request payload: ${rePrice.toJson()}');

        final RePriceResponse respo = await repriceRequestApi(rePrice);

        List<BBFlightLeg> bbflightLegs = [];
        List<BBFlightFare> bbflightFares = [];

        final rflightLegs = respo.journy?.flightOption?.flightLegs;
        if (rflightLegs != null) {
          for (var element in rflightLegs) {
            bbflightLegs.add(
              BBFlightLeg(
                type: element.type ?? '',
                key: element.key ?? '',
                origin: element.origin ?? '',
                destination: element.destination ?? '',
                departureTime: element.departureTime ?? '',
                arrivalTime: element.arrivalTime ?? '',
                flightNo: element.flightNo ?? '',
                airlineCode: element.airlineCode ?? '',
                distance: element.distance ?? 0,
                freeBaggages: element.freeBaggages ?? [],
              ),
            );
          }
        }

        final flightFares = respo.journy?.flightOption?.flightFares;
        if (flightFares != null) {
          for (var element in flightFares) {
            bbflightFares.add(
              BBFlightFare(
                fares: element.fares ?? [],
                fid: element.fid ?? '',
                fareKey: element.fareKey ?? "",
                aprxTotalBaseFare:
                    (element.aprxTotalBaseFare as num?)?.toDouble() ?? 0.0,
                aprxTotalTax: (element.aprxTotalTax as num?)?.toDouble() ?? 0.0,
                totalDiscount:
                    (element.totalDiscount as num?)?.toDouble() ?? 0.0,
                aprxTotalAmount:
                    (element.aprxTotalAmount as num?)?.toDouble() ?? 0.0,
                totalAmount: (element.totalAmount as num?)?.toDouble() ?? 0.0,
              ),
            );
          }
        }

        final BBBookingRequest bookingRequestData = BBBookingRequest(
          journey: BBJourney(
            flightOptions: [],
            flightOption: BBFlightOption(
              key: respo.journy?.flightOption?.key ?? '',
              ticketingCarrier:
                  respo.journy?.flightOption?.ticketingCarrier ?? '',
              apiType: respo.journy?.flightOption?.apiType ?? '',
              seatEnabled: false,
              reprice: respo.journy?.flightOption?.reprice ?? false,
              ffNoEnabled: respo.journy?.flightOption?.ffNoEnabled ?? false,
              availableSeat: respo.journy?.flightOption?.availableSeat ?? 0,
              flightFares: bbflightFares,
              flightLegs: bbflightLegs,
            ),
            hostTokens: [],
            errors: [],
          ),
          errors: null,
          token: event.token,
          userId: 'INCCJ029000000',
          tripMode: event.tripMode,
          passengers: passengers,
        );

        log('Booking request created with reprice data');

        emit(
          state.copyWith(
            isLoading: false,
            bookingdata: bookingRequestData,
            bookingError: null,
          ),
        );
      } else {
        log('No reprice needed, creating booking directly');

        final FFlightOption fFlightOption = event.fareReData;

        List<BBFlightLeg> bbflightLegs = [];
        List<BBFlightFare> bbflightFares = [];

        for (var element in fFlightOption.flightLegs!) {
          bbflightLegs.add(
            BBFlightLeg(
              type: element.type ?? '',
              key: element.key ?? '',
              origin: element.origin ?? '',
              destination: element.destination ?? '',
              departureTime: element.departureTime ?? '',
              arrivalTime: element.arrivalTime ?? '',
              flightNo: element.flightNo ?? '',
              airlineCode: element.airlineCode ?? '',
              distance: element.distance ?? 0,
              freeBaggages: element.freeBaggages ?? [],
            ),
          );
        }

        for (var element in fFlightOption.flightFares!) {
          bbflightFares.add(
            BBFlightFare(
              fares: element.fares ?? [],
              fid: element.fid ?? '',
              fareKey: element.fareKey ?? "",
              aprxTotalBaseFare:
                  (element.aprxTotalBaseFare as num?)?.toDouble() ?? 0.0,
              aprxTotalTax: (element.aprxTotalTax as num?)?.toDouble() ?? 0.0,
              totalDiscount: (element.totalDiscount as num?)?.toDouble() ?? 0.0,
              aprxTotalAmount:
                  (element.aprxTotalAmount as num?)?.toDouble() ?? 0.0,
              totalAmount: (element.totalAmount as num?)?.toDouble() ?? 0.0,
            ),
          );
        }

        final BBBookingRequest bookingRequestData = BBBookingRequest(
          journey: BBJourney(
            flightOptions: [],
            flightOption: BBFlightOption(
              key: fFlightOption.key ?? '',
              ticketingCarrier: fFlightOption.ticketingCarrier ?? '',
              apiType: fFlightOption.apiType ?? '',
              availableSeat: fFlightOption.availableSeat ?? 0,
              flightFares: bbflightFares,
              flightLegs: bbflightLegs,
              seatEnabled: false,
              reprice: fFlightOption.reprice ?? false,
              ffNoEnabled: fFlightOption.ffNoEnabled ?? false,
            ),
            hostTokens: [],
            errors: [],
          ),
          errors: null,
          token: event.token,
          userId: 'INCCJ029000000',
          tripMode: event.tripMode,
          passengers: passengers,
        );

        emit(
          state.copyWith(
            isLoading: false,
            bookingdata: bookingRequestData,
            bookingError: null,
          ),
        );
      }
    } catch (e) {
      log('Booking error: ${e.toString()}');
      emit(
        state.copyWith(
          isLoading: false,
          bookingError: 'Failed to process booking: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _onConfirmBooking(
    ConfirmBooking event,
    Emitter<BookingState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        bookingError: null,
        isBookingConfirmed: false,
        alhindPnr: null,
      ),
    );

    try {
      final response = await bookingConfirmApi(state.bookingdata!);
      final Map<String, dynamic> respo = jsonDecode(response.body);

      if (respo.containsKey('Errors') && respo['Errors'] != null) {
        final errorMessage =
            respo['Errors'][0]['ErrorMessage'] ??
            'Booking failed. Please try again.';
        emit(
          state.copyWith(
            isLoading: false,
            bookingError: errorMessage,
            isBookingConfirmed: false,
          ),
        );
      } else if (respo.containsKey('AlhindPnr')) {
        final alhindPnr = respo['AlhindPnr'];
        emit(
          state.copyWith(
            isLoading: false,
            isBookingConfirmed: true,
            alhindPnr: alhindPnr,
            bookingError: null,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            bookingError: 'Unexpected response from server',
            isBookingConfirmed: false,
          ),
        );
      }
    } catch (e) {
      log('Error in ConfirmBooking: ${e.toString()}');
      emit(
        state.copyWith(
          isLoading: false,
          bookingError: 'Error confirming booking: ${e.toString()}',
          isBookingConfirmed: false,
        ),
      );
    }
  }

  void _onResetBooking(ResetBooking event, Emitter<BookingState> emit) {
    emit(BookingState.initial());
  }

  String formatDateForApi(String? dateString) {
    if (dateString == null || dateString.isEmpty) return '0001-01-01';
    
    try {
      // Try to parse as yyyy-MM-dd (the format from your form)
      final parsedDate = DateFormat('yyyy-MM-dd').parse(dateString);
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    } catch (e) {
      try {
        // If that fails, try to parse as dd-MM-yyyy (fallback)
        final parsedDate = DateFormat('dd-MM-yyyy').parse(dateString);
        return DateFormat('yyyy-MM-dd').format(parsedDate);
      } catch (e) {
        return '0001-01-01'; // fallback if parsing fails
      }
    }
  }
}