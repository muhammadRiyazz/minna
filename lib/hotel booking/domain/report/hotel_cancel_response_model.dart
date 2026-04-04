
class HotelCancelResponse {
  final bool status;
  final String message;
  final HotelCancelData? data;

  HotelCancelResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory HotelCancelResponse.fromJson(Map<String, dynamic> json) {
    return HotelCancelResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? HotelCancelData.fromJson(json['data']) : null,
    );
  }
}

class HotelCancelData {
  final bool? b2b2bStatus;
  final CancellationChargeBreakdown? cancellationChargeBreakUp;
  final double? totalServiceCharge;
  final int? responseStatus;
  final TboError? error;
  final String? traceId;
  final int? changeRequestId;
  final double? refundedAmount;
  final double? totalPrice;
  final int? changeRequestStatus;
  final String? creditNoteNo;
  final String? creditNoteCreatedOn;

  HotelCancelData({
    this.b2b2bStatus,
    this.cancellationChargeBreakUp,
    this.totalServiceCharge,
    this.responseStatus,
    this.error,
    this.traceId,
    this.changeRequestId,
    this.refundedAmount,
    this.totalPrice,
    this.changeRequestStatus,
    this.creditNoteNo,
    this.creditNoteCreatedOn,
  });

  factory HotelCancelData.fromJson(Map<String, dynamic> json) {
    return HotelCancelData(
      b2b2bStatus: json['B2B2BStatus'],
      cancellationChargeBreakUp: json['CancellationChargeBreakUp'] != null
          ? CancellationChargeBreakdown.fromJson(json['CancellationChargeBreakUp'])
          : null,
      totalServiceCharge: (json['TotalServiceCharge'] as num?)?.toDouble(),
      responseStatus: json['ResponseStatus'],
      error: json['Error'] != null ? TboError.fromJson(json['Error']) : null,
      traceId: json['TraceId'],
      changeRequestId: json['ChangeRequestId'],
      refundedAmount: (json['RefundedAmount'] as num?)?.toDouble(),
      totalPrice: (json['TotalPrice'] as num?)?.toDouble(),
      changeRequestStatus: json['ChangeRequestStatus'],
      creditNoteNo: json['CreditNoteNo'],
      creditNoteCreatedOn: json['CreditNoteCreatedOn'],
    );
  }
}

class CancellationChargeBreakdown {
  final double? cancellationFees;
  final double? cancellationServiceCharge;

  CancellationChargeBreakdown({
    this.cancellationFees,
    this.cancellationServiceCharge,
  });

  factory CancellationChargeBreakdown.fromJson(Map<String, dynamic> json) {
    return CancellationChargeBreakdown(
      cancellationFees: (json['CancellationFees'] as num?)?.toDouble(),
      cancellationServiceCharge: (json['CancellationServiceCharge'] as num?)?.toDouble(),
    );
  }
}

class TboError {
  final int? errorCode;
  final String? errorMessage;

  TboError({
    this.errorCode,
    this.errorMessage,
  });

  factory TboError.fromJson(Map<String, dynamic> json) {
    return TboError(
      errorCode: json['ErrorCode'],
      errorMessage: json['ErrorMessage'],
    );
  }
}
