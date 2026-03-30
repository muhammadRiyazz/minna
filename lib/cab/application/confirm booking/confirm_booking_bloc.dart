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

class ConfirmBookingBloc
    extends Bloc<ConfirmBookingEvent, ConfirmBookingState> {
  ConfirmBookingBloc() : super(ConfirmBookingInitial()) {
    on<_PaymentDone>((event, emit) async {
      emit(ConfirmBookingLoading());
      log(
        '🟢 PaymentDone event received with: '
        'orderId=${event.orderId}, '
        'bookingId=${event.bookingid}, '
        'tableId=${event.tableid}, '
        'transactionId=${event.transactionId}, '
        'amount=${event.amount}',
      );

      try {
        log('🔹 Calling savePaymentDetails...');
        final saveResult = await savePaymentDetails(
          orderId: event.orderId,
          status: 1,
          table: "cab_data",
          tableid: event.tableid,
          transactionId: event.transactionId,
        );
        log('✅ savePaymentDetails result: $saveResult');

        if (!saveResult['success']) {
          // final refundResult = await refundPayment(
          //       transactionId: event.transactionId,
          //       amount: event.amount,
          //       tableId: event.tableid,
          //       table: 'cab_data',
          //     );

          // if (refundResult['success']) {
          //     emit(ConfirmBookingRefundInitiated(
          //       message: refundResult['message'] ?? "Refund initiated successfully",
          //       orderId: event.orderId,
          //       transactionId: event.transactionId,
          //       amount: event.amount,
          //       tableid: event.tableid,
          //       bookingid: event.bookingid,
          //     ));
          //   } else {
          //     emit(ConfirmBookingRefundFailed(
          //       message: refundResult['message'] ?? "Refund failed",
          //       orderId: event.orderId,
          //       transactionId: event.transactionId,
          //       amount: event.amount,
          //       tableid: event.tableid,
          //       bookingid: event.bookingid,
          //     ));
          //   }

          log('❌ Payment save failed');
          emit(
            ConfirmBookingPaymentSavedFailed(
              message: "Payment details could not be saved",
              orderId: event.orderId,
              shouldRefund: true,
              transactionId: event.transactionId,
              amount: event.amount,
              tableid: event.tableid,
              bookingid: event.bookingid,
            ),
          );
          return;
        }

        log('🔹 Calling confirm booking API...');
        final response = await http.post(
          Uri.parse('http://gozotech2.ddns.net:5192/api/cpapi/booking/confirm'),
          headers: {
            'Authorization': cabauth,
            'Content-Type': 'application/json',
          },
          body: jsonEncode({"bookingId": event.bookingid}),
        );

        log("📩 confirm API Response code: ${response.statusCode}");
        log("📩 confirm API Response body: ${response.body}");

        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final confirmBookingResponse = BookingConfirmResponse.fromJson(
          jsonData,
        );
        log(
          "✅ confirmBookingResponse.success = ${confirmBookingResponse.success}",
        );

        if (confirmBookingResponse.success) {
          log('🔹 Calling cab-status API for success...');
          try {
            final saveResponse = await http.post(
              Uri.parse('${baseUrl}cab-status'),
              body: {
                "booking_id": event.tableid.toString(),
                "type": "confirm",
                "request": jsonEncode({"bookingId": event.bookingid}),
                "response": jsonEncode(jsonData),
              },
            );

            log("📩 cab-status Response code: ${saveResponse.statusCode}");
            log("📩 cab-status Response body: ${saveResponse.body}");

            final saveJson = jsonDecode(saveResponse.body);

            if (saveJson["status"] == "success") {
              log("✅ cab-status saved successfully");
              emit(ConfirmBookingSuccess(data: confirmBookingResponse.data!));
            } else {
              log("❌ cab-status save failed: ${saveJson["message"]}");
              emit(
                ConfirmBookingError(
                  message: "Failed to save booking. Please try again.",
                  shouldRefund: false,
                  orderId: event.orderId,
                  transactionId: event.transactionId,
                  amount: event.amount,
                  tableid: event.tableid,
                  bookingid: event.bookingid,
                ),
              );
            }
          } catch (e) {
            log("💥 Exception while saving cab-status: $e");
            emit(
              ConfirmBookingError(
                message: "Booking succeeded, but saving failed: $e",
                shouldRefund: false,
                orderId: event.orderId,
                transactionId: event.transactionId,
                amount: event.amount,
                tableid: event.tableid,
                bookingid: event.bookingid,
              ),
            );
          }
        } else {
          log(
            "❌ confirmBookingResponse.success == false, initiating failed save + refund",
          );
          try {
            final saveResponse = await http.post(
              Uri.parse('${baseUrl}cab-status'),

              body: {
                "booking_id": event.tableid.toString(),
                "type": "failure",
                "request": jsonEncode({"bookingId": event.bookingid}),
                "response": jsonEncode(jsonData),
              },
            );

            log("📩 cab-status failed Response body: ${saveResponse.body}");

            final refundResult = await refundPayment(
              transactionId: event.transactionId,
              amount: event.amount,
              tableId: event.tableid,
              table: 'cab_data',
            );

            if (refundResult['success']) {
              emit(
                ConfirmBookingRefundInitiated(
                  message:
                      refundResult['message'] ??
                      "Refund initiated successfully",
                  orderId: event.orderId,
                  transactionId: event.transactionId,
                  amount: event.amount,
                  tableid: event.tableid,
                  bookingid: event.bookingid,
                ),
              );
            } else {
              emit(
                ConfirmBookingRefundFailed(
                  message: refundResult['message'] ?? "Refund failed",
                  orderId: event.orderId,
                  transactionId: event.transactionId,
                  amount: event.amount,
                  tableid: event.tableid,
                  bookingid: event.bookingid,
                ),
              );
            }

            emit(
              ConfirmBookingRefundInitiated(
                message: "Booking confirmation failed. Refund initiated.",
                orderId: event.orderId,
                transactionId: event.transactionId,
                amount: event.amount,
                tableid: event.tableid,
                bookingid: event.bookingid,
              ),
            );
          } catch (e) {
            log("💥 Failed to save failed status: $e");
            emit(
              ConfirmBookingError(
                message: "Booking failed and couldn't save status",
                shouldRefund: true,
                orderId: event.orderId,
                transactionId: event.transactionId,
                amount: event.amount,
                tableid: event.tableid,
                bookingid: event.bookingid,
              ),
            );
          }
        }
      } catch (e) {
        await http.post(
          Uri.parse('${baseUrl}cab-status'),
          body: {
            "booking_id": event.tableid.toString(),
            "type": "failure",
            "request": jsonEncode({"bookingId": event.bookingid}),
            "response": "",
          },
        );

        log("💥 Outer try-catch Error: $e");
        emit(
          ConfirmBookingError(
            message: e.toString(),
            shouldRefund: true,
            orderId: event.orderId,
            transactionId: event.transactionId,
            amount: event.amount,
            tableid: event.tableid,
            bookingid: event.bookingid,
          ),
        );
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
          emit(
            ConfirmBookingPaymentFailed(
              message: "Payment failed",
              orderId: event.orderId,
              tableid: event.tableid,
              bookingid: event.bookingid,
            ),
          );
        } else {
          emit(
            ConfirmBookingPaymentFailed(
              message: "Payment failed and couldn't save details",
              orderId: event.orderId,
              tableid: event.tableid,
              bookingid: event.bookingid,
            ),
          );
        }
      } catch (e) {
        emit(
          ConfirmBookingPaymentFailed(
            message: "Payment failed with error: $e",
            orderId: event.orderId,
            tableid: event.tableid,
            bookingid: event.bookingid,
          ),
        );
      }
    });
    // In your ConfirmBookingBloc
    on<_StartLoading>((event, emit) async {
      // Store the current state as previous state before going to loading
      final currentState = state;
      if (currentState is! ConfirmBookingLoading) {
        emit(ConfirmBookingLoading(previousState: currentState));
      }
    });

    on<_StopLoading>((event, emit) async {
      // Return to the previous state if it exists, otherwise go to initial
      if (state is ConfirmBookingLoading) {
        final loadingState = state as ConfirmBookingLoading;
        if (loadingState.previousState != null) {
          emit(loadingState.previousState!);
        } else {
          emit(ConfirmBookingInitial());
        }
      }
    });

    on<_InitiateRefund>((event, emit) async {
      emit(
        ConfirmBookingRefundProcessing(
          orderId: event.orderId,
          transactionId: event.transactionId,
          amount: event.amount,
          tableid: event.tableid,
          bookingid: event.bookingid,
        ),
      );

      try {
        final refundResult = await refundPayment(
          transactionId: event.transactionId,
          amount: event.amount,
          tableId: event.tableid,
          table: 'cab_data',
        );

        if (refundResult['success']) {
          emit(
            ConfirmBookingRefundInitiated(
              message:
                  refundResult['message'] ?? "Refund initiated successfully",
              orderId: event.orderId,
              transactionId: event.transactionId,
              amount: event.amount,
              tableid: event.tableid,
              bookingid: event.bookingid,
            ),
          );
        } else {
          emit(
            ConfirmBookingRefundFailed(
              message: refundResult['message'] ?? "Refund failed",
              orderId: event.orderId,
              transactionId: event.transactionId,
              amount: event.amount,
              tableid: event.tableid,
              bookingid: event.bookingid,
            ),
          );
        }
      } catch (e) {
        emit(
          ConfirmBookingRefundFailed(
            message: "Refund failed with error: $e",
            orderId: event.orderId,
            transactionId: event.transactionId,
            amount: event.amount,
            tableid: event.tableid,
            bookingid: event.bookingid,
          ),
        );
      }
    });
  }
}
