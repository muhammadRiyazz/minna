class BbpsDynamicBiller {
  final String billerId;
  final String billerName;

  BbpsDynamicBiller({required this.billerId, required this.billerName});

  factory BbpsDynamicBiller.fromJson(Map<String, dynamic> json) {
    return BbpsDynamicBiller(
      billerId: json['billerId'] ?? '',
      billerName: json['billerName'] ?? '',
    );
  }
}

class BbpsDynamicBillerInfo {
  final bool success;
  final String billerName;
  final List<BbpsDynamicBillerParam> billerInputParams;

  BbpsDynamicBillerInfo({
    required this.success,
    required this.billerName,
    required this.billerInputParams,
  });

  factory BbpsDynamicBillerInfo.fromJson(Map<String, dynamic> json) {
    return BbpsDynamicBillerInfo(
      success: json['success'] ?? false,
      billerName: json['billerName'] ?? '',
      billerInputParams: (json['billerInputParams'] as List? ?? [])
          .map((e) => BbpsDynamicBillerParam.fromJson(e))
          .toList(),
    );
  }
}

class BbpsDynamicBillerParam {
  final String paramName;
  final String dataType;
  final int minLength;
  final int maxLength;
  final String? regex;
  final bool isOptional;

  BbpsDynamicBillerParam({
    required this.paramName,
    required this.dataType,
    required this.minLength,
    required this.maxLength,
    this.regex,
    required this.isOptional,
  });

  factory BbpsDynamicBillerParam.fromJson(Map<String, dynamic> json) {
    return BbpsDynamicBillerParam(
      paramName: json['paramName'] ?? '',
      dataType: json['dataType'] ?? '',
      minLength: json['minLength'] ?? 0,
      maxLength: json['maxLength'] ?? 0,
      regex: json['regex'],
      isOptional: json['isOptional'] == 'true' || json['isOptional'] == true,
    );
  }
}

class BbpsDynamicBillResponse {
  final bool success;
  final BbpsDynamicBill? bill;
  final String? paymentExactness;
  final bool? billerAdhoc;
  final double? maxBillAmount;
  final double? minBillAmount;

  BbpsDynamicBillResponse({
    required this.success,
    this.bill,
    this.paymentExactness,
    this.billerAdhoc,
    this.maxBillAmount,
    this.minBillAmount,
  });

  factory BbpsDynamicBillResponse.fromJson(Map<String, dynamic> json) {
    final billJson = json['bill'] as Map<String, dynamic>?;
    final maxAmount = json['maxBillAmount'] ?? billJson?['maxBillAmount'];
    final minAmount = json['minBillAmount'] ?? billJson?['minBillAmount'];

    return BbpsDynamicBillResponse(
      success: json['success'] ?? false,
      bill: billJson != null ? BbpsDynamicBill.fromJson(billJson) : null,
      paymentExactness: json['paymentExactness'] ?? billJson?['paymentExactness'],
      billerAdhoc: json['billerAdhoc'] == true || json['billerAdhoc'] == 'true' || 
                   billJson?['billerAdhoc'] == true || billJson?['billerAdhoc'] == 'true',
      maxBillAmount: maxAmount != null ? double.tryParse(maxAmount.toString()) : null,
      minBillAmount: minAmount != null ? double.tryParse(minAmount.toString()) : null,
    );
  }
}

class BbpsDynamicBill {
  final String consumerName;
  final double amount;
  final String amountPaise;
  final String billerName;
  final String reqId;
  final String consumerNo;
  final String? billNumber;
  final List<BbpsDynamicAdditionalInfo> additionalInfo;

  BbpsDynamicBill({
    required this.consumerName,
    required this.amount,
    required this.amountPaise,
    required this.billerName,
    required this.reqId,
    required this.consumerNo,
    this.billNumber,
    required this.additionalInfo,
  });

  factory BbpsDynamicBill.fromJson(Map<String, dynamic> json) {
    return BbpsDynamicBill(
      consumerName: json['consumerName'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      amountPaise: json['amountPaise']?.toString() ?? '0',
      billerName: json['billerName'] ?? '',
      reqId: json['reqId'] ?? '',
      consumerNo: json['consumerNo'] ?? '',
      billNumber: json['billNumber']?.toString(),
      additionalInfo: (json['additionalInfo'] as List? ?? [])
          .map((e) => BbpsDynamicAdditionalInfo.fromJson(e))
          .toList(),
    );
  }
}

class BbpsDynamicAdditionalInfo {
  final String infoName;
  final String infoValue;

  BbpsDynamicAdditionalInfo({
    required this.infoName,
    required this.infoValue,
  });

  factory BbpsDynamicAdditionalInfo.fromJson(Map<String, dynamic> json) {
    return BbpsDynamicAdditionalInfo(
      infoName: json['infoName'] ?? '',
      infoValue: json['infoValue']?.toString() ?? '',
    );
  }
}
