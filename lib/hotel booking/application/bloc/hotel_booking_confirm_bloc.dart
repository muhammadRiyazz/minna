import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:minna/comman/core/api.dart';
import 'package:minna/comman/functions/refund_payment.dart';
import 'package:minna/hotel%20booking/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'hotel_booking_confirm_event.dart';
part 'hotel_booking_confirm_state.dart';
part 'hotel_booking_confirm_bloc.freezed.dart';

class HotelBookingConfirmBloc extends Bloc<HotelBookingConfirmEvent, HotelBookingConfirmState> {
  HotelBookingConfirmBloc() : super(HotelBookingConfirmInitial()) {
    on<_PaymentDone>(_onPaymentDone);
    on<_PaymentFail>(_onPaymentFail);
    on<_InitiateRefund>(_onInitiateRefund);
    on<_StartLoading>(_onStartLoading);
    on<_StopLoading>(_onStopLoading);
  }

  Future<void> _onPaymentDone(_PaymentDone event, Emitter<HotelBookingConfirmState> emit) async {
    emit(HotelBookingConfirmLoading());
    
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString('userId') ?? '';

    log('🟢 Hotel PaymentDone event received: '
        'orderId=${event.orderId}, '
        'bookingId=${event.bookingId}, '
        'transactionId=${event.transactionId}, '
        'amount=${event.amount}');

    try {
      final bookingResponse = await _confirmHotelBooking(event.bookingRequest);

      if (bookingResponse['success']) {
        // Call callback API for successful booking
        final callbackResult = await _callBookingCallback(
          userId: userId,
          prebookId: event.prebookId,
          bookingStatus: "confirmed",
          hotelBookingStatus: "booked",
          response: bookingResponse,
          bookingId: bookingResponse['BookResult']['BookingId']?.toString() ?? event.bookingId,
          noOfPassenger: _getPassengerCount(event.bookingRequest),
          passengerDetails: _getPassengerDetails(event.bookingRequest),
          signature: "",
          orderId: event.orderId,
          paymentId: event.transactionId,
          paymentStatus: "success",
        );

      final bookId = callbackResult['data']['data']?['bookId']?.toString() ?? '';

        emit(HotelBookingConfirmSuccess(
          data: bookingResponse,
          bookingId: bookingResponse['BookResult']['BookingId']?.toString() ?? '',
          confirmationNo: bookingResponse['BookResult']['ConfirmationNo'] ?? '',
          bookingRefNo: bookingResponse['BookResult']['BookingRefNo'] ?? '',
          booktableId: bookId,
        ));
      } else {

        log(' call ----_handleBookingFailure');
        // Handle booking failure with refund and callback
        await _handleBookingFailure(
          userId: userId,
          event: event,
          bookingResponse: bookingResponse,
          emit: emit,
        );
      }
    } catch (e) {
      log('💥 Hotel booking error: $e');
      
      // Call callback API for error
      final callbackResult = await _callBookingCallback(
        userId: userId,
        prebookId: event.prebookId,
        bookingStatus: "failed",
        hotelBookingStatus: "error",
        response: {"error": e.toString()},
        bookingId: event.bookingId,
        noOfPassenger: _getPassengerCount(event.bookingRequest),
        passengerDetails: _getPassengerDetails(event.bookingRequest),
        signature: "",
        orderId: event.orderId,
        paymentId: event.transactionId,
        paymentStatus: "error",
      );

      final bookId = callbackResult['data']['data']?['bookId']?.toString() ?? '';

      emit(HotelBookingConfirmError(
        message: e.toString(),
        shouldRefund: true,
        orderId: event.orderId,
        transactionId: event.transactionId,
        amount: event.amount,
        booktableId: bookId,
        bookingId: event.bookingId,
      ));
    }
  }

