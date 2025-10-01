import 'package:flutter/material.dart';
import 'package:minna/comman/core/api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CommissionProvider with ChangeNotifier {
  final CommissionService _commissionService = CommissionService();
  double? _cachedCommission;
  bool _isLoading = false;

  double? get commission => _cachedCommission;
  bool get isLoading => _isLoading;

  Future<double> getCommission() async {
    _isLoading = true;
    notifyListeners();

    try {
      _cachedCommission = await _commissionService.getCommission();
      _isLoading = false;
      notifyListeners();
      return _cachedCommission!;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<double> calculateAmountWithCommission(double amount) async {
    return await _commissionService.calculateAmountWithCommission(amount);
  }
}

class CommissionService {
  static final CommissionService _instance = CommissionService._internal();
  factory CommissionService() => _instance;
  CommissionService._internal();

  static const String _baseUrl = '${baseUrl}commission';
  
  double? _cachedCommission;
  DateTime? _lastFetchTime;
  static const Duration _cacheDuration = Duration(hours: 1); // Cache for 1 hour

  Future<double> getCommission() async {
    // Return cached commission if available and not expired
    if (_cachedCommission != null && 
        _lastFetchTime != null && 
        DateTime.now().difference(_lastFetchTime!) < _cacheDuration) {
      return _cachedCommission!;
    }

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        body: {'type': 'cab'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        
        if (data['status'] == 'success') {
          _cachedCommission = (data['commission'] as num).toDouble();
          _lastFetchTime = DateTime.now();
          return _cachedCommission!;
        } else {
          throw Exception(data['message'] ?? 'Failed to get commission');
        }
      } else {
        throw Exception('HTTP ${response.statusCode}');
      }
    } catch (e) {
      // If API call fails but we have cached value, return cached value
      if (_cachedCommission != null) {
        return _cachedCommission!;
      }
      throw Exception('Failed to fetch commission: $e');
    }
  }

  // Calculate amount with commission
  Future<double> calculateAmountWithCommission(double amount) async {
    final commission = await getCommission();
    return amount + (amount * commission / 100);
  }

  // Clear cache (useful for testing or when you want to force refresh)
  void clearCache() {
    _cachedCommission = null;
    _lastFetchTime = null;
  }

  // Check if commission is cached
  bool get isCommissionCached => _cachedCommission != null;
}