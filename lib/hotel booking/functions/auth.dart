import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:minna/hotel%20booking/core/core.dart';
import 'package:minna/hotel%20booking/domain/authentication/authendication.dart';

class AuthApiService {
  static final AuthApiService _instance = AuthApiService._internal();
  factory AuthApiService() => _instance;
  AuthApiService._internal();

  static const String _baseAuthUrl = 'http://Sharedapi.tektravels.com/SharedData.svc/rest';
  static const String _baseHotelUrl = 'https://affiliate.tektravels.com/HotelAPI';

  String? _tokenId;
  Member? _currentMember;
  String _clientId = 'ApiIntegrationNew';
  
  // Get current IP address
  String get _endUserIp => '192.168.1.1'; // Replace with actual IP detection

  // Get current authentication info
  AuthInfo? get authInfo {
    if (_tokenId == null || _currentMember == null) {
      return null;
    }
    return AuthInfo(
      tokenId: _tokenId!,
      member: _currentMember!,
      clientId: _clientId,
      endUserIp: _endUserIp,
    );
  }

  // Check if authenticated
  bool get isAuthenticated => _tokenId != null && _currentMember != null;

  Future<ApiResult<AuthenticateResponse>> authenticate() async {
    log('authenticate ------------------------------');
    try {
      final request = AuthenticateRequest(
        clientId: _clientId,
        userName: "Rinoware",
        password: "Rinoware@123",
        endUserIp: _endUserIp,
      );

      final response = await http.post(
        Uri.parse('$_baseAuthUrl/Authenticate'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(request.toJson()),
      );
      
      log('authenticate respo--');
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
        clientId: _clientId,
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

  // UPDATED: PreBook with authentication info included
  Future<ApiResult<PreBookResponseWithAuth>> preBookRoomWithAuth({
    required String bookingCode,
  }) async {
    try {
      // First ensure we're authenticated
      if (!isAuthenticated) {
        final authResult = await authenticate();
        if (!authResult.isSuccess) {
          return ApiResult.error('Authentication failed: ${authResult.error}');
        }
      }

      // Now make the prebook call
      final preBookResult = await _preBookRoomInternal(bookingCode: bookingCode);
      
      if (preBookResult.isSuccess) {
        // Wrap the response with authentication info
        final responseWithAuth = PreBookResponseWithAuth(
          preBookResponse: preBookResult.data!,
          tokenId: _tokenId!,
          agencyId: _currentMember!.agencyId,
          memberId: _currentMember!.memberId,
          endUserIp: _endUserIp,
          clientId: _clientId,
        );
        
        return ApiResult.success(responseWithAuth);
      } else {
        return ApiResult.error(preBookResult.error ?? 'Prebook failed');
      }
    } catch (e) {
      log('PreBook Error: $e');
      return ApiResult.error('Network error: $e');
    }
  }

  // Internal prebook method (without auth)
  Future<ApiResult<PreBookResponse>> _preBookRoomInternal({
    required String bookingCode,
  }) async {
    try {
      final String basicAuth = 'Basic ${base64Encode(utf8.encode('$livehotelusername:$livehoteluserpass'))}';
      final request = PreBookRequest(bookingCode: bookingCode);

      final response = await http.post(
        Uri.parse('$_baseHotelUrl/PreBook'),
        headers: {
          'Authorization': basicAuth,
          'Content-Type': 'application/json',
        },
        body: json.encode(request.toJson()),
      );

      log('PreBook Request: ${json.encode(request.toJson())}');
      log('PreBook Response: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final preBookResponse = PreBookResponse.fromJson(data);

        if (preBookResponse.isSuccess) {
          return ApiResult.success(preBookResponse);
        } else {
          return ApiResult.error(
            'Pre-book failed: ${preBookResponse.status.description}',
          );
        }
      } else {
        return ApiResult.error('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      log('PreBook Error: $e');
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

  // Get confirmation data for navigation
  ConfirmationData? getConfirmationData(PreBookResponse preBookResponse) {
    if (!isAuthenticated) {
      return null;
    }
    
    return ConfirmationData(
      preBookResponse: preBookResponse,
      tokenId: _tokenId!,
      agencyId: _currentMember!.agencyId,
      memberId: _currentMember!.memberId,
      endUserIp: _endUserIp,
      clientId: _clientId,
    );
  }
}

// Helper class for authentication info
class AuthInfo {
  final String tokenId;
  final Member member;
  final String clientId;
  final String endUserIp;

  AuthInfo({
    required this.tokenId,
    required this.member,
    required this.clientId,
    required this.endUserIp,
  });

  ConfirmationData toConfirmationData(PreBookResponse preBookResponse) {
    return ConfirmationData(
      preBookResponse: preBookResponse,
      tokenId: tokenId,
      agencyId: member.agencyId,
      memberId: member.memberId,
      endUserIp: endUserIp,
      clientId: clientId,
    );
  }
}