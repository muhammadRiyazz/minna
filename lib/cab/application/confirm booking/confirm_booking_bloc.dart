// confirm_booking_bloc.dart
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:minna/cab/domain/confirm%20model/confirm_model.dart';
import 'package:minna/comman/core/api.dart';
import 'package:minna/comman/functions/refund_payment.dart';
import 'package:minna/comman/functions/save_payment.dart';

part 'confirm_booking_event.dart';
part 'confirm_booking_state.dart';
part 'confirm_booking_bloc.freezed.dart';

class ConfirmBookingBloc extends Bloc<ConfirmBookingEvent, ConfirmBookingState> {
  ConfirmBookingBloc() : super(ConfirmBookingInitial()) {
    on<_PaymentDone>((event, emit) async {
      emit(ConfirmBookingLoading());
      log('ConfirmBookingBloc ...');

      try {
        log('savePaymentDetails ... call ---');

        final saveResult = await savePaymentDetails(
          orderId: event.orderId,
          status: 1,
          table: "cab_data",
          tableid: event.tableid,
          transactionId: event.transactionId,
        );

        if (!saveResult['success']) {
          
          emit(ConfirmBookingPaymentSavedFailed(
            message: "Payment details could not be saved",
            orderId: event.orderId,
            transactionId: event.transactionId,
            amount: event.amount,
            tableid: event.tableid,
            bookingid: event.bookingid,
          ));
          return;
        }

        final response = await http.post(
          Uri.parse('http://gozotech2.ddns.net:5192/api/cpapi/booking/confirm'),
          headers: {
            'Authorization': 'Basic ZjA2MjljNTIxZjE2MjU0NTA2YmIyMDQzNWI4MTJmMmE=',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "bookingId": event.bookingid
          }),
        );

        log("confirm API Response: ${response.body}");

        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final confirmBookingResponse = BookingConfirmResponse.fromJson(jsonData);

        if (confirmBookingResponse.success) {
//           try {
           
// final saveResponse = await http.post(
//   Uri.parse('${baseUrl}cab-status'),
//   body: {
//     "booking_id": event.tableid.toString(),   // ✅ ensure string
//     "type": "confirm",                        // ✅ plain text
//     "request": jsonEncode({"bookingId": event.bookingid}), // ✅ JSON
//     "response": jsonEncode(jsonData),         // ✅ JSON
//   },
// );


          //   log("cab-status Save Response: ${saveResponse.body}");
          //   final saveJson = jsonDecode(saveResponse.body);

          //   if (saveJson["status"] == "success") {
              emit(ConfirmBookingSuccess(data: confirmBookingResponse.data!));
          //   } else {
          //     emit(ConfirmBookingError(
          //       message: saveJson["message"] ?? "Failed to save booking. Please try again.",
          //       shouldRefund: false,
          //       orderId: event.orderId,
          //       transactionId: event.transactionId,
          //       amount: event.amount,
          //       tableid: event.tableid,
          //       bookingid: event.bookingid,
          //     ));
          //   }
          // } catch (e) {
          //   log("cab-status Save Error: $e");
          //   emit(ConfirmBookingError(
          //     message: "Booking succeeded, but saving failed: $e",
          //     shouldRefund: false,
          //     orderId: event.orderId,
          //     transactionId: event.transactionId,
          //     amount: event.amount,
          //     tableid: event.tableid,
          //     bookingid: event.bookingid,
          //   ));
          // }
        } else {
          // try {
            // final saveResponse = await http.post(
            //   Uri.parse('${baseUrl}cab-status'),
            //   body: {
            //     "booking_id": event.tableid,
            //     "request": jsonEncode({"bookingId": event.bookingid}),
            //     "response": jsonEncode(jsonData),
            //     "type": "failed"
            //   },
            // );

            // log("cab-status Save Response: ${saveResponse.body}");

            emit(ConfirmBookingRefundInitiated(
              message: "Booking confirmation failed. Refund initiated.",
              orderId: event.orderId,
              transactionId: event.transactionId,
              amount: event.amount,
              tableid: event.tableid,
              bookingid: event.bookingid,
            ));
          // } catch (e) {
          //   log("Failed to save failed status: $e");
          //   emit(ConfirmBookingError(
          //     message: "Booking failed and couldn't save status",
          //     shouldRefund: true,
          //     orderId: event.orderId,
          //     transactionId: event.transactionId,
          //     amount: event.amount,
          //     tableid: event.tableid,
          //     bookingid: event.bookingid,
          //   ));
          // }
        }
      } catch (e) {

        log("Error: $e");
        emit(ConfirmBookingError(
          message: e.toString(),
          shouldRefund: true,
          orderId: event.orderId,
          transactionId: event.transactionId,
          amount: event.amount,
          tableid: event.tableid,
          bookingid: event.bookingid,
        ));
      }
    });

    on<_PaymentFail>((event, emit) async {
      emit(ConfirmBookingLoading());
      
      try {
        final saveResult = await savePaymentDetails(
          orderId: event.orderId,
          status: 2,
          table: "cab_data",
          tableid: event.tableid,
          transactionId: "",
        );

        if (saveResult['success']) {
          emit(ConfirmBookingPaymentFailed(
            message: "Payment failed",
            orderId: event.orderId,
            tableid: event.tableid,
            bookingid: event.bookingid,
          ));
        } else {
          emit(ConfirmBookingPaymentFailed(
            message: "Payment failed and couldn't save details",
            orderId: event.orderId,
            tableid: event.tableid,
            bookingid: event.bookingid,
          ));
        }
      } catch (e) {
        emit(ConfirmBookingPaymentFailed(
          message: "Payment failed with error: $e",
          orderId: event.orderId,
          tableid: event.tableid,
          bookingid: event.bookingid,
        ));
      }
    });

    on<_InitiateRefund>((event, emit) async {
      emit(ConfirmBookingRefundProcessing(
        orderId: event.orderId,
        transactionId: event.transactionId,
        amount: event.amount,
        tableid: event.tableid,
        bookingid: event.bookingid,
      ));

      try {
        final refundResult = await refundPayment(
          transactionId: event.transactionId,
          amount: event.amount,
          tableId: event.tableid,
          table: 'cab_data',
        );

        if (refundResult['success']) {
          emit(ConfirmBookingRefundInitiated(
            message: refundResult['message'] ?? "Refund initiated successfully",
            orderId: event.orderId,
            transactionId: event.transactionId,
            amount: event.amount,
            tableid: event.tableid,
            bookingid: event.bookingid,
          ));
        } else {
          emit(ConfirmBookingRefundFailed(
            message: refundResult['message'] ?? "Refund failed",
            orderId: event.orderId,
            transactionId: event.transactionId,
            amount: event.amount,
            tableid: event.tableid,
            bookingid: event.bookingid,
          ));
        }
      } catch (e) {
        emit(ConfirmBookingRefundFailed(
          message: "Refund failed with error: $e",
          orderId: event.orderId,
          transactionId: event.transactionId,
          amount: event.amount,
          tableid: event.tableid,
          bookingid: event.bookingid,
        ));
      }
    });
  }
}