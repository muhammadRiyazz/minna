class HotelResponse {
  final Status status;
  final List<Hotel> hotels;

  HotelResponse({required this.status, required this.hotels});

  factory HotelResponse.fromJson(Map<String, dynamic> json) {
    return HotelResponse(
      status: Status.fromJson(json['Status']),
      hotels: (json['Hotels'] as List<dynamic>)
          .map((e) => Hotel.fromJson(e))
          .toList(),
    );
  }
}

class Status {
  final int code;
  final String description;

  Status({required this.code, required this.description});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      code: json['Code'],
      description: json['Description'],
    );
  }
}

class Hotel {
  final String hotelCode;
  final String hotelName;
  final String latitude;
  final String longitude;
  final String hotelRating;
  final String address;
  final String countryName;
  final String cityName;

  Hotel({
    required this.hotelCode,
    required this.hotelName,
    required this.latitude,
    required this.longitude,
    required this.hotelRating,
    required this.address,
    required this.countryName,
    required this.cityName,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      hotelCode: json['HotelCode'],
      hotelName: json['HotelName'],
      latitude: json['Latitude'],
      longitude: json['Longitude'],
      hotelRating: json['HotelRating'],
      address: json['Address'],
      countryName: json['CountryName'],
      cityName: json['CityName'],
    );
  }
}
// hotel_models.dart
class HotelSearchRequest {
  final String country;
  final String city;
  final String checkIn;
  final String checkOut;
  final List<RoomRequest> rooms;

  HotelSearchRequest({
    required this.country,
    required this.city,
    required this.checkIn,
    required this.checkOut,
    required this.rooms,
  });

  Map<String, dynamic> toJson() => {
    'country': country,
    'city': city,
    'CheckIn': checkIn,
    'CheckOut': checkOut,
    'rooms': rooms.map((room) => room.toJson()).toList(),
  };
}

class RoomRequest {
  final int adults;
  final int children;
  final List<int>? childrenAges;

  RoomRequest({
    required this.adults,
    required this.children,
    this.childrenAges,
  });

  Map<String, dynamic> toJson() => {
    'Adults': adults,
    'Children': children,
    'ChildrenAges': childrenAges,
  };
}

class HotelSearchResponse {
  final bool status;
  final String message;
  final int totalHotels;
  final List<HotelSearchItem> hotels;

  HotelSearchResponse({
    required this.status,
    required this.message,
    required this.totalHotels,
    required this.hotels,
  });

  factory HotelSearchResponse.fromJson(Map<String, dynamic> json) {
    return HotelSearchResponse(
      status: json['status'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      totalHotels: json['totalHotels'] as int? ?? 0,
      hotels: (json['hotels'] as List<dynamic>?)
          ?.map((e) => HotelSearchItem.fromJson(e))
          .toList() ?? [],
    );
  }
}

class HotelSearchItem {
  final HotelSearchDetails hotelSearchDetails;
  final HotelDetails hotelDetails;

  HotelSearchItem({
    required this.hotelSearchDetails,
    required this.hotelDetails,
  });

  factory HotelSearchItem.fromJson(Map<String, dynamic> json) {
    return HotelSearchItem(
      hotelSearchDetails: HotelSearchDetails.fromJson(json['HotelSearchDetails']),
      hotelDetails: HotelDetails.fromJson(json['HotelDetails']),
    );
  }
}

class HotelSearchDetails {
  final String hotelCode;
  final String currency;
  final List<RoomDetail> rooms;

  HotelSearchDetails({
    required this.hotelCode,
    required this.currency,
    required this.rooms,
  });

  factory HotelSearchDetails.fromJson(Map<String, dynamic> json) {
    return HotelSearchDetails(
      hotelCode: json['HotelCode'] as String? ?? '',
      currency: json['Currency'] as String? ?? 'INR',
      rooms: (json['Rooms'] as List<dynamic>?)
          ?.map((e) => RoomDetail.fromJson(e))
          .toList() ?? [],
    );
  }
}

class RoomDetail {
  final List<String> name;
  final String bookingCode;
  final String inclusion;
  final List<List<DayRate>> dayRates;
  final double totalFare;
  final double totalTax;
  final List<String> roomPromotion;
  final List<CancelPolicy> cancelPolicies;
  final String mealType;
  final bool isRefundable;
  final bool withTransfers;
  final List<List<Supplement>>? supplements;

  RoomDetail({
    required this.name,
    required this.bookingCode,
    required this.inclusion,
    required this.dayRates,
    required this.totalFare,
    required this.totalTax,
    required this.roomPromotion,
    required this.cancelPolicies,
    required this.mealType,
    required this.isRefundable,
    required this.withTransfers,
    this.supplements,
  });

