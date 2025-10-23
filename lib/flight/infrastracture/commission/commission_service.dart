// commission_service.dart
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:minna/comman/core/api.dart';

class CommissionRule {
  final String travelType;
  final double amtUpto;
  final int uptoAbove; // 1 = upto, 0 = above
  final double commission;

  CommissionRule({
    required this.travelType,
    required this.amtUpto,
    required this.uptoAbove,
    required this.commission,
  });

  factory CommissionRule.fromJson(Map<String, dynamic> json) {
    return CommissionRule(
      travelType: json['travelType'],
      amtUpto: double.parse(json['amtUpto'].toString()),
      uptoAbove: int.parse(json['uptoAbove'].toString()),
      commission: double.parse(json['commission'].toString()),
    );
  }
}

class CommissionResponse {
  final String status;
  final int statusCode;
  final String statusDesc;
  final List<CommissionRule> data;

  CommissionResponse({
    required this.status,
    required this.statusCode,
    required this.statusDesc,
    required this.data,
  });

  factory CommissionResponse.fromJson(Map<String, dynamic> json) {
    return CommissionResponse(
      status: json['status'],
      statusCode: json['statusCode'],
      statusDesc: json['statusDesc'],
      data: (json['data'] as List)
          .map((item) => CommissionRule.fromJson(item))
          .toList(),
    );
  }
}

class FlightCommissionService {
  static final FlightCommissionService _instance = FlightCommissionService._internal();
  factory FlightCommissionService() => _instance;
  FlightCommissionService._internal();

  static const String _apiUrl = '${baseUrl}flight-service-charge';
  
  List<CommissionRule>? _commissionRules;
  DateTime? _lastFetchTime;
  static const Duration _cacheDuration = Duration(hours: 1);
  
  // Add the missing getter
  bool get hasValidData => 
      _commissionRules != null && 
      _lastFetchTime != null &&
      DateTime.now().difference(_lastFetchTime!) < _cacheDuration;

  Future<void> fetchCommissionRules({bool forceRefresh = false}) async {
    // Return if we have valid cached data and not forcing refresh
    if (hasValidData && !forceRefresh) {
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
      );
log(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final commissionResponse = CommissionResponse.fromJson(responseData);
        
        if (commissionResponse.status == 'SUCCESS') {
          _commissionRules = commissionResponse.data;
          _lastFetchTime = DateTime.now();
        } else {
          throw Exception('Failed to fetch commission rules: ${commissionResponse.statusDesc}');
        }
      } else {
        throw Exception('HTTP error ${response.statusCode}');
      }
    } catch (e) {
      // If we have old data, keep using it. Otherwise rethrow.
      if (_commissionRules == null) {
        rethrow;
      }
      // Log error but continue with cached data
      log('Commission API error: $e, using cached data if available');
    }
  }

  // Add the missing calculateCommission method
  double calculateCommission({
    required double actualAmount,
    required String travelType,
  }) {
    if (_commissionRules == null) {
      throw Exception('Commission rules not loaded');
    }

    // Filter rules for the specific travel type
    final relevantRules = _commissionRules!
        .where((rule) => rule.travelType == travelType)
        .toList();

    if (relevantRules.isEmpty) {
      throw Exception('No commission rules found for travel type: $travelType');
    }

    // Sort rules by amount
    relevantRules.sort((a, b) => a.amtUpto.compareTo(b.amtUpto));

    CommissionRule? matchingRule;

    // First, try to find "upto" rules (uptoAbove = 1)
    final uptoRules = relevantRules.where((rule) => rule.uptoAbove == 1).toList();
    for (final rule in uptoRules) {
      if (actualAmount <= rule.amtUpto) {
        matchingRule = rule;
        break;
      }
    }

    // If no "upto" rule found, look for "above" rules (uptoAbove = 0)
    if (matchingRule == null) {
      final aboveRules = relevantRules.where((rule) => rule.uptoAbove == 0).toList();
      if (aboveRules.isNotEmpty) {
        // For "above" rules, find the one with the highest amount threshold
        aboveRules.sort((a, b) => b.amtUpto.compareTo(a.amtUpto));
        for (final rule in aboveRules) {
          if (actualAmount > rule.amtUpto) {
            matchingRule = rule;
            break;
          }
        }
        // If no specific above rule matches, use the highest above rule
        matchingRule ??= aboveRules.first;
      }
    }

    // If still no rule found, use the highest upto rule as fallback
    matchingRule ??= uptoRules.last;

    return matchingRule.commission;
  }

  // Add the missing getTotalAmountWithCommission method
  double getTotalAmountWithCommission({
    required double actualAmount,
    required String travelType,
  }) {
    final commission = calculateCommission(
      actualAmount: actualAmount,
      travelType: travelType,
    );
    return actualAmount + commission;
  }

  // Clear cache (useful for testing or logout)
  void clearCache() {
    _commissionRules = null;
    _lastFetchTime = null;
  }

  // Helper method to get all commission rules (for debugging)
  List<CommissionRule>? get commissionRules => _commissionRules;
}