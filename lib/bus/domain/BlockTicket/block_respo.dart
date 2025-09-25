class BlockResponse {
  final String blockKey;
  final FareBreakup? fareBreakup;

  BlockResponse({
    required this.blockKey,
    this.fareBreakup,
  });

  factory BlockResponse.fromJson(Map<String, dynamic> json) {
    return BlockResponse(
      blockKey: json['blockKey'] ?? '',
      fareBreakup: json['fareBreakup'] != null
          ? FareBreakup.fromJson(json['fareBreakup'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'blockKey': blockKey,
      'fareBreakup': fareBreakup?.toJson(),
    };
  }
}

class FareBreakup {
  final String asnFare;
  final String boConcessionAmount;
  final String bookingFee;
  final String convenienceFee;
  final FareBreakupDetails? fareBreakup;
  final String otherCharges;
  final String previousFare;
  final String reservationFee;
  final dynamic seatWiseDiscountBreakup;
  final String serviceCharge;
  final String streakDiscount;
  final dynamic streakSeatWiseDiscountBreakup;
  final String tollFee;
  final String updatedFare;
  final String updatedOperatorServiceCharge;
  final String updatedServiceTax;
  final String whatsappDiscount;

  FareBreakup({
    required this.asnFare,
    required this.boConcessionAmount,
    required this.bookingFee,
    required this.convenienceFee,
    this.fareBreakup,
    required this.otherCharges,
    required this.previousFare,
    required this.reservationFee,
    this.seatWiseDiscountBreakup,
    required this.serviceCharge,
    required this.streakDiscount,
    this.streakSeatWiseDiscountBreakup,
    required this.tollFee,
    required this.updatedFare,
    required this.updatedOperatorServiceCharge,
    required this.updatedServiceTax,
    required this.whatsappDiscount,
  });

  factory FareBreakup.fromJson(Map<String, dynamic> json) {
    return FareBreakup(
      asnFare: json['asnFare'] ?? '0',
      boConcessionAmount: json['boConcessionAmount'] ?? '0',
      bookingFee: json['bookingFee'] ?? '0',
      convenienceFee: json['convenienceFee'] ?? '0',
      fareBreakup: json['fareBreakup'] != null
          ? FareBreakupDetails.fromJson(json['fareBreakup'])
          : null,
      otherCharges: json['otherCharges'] ?? '0',
      previousFare: json['previousFare'] ?? '0',
      reservationFee: json['reservationFee'] ?? '0',
      seatWiseDiscountBreakup: json['seatWiseDiscountBreakup'],
      serviceCharge: json['serviceCharge'] ?? '0',
      streakDiscount: json['streakDiscount'] ?? '0',
      streakSeatWiseDiscountBreakup: json['streakSeatWiseDiscountBreakup'],
      tollFee: json['tollFee'] ?? '0',
      updatedFare: json['updatedFare'] ?? '0',
      updatedOperatorServiceCharge: json['updatedOperatorServiceCharge'] ?? '0',
      updatedServiceTax: json['updatedServiceTax'] ?? '0',
      whatsappDiscount: json['whatsappDiscount'] ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'asnFare': asnFare,
      'boConcessionAmount': boConcessionAmount,
      'bookingFee': bookingFee,
      'convenienceFee': convenienceFee,
      'fareBreakup': fareBreakup?.toJson(),
      'otherCharges': otherCharges,
      'previousFare': previousFare,
      'reservationFee': reservationFee,
      'seatWiseDiscountBreakup': seatWiseDiscountBreakup,
      'serviceCharge': serviceCharge,
      'streakDiscount': streakDiscount,
      'streakSeatWiseDiscountBreakup': streakSeatWiseDiscountBreakup,
      'tollFee': tollFee,
      'updatedFare': updatedFare,
      'updatedOperatorServiceCharge': updatedOperatorServiceCharge,
      'updatedServiceTax': updatedServiceTax,
      'whatsappDiscount': whatsappDiscount,
    };
  }
}

class FareBreakupDetails {
  final FareBreakups? fareBreakups;

  FareBreakupDetails({this.fareBreakups});

  factory FareBreakupDetails.fromJson(Map<String, dynamic> json) {
    return FareBreakupDetails(
      fareBreakups: json['fareBreakups'] != null
          ? FareBreakups.fromJson(json['fareBreakups'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fareBreakups': fareBreakups?.toJson(),
    };
  }
}

class FareBreakups {
  final List<CustomerPriceBreakUp> customerPriceBreakUp;
  final String seatName;

  FareBreakups({
    required this.customerPriceBreakUp,
    required this.seatName,
  });

  factory FareBreakups.fromJson(Map<String, dynamic> json) {
    return FareBreakups(
      customerPriceBreakUp: (json['customerPriceBreakUp'] as List? ?? [])
          .map((e) => CustomerPriceBreakUp.fromJson(e))
          .toList(),
      seatName: json['seatName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerPriceBreakUp':
          customerPriceBreakUp.map((e) => e.toJson()).toList(),
      'seatName': seatName,
    };
  }
}

class CustomerPriceBreakUp {
  final String cancellationHandling;
  final String componentName;
  final String refundableValue;
  final String type;
  final String value;

  CustomerPriceBreakUp({
    required this.cancellationHandling,
    required this.componentName,
    required this.refundableValue,
    required this.type,
    required this.value,
  });

  factory CustomerPriceBreakUp.fromJson(Map<String, dynamic> json) {
    return CustomerPriceBreakUp(
      cancellationHandling: json['cancellationHandling'] ?? '',
      componentName: json['componentName'] ?? '',
      refundableValue: json['refundableValue'] ?? '0',
      type: json['type'] ?? '',
      value: json['value'] ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cancellationHandling': cancellationHandling,
      'componentName': componentName,
      'refundableValue': refundableValue,
      'type': type,
      'value': value,
    };
  }
}
