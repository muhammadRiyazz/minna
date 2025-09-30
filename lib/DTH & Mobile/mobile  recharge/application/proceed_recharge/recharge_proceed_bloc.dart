import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:minna/comman/core/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'recharge_proceed_event.dart';
part 'recharge_proceed_state.dart';
part 'recharge_proceed_bloc.freezed.dart';

class RechargeProceedBloc
    extends Bloc<RechargeProceedEvent, RechargeProceedState> {
  RechargeProceedBloc() : super(RechargeProceedState.initial()) {
    // on<Proceed>((event, emit) async {
    //   emit(state.copyWith(isLoading: true));

    //   final url = Uri.parse('${baseUrl}mobile-recharge');
    //   SharedPreferences preferences = await SharedPreferences.getInstance();
    //   final userId = preferences.getString('userId') ?? '';

    //   final body = {
    //     "insert_id":event.
    //     "userId": userId,
    //     "mobNumber": event.phoneNo,
    //     "operator": event.operator,
    //     "amount": event.amount,
    //   };

    //   try {
    //     final response = await http.post(url, body: body);

    //     if (response.statusCode == 200) {
    //       final json = jsonDecode(response.body);
    //       log(response.body);
    //       if (json['status'] == 'SUCCESS') {
    //         emit(
    //           state.copyWith(
    //             isLoading: false,
    //             rechargeStatus: json['data']['rechargeStatus'],
    //           ),
    //         );
    //       } else {
    //         emit(state.copyWith(isLoading: false, rechargeStatus: 'FAILED'));
    //       }
    //     } else {
    //       emit(state.copyWith(isLoading: false, rechargeStatus: 'FAILED'));
    //     }
    //   } catch (e) {
    //     log(e.toString());
    //     emit(state.copyWith(isLoading: false, rechargeStatus: 'FAILED'));
    //   }
    // });

    on<ProceedWithPayment>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      // First save payment details
      final paymentSaved = await _savePaymentDetails(
        event.orderId,
        event.transactionId,
        event.amount,
        event.paymentStatus,
      );

      if (!paymentSaved) {
        emit(state.copyWith(
          isLoading: false,
          paymentSavedStatus: 'PAYMENT_SAVED_FAILED',
          shouldRefund: true, // Refund since payment was successful but save failed
          orderId: event.orderId,
          transactionId: event.transactionId,
          amount: event.amount,
        ));
        return;
      }

      emit(state.copyWith(
        paymentSavedStatus: 'PAYMENT_SAVED_SUCCESS',
        orderId: event.orderId,
        transactionId: event.transactionId,
        amount: event.amount,
      ));

      // Now proceed with recharge
      final url = Uri.parse('${baseUrl}mobile-recharge');
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final userId = preferences.getString('userId') ?? '';

      final body = {
        "userId": userId,
        "mobNumber": event.phoneNo,
        "operator": event.operator,
        "amount": event.amount,
        "orderId": event.orderId,
        "transactionId": event.transactionId,
      };

      try {
        final response = await http.post(url, body: body);

        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);
          log(response.body);
          if (json['status'] == 'SUCCESS') {
            emit(
              state.copyWith(
                isLoading: false,
                rechargeStatus: json['data']['rechargeStatus'],
              ),
            );
          } else {
            emit(state.copyWith(
              isLoading: false,
              rechargeStatus: 'FAILED',
              shouldRefund: true, // Refund since recharge failed
            ));
          }
        } else {
          emit(state.copyWith(
            isLoading: false,
            rechargeStatus: 'FAILED',
            shouldRefund: true, // Refund since recharge failed
          ));
        }
      } catch (e) {
        log(e.toString());
        emit(state.copyWith(
          isLoading: false,
          rechargeStatus: 'FAILED',
          shouldRefund: true, // Refund since recharge failed
        ));
      }
    });

    on<PaymentFailed>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      // Save failed payment details
      await _savePaymentDetails(
        event.orderId,
        '',
        event.amount,
        0, // Payment failed status
      );

      emit(state.copyWith(
        isLoading: false,
        paymentSavedStatus: 'PAYMENT_FAILED',
        orderId: event.orderId,
        amount: event.amount,
      ));
    });

    on<InitiateRefund>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      try {
        final refundSuccess = await _processRefund(
          event.orderId,
          event.transactionId,
          event.amount,
        );

        if (refundSuccess) {
          emit(state.copyWith(
            isLoading: false,
            refundStatus: 'REFUND_INITIATED',
          ));
        } else {
          emit(state.copyWith(
            isLoading: false,
            refundStatus: 'REFUND_FAILED',
          ));
        }
      } catch (e) {
        log('Refund error: $e');
        emit(state.copyWith(
          isLoading: false,
          refundStatus: 'REFUND_FAILED',
        ));
      }
    });
  }

  Future<bool> _savePaymentDetails(
    String orderId,
    String transactionId,
    String amount,
    int status,
  ) async {
    try {
      final url = Uri.parse('${baseUrl}paysave');
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final userId = preferences.getString('userId') ?? '';

      final body = {
        "userId": userId,
        "orderId": orderId,
        "transactionId": transactionId,
        "amount": amount,
        "status": status.toString(),
        "table": "mm_mobilerecharge",
      };

      final response = await http.post(url, body: body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return json['status'] == 'SUCCESS';
      }
      return false;
    } catch (e) {
      log('Save payment error: $e');
      return false;
    }
  }

  Future<bool> _processRefund(
    String orderId,
    String transactionId,
    String amount,
  ) async {
    try {
      final url = Uri.parse('${baseUrl}initiate-refund');
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final userId = preferences.getString('userId') ?? '';

      final body = {
        "userId": userId,
        "orderId": orderId,
        "transactionId": transactionId,
        "amount": amount,
        "table": "mm_mobilerecharge",
      };

      final response = await http.post(url, body: body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return json['status'] == 'SUCCESS';
      }
      return false;
    } catch (e) {
      log('Refund processing error: $e');
      return false;
    }
  }
}