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
      final rechargeResult = await _processMobileRecharge(
        event.phoneNo,
        event.operator,
        event.amount,
        event.callbackId,
      );

      if (rechargeResult['success']) {
        emit(
          state.copyWith(
            isLoading: false,
            rechargeStatus: "SUCCESS",
            hasRechargeFailedHandled: false,
          ),
        );
      } else {
        bool shouldRefund = rechargeResult['shouldRefund'] ?? true;
        String errorMessage = rechargeResult['message'] ?? 'Recharge failed';
        
        log("rechargeStatus FAILED: $errorMessage");
        
        emit(state.copyWith(
          isLoading: false,
          rechargeStatus: 'FAILED',
          shouldRefund: shouldRefund,
          hasRechargeFailedHandled: true,
          // errorMessage: errorMessage,
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

  Future<Map<String, dynamic>> _processMobileRecharge(
    String phoneNo,
    String operator,
    String amount,
    String callbackId,
  ) async {
    try {
      final url = Uri.parse('${baseUrl}mobile-recharge');
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final userId = preferences.getString('userId') ?? '';

      final body = {
        "insert_id": callbackId,
        "userId": userId,
        "operator": operator,
        "amount": amount,
        "mobNumber": phoneNo
      };

      log("Mobile recharge request: ${body.toString()}");
      
      final response = await http.post(url, body: body);
      
      log("Mobile recharge response: ${response.statusCode} - ${response.body}");

      if (response.statusCode == 200) {
        dynamic responseData = jsonDecode(response.body);
        
        // Handle both List and Map response formats
        Map<String, dynamic> json;
        if (responseData is List) {
          json = responseData.isNotEmpty ? 
                Map<String, dynamic>.from(responseData[0]) : {};
          log("Mobile response is List, using first element");
        } else if (responseData is Map) {
          json = Map<String, dynamic>.from(responseData);
          log("Mobile response is Map");
        } else {
          return {
            'success': false,
            'shouldRefund': true,
            'message': 'Invalid response format'
          };
        }

        log("Parsed Mobile response: $json");
        
        // Check if the API call was successful
        if (json['status'] == 'SUCCESS' && json['statusCode'] == 0) {
          // Check the actual recharge status in data
          if (json['data'] != null) {
            final Map<String, dynamic> data = json['data'] is Map 
                ? Map<String, dynamic>.from(json['data']) 
                : {};
            
            final rechargeStatus = data['rechargeStatus']?.toString() ?? '';
            
            // Check for successful recharge status - including PENDING/ACCEPTED
            if (rechargeStatus.toUpperCase() == 'SUCCESS' || 
                rechargeStatus.toLowerCase() == 'success' 
                // rechargeStatus.contains('ACCEPTED') ||
                // rechargeStatus.contains('PENDING')
                )
                 {
              return {
                'success': true,
                'message': 'Mobile recharge successful'
              };
            } else {
              // Recharge failed but API call was successful
              final statusDesc = json['statusDesc']?.toString() ?? 'Recharge failed';
              final responseData = data['responseData'];
              
              String detailedError = statusDesc;
              
              // Extract detailed error from nested responseData
              if (responseData is Map) {
                final responseDataMap = Map<String, dynamic>.from(responseData);
                detailedError = responseDataMap['STATUSMSG']?.toString() ?? statusDesc;
              } else if (responseData is String && responseData.isNotEmpty) {
                try {
                  final responseJson = jsonDecode(responseData);
                  final responseJsonMap = Map<String, dynamic>.from(responseJson);
                  detailedError = responseJsonMap['STATUSMSG']?.toString() ?? statusDesc;
                } catch (e) {
                  log('Error parsing responseData string: $e');
                }
              }
              
              
              return {
                'success': false,
                'shouldRefund': true,
                'message': detailedError
              };
            }
          } else {
            return {
              'success': false,
              'shouldRefund': true,
              'message': 'No data received from recharge API'
            };
          }
        } else {
          // API call failed
          final statusDesc = json['statusDesc']?.toString() ?? 'Something went wrong';
          final statusCode = json['statusCode'] ?? 1;
          
          // Determine if we should refund based on error type
          
          return {
            'success': false,
            'shouldRefund': true,
            'message': statusDesc
          };
        }
      } else {
        // HTTP error
        return {
          'success': false,
          'shouldRefund': true,
          'message': 'Network error: ${response.statusCode}'
        };
      }
    } catch (e) {
      log('Mobile recharge error: $e');
      return {
        'success': false,
        'shouldRefund': true,
        'message': 'Connection error: ${e.toString()}'
      };
    }
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
        try {
          final json = jsonDecode(response.body) as Map<String, dynamic>;
          return json['status'] == 'success' || json['status'] == 'SUCCESS';
        } catch (e) {
          log('Error parsing payment save response: $e');
          return false;
        }
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
    
    try {
      final url = Uri.parse('${baseUrl}payrefund');

      final body = {
        "id": tableId,
        "transaction_id": transactionId,
        'amount': amount,
        "table": "mm_mobilerecharge",
      };
      
      log("Refund request body: ${body.toString()}");
      
      final response = await http.post(url, body: body);
      log('_processRefund response body: ${response.body.toString()}');

      if (response.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
          bool success = jsonResponse['status'] == 'SUCCESS' || 
                         jsonResponse['status'] == 'success';
          
          log("Refund API success: $success");
          return success;
        } catch (e) {
          log('Error parsing refund response: $e');
          return false;
        }
      }
      
      log("Refund API failed with status: ${response.statusCode}");
      return false;
      
    } catch (e) {
      log('Refund processing error: $e');
      return false;
    }
  }
}