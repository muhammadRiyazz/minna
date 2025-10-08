import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:minna/hotel%20booking/domain/authentication/authendication.dart';

class AuthApiService {
  static final AuthApiService _instance = AuthApiService._internal();
  factory AuthApiService() => _instance;
  AuthApiService._internal();

  static const String _baseAuthUrl = 'http://Sharedapi.tektravels.com/SharedData.svc/rest';
  static const String _baseHotelUrl = 'https://affiliate.tektravels.com/HotelAPI';

  String? _tokenId;
  Member? _currentMember;

  // Get current IP address (you might want to implement this properly)
  String get _endUserIp => '192.168.1.1'; // Replace with actual IP detection

  Future<ApiResult<AuthenticateResponse>> authenticate() async {
    try {
      final request = AuthenticateRequest(
        clientId: 'ApiIntegrationNew',
        userName: "Rinoware",
        password: "Rinoware@123",
        endUserIp: _endUserIp,
      );

      final response = await http.post(
        Uri.parse('$_baseAuthUrl/Authenticate'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(request.toJson()),
      );
log(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final authResponse = AuthenticateResponse.fromJson(data);
        
        if (authResponse.isSuccess) {
          _tokenId = authResponse.tokenId;
          _currentMember = authResponse.member;
          return ApiResult.success(authResponse);
        } else {
          return ApiResult.error('Authentication failed: ${authResponse.error.errorMessage}');
        }
      } else {
        return ApiResult.error('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResult.error('Network error: $e');
    }
  }

  Future<ApiResult<AgencyBalanceResponse>> getAgencyBalance() async {
    if (_tokenId == null || _currentMember == null) {
      return ApiResult.error('Please authenticate first');
    }

    try {
      final request = AgencyBalanceRequest(
        clientId: 'ApiIntegrationNew',
        tokenAgencyId: _currentMember!.agencyId.toString(),
        tokenMemberId: _currentMember!.memberId.toString(),
        endUserIp: _endUserIp,
        tokenId: _tokenId!,
      );

      final response = await http.post(
        Uri.parse('$_baseAuthUrl/GetAgencyBalance'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(request.toJson()),
      );
log(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final balanceResponse = AgencyBalanceResponse.fromJson(data);
        
        if (balanceResponse.isSuccess) {
          return ApiResult.success(balanceResponse);
        } else {
          return ApiResult.error('Failed to get balance: ${balanceResponse.error.errorMessage}');
        }
      } else {
        return ApiResult.error('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResult.error('Network error: $e');
    }
  }

  Future<ApiResult<PreBookResponse>> preBookRoom({
    required String bookingCode,
  }) async {
    try {
      final request = PreBookRequest(bookingCode: bookingCode);

      final response = await http.post(
        Uri.parse('$_baseHotelUrl/PreBook'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(request.toJson()),
      );
      log(json.encode(request.toJson()));
log(response.body)
;      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final preBookResponse = PreBookResponse.fromJson(data);
        
        if (preBookResponse.isSuccess) {
          return ApiResult.success(preBookResponse);
        } else {
          return ApiResult.error('Pre-book failed: ${preBookResponse.status.description}');
        }
      } else {
        return ApiResult.error('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResult.error('Network error: $e');
    }
  }

  // Helper method to check if user has sufficient balance
  Future<bool> checkSufficientBalance(double roomAmount) async {
    final balanceResult = await getAgencyBalance();
    if (balanceResult.isSuccess) {
      final balance = balanceResult.data!;
      return balance.cashBalance >= roomAmount;
    }
    return false;
  }

  // Clear session
  void clearSession() {
    _tokenId = null;
    _currentMember = null;
  }
}

// Generic result class for API responses
class ApiResult<T> {
  final T? data;
  final String? error;
  final bool isSuccess;

  ApiResult.success(this.data) 
      : error = null, 
        isSuccess = true;

  ApiResult.error(this.error) 
      : data = null, 
        isSuccess = false;
}