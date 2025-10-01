// lib/water_electricity/domain/bill_payment_model.dart

import 'package:flutter/material.dart';

class BillPaymentResponse {
  final String status;
  final int statusCode;
  final String statusDesc;
  final List<BillPaymentModel> data;

  BillPaymentResponse({
    required this.status,
    required this.statusCode,
    required this.statusDesc,
    required this.data,
  });

  factory BillPaymentResponse.fromJson(Map<String, dynamic> json) {
    return BillPaymentResponse(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      statusDesc: json['statusDesc'] ?? '',
      data: (json['data'] as List? ?? [])
          .map((item) => BillPaymentModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'statusCode': statusCode,
      'statusDesc': statusDesc,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }

  bool get isSuccess => status == 'SUCCESS';
}

class BillPaymentModel {
  final String id;
  final String billerCategory;
  final String mobile;
  final String txtConsumer;
  final String txtAmount;
  final String billStatus;
  final String dateTime;
  final String responce;
  final String paymentStatus;
  final String paymentDateTime;
  final String orderId;
  final String transactionId;
  final String receiptId;
  final String refundStatus;
  final String refundDate;

  BillPaymentModel({
    required this.id,
    required this.billerCategory,
    required this.mobile,
    required this.txtConsumer,
    required this.txtAmount,
    required this.billStatus,
    required this.dateTime,
    required this.responce,
    required this.paymentStatus,
    required this.paymentDateTime,
    required this.orderId,
    required this.transactionId,
    required this.receiptId,
    required this.refundStatus,
    required this.refundDate,
  });

  factory BillPaymentModel.fromJson(Map<String, dynamic> json) {
    return BillPaymentModel(
      id: json['id']?.toString() ?? '',
      billerCategory: json['billerCategory']?.toString() ?? '',
      mobile: json['mobile']?.toString() ?? '',
      txtConsumer: json['txtConsumer']?.toString() ?? '',
      txtAmount: json['txtAmount']?.toString() ?? '',
      billStatus: json['billStatus']?.toString() ?? '',
      dateTime: json['dateTime']?.toString() ?? '',
      responce: json['responce']?.toString() ?? '',
      paymentStatus: json['paymentStatus']?.toString() ?? '',
      paymentDateTime: json['paymentDateTime']?.toString() ?? '',
      orderId: json['orderId']?.toString() ?? '',
      transactionId: json['transactionId']?.toString() ?? '',
      receiptId: json['receiptId']?.toString() ?? '',
      refundStatus: json['refundStatus']?.toString() ?? '',
      refundDate: json['refundDate']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'billerCategory': billerCategory,
      'mobile': mobile,
      'txtConsumer': txtConsumer,
      'txtAmount': txtAmount,
      'billStatus': billStatus,
      'dateTime': dateTime,
      'responce': responce,
      'paymentStatus': paymentStatus,
      'paymentDateTime': paymentDateTime,
      'orderId': orderId,
      'transactionId': transactionId,
      'receiptId': receiptId,
      'refundStatus': refundStatus,
      'refundDate': refundDate,
    };
  }

  // Helper methods for UI
  String get formattedDate {
    try {
      final date = DateTime.parse(dateTime);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateTime;
    }
  }

  String get formattedAmount {
    if (txtAmount.isEmpty) return '₹0.00';
    return '₹$txtAmount';
  }

  Color get statusColor {
    switch (billStatus.toLowerCase()) {
      case 'success':
        return Colors.green;
      case 'failure':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData get statusIcon {
    switch (billStatus.toLowerCase()) {
      case 'success':
        return Icons.check_circle;
      case 'failure':
        return Icons.error;
      case 'pending':
        return Icons.pending;
      default:
        return Icons.help;
    }
  }

  String get displayStatus {
    switch (billStatus.toLowerCase()) {
      case 'success':
        return 'Successful';
      case 'failure':
        return 'Failed';
      case 'pending':
        return 'Pending';
      default:
        return billStatus;
    }
  }

  Color get paymentStatusColor {
    return paymentStatus == '1' ? Colors.green : Colors.red;
  }

  String get paymentStatusText {
    return paymentStatus == '1' ? 'PAID' : 'UNPAID';
  }

  String get consumerNumber {
    return txtConsumer;
  }

  String get amount {
    return txtAmount;
  }
}