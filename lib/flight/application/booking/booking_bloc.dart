// flight_booking_bloc.dart
import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:minna/comman/functions/create_order_id.dart';
import 'package:minna/flight/domain/booking%20request%20/booking_request.dart';
import 'package:minna/flight/domain/fare%20request%20and%20respo/fare_respo.dart';
import 'package:minna/flight/domain/reprice%20/re_price.dart';
import 'package:minna/flight/domain/reprice%20/reprice_respo.dart';
import 'package:minna/flight/infrastracture/booking%20confirm/booking.dart';
import 'package:minna/flight/infrastracture/reprice/call_reprice_api.dart';
import 'package:minna/comman/core/api.dart';
import 'package:minna/comman/functions/refund_payment.dart';
import 'package:minna/comman/functions/save_payment.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'booking_event.dart';
part 'booking_state.dart';
part 'booking_bloc.freezed.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingState.initial()) {
    on<_GetRePrice>(_onGetRePrice);
    on<_ConfirmFlightBooking>(_onConfirmBooking);
    on<_SaveFinalBooking>(_onSaveFinalBooking);
    on<_InitiateRefund>(_onInitiateRefund);
    on<_ResetBooking>(_onResetBooking);
  }

  Future<void> _onGetRePrice(
    _GetRePrice event,
    Emitter<BookingState> emit,
  ) async {
    emit(state.copyWith(
      isLoading: true,
      isRepriceLoading: true,
      isRepriceCompleted: false,
      bookingError: null
    ));

    try {
      final List<Map<String, dynamic>> passengerDataList = event.passengerDataList;

      final List<RePassenger> passengers = passengerDataList.map((passengerData) {
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

      // Variables to store data for API call
      dynamic apiResponseData;
      BBBookingRequest? bookingRequestData;

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

        final List<Passenger> passengerss = passengerDataList.map((passengerData) {
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

          if (passengerData['baggage'] != null && passengerData['baggage'] is Map) {
            baggageInfoList.add(
              PBaggageInfo(
                baggages: [
                  PBaggage(
                    code: passengerData['baggage']['code'],
                    name: passengerData['baggage']['name'],
                    amount: (passengerData['baggage']['amount'] as num).toDouble(),
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
                aprxTotalBaseFare: (element.aprxTotalBaseFare as num?)?.toDouble() ?? 0.0,
                aprxTotalTax: (element.aprxTotalTax as num?)?.toDouble() ?? 0.0,
                totalDiscount: (element.totalDiscount as num?)?.toDouble() ?? 0.0,
                aprxTotalAmount: (element.aprxTotalAmount as num?)?.toDouble() ?? 0.0,
                totalAmount: (element.totalAmount as num?)?.toDouble() ?? 0.0,
              ),
            );
          }
        }

        bookingRequestData = BBBookingRequest(
          journey: BBJourney(
            flightOptions: [],
            flightOption: BBFlightOption(
              key: respo.journy?.flightOption?.key ?? '',
              ticketingCarrier: respo.journy?.flightOption?.ticketingCarrier ?? '',
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
              aprxTotalBaseFare: (element.aprxTotalBaseFare as num?)?.toDouble() ?? 0.0,
              aprxTotalTax: (element.aprxTotalTax as num?)?.toDouble() ?? 0.0,
              totalDiscount: (element.totalDiscount as num?)?.toDouble() ?? 0.0,
              aprxTotalAmount: (element.aprxTotalAmount as num?)?.toDouble() ?? 0.0,
              totalAmount: (element.totalAmount as num?)?.toDouble() ?? 0.0,
            ),
          );
        }

        bookingRequestData = BBBookingRequest(
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

        // Use last response for API call when not reprice
        apiResponseData = event.lastRespo;
      }

      // Calculate total amount from booking data
      double totalAmount = 0.0;
      double totalCom = 0.0;
      
      if (bookingRequestData != null) {
        // Calculate total amount from flight fares
        for (var fare in bookingRequestData.journey.flightOption.flightFares) {
          totalAmount += fare.totalAmount;
          // You might need to adjust how commission is calculated based on your business logic
          totalCom += fare.totalDiscount; // Using discount as commission for example
        }
      }

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userId = prefs.getString('userId');

      // Make API call to flight booking preview
      final Map<String, dynamic> apiParams = {
        'token': event.token,
        'userId': userId ,
        'totalCom': '0',
        'totalAmount': totalAmount.toString(),
        'responseArray': jsonEncode(apiResponseData.toJson()) 
      };

      log('Making flight booking preview API call with params: $apiParams');

      final bookingPreviewResponse = await _makeBookingPreviewApiCall(apiParams);

      // ✅ CRITICAL FIX: Check if booking preview failed
      if (bookingPreviewResponse['status'] == 'SUCCESS') {
        log('Flight booking preview successful: ${bookingPreviewResponse['data']}');

        // ✅ Only proceed with success state if booking preview was successful
        emit(
          state.copyWith(
            tableID: bookingPreviewResponse['data']['bookingId'].toString(),
            isLoading: false,
            isRepriceLoading: false,
            isRepriceCompleted: true, // Set completion flag ONLY on success
            bookingdata: bookingRequestData,
            bookingError: null,
          ),
        );

      } else {
        // ✅ Handle booking preview failure properly
        final errorMessage = bookingPreviewResponse['statusDesc'] ?? 'Booking preview failed';
        log('Flight booking preview failed: $errorMessage');
        
        emit(
          state.copyWith(
            isLoading: false,
            isRepriceLoading: false,
            isRepriceCompleted: false, // ❌ DO NOT set completion flag on failure
            bookingError: 'Booking preview failed: $errorMessage', // Set the error message
          ),
        );
        
        // Don't proceed further - navigation will be blocked by the error state
        return; // Exit early on failure
      }

    } catch (e) {
      log('Booking error: ${e.toString()}');
      emit(
        state.copyWith(
          isLoading: false,
          isRepriceLoading: false,
          isRepriceCompleted: false, // ❌ DO NOT set completion flag on error
          bookingError: 'Failed to process booking: ${e.toString()}',
        ),
      );
    }
  }

  // Helper method for the API call
  Future<Map<String, dynamic>> _makeBookingPreviewApiCall(dynamic params) async {
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
          'statusDesc': 'HTTP error: ${response.statusCode}'
        };
      }
    } catch (e) {
      log('Network error in _makeBookingPreviewApiCall: $e');
      return {
        'status': 'FAILED',
        'statusCode': 1,
        'statusDesc': 'Network error: ${e.toString()}'
      };
    }
  }

  Future<void> _onConfirmBooking(
    _ConfirmFlightBooking event,
    Emitter<BookingState> emit,
  ) async {
    emit(state.copyWith(
      isLoading: true,
      isConfirmingBooking: true,
      bookingError: null,
      bookingFailed: false, // Reset booking failed flag
      refundInitiated: false, // Reset refund flags
      refundFailed: false,
    ));

    try {
      final response = await bookingConfirmApi(state.bookingdata!);
      final respo = jsonDecode(response.body);

      if (respo.containsKey('Errors') && respo['Errors'] != null) {
        final errorMessage = respo['Errors'][0]['ErrorMessage'] ?? 'Booking failed';
        
        log('Booking confirmation failed: $errorMessage');
        
        emit(state.copyWith(
          isLoading: false,
          isConfirmingBooking: false,
          bookingError: errorMessage,
          bookingFailed: true
        ));

        // Initiate refund since booking failed after payment
        final amount = state.bookingdata!.journey.flightOption.flightFares.first.totalAmount;
        add(BookingEvent.initiateRefund(
          orderId: event.orderId,
          paymentId: event.paymentId,
          amount: amount,
          tableID: state.tableID ?? '',
          reason: 'Booking confirmation failed: $errorMessage'
        ));
      } else if (respo.containsKey('AlhindPnr')) {
        final alhindPnr = respo['AlhindPnr'];
        
        log('Booking confirmed successfully with PNR: $alhindPnr');
        
        emit(state.copyWith(
          isLoading: false,
          isConfirmingBooking: false,
          isBookingConfirmed: true,
          alhindPnr: alhindPnr,
          bookingError: null,
          bookingFailed: false,
        ));

        // Save final booking data
        add(BookingEvent.saveFinalBooking(
          alhindPnr: alhindPnr,
          tableID: state.tableID ?? '',
          orderId: event.orderId,
          signature: event.signature,
          paymentId: event.paymentId,
          finalResponse: respo,
          razorpayResponse: {
            'order_id': event.orderId,
            'payment_id': event.paymentId,
            'signature': event.signature
          }
        ));
      } else {
        throw Exception('Unexpected response from booking confirmation');
      }
    } catch (e) {
      log('Error in ConfirmBooking: ${e.toString()}');
      emit(state.copyWith(
        isLoading: false,
        isConfirmingBooking: false,
        bookingError: 'Error confirming booking: ${e.toString()}',
        bookingFailed: true
      ));

      // Initiate refund
      final amount = state.bookingdata!.journey.flightOption.flightFares.first.totalAmount;
      add(BookingEvent.initiateRefund(
        orderId: event.orderId,
        paymentId: event.paymentId,
        amount: amount,
        tableID: state.tableID ?? '',
        reason: 'Booking confirmation error: $e'
      ));
    }
  }

Future<void> _onSaveFinalBooking(
  _SaveFinalBooking event,
  Emitter<BookingState> emit,
) async {
  emit(state.copyWith(
    isLoading: true,
    isSavingFinalBooking: true,
    bookingError: null
  ));

  try {
    // Prepare the request body
final Map<String, dynamic> requestBody = {
  'AlhindPnr': event.alhindPnr.toString(),
  'bookingId': event.tableID.toString(),
  'orderId': event.orderId.toString(),
  'signature': event.signature.toString(),
  'paymentId': event.paymentId.toString(),
  'paymentStatus': 'SUCCESS',
  'finalResponse': jsonEncode(event.finalResponse),
  'razorpayResp': jsonEncode(event.razorpayResponse)
};

log(requestBody.toString());
    final response = await http.post(
      Uri.parse('${baseUrl}flight-booking'),
     
      body:requestBody ,
    );

    log('Final booking API response: ${response.body}');
    
    final responseData = jsonDecode(response.body);
    
    if (responseData['status'] == 'SUCCESS') {
      emit(state.copyWith(
        isLoading: false,
        isSavingFinalBooking: false,
        isBookingCompleted: true,
        isBookingConfirmed: true
      ));
    } else {
      throw Exception(responseData['statusDesc'] ?? 'Failed to save final booking');
    }
  } catch (e) {
    log('Error saving final booking: $e');
    // Still mark as completed since booking was confirmed
    emit(state.copyWith(
      isLoading: false,
      isSavingFinalBooking: false,
      isBookingCompleted: true,
      bookingError: 'Booking confirmed but save failed: $e'
    ));
  }
}
  Future<void> _onInitiateRefund(
    _InitiateRefund event,
    Emitter<BookingState> emit,
  ) async {
    // Prevent multiple refund calls - check if already processing or completed
    if (state.isRefundProcessing == true || 
        state.refundInitiated == true || 
        state.refundFailed == true) {
      log('Refund already processing or completed, skipping duplicate call');
      return;
    }

    emit(state.copyWith(
      isLoading: true,
      isRefundProcessing: true,
      bookingError: null,
      refundFailed: false,
      refundInitiated: false, // Ensure this is reset when starting new refund
    ));

    try {
      log('Initiating refund for payment: ${event.paymentId}, amount: ${event.amount}');
      
      final refundResult = await refundPayment(
        transactionId: event.paymentId,
        amount: event.amount,
        tableId: event.tableID,
        table: 'flight_booking_header',
      );

      log('Refund API response: $refundResult');

      if (refundResult['success'] == true) {
        log('Refund initiated successfully');
        emit(state.copyWith(
          isLoading: false,
          isRefundProcessing: false,
          refundInitiated: true,
          refundFailed: false,
          bookingError: 'Payment refunded: ${refundResult['message']}'
        ));
      } else {
        log('Refund failed: ${refundResult['message']}');
        emit(state.copyWith(
          isLoading: false,
          isRefundProcessing: false,
          refundInitiated: false,
          refundFailed: true,
          bookingError: 'Refund failed: ${refundResult['message']}'
        ));
      }
    } catch (e) {
      log('Refund initiation error: $e');
      emit(state.copyWith(
        isLoading: false,
        isRefundProcessing: false,
        refundInitiated: false,
        refundFailed: true,
        bookingError: 'Refund failed with error: $e'
      ));
    }
  }

  void _onResetBooking(_ResetBooking event, Emitter<BookingState> emit) {
    emit(BookingState.initial());
  }

  String formatDateForApi(String? dateString) {
    if (dateString == null || dateString.isEmpty) return '0001-01-01';
    try {
      final parsedDate = DateFormat('yyyy-MM-dd').parse(dateString);
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    } catch (e) {
      try {
        final parsedDate = DateFormat('dd-MM-yyyy').parse(dateString);
        return DateFormat('yyyy-MM-dd').format(parsedDate);
      } catch (e) {
        return '0001-01-01';
      }
    }
  }
}