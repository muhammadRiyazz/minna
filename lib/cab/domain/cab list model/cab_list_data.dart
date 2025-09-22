
class CabResponse {
  final bool success;
  final CabData data;

  CabResponse({
    required this.success,
    required this.data,
  });

  factory CabResponse.fromJson(Map<String, dynamic> json) {
    return CabResponse(
      success: json['success'] as bool,
      data: CabData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
    };
  }
}

class CabData {
  final String startDate;
  final String startTime;
  final int quotedDistance;
  final int estimatedDuration;
  final List<CabRate> cabRate;

  CabData({
    required this.startDate,
    required this.startTime,
    required this.quotedDistance,
    required this.estimatedDuration,
    required this.cabRate,
  });

  factory CabData.fromJson(Map<String, dynamic> json) {
    var cabRateList = (json['cabRate'] as List)
        .map((e) => CabRate.fromJson(e as Map<String, dynamic>))
        .toList();
    return CabData(
      startDate: json['startDate'] as String,
      startTime: json['startTime'] as String,
      quotedDistance: json['quotedDistance'] as int,
      estimatedDuration: json['estimatedDuration'] as int,
      cabRate: cabRateList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate,
      'startTime': startTime,
      'quotedDistance': quotedDistance,
      'estimatedDuration': estimatedDuration,
      'cabRate': cabRate.map((e) => e.toJson()).toList(),
    };
  }
}

class CabRate {
  final CabDetail cab;
  final Fare fare;
  final int distance;
  final String cancellationPolicy;

  CabRate({
    required this.cab,
    required this.fare,
    required this.distance,
    required this.cancellationPolicy,
  });

  factory CabRate.fromJson(Map<String, dynamic> json) {
    return CabRate(
      cab: CabDetail.fromJson(json['cab'] as Map<String, dynamic>),
      fare: Fare.fromJson(json['fare'] as Map<String, dynamic>),
      distance: json['distance'] as int,
      cancellationPolicy: json['cancellationPolicy'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cab': cab.toJson(),
      'fare': fare.toJson(),
      'distance': distance,
      'cancellationPolicy': cancellationPolicy,
    };
  }
}

class CabDetail {
  final String type;
  final String category;
  final String sClass;
  final List<String> instructions;
  final String model;
  final String image;
  final int seatingCapacity;
  final int bagCapacity;
  final int bigBagCapaCity;
  final String isAssured;
  final String? fuelType;

  CabDetail({
    required this.type,
    required this.category,
    required this.sClass,
    required this.instructions,
    required this.model,
    required this.image,
    required this.seatingCapacity,
    required this.bagCapacity,
    required this.bigBagCapaCity,
    required this.isAssured,
    this.fuelType,
  });

  factory CabDetail.fromJson(Map<String, dynamic> json) {
    var instr = (json['instructions'] as List).map((e) => e as String).toList();
    return CabDetail(
      type: json['type'] as String,
      category: json['category'] as String,
      sClass: json['sClass'] as String,
      instructions: instr,
      model: json['model'] as String,
      image: json['image'] as String,
      seatingCapacity: json['seatingCapacity'] as int,
      bagCapacity: json['bagCapacity'] as int,
      bigBagCapaCity: json['bigBagCapaCity'] as int,
      isAssured: json['isAssured'] as String,
      fuelType: json['fuelType'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'category': category,
      'sClass': sClass,
      'instructions': instructions,
      'model': model,
      'image': image,
      'seatingCapacity': seatingCapacity,
      'bagCapacity': bagCapacity,
      'bigBagCapaCity': bigBagCapaCity,
      'isAssured': isAssured,
      'fuelType': fuelType,
    };
  }
}

class Fare {
  final double baseFare;
  final double driverAllowance;
  final double gst;
  final double? tollIncluded;
  final double? stateTaxIncluded;
  final double? stateTax;
  final double? tollTax;
  final double? nightPickupIncluded;
  final double? nightDropIncluded;
  final double? extraPerKmRate;
  final double? totalAmount;
  final double? airportChargeIncluded;
  final double? airportEntryFee;
  final double? extraPerMinCharge;

  Fare({
    required this.baseFare,
    required this.driverAllowance,
    required this.gst,
    this.tollIncluded,
    this.stateTaxIncluded,
    this.stateTax,
    this.tollTax,
    this.nightPickupIncluded,
    this.nightDropIncluded,
    this.extraPerKmRate,
    this.totalAmount,
    this.airportChargeIncluded,
    this.airportEntryFee,
    this.extraPerMinCharge,
  });

  factory Fare.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value.toDouble();
      if (value is double) return value;
      return double.tryParse(value.toString()) ?? 0;
    }

    return Fare(
      baseFare: parseDouble(json['baseFare']),
      driverAllowance: parseDouble(json['driverAllowance']),
      gst: parseDouble(json['gst']),
      tollIncluded: parseDouble(json['tollIncluded']),
      stateTaxIncluded: parseDouble(json['stateTaxIncluded']),
      stateTax: parseDouble(json['stateTax']),
      tollTax: parseDouble(json['tollTax']),
      nightPickupIncluded: parseDouble(json['nightPickupIncluded']),
      nightDropIncluded: parseDouble(json['nightDropIncluded']),
      extraPerKmRate: parseDouble(json['extraPerKmRate']),
      totalAmount: parseDouble(json['totalAmount']),
      airportChargeIncluded: parseDouble(json['airportChargeIncluded']),
      airportEntryFee: parseDouble(json['airportEntryFee']),
      extraPerMinCharge: parseDouble(json['extraPerMinCharge']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'baseFare': baseFare,
      'driverAllowance': driverAllowance,
      'gst': gst,
      'tollIncluded': tollIncluded,
      'stateTaxIncluded': stateTaxIncluded,
      'stateTax': stateTax,
      'tollTax': tollTax,
      'nightPickupIncluded': nightPickupIncluded,
      'nightDropIncluded': nightDropIncluded,
      'extraPerKmRate': extraPerKmRate,
      'totalAmount': totalAmount,
      'airportChargeIncluded': airportChargeIncluded,
      'airportEntryFee': airportEntryFee,
      'extraPerMinCharge': extraPerMinCharge,
    };
  }
}
