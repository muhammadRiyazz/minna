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
    
    on<ProceedWithPayment>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
        hasRefundBeenAttempted: false,
        hasRechargeFailedHandled: false,
        hasPaymentSaveFailedHandled: false,
      ));

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
          shouldRefund: true,
          orderId: event.orderId,
          transactionId: event.transactionId,
          amount: event.amount,
          hasPaymentSaveFailedHandled: true,
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
        "insert_id": event.callbackId,
        "userId": userId,
        "operator": event.operator,
        "amount": event.amount,
      };

      try {
        final response = await http.post(url, body: body);
        
        log(".repo body of conform recharge --- ${response.body.toString()}");
        
        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);
          log(response.body);
          
          if (json['status'] == 'SUCCESS') {
            emit(
              state.copyWith(
                isLoading: false,
                rechargeStatus: "SUCCESS",
                hasRechargeFailedHandled: false,
              ),
            );
          } else {
            log("rechargeStatus FAILED --case 1");
            emit(state.copyWith(
              isLoading: false,
              rechargeStatus: 'FAILED',
              shouldRefund: true,
              hasRechargeFailedHandled: true,
            ));
          }
        } else {
          log("rechargeStatus FAILED --case 2");
          emit(state.copyWith(
            isLoading: false,
            rechargeStatus: 'FAILED',
            shouldRefund: true,
            hasRechargeFailedHandled: true,
          ));
        }
      } catch (e) {
        log("rechargeStatus FAILED --case 3");
        log(e.toString());
        emit(state.copyWith(
          isLoading: false,
          rechargeStatus: 'FAILED',
          shouldRefund: true,
          hasRechargeFailedHandled: true,
        ));
      }
    });

    on<PaymentFailed>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
        hasRefundBeenAttempted: false,
      ));

      // Save failed payment details
      await _savePaymentDetails(
        event.orderId,
        '',
        event.amount,
        0,
      );

      emit(state.copyWith(
        isLoading: false,
        paymentSavedStatus: 'PAYMENT_FAILED',
        orderId: event.orderId,
        amount: event.amount,
      ));
    });

    on<InitiateRefund>((event, emit) async {
      log("InitiateRefund - Starting refund process");
      
      // Check if refund has already been attempted
      if (state.hasRefundBeenAttempted) {
        log("Refund already attempted, skipping...");
        return;
      }

      emit(state.copyWith(
        isLoading: true,
        isRefundInProgress: true,
        hasRefundBeenAttempted: true,
      ));

      try {
        final refundSuccess = await _processRefund(
          event.orderId,
          event.transactionId,
          event.amount,
          event.callbackId,
        );

        if (refundSuccess) {
          emit(state.copyWith(
            isLoading: false,
            isRefundInProgress: false,
            refundStatus: 'REFUND_INITIATED',
            hasRefundBeenAttempted: true,
          ));
          
          // Auto-reset after 2 seconds
          await Future.delayed(const Duration(seconds: 2));
          add(const RechargeProceedEvent.resetStates());
        } else {
          emit(state.copyWith(
            isLoading: false,
            isRefundInProgress: false,
            refundStatus: 'REFUND_FAILED',
            hasRefundBeenAttempted: true,
          ));
        }
      } catch (e) {
        log('Refund error: $e');
        emit(state.copyWith(
          isLoading: false,
          isRefundInProgress: false,
          refundStatus: 'REFUND_FAILED',
          hasRefundBeenAttempted: true,
        ));
      }
    });

    on<ResetStates>((event, emit) {
      emit(RechargeProceedState.initial());
    });

    on<MarkRefundAttempted>((event, emit) {
      emit(state.copyWith(hasRefundBeenAttempted: true));
    });
  }

  Future<bool> _savePaymentDetails(
    String orderId,
    String transactionId,
    String amount,
    int status,
  ) async {
    log("_savePaymentDetails ---");
    try {
      final url = Uri.parse('${baseUrl}paysave');
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final userId = preferences.getString('userId') ?? '';

      final body = {
        "id": userId,
        "order_id": orderId,
        "transaction_id": transactionId,
        "status": status.toString(),
        "table": "mm_mobilerecharge",
      };
      
      log('request body--- ${body.toString()}');
      final response = await http.post(url, body: body);
      log('response body--- ${response.body.toString()}');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return json['status'] == 'success';
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
    String tableId,
  ) async {
    log("_processRefund--- orderId: $orderId, transactionId: $transactionId");
    
    // try {
    //   final url = Uri.parse('${baseUrl}payrefund');

    //   final body = {
    //     "id": tableId,
    //     "transaction_id": transactionId,
    //     'amount': amount,
    //     "table": "mm_mobilerecharge",
    //   };
      
    //   log("Refund request body: ${body.toString()}");
      
    //   final response = await http.post(url, body: body);
    //   log('_processRefund response body: ${response.body.toString()}');

    //   if (response.statusCode == 200) {
    //     final jsonResponse = jsonDecode(response.body);
    //     bool success = jsonResponse['status'] == 'SUCCESS' || 
    //                    jsonResponse['status'] == 'success';
        
    //     log("Refund API success: $success");
    //     return success;
    //   }
      
    //   log("Refund API failed with status: ${response.statusCode}");
    //   return false;
      
    // } catch (e) {
    //   log('Refund processing error: $e');
    //   return false;
    // }
    return true;
  }
}