  factory RoomDetail.fromJson(Map<String, dynamic> json) {
    return RoomDetail(
      name: (json['Name'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ?? [],
      bookingCode: json['BookingCode'] as String? ?? '',
      inclusion: json['Inclusion'] as String? ?? '',
      dayRates: (json['DayRates'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>)
              .map((rate) => DayRate.fromJson(rate))
              .toList())
          .toList() ?? [],
      totalFare: (json['TotalFare'] as num?)?.toDouble() ?? 0.0,
      totalTax: (json['TotalTax'] as num?)?.toDouble() ?? 0.0,
      roomPromotion: (json['RoomPromotion'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ?? [],
      cancelPolicies: (json['CancelPolicies'] as List<dynamic>?)
          ?.map((e) => CancelPolicy.fromJson(e))
          .toList() ?? [],
      mealType: json['MealType'] as String? ?? '',
      isRefundable: json['IsRefundable'] as bool? ?? false,
      withTransfers: json['WithTransfers'] as bool? ?? false,
      supplements: (json['Supplements'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>)
              .map((sup) => Supplement.fromJson(sup))
              .toList())
          .toList(),
    );
  }
}

class DayRate {
  final double basePrice;

  DayRate({required this.basePrice});

  factory DayRate.fromJson(Map<String, dynamic> json) {
    return DayRate(
      basePrice: (json['BasePrice'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class CancelPolicy {
  final String fromDate;
  final String chargeType;
  final double cancellationCharge;

  CancelPolicy({
    required this.fromDate,
    required this.chargeType,
    required this.cancellationCharge,
  });

  factory CancelPolicy.fromJson(Map<String, dynamic> json) {
    return CancelPolicy(
      fromDate: json['FromDate'] as String? ?? '',
      chargeType: json['ChargeType'] as String? ?? '',
      cancellationCharge: (json['CancellationCharge'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class Supplement {
  final int index;
  final String type;
  final String description;
  final double price;
  final String currency;

  Supplement({
    required this.index,
    required this.type,
    required this.description,
    required this.price,
    required this.currency,
  });

  factory Supplement.fromJson(Map<String, dynamic> json) {
    return Supplement(
      index: json['Index'] as int? ?? 0,
      type: json['Type'] as String? ?? '',
      description: json['Description'] as String? ?? '',
      price: (json['Price'] as num?)?.toDouble() ?? 0.0,
      currency: json['Currency'] as String? ?? '',
    );
  }
}

class HotelDetails {
  final String hotelCode;
  final String hotelName;
  final String description;
  final List<String> hotelFacilities;
  final Map<String, String> attractions;
  final List<String> images;
  final String address;
  final String pinCode;
  final String cityId;
  final String countryName;
  final String phoneNumber;
  final String email;
  final String hotelWebsiteUrl;
  final String faxNumber;
  final String map;
  final int hotelRating;
  final String cityName;
  final String countryCode;
  final String checkInTime;
  final String checkOutTime;
  final HotelFees hotelFees;
  final List<RoomTypeDetail> roomDetails;

  HotelDetails({
    required this.hotelCode,
    required this.hotelName,
    required this.description,
    required this.hotelFacilities,
    required this.attractions,
    required this.images,
    required this.address,
    required this.pinCode,
    required this.cityId,
    required this.countryName,
    required this.phoneNumber,
    required this.email,
    required this.hotelWebsiteUrl,
    required this.faxNumber,
    required this.map,
    required this.hotelRating,
    required this.cityName,
    required this.countryCode,
    required this.checkInTime,
    required this.checkOutTime,
    required this.hotelFees,
    required this.roomDetails,
  });

  factory HotelDetails.fromJson(Map<String, dynamic> json) {
    // Parse attractions from JSON object
    final attractionsMap = <String, String>{};
    if (json['Attractions'] is Map<String, dynamic>) {
      (json['Attractions'] as Map<String, dynamic>).forEach((key, value) {
        if (value is String) {
          attractionsMap[key] = value;
        }
      });
    }

    return HotelDetails(
      hotelCode: json['HotelCode'] as String? ?? '',
      hotelName: json['HotelName'] as String? ?? '',
      description: json['Description'] as String? ?? '',
      hotelFacilities: (json['HotelFacilities'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ?? [],
      attractions: attractionsMap,
      images: (json['Images'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ?? [],
      address: json['Address'] as String? ?? '',
      pinCode: json['PinCode'] as String? ?? '',
      cityId: json['CityId'] as String? ?? '',
      countryName: json['CountryName'] as String? ?? '',
      phoneNumber: json['PhoneNumber'] as String? ?? '',
      email: json['Email'] as String? ?? '',
      hotelWebsiteUrl: json['HotelWebsiteUrl'] as String? ?? '',
      faxNumber: json['FaxNumber'] as String? ?? '',
      map: json['Map'] as String? ?? '',
      hotelRating: json['HotelRating'] as int? ?? 0,
      cityName: json['CityName'] as String? ?? '',
      countryCode: json['CountryCode'] as String? ?? '',
      checkInTime: json['CheckInTime'] as String? ?? '',
      checkOutTime: json['CheckOutTime'] as String? ?? '',
      hotelFees: HotelFees.fromJson(json['HotelFees'] ?? {}),
      roomDetails: (json['RoomDetails'] as List<dynamic>?)
          ?.map((e) => RoomTypeDetail.fromJson(e))
          .toList() ?? [],
    );
  }
}

class HotelFees {
  final String hotelId;
  final List<dynamic> optional;
  final List<dynamic> mandatory;

  HotelFees({
    required this.hotelId,
    required this.optional,
    required this.mandatory,
  });

  factory HotelFees.fromJson(Map<String, dynamic> json) {
    return HotelFees(
      hotelId: json['HotelId'] as String? ?? '',
      optional: json['Optional'] as List<dynamic>? ?? [],
      mandatory: json['Mandatory'] as List<dynamic>? ?? [],
    );
  }
}

class RoomTypeDetail {
  final String roomName;
  final List<String> imageURL;
  final int roomId;
  final String roomSize;
  final String roomDescription;

  RoomTypeDetail({
    required this.roomName,
    required this.imageURL,
    required this.roomId,
    required this.roomSize,
    required this.roomDescription,
  });

  factory RoomTypeDetail.fromJson(Map<String, dynamic> json) {
    return RoomTypeDetail(
      roomName: json['RoomName'] as String? ?? '',
      imageURL: (json['imageURL'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ?? [],
      roomId: json['RoomId'] as int? ?? 0,
      roomSize: json['RoomSize'] as String? ?? '',
      roomDescription: json['RoomDescription'] as String? ?? '',
    );
  }
}