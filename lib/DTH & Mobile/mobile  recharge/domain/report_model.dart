import 'package:flutter/material.dart';

class TransactionModel {
  final String id;
  final String mobile;
  final String amount;
  final String status;
  final String? dthnumber;
  final String date;
  final String paidStatus;

  TransactionModel({
    required this.id,
    required this.mobile,
    required this.amount,
    required this.status,
    this.dthnumber,
    required this.date,
    required this.paidStatus,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id']?.toString() ?? '',
      mobile: json['mobile']?.toString() ?? '',
      amount: json['amount']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      dthnumber: json['dthnumber']?.toString(),
      date: json['date']?.toString() ?? '',
      paidStatus: json['paid_status']?.toString() ?? '',
    );
  }

  String get formattedDate {
    try {
      final dateTime = DateTime.parse(date);
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } catch (e) {
      return date;
    }
  }

  String get formattedAmount => '₹$amount';

  Color get statusColor {
    switch (status.toLowerCase()) {
      case 'success':
        return Colors.green;
      case 'pending':
      case 'accepted':
        return Colors.orange;
      case 'system failed':
      case 'operator failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData get statusIcon {
    switch (status.toLowerCase()) {
      case 'success':
        return Icons.check_circle;
      case 'pending':
      case 'accepted':
        return Icons.pending;
      case 'system failed':
      case 'operator failed':
        return Icons.error;
      default:
        return Icons.help;
    }
  }
}

class TransactionResponse {
  final String status;
  final List<TransactionModel> transactions;
  final String? errorMessage;

  TransactionResponse({
    required this.status,
    required this.transactions,
    this.errorMessage,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    if (json['status'] == 'errors') {
      return TransactionResponse(
        status: 'error',
        transactions: [],
        errorMessage: json['message']?.toString(),
      );
    }

    final List<dynamic> messageData = json['message'] ?? [];
    final transactions = messageData.map((item) {
      return TransactionModel.fromJson(item);
    }).toList();

    return TransactionResponse(
      status: json['status']?.toString() ?? '',
      transactions: transactions,
    );
  }

  bool get isSuccess => status == 'success';
  bool get isEmpty => transactions.isEmpty;
}