import 'package:flutter/foundation.dart';
import 'package:minna/flight/infrastracture/commission/commission_service.dart';

class CommissionProvider with ChangeNotifier {
  final FlightCommissionService commissionService = FlightCommissionService();
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasData => commissionService.hasValidData;

  Future<void> initializeCommissionData() async {
    await _loadCommissionData();
  }

  Future<void> _loadCommissionData({bool forceRefresh = false}) async {
    if (!forceRefresh && commissionService.hasValidData) {
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await commissionService.fetchCommissionRules(forceRefresh: forceRefresh);
      _error = null;
    } catch (e) {
      _error = e.toString();
      print('Error loading commission data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshCommissionData() async {
    await _loadCommissionData(forceRefresh: true);
  }

  double calculateCommission({
    required double actualAmount,
    required String travelType,
  }) {
    if (!commissionService.hasValidData) {
      throw Exception('Commission data not available. Please initialize first.');
    }
    
    return commissionService.calculateCommission(
      actualAmount: actualAmount,
      travelType: travelType,
    );
  }

  double getTotalAmountWithCommission({
    required double actualAmount,
    required String travelType,
  }) {
    if (!commissionService.hasValidData) {
      throw Exception('Commission data not available. Please initialize first.');
    }
    
    return commissionService.getTotalAmountWithCommission(
      actualAmount: actualAmount,
      travelType: travelType,
    );
  }
}