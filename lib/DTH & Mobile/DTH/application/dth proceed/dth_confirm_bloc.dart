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

      // Now proceed with DTH recharge
      final rechargeResult = await _processDthRecharge(
        event.phoneNo,
        event.operator,
        event.amount,
        event.subcriberNo,
        event.callbackId,
      );

      emit(
        state.copyWith(
          isLoading: false,
          rechargeStatus: rechargeResult['success'] ? "SUCCESS" : "FAILED",
          actualStatus: rechargeResult['actualStatus'],
          errorMessage: rechargeResult['message'],
        ),
      );
    });

    on<PaymentFailed>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      // Save failed payment details
      await _savePaymentDetails(
        event.orderId,
        '',
        event.amount,
        0,
        event.callbackId,
      );

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
      emit(DthConfirmState.initial());
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
      final url = Uri.parse('${baseUrl}dth-recharges');
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
          json = responseData.isNotEmpty
              ? Map<String, dynamic>.from(responseData[0])
              : {};
          log("DTH response is List, using first element");
        } else if (responseData is Map) {
          // Cast Map<dynamic, dynamic> to Map<String, dynamic>
          json = Map<String, dynamic>.from(responseData);
          log("DTH response is Map");
        } else {
          return {
            'success': false,
            'shouldRefund': true,
            'message': 'Invalid response format',
          };
        }

        log("Parsed DTH response: $json");

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

            switch (trnStatus) {
              case 1:
                actualStatus = 'SUCCESS';
                isSuccess = true;
                break;
              case 2:
                actualStatus = 'Operator Failed';
                break;
              case 3:
                actualStatus = 'System Failed';
                break;
              case 4:
                actualStatus = 'On Hold';
                break;
              case 5:
                actualStatus = 'Refunded';
                break;
              case 6:
                actualStatus = 'In Process';
                break;
              default:
                actualStatus = data['rechargeStatus']?.toString() ?? 'Pending';
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
      log('DTH recharge error: $e');
      return {
        'success': false,
        'shouldRefund': true,
        'message': 'Connection error: ${e.toString()}',
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
    String insterId,
  ) async {
    log("DTH _savePaymentDetails ---");
    try {
      final url = Uri.parse('${baseUrl}paysave');

      final body = {
        "id": insterId,
        "order_id": orderId,
        "transaction_id": transactionId,
        "status": status.toString(),
        "table": "mm_mobilerecharge", // Fixed table name
      };

      log('DTH payment save request: ${body.toString()}');
      final response = await http.post(url, body: body);
      log(
        'DTH payment save response: ${response.statusCode} - ${response.body}',
      );

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
}
