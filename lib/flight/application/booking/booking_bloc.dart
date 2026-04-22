// flight_booking_bloc.dart
import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:minna/flight/domain/booking%20request%20/booking_request.dart';
import 'package:minna/flight/domain/fare%20request%20and%20respo/fare_respo.dart';
import 'package:minna/flight/domain/reprice%20/re_price.dart';
import 'package:minna/flight/domain/reprice%20/reprice_respo.dart';
import 'package:minna/flight/infrastracture/commission/commission_service.dart';
import 'package:minna/flight/infrastracture/reprice/call_reprice_api.dart';
import 'package:minna/comman/core/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'booking_event.dart';
part 'booking_state.dart';
part 'booking_bloc.freezed.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingState.initial()) {
    on<_GetRePrice>(_onGetRePrice);

    on<_VerifyFlightPayment>(_onVerifyPayment);

    on<_ResetBooking>(_onResetBooking);
  }

  Future<void> _onGetRePrice(
    _GetRePrice event,
    Emitter<BookingState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        isRepriceLoading: true,
        isRepriceCompleted: false,
        bookingError: null,
      ),
    );

    try {
      final commissionService = FlightCommissionService();
      double totalCommission = 0.0;
      double totalAmountWithCommission = 0.0;
      final List<Map<String, dynamic>> passengerDataList =
          event.passengerDataList;

      // Helper function to safely convert amount to double
      double safeToDouble(dynamic value) {
        if (value == null) return 0.0;
        if (value is double) return value;
        if (value is int) return value.toDouble();
        if (value is String) return double.tryParse(value) ?? 0.0;
        return 0.0;
      }

      final List<RePassenger> passengers = passengerDataList.map((
        passengerData,
      ) {
        final mealInfoList = <ReMealInfo>[];
        final baggageInfoList = <ReBaggageInfo>[];
        final seatInfoList = <ReSeatInfo>[];

        // Handle meal data with safe type conversion
        final mealData = passengerData['meal'];
        if (mealData != null && mealData is Map) {
          mealInfoList.add(
            ReMealInfo(
              meals: [
                ReMeal(
                  code: mealData['code']?.toString() ?? '',
                  name: mealData['name']?.toString() ?? '',
                  amount: safeToDouble(mealData['amount']),
                  currency: mealData['currency']?.toString() ?? 'INR',
                  legKey: mealData['legKey']?.toString() ?? '',
                ),
              ],
            ),
          );
        }

        // Handle baggage data with safe type conversion
        final baggageData = passengerData['baggage'];
        if (baggageData != null && baggageData is Map) {
          baggageInfoList.add(
            ReBaggageInfo(
              baggages: [
                ReBaggage(
                  code: baggageData['code']?.toString() ?? '',
                  name: baggageData['name']?.toString() ?? '',
                  amount: safeToDouble(baggageData['amount']),
                  currency: baggageData['currency']?.toString() ?? 'INR',
                  legKey: baggageData['legKey']?.toString() ?? '',
                ),
              ],
            ),
          );
        }

        return RePassenger(
          frequentFlyerNo: '',
          ticketNo: '',
          ticketNoReturn: '',
          paxNo: passengerData['paxNo']?.toString() ?? '',
          paxKey: passengerData['paxKey']?.toString() ?? '',
          paxType: passengerData['passengerType']?.toString() ?? '',
          title: passengerData['title']?.toString() ?? '',
          firstName: passengerData['firstName']?.toString() ?? '',
          countryCode: safeToInt(passengerData['CountryCode']),
          lastName: passengerData['lastName']?.toString() ?? '',
          dob: formatDateForApi(passengerData['dob']),
          contact: passengerData['contact']?.toString() ?? '',
          email: passengerData['email']?.toString() ?? '',
          address: passengerData['address']?.toString() ?? '',
          nationality: passengerData['nationality']?.toString() ?? '',
          passportNo: passengerData['passportNumber']?.toString(),
          countryOfIssue: passengerData['countryOfIssue']?.toString(),
          dateOfExpiry: formatDateForApi(passengerData['passportExpiry']),
          pinCode: passengerData['pincode']?.toString(),
          ssrAvailability: ReSsrAvailability(
            mealInfo: mealInfoList,
            baggageInfo: baggageInfoList,
            seatInfo: seatInfoList,
          ),
        );
      }).toList();

      // Variables to store data for API call
      dynamic apiResponseData;
      BBBookingRequest? bookingRequestData;

      if (event.reprice) {
        log('Reprice call initiated');
        final FFlightOption fareRequestData = event.fareReData;

        final List<PFlightLeg> flightLegs =
            fareRequestData.flightLegs?.map((element) {
              return PFlightLeg(
                arrivalTerminal: element.arrivalTerminal ?? '',
                departureTerminal: element.departureTerminal ?? '',
                freeBaggages: element.freeBaggages ?? [],
                carrier: element.carrier,
                distance: element.distance,
                airlinePNR: element.airlinePNR,
                rbd: element.rbd,
                mealKey: element.mealKey,
                baggageKey: element.baggageKey,
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

          // Handle meal data with safe type conversion
          if (passengerData['meal'] != null && passengerData['meal'] is Map) {
            final meal = passengerData['meal'];
            mealInfoList.add(
              PMealInfo(
                meals: [
                  PMeal(
                    code: meal['code']?.toString() ?? '',
                    name: meal['name']?.toString() ?? '',
                    amount: safeToDouble(meal['amount']),
                    currency: meal['currency']?.toString() ?? 'INR',
                    legKey: meal['legKey']?.toString() ?? '',
                  ),
                ],
              ),
            );
          }

          // Handle baggage data with safe type conversion
          if (passengerData['baggage'] != null &&
              passengerData['baggage'] is Map) {
            final baggage = passengerData['baggage'];
            baggageInfoList.add(
              PBaggageInfo(
                tripMode: baggage['tripMode']?.toString(),
                baggageKey: baggage['baggageKey']?.toString(),
                baggages: [
                  PBaggage(
                    ptc: baggage['ptc']?.toString(),
                    code: baggage['code']?.toString() ?? '',
                    name: baggage['name']?.toString() ?? '',
                    weight: baggage['weight']?.toString(),
                    amount: safeToDouble(baggage['amount']),
                    currency: baggage['currency']?.toString() ?? 'INR',
                    legKey: baggage['legKey']?.toString() ?? '',
                  ),
                ],
              ),
            );
          }

          return Passenger(
            paxNo: passengerData['paxNo']?.toString() ?? '',
            paxKey: passengerData['paxKey']?.toString() ?? '',
            paxType: passengerData['passengerType']?.toString() ?? '',
            title: passengerData['title']?.toString() ?? '',
            firstName: passengerData['firstName']?.toString() ?? '',
            countryCode: passengerData['CountryCode']?.toString(),
            lastName: passengerData['lastName']?.toString() ?? '',
            dob: formatDateForApi(passengerData['dob']),
            contact: passengerData['contact']?.toString() ?? '',
            email: passengerData['email']?.toString() ?? '',
            address: passengerData['address']?.toString() ?? '',
            nationality: passengerData['nationality']?.toString() ?? '',
            passportNo: passengerData['passportNumber']?.toString(),
            countryOfIssue: passengerData['countryOfIssue']?.toString(),
            dateOfExpiry: formatDateForApi(passengerData['passportExpiry']),
            pinCode: passengerData['pincode']?.toString(),
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
              crsPnr: fareRequestData.crsPnr ?? '',
              providerCode: fareRequestData.providerCode ?? '',
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
                arrivalTerminal: element.arrivalTerminal ?? '',
                departureTerminal: element.departureTerminal ?? '',
                freeBaggages: element.freeBaggages ?? [],
                carrier: element.carrier,
                distance: safeToDouble(element.distance),
                airlinePNR: element.airlinePnr,

                rbd: element.rbd,

                mealKey: element.mealKey,

                baggageKey: element.baggageKey,

                type: element.type ?? '',

                key: element.key ?? '',

                origin: element.origin ?? '',

                destination: element.destination ?? '',

                departureTime: element.departureTime ?? '',

                arrivalTime: element.arrivalTime ?? '',

                flightNo: element.flightNo ?? '',

                airlineCode: element.airlineCode ?? '',
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
                refundableInfo: element.refundableInfo,
                fareKey: element.fareKey ?? "",
                aprxTotalBaseFare: safeToDouble(element.aprxTotalBaseFare),
                aprxTotalTax: safeToDouble(element.aprxTotalTax),
                totalDiscount: safeToDouble(element.totalDiscount),
                extrafare: element.extrafare,
                aprxTotalAmount: safeToDouble(element.aprxTotalAmount),
                currency: element.currency,
                fareType: element.fareType,
                fareName: element.fareName,
                totalAmount: safeToDouble(element.totalAmount),
              ),
            );
          }
        }

        bookingRequestData = BBBookingRequest(
          journey: BBJourney(
            flightOptions: [],
            flightOption: BBFlightOption(
              crsPnr: respo.journy?.flightOption?.crsPnr ?? '',
              providerCode: respo.journy?.flightOption?.providerCode ?? '',
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

        // Use reprice response for API call
        apiResponseData = respo;
        log('Booking request created with reprice data');
      } else {
        log('No reprice needed, creating booking directly');

        final FFlightOption fFlightOption = event.fareReData;

        List<BBFlightLeg> bbflightLegs = [];
        List<BBFlightFare> bbflightFares = [];

        for (var element in fFlightOption.flightLegs!) {
          bbflightLegs.add(
            BBFlightLeg(
              arrivalTerminal: element.arrivalTerminal ?? '',
              departureTerminal: element.departureTerminal ?? '',
              freeBaggages: element.freeBaggages ?? [],
              carrier: element.carrier,
              distance: safeToDouble(element.distance),
              airlinePNR: element.airlinePNR,
              rbd: element.rbd,
              mealKey: element.mealKey,
              baggageKey: element.baggageKey,
              type: element.type ?? '',
              key: element.key ?? '',
              origin: element.origin ?? '',
              destination: element.destination ?? '',
              departureTime: element.departureTime ?? '',
              arrivalTime: element.arrivalTime ?? '',
              flightNo: element.flightNo ?? '',
              airlineCode: element.airlineCode ?? '',
            ),
          );
        }

        for (var element in fFlightOption.flightFares!) {
          bbflightFares.add(
            BBFlightFare(
              fares: element.fares ?? [],
              fid: element.fid ?? '',
              refundableInfo: element.refundableInfo,
              fareKey: element.fareKey ?? "",
              aprxTotalBaseFare: safeToDouble(element.aprxTotalBaseFare),
              aprxTotalTax: safeToDouble(element.aprxTotalTax),
              totalDiscount: safeToDouble(element.totalDiscount),
              extrafare: element.extrafare,
              aprxTotalAmount: safeToDouble(element.aprxTotalAmount),
              currency: element.currency,
              fareType: element.fareType,
              fareName: element.fareName,
              totalAmount: safeToDouble(element.totalAmount),
            ),
          );
        }

        bookingRequestData = BBBookingRequest(
          journey: BBJourney(
            flightOptions: [],
            flightOption: BBFlightOption(
              crsPnr: fFlightOption.crsPnr ?? '',
              providerCode: fFlightOption.providerCode ?? '',
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

        // Use last response for API call when not reprice
        apiResponseData = event.lastRespo;
      }

      // Calculate total amount and commission from booking data
      double totalBaseAmount = 0.0;

      // Calculate total base amount from flight fares
      for (var fare in bookingRequestData.journey.flightOption.flightFares) {
        totalBaseAmount += fare.totalAmount;
      }

      // Calculate commission based on total base amount and travel type
      try {
        totalCommission = commissionService.calculateCommission(
          actualAmount: totalBaseAmount,
          travelType: event.triptype,
        );

        totalAmountWithCommission = commissionService
            .getTotalAmountWithCommission(
              actualAmount: totalBaseAmount,
              travelType: event.triptype,
            );

        log(
          'Commission calculated: Base Amount: ₹$totalBaseAmount, '
          'Commission: ₹$totalCommission, '
          'Total with Commission: ₹$totalAmountWithCommission, '
          'Travel Type: ${event.triptype}',
        );
      } catch (e) {
        log('Error calculating commission: $e');
        // Fallback: use base amount if commission calculation fails
        totalCommission = 0.0;
        totalAmountWithCommission = totalBaseAmount;
      }

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userId = prefs.getString('userId');

      // Make API call to flight booking preview with commission data
      final Map<String, dynamic> apiParams = {
        'token': event.token,
        'userId': userId ?? 'INCCJ029000000',
        'totalCom': totalCommission.toStringAsFixed(2),
        'totalAmount': totalAmountWithCommission.toStringAsFixed(2),
        'responseArray': jsonEncode(apiResponseData.toJson()),
      };

      log('Making flight booking preview API call with params: $apiParams');

      final bookingPreviewResponse = await _makeBookingPreviewApiCall(
        apiParams,
      );

      // ✅ CRITICAL FIX: Check if booking preview failed
      if (bookingPreviewResponse['status'] == 'SUCCESS') {
        log(
          'Flight booking preview successful: ${bookingPreviewResponse['data']}',
        );

        // ✅ Only proceed with success state if booking preview was successful
        emit(
          state.copyWith(
            tableID: bookingPreviewResponse['data']['bookingId'].toString(),
            isLoading: false,
            isRepriceLoading: false,
            isRepriceCompleted: true,
            bookingdata: bookingRequestData,
            totalCommission: totalCommission,
            totalAmountWithCommission: totalAmountWithCommission,
            bookingError: null,
          ),
        );
      } else {
        // ✅ Handle booking preview failure properly
        final errorMessage =
            bookingPreviewResponse['statusDesc'] ?? 'Booking preview failed';
        log('Flight booking preview failed: $errorMessage');

        emit(
          state.copyWith(
            isLoading: false,
            isRepriceLoading: false,
            isRepriceCompleted: false,
            bookingError: 'Booking preview failed: $errorMessage',
          ),
        );

        return;
      }
    } catch (e, stackTrace) {
      log('Booking error: ${e.toString()}');
      log('Stack trace: $stackTrace');
      emit(
        state.copyWith(
          isLoading: false,
          isRepriceLoading: false,
          isRepriceCompleted: false,
          bookingError: 'Failed to process booking: ${e.toString()}',
        ),
      );
    }
  }

  // Helper method for the API call
  Future<Map<String, dynamic>> _makeBookingPreviewApiCall(
    dynamic params,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}flight-booking-preview'),
        body: params,
      );
      log(params.toString());
      log('_makeBookingPreviewApiCall.  --respo');
      log(response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'status': 'FAILED',
          'statusCode': 1,
          'statusDesc': 'HTTP error: ${response.statusCode}',
        };
      }
    } catch (e) {
      log('Network error in _makeBookingPreviewApiCall: $e');
      return {
        'status': 'FAILED',
        'statusCode': 1,
        'statusDesc': 'Network error: ${e.toString()}',
      };
    }
  }

  void _onResetBooking(_ResetBooking event, Emitter<BookingState> emit) {
    emit(BookingState.initial());
  }

  Future<void> _onVerifyPayment(
    _VerifyFlightPayment event,
    Emitter<BookingState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        isConfirmingBooking: true,
        bookingError: null,
        bookingFailed: false,
      ),
    );

    try {
      log('Verifying flight payment: ${event.paymentId}');

      final response = await http.post(
        Uri.parse('${baseUrl}verify-razorpay-for-flight'),
        body: {
          'razorpay_payment_id': event.paymentId,
          'razorpay_order_id': event.orderId,
          'razorpay_signature': event.signature,
        },
      );

      log('Verification API response: ${response.body}');
      final respo = jsonDecode(response.body);

      if (respo['status'] == true) {
        final data = respo['data'];
        final pnr = data['pnr'] ?? '';
        final bookingId = data['booking_id']?.toString() ?? '';

        log('Booking verified successfully. PNR: $pnr, Booking ID: $bookingId');

        emit(
          state.copyWith(
            isLoading: false,
            isConfirmingBooking: false,
            isBookingConfirmed: true,
            isBookingCompleted: true,
            alhindPnr: pnr,
            tableID: bookingId,
            bookingError: null,
            bookingFailed: false,
          ),
        );
      } else {
        final errorMessage = respo['message'] ?? 'Verification failed';
        log('Booking verification failed: $errorMessage');

        emit(
          state.copyWith(
            isLoading: false,
            isConfirmingBooking: false,
            bookingError: errorMessage,
            bookingFailed: true,
          ),
        );
      }
    } catch (e) {
      log('Error in _onVerifyPayment: ${e.toString()}');
      emit(
        state.copyWith(
          isLoading: false,
          isConfirmingBooking: false,
          bookingError: 'Error verifying payment: ${e.toString()}',
          bookingFailed: true,
        ),
      );
    }
  }

  String formatDateForApi(String? dateString) {
    if (dateString == null || dateString.isEmpty) return '0001-01-01';
    try {
      final parsedDate = DateFormat('yyyy-MM-dd').parse(dateString);
      return "${DateFormat('yyyy-MM-dd').format(parsedDate)}T00:00:00";
    } catch (e) {
      try {
        final parsedDate = DateFormat('dd-MM-yyyy').parse(dateString);
        return "${DateFormat('yyyy-MM-dd').format(parsedDate)}T00:00:00";
      } catch (e) {
        return '0001-01-01';
      }
    }
  }

  int? safeToInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    if (value is double) return value.toInt();
    return null;
  }
}
