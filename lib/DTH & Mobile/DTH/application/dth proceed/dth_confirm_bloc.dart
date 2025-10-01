import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:minna/comman/core/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'dth_confirm_event.dart';
part 'dth_confirm_state.dart';
part 'dth_confirm_bloc.freezed.dart';

class DthConfirmBloc extends Bloc<DthConfirmEvent, DthConfirmState> {
  DthConfirmBloc() : super(DthConfirmState.initial()) {
    
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

      // Now proceed with DTH recharge
      final rechargeResult = await _processDthRecharge(
        event.phoneNo,
        event.operator,
        event.amount,
        event.subcriberNo,
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
        // Check if we should refund based on the error type
        bool shouldRefund = rechargeResult['shouldRefund'] ?? true;
        String errorMessage = rechargeResult['message'] ?? 'Recharge failed';
        
        log("DTH rechargeStatus FAILED: $errorMessage");
        
        emit(state.copyWith(
          isLoading: false,
          rechargeStatus: 'FAILED',
          shouldRefund: shouldRefund,
          hasRechargeFailedHandled: true,
          errorMessage: errorMessage,
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
      log("DTH InitiateRefund - Starting refund process");
      
      // Check if refund has already been attempted
      if (state.hasRefundBeenAttempted) {
        log("DTH Refund already attempted, skipping...");
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
        log('DTH Refund error: $e');
        emit(state.copyWith(
          isLoading: false,
          isRefundInProgress: false,
          refundStatus: 'REFUND_FAILED',
          hasRefundBeenAttempted: true,
        ));
      }
    });

    on<ResetStates>((event, emit) {
      emit(DthConfirmState.initial());
    });

    on<MarkRefundAttempted>((event, emit) {
      emit(state.copyWith(hasRefundBeenAttempted: true));
    });
  }

 Future<Map<String, dynamic>> _processDthRecharge(
  String phoneNo,
  String operator,
  String amount,
  String subcriberNo,
  String callbackId,
) async {
  try {
    final url = Uri.parse('${baseUrl}dth-recharge');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString('userId') ?? '';

    final body = {
      "insertid": callbackId,
      "userId": userId,
      "mobNumber": phoneNo,
      "operator": operator,
      "amount": amount,
      "subcriberNo": subcriberNo,
    };

    log("DTH recharge request: ${body.toString()}");
    
    final response = await http.post(url, body: body);
    
    log("DTH recharge response status: ${response.statusCode}");
    log("DTH recharge response body: ${response.body}");

    if (response.statusCode == 200) {
      dynamic responseData = jsonDecode(response.body);
      
      // Handle both List and Map response formats with proper type casting
      Map<String, dynamic> json;
      if (responseData is List) {
        // If response is a list, take the first element and cast it
        json = responseData.isNotEmpty ? 
              Map<String, dynamic>.from(responseData[0]) : {};
        log("DTH response is List, using first element");
      } else if (responseData is Map) {
        // Cast Map<dynamic, dynamic> to Map<String, dynamic>
        json = Map<String, dynamic>.from(responseData);
        log("DTH response is Map");
      } else {
        return {
          'success': false,
          'shouldRefund': true,
          'message': 'Invalid response format'
        };
      }

      log("Parsed DTH response: $json");
      
      // Check if the API call was successful
      if (json['status'] == 'SUCCESS' && json['statusCode'] == 0) {
        // Check the actual recharge status in data
        if (json['data'] != null) {
          // Cast data to Map<String, dynamic>
          final Map<String, dynamic> data = json['data'] is Map 
              ? Map<String, dynamic>.from(json['data']) 
              : {};
          
          final rechargeStatus = data['rechargeStatus']?.toString() ?? '';
          
          // Check for successful recharge status
          if (rechargeStatus.toUpperCase() == 'SUCCESS' || 
              rechargeStatus.toLowerCase() == 'success' ||
              rechargeStatus.toLowerCase() == 'completed') {
            return {
              'success': true,
              'message': 'DTH recharge successful'
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
            
            // bool shouldRefund = _shouldRefundBasedOnError(detailedError);
            
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
        // bool shouldRefund = _shouldRefundBasedOnError(statusDesc);
        
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
    log('DTH recharge error: $e');
    return {
      'success': false,
      'shouldRefund': true,
      'message': 'Connection error: ${e.toString()}'
    };
  }
}

  // bool _shouldRefundBasedOnError(String errorMessage) {
  //   if (errorMessage.isEmpty) return true;

  //   // List of errors that should NOT trigger refund (user input errors)
  //   final noRefundErrors = [
  //     'invalid customer no',
  //     'invalid subscriber id',
  //     'invalid number',
  //     'customer not found',
  //     'invalid amount',
  //     'invalid operator',
  //     'customer no should be numeric',
  //     'should be numeric',
  //     'it should be start with 0',
  //     'subscriber id should start with 0'
  //   ];

  //   // Convert to lowercase for case-insensitive matching
  //   final lowerError = errorMessage.toLowerCase();
    
  //   // Check if this is a user input error (no refund)
  //   for (final error in noRefundErrors) {
  //     if (lowerError.contains(error)) {
  //       log("No refund needed for user input error: $errorMessage");
  //       return false;
  //     }
  //   }
    
  //   // Default to refund for system/technical errors
  //   log("Refund needed for system error: $errorMessage");
  //   return true;
  // }

  Future<bool> _savePaymentDetails(
    String orderId,
    String transactionId,
    String amount,
    int status,
  ) async {
    log("DTH _savePaymentDetails ---");
    try {
      final url = Uri.parse('${baseUrl}paysave');
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final userId = preferences.getString('userId') ?? '';

      final body = {
        "id": userId,
        "order_id": orderId,
        "transaction_id": transactionId,
        "status": status.toString(),
        "table": "mm_mobilerecharge", // Fixed table name
      };
      
      log('DTH payment save request: ${body.toString()}');
      final response = await http.post(url, body: body);
      log('DTH payment save response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        try {
          final json = jsonDecode(response.body);
          return json['status'] == 'success' || json['status'] == 'SUCCESS';
        } catch (e) {
          log('Error parsing payment save response: $e');
          return false;
        }
      }
      log('Payment save failed with status: ${response.statusCode}');
      return false;
    } catch (e) {
      log('DTH Save payment error: $e');
      return false;
    }
  }

  Future<bool> _processRefund(
    String orderId,
    String transactionId,
    String amount,
    String tableId,
  ) async {
    log("DTH _processRefund--- orderId: $orderId, transactionId: $transactionId, tableId: $tableId");
    
    try {
      final url = Uri.parse('${baseUrl}payrefund');

      final body = {
        "id": tableId,
        "transaction_id": transactionId,
        'amount': amount,
        "table": "mm_mobilerecharge", // Fixed table name
      };
      
      log("DTH Refund request: ${body.toString()}");
      
      final response = await http.post(url, body: body);
      log('DTH Refund response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(response.body);
          bool success = jsonResponse['status'] == 'SUCCESS' || 
                         jsonResponse['status'] == 'success';
          
          log("DTH Refund API success: $success");
          return success;
        } catch (e) {
          log('Error parsing refund response: $e');
          return false;
        }
      }
      
      log("DTH Refund API failed with status: ${response.statusCode}");
      return false;
      
    } catch (e) {
      log('DTH Refund processing error: $e');
      return false;
    }
  }
}