  Future<Map<String, dynamic>> _confirmHotelBooking(Map<String, dynamic> bookingRequest) async {
    try {
      final String basicAuth = 'Basic ${base64Encode(utf8.encode('$livehotelusername:$livehoteluserpass'))}';

      final response = await http.post(
        Uri.parse('https://HotelBE.tektravels.com/hotelservice.svc/rest/book/'),
        headers: {
          'Authorization': basicAuth,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(bookingRequest),
      );

      log('📩 Hotel Book API Response: ${response.statusCode}');
      log('📩 Hotel Book API Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final bookResult = jsonData['BookResult'];
        
        if (bookResult['ResponseStatus'] == 1 && bookResult['Status'] == 1) {
          return {
            'success': true,
            'BookResult': bookResult,
          };
        } else if (bookResult['Status'] == 3) {
          return {
            'success': false,
            'error': 'Price changed',
            'BookResult': bookResult,
            'requiresReprice': true,
          };
        } else {
          return {
            'success': false,
            'error': bookResult['Error']['ErrorMessage'] ?? 'Booking failed',
            'BookResult': bookResult,
          };
        }
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      log('💥 Hotel booking API error: $e');
      rethrow;
    }
  }

  Future<void> _handleBookingFailure({
    required _PaymentDone event,
    required Map<String, dynamic> bookingResponse,
    required Emitter<HotelBookingConfirmState> emit,
    required String userId,
  }) async {
    try {
      // Call callback API for booking failure
      final callbackResult = await _callBookingCallback(
        userId: userId,
        prebookId: event.prebookId,
        bookingStatus: "failed",
        hotelBookingStatus: "booking_failed",
        response: bookingResponse,
        bookingId: event.bookingId,
        noOfPassenger: _getPassengerCount(event.bookingRequest),
        passengerDetails: _getPassengerDetails(event.bookingRequest),
        signature: "",
        orderId: event.orderId,
        paymentId: event.transactionId,
        paymentStatus: "refund_pending",
      );

      final bookId = callbackResult['data']['data']?['bookId']?.toString() ?? '';
log('bookId--------.  $bookId');
      // Initiate refund
      final refundResult = await refundPayment(
        transactionId: event.transactionId,
        amount: event.amount,
        tableId: bookId,
        table: 'mm_hotel_book',
      );

      if (refundResult['success']) {
        emit(HotelBookingConfirmRefundInitiated(
          message: refundResult['message'] ?? "Booking failed. Refund initiated.",
          orderId: event.orderId,
          transactionId: event.transactionId,
          amount: event.amount,
          booktableId: bookId,
          bookingId: event.bookingId,
        ));
      } else {
        // Update callback with refund failure
        await _callBookingCallback(
          userId: userId,
          prebookId: event.prebookId,
          bookingStatus: "failed",
          hotelBookingStatus: "refund_failed",
          response: {...bookingResponse, 'refund_error': refundResult},
          bookingId: event.bookingId,
          noOfPassenger: _getPassengerCount(event.bookingRequest),
          passengerDetails: _getPassengerDetails(event.bookingRequest),
          signature: "",
          orderId: event.orderId,
          paymentId: event.transactionId,
          paymentStatus: "refund_failed",
        );

        emit(HotelBookingConfirmRefundFailed(
          message: refundResult['message'] ?? "Booking failed and refund failed",
          orderId: event.orderId,
          transactionId: event.transactionId,
          amount: event.amount,
          // booktableId: bookId,
          bookingId: event.bookingId,
        ));
      }
    } catch (e) {
      log('💥 Booking failure handling error: $e');
      
      // Call callback for error in failure handling
      final callbackResult = await _callBookingCallback(
        userId: userId,
        prebookId: event.prebookId,
        bookingStatus: "error",
        hotelBookingStatus: "system_error",
        response: {"error": e.toString()},
        bookingId: event.bookingId,
        noOfPassenger: _getPassengerCount(event.bookingRequest),
        passengerDetails: _getPassengerDetails(event.bookingRequest),
        signature: "",
        orderId: event.orderId,
        paymentId: event.transactionId,
        paymentStatus: "error",
      );

      final bookId = callbackResult['data']['data']?['bookId']?.toString() ?? '';

      emit(HotelBookingConfirmRefundFailed(
        message: "Booking failed with error: $e",
        orderId: event.orderId,
        transactionId: event.transactionId,
        amount: event.amount,
        // booktableId: bookId,
        bookingId: event.bookingId,
      ));
    }
  }

  Future<void> _onPaymentFail(_PaymentFail event, Emitter<HotelBookingConfirmState> emit) async {
    emit(HotelBookingConfirmLoading());
    
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString('userId') ?? '';

    try {
      // Call callback API for payment failure
      await _callBookingCallback(
        userId: userId,
        prebookId: event.prebookId,
        bookingStatus: "failed",
        hotelBookingStatus: "payment_failed",
        response: {"error": "Payment failed or cancelled by user"},
        bookingId: event.bookingId,
        noOfPassenger: 0,
        passengerDetails: [],
        signature: "",
        orderId: event.orderId,
        paymentId: "",
        paymentStatus: "failed",
      );

      emit(HotelBookingConfirmPaymentFailed(
        message: "Payment failed",
        orderId: event.orderId,
        bookingId: event.bookingId,
      ));
    } catch (e) {
      log('💥 Payment failure error: $e');
      
      // Call callback for payment failure error
      await _callBookingCallback(
        userId: userId,
        prebookId: event.prebookId,
        bookingStatus: "failed",
        hotelBookingStatus: "payment_error",
        response: {"error": e.toString()},
        bookingId: event.bookingId,
        noOfPassenger: 0,
        passengerDetails: [],
        signature: "",
        orderId: event.orderId,
        paymentId: "",
        paymentStatus: "error",
      );

      emit(HotelBookingConfirmPaymentFailed(
        message: "Payment failed with error: $e",
        orderId: event.orderId,
        bookingId: event.bookingId,
      ));
    }
  }

  Future<void> _onInitiateRefund(_InitiateRefund event, Emitter<HotelBookingConfirmState> emit) async {
    emit(HotelBookingConfirmRefundProcessing(
      orderId: event.orderId,
      transactionId: event.transactionId,
      amount: event.amount,
      booktableId: event.booktableId,
      bookingId: event.bookingId,
    ));

    try {
      final refundResult = await refundPayment(
        transactionId: event.transactionId,
        amount: event.amount,
        tableId: event.booktableId,
        table: 'mm_hotel_book',
      );

      if (refundResult['success']) {
        emit(HotelBookingConfirmRefundInitiated(
          message: refundResult['message'] ?? "Refund initiated successfully",
          orderId: event.orderId,
          transactionId: event.transactionId,
          amount: event.amount,
          booktableId: event.booktableId,
          bookingId: event.bookingId,
        ));
      } else {
        emit(HotelBookingConfirmRefundFailed(
          message: refundResult['message'] ?? "Refund failed",
          orderId: event.orderId,
          transactionId: event.transactionId,
          amount: event.amount,
          // booktableId: event.tableId,
          bookingId: event.bookingId,
        ));
      }
    } catch (e) {
      emit(HotelBookingConfirmRefundFailed(
        message: "Refund failed with error: $e",
        orderId: event.orderId,
        transactionId: event.transactionId,
        amount: event.amount,
        // tableId: event.tableId,
        bookingId: event.bookingId,
      ));
    }
  }

  void _onStartLoading(_StartLoading event, Emitter<HotelBookingConfirmState> emit) {
    final currentState = state;
    if (currentState is! HotelBookingConfirmLoading) {
      emit(HotelBookingConfirmLoading(previousState: currentState));
    }
  }

  void _onStopLoading(_StopLoading event, Emitter<HotelBookingConfirmState> emit) {
    if (state is HotelBookingConfirmLoading) {
      final loadingState = state as HotelBookingConfirmLoading;
      if (loadingState.previousState != null) {
        emit(loadingState.previousState!);
      } else {
        emit(HotelBookingConfirmInitial());
      }
    }
  }

  // New method to call booking callback API
  Future<Map<String, dynamic>> _callBookingCallback({
    required String userId,
    required String prebookId,
    required String bookingStatus,
    required String hotelBookingStatus,
    required Map<String, dynamic> response,
    required String bookingId,
    required int noOfPassenger,
    required List<Map<String, dynamic>> passengerDetails,
    required String signature,
    required String orderId,
    required String paymentId,
    required String paymentStatus,
  }) async {
    try {
      log('🔹 Calling booking callback API...');
      
      final callbackResponse = await http.post(
        Uri.parse('${baseUrl}hotel-api-call-book'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'userId': userId,
          'prebookId': prebookId,
          'bookingStatus': bookingStatus,
          'HotelBookingStatus': hotelBookingStatus,
          'response': jsonEncode(response),
          'bookingId': bookingId,
          'noOfPassenger': noOfPassenger.toString(),
          'passengerDetails': jsonEncode(passengerDetails),
          'signature': signature,
          'orderId': orderId,
          'paymentId': paymentId,
          'paymentStatus': paymentStatus,
        },
      );

      if (callbackResponse.statusCode == 200) {
        final result = jsonDecode(callbackResponse.body);
        log('✅ Booking callback successful: $result');
        return {
          'success': true,
          'data': result,
        };
      } else {
        log('❌ Booking callback failed with status: ${callbackResponse.statusCode}');
        return {
          'success': false,
          'error': 'HTTP ${callbackResponse.statusCode}',
        };
      }
    } catch (e) {
      log('💥 Booking callback error: $e');
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  // Helper methods to extract data from booking request
  int _getPassengerCount(Map<String, dynamic> bookingRequest) {
    try {
      final hotelRoomsDetails = bookingRequest['HotelRoomsDetails'] as List?;
      if (hotelRoomsDetails == null || hotelRoomsDetails.isEmpty) return 0;
      
      int totalPassengers = 0;
      for (final room in hotelRoomsDetails) {
        final passengers = room['HotelPassenger'] as List?;
        if (passengers != null) {
          totalPassengers += passengers.length;
        }
      }
      return totalPassengers;
    } catch (e) {
      log('Error getting passenger count: $e');
      return 0;
    }
  }

  List<Map<String, dynamic>> _getPassengerDetails(Map<String, dynamic> bookingRequest) {
    try {
      final List<Map<String, dynamic>> passengerDetails = [];
      final hotelRoomsDetails = bookingRequest['HotelRoomsDetails'] as List?;
      
      if (hotelRoomsDetails != null) {
        for (final room in hotelRoomsDetails) {
          final passengers = room['HotelPassenger'] as List?;
          if (passengers != null) {
            for (final passenger in passengers) {
              passengerDetails.add({
                'Title': passenger['Title'] ?? '',
                'FirstName': passenger['FirstName'] ?? '',
                'LastName': passenger['LastName'] ?? '',
                'Email': passenger['Email'] ?? '',
                'Phone': passenger['Phoneno'] ?? '',
                'Age': passenger['Age'] ?? 0,
                'Passport': passenger['PassportNo'] ?? '',
              });
            }
          }
        }
      }
      return passengerDetails;
    } catch (e) {
      log('Error getting passenger details: $e');
      return [];
    }
  }
}