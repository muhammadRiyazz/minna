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
      emit(state.copyWith(isLoading: true));

      // First save payment details
      final paymentSaved = await _savePaymentDetails(
        event.orderId,
        event.transactionId,
        event.amount,
        event.paymentStatus,
        event.callbackId,
      );

      if (!paymentSaved) {
        emit(
          state.copyWith(
            isLoading: false,
            paymentSavedStatus: 'PAYMENT_SAVED_FAILED',
            orderId: event.orderId,
            transactionId: event.transactionId,
            amount: event.amount,
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          paymentSavedStatus: 'PAYMENT_SAVED_SUCCESS',
          orderId: event.orderId,
          transactionId: event.transactionId,
          amount: event.amount,
        ),
      );

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
            actualStatus: rechargeResult['actualStatus'],
            errorMessage: rechargeResult['message'],
          ),
        );
      } else {
        String errorMessage = rechargeResult['message'] ?? 'Recharge failed';

        log("rechargeStatus FAILED: $errorMessage");

        emit(
          state.copyWith(
            isLoading: false,
            rechargeStatus: 'FAILED',
            actualStatus: rechargeResult['actualStatus'],
            errorMessage: errorMessage,
          ),
        );
      }
    });

    on<PaymentFailed>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      // Save failed payment details
      await _savePaymentDetails(event.orderId, '', event.amount, 0,event.callbackId);

      emit(
        state.copyWith(
          isLoading: false,
          paymentSavedStatus: 'PAYMENT_FAILED',
          orderId: event.orderId,
          amount: event.amount,
        ),
      );
    });

    on<ResetStates>((event, emit) {
      emit(RechargeProceedState.initial());
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
        "mobNumber": phoneNo,
      };

      log("Mobile recharge request: ${body.toString()}");

      final response = await http.post(url, body: body);

      log(
        "Mobile recharge response: ${response.statusCode} - ${response.body}",
      );

      if (response.statusCode == 200) {
        String body = response.body;

        // Sanitize response: Find the first occurrence of '{' or '[' to handle cases where 
        // the server might prepend text to the JSON response.
        int jsonStartIndex = body.indexOf('{');
        int listStartIndex = body.indexOf('[');
        int startIndex = -1;

        if (jsonStartIndex != -1 && listStartIndex != -1) {
          startIndex = jsonStartIndex < listStartIndex ? jsonStartIndex : listStartIndex;
        } else {
          startIndex = jsonStartIndex != -1 ? jsonStartIndex : listStartIndex;
        }

        if (startIndex != -1) {
          body = body.substring(startIndex);
        }

        dynamic responseData = jsonDecode(body);

        // Handle both List and Map response formats
        Map<String, dynamic> json;
        if (responseData is List) {
          json = responseData.isNotEmpty
              ? Map<String, dynamic>.from(responseData[0])
              : {};
          log("Mobile response is List, using first element");
        } else if (responseData is Map) {
          json = Map<String, dynamic>.from(responseData);
          log("Mobile response is Map");
        } else {
          return {
            'success': false,
            'shouldRefund': true,
            'message': 'Invalid response format',
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

            final responseData = data['responseData'];
            Map<String, dynamic> responseDataMap = {};
            if (responseData is Map) {
              responseDataMap = Map<String, dynamic>.from(responseData);
            } else if (responseData is String && responseData.isNotEmpty) {
              try {
                responseDataMap = Map<String, dynamic>.from(
                  jsonDecode(responseData),
                );
              } catch (e) {
                log('Error parsing responseData string: $e');
              }
            }

            final int trnStatus =
                int.tryParse(responseDataMap['TRNSTATUS']?.toString() ?? '') ??
                0;
            String actualStatus = 'Unknown';
            bool isSuccess = false;

            // Mapping TRNSTATUS as requested
            switch (trnStatus) {
              case 1:
                actualStatus = "SUCCESS";
                isSuccess = true;
                break;
              case 2:
                actualStatus = "Operator Failed";
                break;
              case 3:
                actualStatus = "System Failed";
                break;
              case 4:
                actualStatus = "On Hold";
                isSuccess = true; // Still "Success" in terms of API acceptance
                break;
              case 5:
                actualStatus = "Refunded";
                break;
              case 6:
                actualStatus = "In Process";
                isSuccess = true; // Still "Success" in terms of API acceptance
                break;
              default:
                actualStatus = data['rechargeStatus']?.toString() ?? 'FAILED';
                isSuccess = actualStatus.toUpperCase() == 'SUCCESS';
            }

            final statusDesc =
                responseDataMap['STATUSMSG']?.toString() ??
                responseDataMap['TRNSTATUSDESC']?.toString() ??
                json['statusDesc']?.toString() ??
                'Recharge failed';

            return {
              'success': isSuccess,
              'actualStatus': actualStatus,
              'message': statusDesc,
            };
          } else {
            return {
              'success': false,
              'actualStatus': 'FAILED',
              'message': 'No data received from recharge API',
            };
          }
        } else {
          // API call failed
          final statusDesc =
              json['statusDesc']?.toString() ?? 'Something went wrong';
          return {
            'success': false,
            'actualStatus': 'FAILED',
            'message': statusDesc,
          };
        }
      } else {
        // HTTP error
        return {
          'success': false,
          'shouldRefund': true,
          'message': 'Network error: ${response.statusCode}',
        };
      }
    } catch (e) {
      log('Mobile recharge error: $e');
      return {
        'success': false,
        'shouldRefund': true,
        'message': 'Connection error: ${e.toString()}',
      };
    }
  }

  Future<bool> _savePaymentDetails(
    String orderId,
    String transactionId,
    String amount,
    int status,
    String insterId,

  ) async {
    log("_savePaymentDetails ---");
    try {
      final url = Uri.parse('${baseUrl}paysave');

      final body = {
        "id": insterId,
        "order_id": orderId,
        "transaction_id": transactionId,
        "status": status.toString(),
        "table": "mm_mobilerecharge",
      };

      log('request body--- ${body.toString()}');
      final response = await http.post(
        url,
        // headers: {'Content-Type': 'application/json'},
        body: body,
      );
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
}
