import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:minna/hotel%20booking/domain/authentication/authendication.dart';

class AuthApiService {
  static final AuthApiService _instance = AuthApiService._internal();
  factory AuthApiService() => _instance;
  AuthApiService._internal();

  static const String _baseUrl = 'https://mttrip.in';

  String? _token;
  Member? _currentMember;
  String _clientId = 'ApiIntegrationNew';

  // Get current IP address
  String get _endUserIp => '192.168.1.1'; // Replace with actual IP detection

  // Get current authentication info
  AuthInfo? get authInfo {
    if (_token == null || _currentMember == null) {
      return null;
    }
    return AuthInfo(
      token: _token!,
      member: _currentMember!,
      clientId: _clientId,
      endUserIp: _endUserIp,
    );
  }

  // Check if authenticated
  bool get isAuthenticated => _token != null && _currentMember != null;

  Future<ApiResult<AuthenticateResponse>> authenticate() async {
    log('authenticate mttrip ------------------------------');
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/hotel-api-authenticateApi'),
        headers: {'Content-Type': 'application/json'},
      );

      log('authenticate respo--');
      log(response.body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final authResponse = AuthenticateResponse.fromJson(data);

        if (authResponse.isSuccess) {
          _token = authResponse.token;
          _currentMember = authResponse.member;
          return ApiResult.success(authResponse);
        } else {
          return ApiResult.error(
            'Authentication failed: ${authResponse.message ?? "Unknown error"}',
          );
        }
      } else {
        return ApiResult.error('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      log('Authenticate Error: $e');
      return ApiResult.error('Network error: $e');
    }
  }

  Future<ApiResult<ServiceChargeResponse>> getServiceCharge() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/hotel-api-get-service-charge'),
        headers: {'Content-Type': 'application/json'},
      );

      log('Service Charge Response: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final chargeResponse = ServiceChargeResponse.fromJson(data);

        if (chargeResponse.status) {
          return ApiResult.success(chargeResponse);
        } else {
          return ApiResult.error('Failed to get service charge');
        }
      } else {
        return ApiResult.error('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      log('Service Charge Error: $e');
      return ApiResult.error('Network error: $e');
    }
  }

  Future<ApiResult<AgencyBalanceResponse>> getAgencyBalance() async {
    // Note: The user didn't provide a new endpoint for balance,
    // keeping the old one for now but it may need update to mttrip.in
    if (_token == null || _currentMember == null) {
      return ApiResult.error('Please authenticate first');
    }

    try {
      final request = AgencyBalanceRequest(
        clientId: _clientId,
        tokenAgencyId: _currentMember!.agencyId.toString(),
        tokenMemberId: _currentMember!.memberId.toString(),
        endUserIp: _endUserIp,
        tokenId: _token!,
      );

      final response = await http.post(
        Uri.parse(
          'http://Sharedapi.tektravels.com/SharedData.svc/rest/GetAgencyBalance',
        ),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final balanceResponse = AgencyBalanceResponse.fromJson(data);

        if (balanceResponse.isSuccess) {
          return ApiResult.success(balanceResponse);
        } else {
          return ApiResult.error(
            'Failed to get balance: ${balanceResponse.error.errorMessage}',
          );
        }
      } else {
        return ApiResult.error('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResult.error('Network error: $e');
    }
  }

  // UPDATED: PreBook using mttrip.in endpoint
  Future<ApiResult<PreBookResponseWithAuth>> preBookRoomWithAuth({
    required String bookingCode,
  }) async {
    try {
      if (!isAuthenticated) {
        final authResult = await authenticate();
        if (!authResult.isSuccess) {
          return ApiResult.error('Authentication failed: ${authResult.error}');
        }
      }

      final preBookResult = await _preBookRoomInternal(
        bookingCode: bookingCode,
      );

      if (preBookResult.isSuccess) {
        return ApiResult.success(
          PreBookResponseWithAuth(
            preBookResponse: preBookResult.data!,
            token: _token!,
            agencyId: _currentMember!.agencyId,
            memberId: _currentMember!.memberId,
            endUserIp: _endUserIp,
            clientId: _clientId,
          ),
        );
      } else {
        return ApiResult.error(preBookResult.error ?? 'Prebook failed');
      }
    } catch (e) {
      log('PreBook Error: $e');
      return ApiResult.error('Network error: $e');
    }
  }

  Future<ApiResult<PreBookResponse>> _preBookRoomInternal({
    required String bookingCode,
  }) async {
    log('preBookRoomInternal ------------------------------$bookingCode');
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/hotel-api-prebook'),
        body: {'bookingCode': bookingCode},
      );

      log('PreBook Request: ${json.encode({'bookingCode': bookingCode})}');
      log('PreBook Response: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final apiWrapper = PreBookApiResponse.fromJson(data);

        if (apiWrapper.isSuccess && apiWrapper.data != null) {
          return ApiResult.success(apiWrapper.data);
        } else {
          return ApiResult.error(
            apiWrapper.message.isNotEmpty
                ? apiWrapper.message
                : 'Pre-book failed',
          );
        }
      } else {
        return ApiResult.error('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      log('_preBookRoomInternal Error: $e');
      return ApiResult.error('Network error: $e');
    }
  }

  // Future<bool> checkSufficientBalance(double roomAmount) async {
  //   final balanceResult = await getAgencyBalance();
  //   if (balanceResult.isSuccess) {
  //     return balanceResult.data!.cashBalance >= roomAmount;
  //   }
  //   return false;
  // }

  void clearSession() {
    _token = null;
    _currentMember = null;
  }

  ConfirmationData? getConfirmationData(PreBookResponse preBookResponse) {
    if (!isAuthenticated) return null;
    return ConfirmationData(
      preBookResponse: preBookResponse,
      token: _token!,
      agencyId: _currentMember!.agencyId,
      memberId: _currentMember!.memberId,
      endUserIp: _endUserIp,
      clientId: _clientId,
    );
  }
}

// Helper class for authentication info
class AuthInfo {
  final String token;
  final Member member;
  final String clientId;
  final String endUserIp;

  AuthInfo({
    required this.token,
    required this.member,
    required this.clientId,
    required this.endUserIp,
  });

  ConfirmationData toConfirmationData(PreBookResponse preBookResponse) {
    return ConfirmationData(
      preBookResponse: preBookResponse,
      token: token,
      agencyId: member.agencyId,
      memberId: member.memberId,
      endUserIp: endUserIp,
      clientId: clientId,
    );
  }
}
