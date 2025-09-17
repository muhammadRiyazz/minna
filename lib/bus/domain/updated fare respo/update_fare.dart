class UpdatedFareResponse {
  final double convenienceFee;
  final double otherCharges;
  final double previousFare;
  final double reservationCharges;
  final double updatedFare;
  final List<FareBreakup> fareBreakup;

  UpdatedFareResponse({
    required this.convenienceFee,
    required this.otherCharges,
    required this.previousFare,
    required this.reservationCharges,
    required this.updatedFare,
    required this.fareBreakup,
  });

  factory UpdatedFareResponse.fromJson(Map<String, dynamic> json) {
    return UpdatedFareResponse(
      convenienceFee: (json['convenienceFee'] ?? 0).toDouble(),
      otherCharges: (json['otherCharges'] ?? 0).toDouble(),
      previousFare: (json['previousFare'] ?? 0).toDouble(),
      reservationCharges: (json['reservationCharges'] ?? 0).toDouble(),
      updatedFare: (json['updatedFare'] ?? 0).toDouble(),
      fareBreakup: (json['fareBreakup'] as List<dynamic>? ?? [])
          .map((e) => FareBreakup.fromJson(e))
          .toList(),
    );
  }
}

class FareBreakup {
  final String seatName;
  final List<CustomerPriceBreakUp> customerPriceBreakUp;

  FareBreakup({
    required this.seatName,
    required this.customerPriceBreakUp,
  });

  factory FareBreakup.fromJson(Map<String, dynamic> json) {
    return FareBreakup(
      seatName: json['seatName'].toString(),
      customerPriceBreakUp: (json['customerPriceBreakUp'] as List<dynamic>? ?? [])
          .map((e) => CustomerPriceBreakUp.fromJson(e))
          .toList(),
    );
  }
}

class CustomerPriceBreakUp {
  final String key;
  final double value;

  CustomerPriceBreakUp({
    required this.key,
    required this.value,
  });

  factory CustomerPriceBreakUp.fromJson(Map<String, dynamic> json) {
    return CustomerPriceBreakUp(
      key: json['key'].toString(),
      value: (json['value'] ?? 0).toDouble(),
    );
  }
}
