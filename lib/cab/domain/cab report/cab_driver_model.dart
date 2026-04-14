import 'dart:convert';

class CabDriverResponse {
  final bool success;
  final List<CabDriverDataItem> data;
  final String? message;

  CabDriverResponse({
    required this.success,
    required this.data,
    this.message,
  });

  factory CabDriverResponse.fromJson(Map<String, dynamic> json) {
    return CabDriverResponse(
      success: json['status'] == 'success',
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => CabDriverDataItem.fromJson(item))
              .toList() ??
          [],
    );
  }

  // Helper to get the primary driver info (type: cabDriverUpdate)
  CabDriverUpdate? get driverUpdate {
    for (var item in data) {
      if (item.type == 'cabDriverUpdate' && item.driverUpdate != null) {
        return item.driverUpdate;
      }
    }
    return null;
  }

  // Helper to get the current status from timeline
  String? get currentStatus {
    if (data.isEmpty) return null;
    // Usually the last event represents the current state
    return data.last.type;
  }
}

class CabDriverDataItem {
  final String type;
  final CabDriverUpdate? driverUpdate;
  final CabTripEvent? tripEvent;

  CabDriverDataItem({
    required this.type,
    this.driverUpdate,
    this.tripEvent,
  });

  factory CabDriverDataItem.fromJson(Map<String, dynamic> json) {
    final type = json['type'] ?? '';
    if (type == 'cabDriverUpdate') {
      return CabDriverDataItem(
        type: type,
        driverUpdate: CabDriverUpdate.fromJson(json['data'] ?? {}),
      );
    } else {
      return CabDriverDataItem(
        type: type,
        tripEvent: CabTripEvent.fromJson(json['data'] ?? {}),
      );
    }
  }
}

class CabDriverUpdate {
  final CabCar car;
  final String otp;
  final CabDriver driver;
  final String bookingId;
  final String statusDesc;

  CabDriverUpdate({
    required this.car,
    required this.otp,
    required this.driver,
    required this.bookingId,
    required this.statusDesc,
  });

  factory CabDriverUpdate.fromJson(Map<String, dynamic> json) {
    return CabDriverUpdate(
      car: CabCar.fromJson(json['car'] ?? {}),
      otp: (json['otp'] ?? '').toString(),
      driver: CabDriver.fromJson(json['driver'] ?? {}),
      bookingId: json['bookingId'] ?? '',
      statusDesc: json['statusDesc'] ?? '',
    );
  }
}

class CabCar {
  final String model;
  final String number;

  CabCar({required this.model, required this.number});

  factory CabCar.fromJson(Map<String, dynamic> json) {
    return CabCar(
      model: json['model'] ?? 'N/A',
      number: json['number'] ?? 'N/A',
    );
  }
}

class CabDriver {
  final String name;
  final double rating;
  final CabContact contact;

  CabDriver({
    required this.name,
    required this.rating,
    required this.contact,
  });

  factory CabDriver.fromJson(Map<String, dynamic> json) {
    return CabDriver(
      name: json['name'] ?? 'N/A',
      rating: (json['rating'] ?? 0.0).toDouble(),
      contact: CabContact.fromJson(json['contact'] ?? {}),
    );
  }
}

class CabContact {
  final String code;
  final String number;

  CabContact({required this.code, required this.number});

  factory CabContact.fromJson(Map<String, dynamic> json) {
    return CabContact(
      code: (json['code'] ?? '91').toString(),
      number: (json['number'] ?? '').toString(),
    );
  }

  String get fullNumber => '+$code$number';
}

class CabTripEvent {
  final String bookingStatus;
  final CabCoordinates? coordinates;

  CabTripEvent({required this.bookingStatus, this.coordinates});

  factory CabTripEvent.fromJson(Map<String, dynamic> json) {
    return CabTripEvent(
      bookingStatus: json['bookingStatus'] ?? '',
      coordinates: json['tripdata'] != null && json['tripdata']['coordinates'] != null
          ? CabCoordinates.fromJson(json['tripdata']['coordinates'])
          : null,
    );
  }
}

class CabCoordinates {
  final String latitude;
  final String longitude;

  CabCoordinates({required this.latitude, required this.longitude});

  factory CabCoordinates.fromJson(Map<String, dynamic> json) {
    return CabCoordinates(
      latitude: (json['latitude'] ?? '0').toString(),
      longitude: (json['longitude'] ?? '0').toString(),
    );
  }
}
