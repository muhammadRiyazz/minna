import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:minna/comman/core/api.dart';
import 'package:minna/comman/functions/refund_payment.dart';
import 'package:minna/comman/functions/save_payment.dart';
import 'package:minna/hotel%20booking/core/core.dart';

part 'hotel_booking_confirm_event.dart';
part 'hotel_booking_confirm_state.dart';
part 'hotel_booking_confirm_bloc.freezed.dart';

class HotelBookingConfirmBloc extends Bloc<HotelBookingConfirmEvent, HotelBookingConfirmState> {
  HotelBookingConfirmBloc() : super(HotelBookingConfirmInitial()) {
    on<HotelBookingConfirmEvent>((event, emit) {
    on<_PaymentDone>(_onPaymentDone);
    on<_PaymentFail>(_onPaymentFail);
    on<_InitiateRefund>(_onInitiateRefund);
    on<_StartLoading>(_onStartLoading);
    on<_StopLoading>(_onStopLoading);



    }  ); }

  Future<void> _onPaymentDone(_PaymentDone event, Emitter<HotelBookingConfirmState> emit) async {
    emit(HotelBookingConfirmLoading());
    
    log('🟢 Hotel PaymentDone event received: '
        'orderId=${event.orderId}, '
        'bookingId=${event.bookingId}, '
        'transactionId=${event.transactionId}, '
        'amount=${event.amount}');

    try {
      // 1. Save payment details
      log('🔹 Saving payment details...');
      // final saveResult = await savePaymentDetails(
      //   orderId: event.orderId,
      //   status: 1,
      //   table: "hotel_data",
      //   tableid: event.tableId,
      //   transactionId: event.transactionId,
      // );

      // if (!saveResult['success']) {
      //   log('❌ Payment save failed');
      //   emit(HotelBookingConfirmPaymentSavedFailed(
      //     message: "Payment details could not be saved",
      //     orderId: event.orderId,
      //     transactionId: event.transactionId,
      //     amount: event.amount,
      //     tableId: event.tableId,
      //     bookingId: event.bookingId,
      //     shouldRefund: true,
      //   ));
      //   return;
      // }

      // 2. Confirm hotel booking
      log('🔹 Confirming hotel booking...');
      final bookingResponse = await _confirmHotelBooking(event.bookingRequest);

      if (bookingResponse['success']) {
        // 3. Save booking status
        // await _saveHotelStatus(
        //   tableId: event.tableId,
        //   type: "confirm",
        //   request: event.bookingRequest,
        //   response: bookingResponse,
        // );

        emit(HotelBookingConfirmSuccess(
          data: bookingResponse,
          bookingId: bookingResponse['BookResult']['BookingId']?.toString() ?? '',
          confirmationNo: bookingResponse['BookResult']['ConfirmationNo'] ?? '',
          bookingRefNo: bookingResponse['BookResult']['BookingRefNo'] ?? '',
        ));
      } else {
        // Handle booking failure with refund
        await _handleBookingFailure(
          event: event,
          bookingResponse: bookingResponse,
          emit: emit,
        );
      }
    } catch (e) {
      log('💥 Hotel booking error: $e');
      // await _saveHotelStatus(
      //   tableId: event.tableId,
      //   type: "failure",
      //   request: event.bookingRequest,
      //   response: {"error": e.toString()},
      // );

      emit(HotelBookingConfirmError(
        message: e.toString(),
        shouldRefund: true,
        orderId: event.orderId,
        transactionId: event.transactionId,
        amount: event.amount,
        tableId: event.tableId,
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
        
        // Check if booking was successful
        if (bookResult['ResponseStatus'] == 1 && bookResult['Status'] == 1) {
          return {
            'success': true,
            'BookResult': bookResult,
          };
        } else if (bookResult['Status'] == 3) { // VerifyPrice status
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
  }) async {
    try {
      // Save failure status
      // await _saveHotelStatus(
      //   tableId: event.tableId,
      //   type: "failure",
      //   request: event.bookingRequest,
      //   response: bookingResponse,
      // );

      // Initiate refund
      final refundResult = await refundPayment(
        transactionId: event.transactionId,
        amount: event.amount,
        tableId: event.tableId,
        table: 'hotel_data',
      );

      if (refundResult['success']) {
        emit(HotelBookingConfirmRefundInitiated(
          message: refundResult['message'] ?? "Booking failed. Refund initiated.",
          orderId: event.orderId,
          transactionId: event.transactionId,
          amount: event.amount,
          tableId: event.tableId,
          bookingId: event.bookingId,
        ));
      } else {
        emit(HotelBookingConfirmRefundFailed(
          message: refundResult['message'] ?? "Booking failed and refund failed",
          orderId: event.orderId,
          transactionId: event.transactionId,
          amount: event.amount,
          tableId: event.tableId,
          bookingId: event.bookingId,
        ));
      }
    } catch (e) {
      emit(HotelBookingConfirmRefundFailed(
        message: "Booking failed with error: $e",
        orderId: event.orderId,
        transactionId: event.transactionId,
        amount: event.amount,
        tableId: event.tableId,
        bookingId: event.bookingId,
      ));
    }
  }

  // Future<void> _saveHotelStatus({
  //   required String tableId,
  //   required String type,
  //   required Map<String, dynamic> request,
  //   required Map<String, dynamic> response,
  // }) async {
  //   try {
  //     final saveResponse = await http.post(
  //       Uri.parse('${baseUrl}hotel-status'),
  //       body: {
  //         "booking_id": tableId,
  //         "type": type,
  //         "request": jsonEncode(request),
  //         "response": jsonEncode(response),
  //       },
  //     );
  //     log('📩 Hotel status save response: ${saveResponse.body}');
  //   } catch (e) {
  //     log('💥 Hotel status save error: $e');
  //   }
  // }

  Future<void> _onPaymentFail(_PaymentFail event, Emitter<HotelBookingConfirmState> emit) async {
    emit(HotelBookingConfirmLoading());
    
    try {
      final saveResult = await savePaymentDetails(
        orderId: event.orderId,
        status: 2,
        table: "hotel_data",
        tableid: event.tableId,
        transactionId: "",
      );

      emit(HotelBookingConfirmPaymentFailed(
        message: "Payment failed",
        orderId: event.orderId,
        tableId: event.tableId,
        bookingId: event.bookingId,
      ));
    } catch (e) {
      emit(HotelBookingConfirmPaymentFailed(
        message: "Payment failed with error: $e",
        orderId: event.orderId,
        tableId: event.tableId,
        bookingId: event.bookingId,
      ));
    }
  }

  Future<void> _onInitiateRefund(_InitiateRefund event, Emitter<HotelBookingConfirmState> emit) async {
    emit(HotelBookingConfirmRefundProcessing(
      orderId: event.orderId,
      transactionId: event.transactionId,
      amount: event.amount,
      tableId: event.tableId,
      bookingId: event.bookingId,
    ));

    try {
      final refundResult = await refundPayment(
        transactionId: event.transactionId,
        amount: event.amount,
        tableId: event.tableId,
        table: 'hotel_data',
      );

      if (refundResult['success']) {
        emit(HotelBookingConfirmRefundInitiated(
          message: refundResult['message'] ?? "Refund initiated successfully",
          orderId: event.orderId,
          transactionId: event.transactionId,
          amount: event.amount,
          tableId: event.tableId,
          bookingId: event.bookingId,
        ));
      } else {
        emit(HotelBookingConfirmRefundFailed(
          message: refundResult['message'] ?? "Refund failed",
          orderId: event.orderId,
          transactionId: event.transactionId,
          amount: event.amount,
          tableId: event.tableId,
          bookingId: event.bookingId,
        ));
      }
    } catch (e) {
      emit(HotelBookingConfirmRefundFailed(
        message: "Refund failed with error: $e",
        orderId: event.orderId,
        transactionId: event.transactionId,
        amount: event.amount,
        tableId: event.tableId,
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

}
  

// hotel_booking_bloc.dart
// import 'dart:convert';
// import 'dart:developer';
// import 'package:bloc/bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:http/http.dart' as http;
// import 'package:minna/comman/core/api.dart';
// import 'package:minna/comman/functions/refund_payment.dart';
// import 'package:minna/comman/functions/save_payment.dart';


// class HotelBookingBloc extends Bloc<HotelBookingEvent, HotelBookingState> {
//   HotelBookingBloc() : super(HotelBookingInitial()) {
//     on<_PaymentDone>(_onPaymentDone);
//     on<_PaymentFail>(_onPaymentFail);
//     on<_InitiateRefund>(_onInitiateRefund);
//     on<_StartLoading>(_onStartLoading);
//     on<_StopLoading>(_onStopLoading);
//   }

  // Future<void> _onPaymentDone(_PaymentDone event, Emitter<HotelBookingState> emit) async {
  //   emit(HotelBookingLoading());
    
  //   log('🟢 Hotel PaymentDone event received: '
  //       'orderId=${event.orderId}, '
  //       'bookingId=${event.bookingId}, '
  //       'transactionId=${event.transactionId}, '
  //       'amount=${event.amount}');

  //   try {
  //     // 1. Save payment details
  //     log('🔹 Saving payment details...');
  //     final saveResult = await savePaymentDetails(
  //       orderId: event.orderId,
  //       status: 1,
  //       table: "hotel_data",
  //       tableid: event.tableId,
  //       transactionId: event.transactionId,
  //     );

  //     if (!saveResult['success']) {
  //       log('❌ Payment save failed');
  //       emit(HotelBookingPaymentSavedFailed(
  //         message: "Payment details could not be saved",
  //         orderId: event.orderId,
  //         transactionId: event.transactionId,
  //         amount: event.amount,
  //         tableId: event.tableId,
  //         bookingId: event.bookingId,
  //         shouldRefund: true,
  //       ));
  //       return;
  //     }

  //     // 2. Confirm hotel booking
  //     log('🔹 Confirming hotel booking...');
  //     final bookingResponse = await _confirmHotelBooking(event.bookingRequest);

  //     if (bookingResponse['success']) {
  //       // 3. Save booking status
  //       await _saveHotelStatus(
  //         tableId: event.tableId,
  //         type: "confirm",
  //         request: event.bookingRequest,
  //         response: bookingResponse,
  //       );

  //       emit(HotelBookingSuccess(
  //         data: bookingResponse,
  //         bookingId: bookingResponse['BookResult']['BookingId']?.toString() ?? '',
  //         confirmationNo: bookingResponse['BookResult']['ConfirmationNo'] ?? '',
  //         bookingRefNo: bookingResponse['BookResult']['BookingRefNo'] ?? '',
  //       ));
  //     } else {
  //       // Handle booking failure with refund
  //       await _handleBookingFailure(
  //         event: event,
  //         bookingResponse: bookingResponse,
  //         emit: emit,
  //       );
  //     }
  //   } catch (e) {
  //     log('💥 Hotel booking error: $e');
  //     await _saveHotelStatus(
  //       tableId: event.tableId,
  //       type: "failure",
  //       request: event.bookingRequest,
  //       response: {"error": e.toString()},
  //     );

  //     emit(HotelBookingError(
  //       message: e.toString(),
  //       shouldRefund: true,
  //       orderId: event.orderId,
  //       transactionId: event.transactionId,
  //       amount: event.amount,
  //       tableId: event.tableId,
  //       bookingId: event.bookingId,
  //     ));
  //   }
  // }

  // Future<Map<String, dynamic>> _confirmHotelBooking(Map<String, dynamic> bookingRequest) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('https://HotelBE.tektravels.com/hotelservice.svc/rest/book/'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode(bookingRequest),
  //     );

  //     log('📩 Hotel Book API Response: ${response.statusCode}');
  //     log('📩 Hotel Book API Body: ${response.body}');

  //     if (response.statusCode == 200) {
  //       final jsonData = jsonDecode(response.body);
  //       final bookResult = jsonData['BookResult'];
        
  //       // Check if booking was successful
  //       if (bookResult['ResponseStatus'] == 1 && bookResult['Status'] == 1) {
  //         return {
  //           'success': true,
  //           'BookResult': bookResult,
  //         };
  //       } else if (bookResult['Status'] == 3) { // VerifyPrice status
  //         return {
  //           'success': false,
  //           'error': 'Price changed',
  //           'BookResult': bookResult,
  //           'requiresReprice': true,
  //         };
  //       } else {
  //         return {
  //           'success': false,
  //           'error': bookResult['Error']['ErrorMessage'] ?? 'Booking failed',
  //           'BookResult': bookResult,
  //         };
  //       }
  //     } else {
  //       throw Exception('HTTP ${response.statusCode}: ${response.body}');
  //     }
  //   } catch (e) {
  //     log('💥 Hotel booking API error: $e');
  //     rethrow;
  //   }
  // }

  // Future<void> _handleBookingFailure({
  //   required _PaymentDone event,
  //   required Map<String, dynamic> bookingResponse,
  //   required Emitter<HotelBookingState> emit,
  // }) async {
  //   try {
  //     // Save failure status
  //     await _saveHotelStatus(
  //       tableId: event.tableId,
  //       type: "failure",
  //       request: event.bookingRequest,
  //       response: bookingResponse,
  //     );

  //     // Initiate refund
  //     final refundResult = await refundPayment(
  //       transactionId: event.transactionId,
  //       amount: event.amount,
  //       tableId: event.tableId,
  //       table: 'hotel_data',
  //     );

  //     if (refundResult['success']) {
  //       emit(HotelBookingRefundInitiated(
  //         message: refundResult['message'] ?? "Booking failed. Refund initiated.",
  //         orderId: event.orderId,
  //         transactionId: event.transactionId,
  //         amount: event.amount,
  //         tableId: event.tableId,
  //         bookingId: event.bookingId,
  //       ));
  //     } else {
  //       emit(HotelBookingRefundFailed(
  //         message: refundResult['message'] ?? "Booking failed and refund failed",
  //         orderId: event.orderId,
  //         transactionId: event.transactionId,
  //         amount: event.amount,
  //         tableId: event.tableId,
  //         bookingId: event.bookingId,
  //       ));
  //     }
  //   } catch (e) {
  //     emit(HotelBookingRefundFailed(
  //       message: "Booking failed with error: $e",
  //       orderId: event.orderId,
  //       transactionId: event.transactionId,
  //       amount: event.amount,
  //       tableId: event.tableId,
  //       bookingId: event.bookingId,
  //     ));
  //   }
  // }

  // Future<void> _saveHotelStatus({
  //   required String tableId,
  //   required String type,
  //   required Map<String, dynamic> request,
  //   required Map<String, dynamic> response,
  // }) async {
  //   try {
  //     final saveResponse = await http.post(
  //       Uri.parse('${baseUrl}hotel-status'),
  //       body: {
  //         "booking_id": tableId,
  //         "type": type,
  //         "request": jsonEncode(request),
  //         "response": jsonEncode(response),
  //       },
  //     );
  //     log('📩 Hotel status save response: ${saveResponse.body}');
  //   } catch (e) {
  //     log('💥 Hotel status save error: $e');
  //   }
  // }

  // Future<void> _onPaymentFail(_PaymentFail event, Emitter<HotelBookingState> emit) async {
  //   emit(HotelBookingLoading());
    
  //   try {
  //     final saveResult = await savePaymentDetails(
  //       orderId: event.orderId,
  //       status: 2,
  //       table: "hotel_data",
  //       tableid: event.tableId,
  //       transactionId: "",
  //     );

  //     emit(HotelBookingPaymentFailed(
  //       message: "Payment failed",
  //       orderId: event.orderId,
  //       tableId: event.tableId,
  //       bookingId: event.bookingId,
  //     ));
  //   } catch (e) {
  //     emit(HotelBookingPaymentFailed(
  //       message: "Payment failed with error: $e",
  //       orderId: event.orderId,
  //       tableId: event.tableId,
  //       bookingId: event.bookingId,
  //     ));
  //   }
  // }

  // Future<void> _onInitiateRefund(_InitiateRefund event, Emitter<HotelBookingState> emit) async {
  //   emit(HotelBookingRefundProcessing(
  //     orderId: event.orderId,
  //     transactionId: event.transactionId,
  //     amount: event.amount,
  //     tableId: event.tableId,
  //     bookingId: event.bookingId,
  //   ));

  //   try {
  //     final refundResult = await refundPayment(
  //       transactionId: event.transactionId,
  //       amount: event.amount,
  //       tableId: event.tableId,
  //       table: 'hotel_data',
  //     );

  //     if (refundResult['success']) {
  //       emit(HotelBookingRefundInitiated(
  //         message: refundResult['message'] ?? "Refund initiated successfully",
  //         orderId: event.orderId,
  //         transactionId: event.transactionId,
  //         amount: event.amount,
  //         tableId: event.tableId,
  //         bookingId: event.bookingId,
  //       ));
  //     } else {
  //       emit(HotelBookingRefundFailed(
  //         message: refundResult['message'] ?? "Refund failed",
  //         orderId: event.orderId,
  //         transactionId: event.transactionId,
  //         amount: event.amount,
  //         tableId: event.tableId,
  //         bookingId: event.bookingId,
  //       ));
  //     }
  //   } catch (e) {
  //     emit(HotelBookingRefundFailed(
  //       message: "Refund failed with error: $e",
  //       orderId: event.orderId,
  //       transactionId: event.transactionId,
  //       amount: event.amount,
  //       tableId: event.tableId,
  //       bookingId: event.bookingId,
  //     ));
  //   }
  // }

  // void _onStartLoading(_StartLoading event, Emitter<HotelBookingState> emit) {
  //   final currentState = state;
  //   if (currentState is! HotelBookingLoading) {
  //     emit(HotelBookingLoading(previousState: currentState));
  //   }
  // }

  // void _onStopLoading(_StopLoading event, Emitter<HotelBookingState> emit) {
  //   if (state is HotelBookingLoading) {
  //     final loadingState = state as HotelBookingLoading;
  //     if (loadingState.previousState != null) {
  //       emit(loadingState.previousState!);
  //     } else {
  //       emit(HotelBookingInitial());
  //     }
  //   }
//   }
// }