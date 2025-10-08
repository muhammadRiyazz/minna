class AuthenticateRequest {
  final String clientId;
  final String userName;
  final String password;
  final String endUserIp;

  AuthenticateRequest({
    required this.clientId,
    required this.userName,
    required this.password,
    required this.endUserIp,
  });

  Map<String, dynamic> toJson() => {
        'ClientId': clientId,
        'UserName': userName,
        'Password': password,
        'EndUserIp': endUserIp,
      };
}

class AuthenticateResponse {
  final int status;
  final String tokenId;
  final Member member;
  final ApiError error;

  AuthenticateResponse({
    required this.status,
    required this.tokenId,
    required this.member,
    required this.error,
  });

  factory AuthenticateResponse.fromJson(Map<String, dynamic> json) {
    return AuthenticateResponse(
      status: json['Status'] ?? 0,
      tokenId: json['TokenId'] ?? '',
      member: Member.fromJson(json['Member'] ?? {}),
      error: ApiError.fromJson(json['Error'] ?? {}),
    );
  }

  bool get isSuccess => status == 1;
}

class Member {
  final String firstName;
  final String lastName;
  final String email;
  final int memberId;
  final int agencyId;
  final String loginName;
  final String loginDetails;

  Member({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.memberId,
    required this.agencyId,
    required this.loginName,
    required this.loginDetails,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      firstName: json['FirstName'] ?? '',
      lastName: json['LastName'] ?? '',
      email: json['Email'] ?? '',
      memberId: json['MemberId'] ?? 0,
      agencyId: json['AgencyId'] ?? 0,
      loginName: json['LoginName'] ?? '',
      loginDetails: json['LoginDetails'] ?? '',
    );
  }
}

class ApiError {
  final int errorCode;
  final String errorMessage;

  ApiError({
    required this.errorCode,
    required this.errorMessage,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      errorCode: json['ErrorCode'] ?? 0,
      errorMessage: json['ErrorMessage'] ?? '',
    );
  }

  bool get hasError => errorCode != 0;
}

class AgencyBalanceRequest {
  final String clientId;
  final String tokenAgencyId;
  final String tokenMemberId;
  final String endUserIp;
  final String tokenId;

  AgencyBalanceRequest({
    required this.clientId,
    required this.tokenAgencyId,
    required this.tokenMemberId,
    required this.endUserIp,
    required this.tokenId,
  });

  Map<String, dynamic> toJson() => {
        'ClientId': clientId,
        'TokenAgencyId': tokenAgencyId,
        'TokenMemberId': tokenMemberId,
        'EndUserIp': endUserIp,
        'TokenId': tokenId,
      };
}

class AgencyBalanceResponse {
  final int status;
  final int agencyType;
  final double cashBalance;
  final double creditBalance;
  final ApiError error;

  AgencyBalanceResponse({
    required this.status,
    required this.agencyType,
    required this.cashBalance,
    required this.creditBalance,
    required this.error,
  });

  factory AgencyBalanceResponse.fromJson(Map<String, dynamic> json) {
    return AgencyBalanceResponse(
      status: json['Status'] ?? 0,
      agencyType: json['AgencyType'] ?? 0,
      cashBalance: (json['CashBalance'] ?? 0).toDouble(),
      creditBalance: (json['CreditBalance'] ?? 0).toDouble(),
      error: ApiError.fromJson(json['Error'] ?? {}),
    );
  }

  bool get isSuccess => status == 1;
}

class PreBookRequest {
  final String bookingCode;
  final String paymentMode;

  PreBookRequest({
    required this.bookingCode,
    this.paymentMode = 'Limit',
  });

  Map<String, dynamic> toJson() => {
        'BookingCode': bookingCode,
        'PaymentMode': paymentMode,
      };
}

class PreBookResponse {
  final ApiStatus status;
  final List<HotelPreBookResult> hotelResult;
  final ValidationInfo? validationInfo;

  PreBookResponse({
    required this.status,
    required this.hotelResult,
    this.validationInfo,
  });

  factory PreBookResponse.fromJson(Map<String, dynamic> json) {
    return PreBookResponse(
      status: ApiStatus.fromJson(json['Status'] ?? {}),
      hotelResult: (json['HotelResult'] as List? ?? [])
          .map((e) => HotelPreBookResult.fromJson(e))
          .toList(),
      validationInfo: json['ValidationInfo'] != null
          ? ValidationInfo.fromJson(json['ValidationInfo'])
          : null,
    );
  }

  bool get isSuccess => status.code == 200;
}

class HotelPreBookResult {
  final String hotelCode;
  final String currency;
  final List<PreBookRoom> rooms;
  final List<String> rateConditions;

  HotelPreBookResult({
    required this.hotelCode,
    required this.currency,
    required this.rooms,
    required this.rateConditions,
  });

  factory HotelPreBookResult.fromJson(Map<String, dynamic> json) {
    return HotelPreBookResult(
      hotelCode: json['HotelCode'] ?? '',
      currency: json['Currency'] ?? '',
      rooms: (json['Rooms'] as List? ?? [])
          .map((e) => PreBookRoom.fromJson(e))
          .toList(),
      rateConditions: (json['RateConditions'] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}

class PreBookRoom {
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
  final List<List<Supplement>> supplements;
  final bool withTransfers;
  final List<String> amenities;

  PreBookRoom({
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
    required this.supplements,
    required this.withTransfers,
    required this.amenities,
  });

  factory PreBookRoom.fromJson(Map<String, dynamic> json) {
    return PreBookRoom(
      name: (json['Name'] as List? ?? []).map((e) => e.toString()).toList(),
      bookingCode: json['BookingCode'] ?? '',
      inclusion: json['Inclusion'] ?? '',
      dayRates: _parseDayRates(json['DayRates']),
      totalFare: (json['TotalFare'] ?? 0).toDouble(),
      totalTax: (json['TotalTax'] ?? 0).toDouble(),
      roomPromotion: (json['RoomPromotion'] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
      cancelPolicies: (json['CancelPolicies'] as List? ?? [])
          .map((e) => CancelPolicy.fromJson(e))
          .toList(),
      mealType: json['MealType'] ?? '',
      isRefundable: json['IsRefundable'] ?? false,
      supplements: _parseSupplements(json['Supplements']),
      withTransfers: json['WithTransfers'] ?? false,
      amenities: (json['Amenities'] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }

  static List<List<DayRate>> _parseDayRates(dynamic dayRates) {
    if (dayRates is List) {
      return dayRates.map<List<DayRate>>((roomRates) {
        if (roomRates is List) {
          return roomRates.map<DayRate>((rate) {
            if (rate is Map) {
              return DayRate.fromJson(Map<String, dynamic>.from(rate));
            }
            return DayRate(basePrice: 0);
          }).toList();
        }
        return [];
      }).toList();
    }
    return [];
  }

  static List<List<Supplement>> _parseSupplements(dynamic supplements) {
    if (supplements is List) {
      return supplements.map<List<Supplement>>((roomSupplements) {
        if (roomSupplements is List) {
          return roomSupplements.map<Supplement>((supplement) {
            if (supplement is Map) {
              return Supplement.fromJson(Map<String, dynamic>.from(supplement));
            }
            return Supplement(
              index: 0,
              type: '',
              description: '',
              price: 0,
              currency: '',
            );
          }).toList();
        }
        return [];
      }).toList();
    }
    return [];
  }
}

// Missing Model Classes
class DayRate {
  final double basePrice;

  DayRate({
    required this.basePrice,
  });

  factory DayRate.fromJson(Map<String, dynamic> json) {
    return DayRate(
      basePrice: (json['BasePrice'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'BasePrice': basePrice,
      };
}

class CancelPolicy {
  final String index;
  final String fromDate;
  final String chargeType;
  final double cancellationCharge;

  CancelPolicy({
    required this.index,
    required this.fromDate,
    required this.chargeType,
    required this.cancellationCharge,
  });

  factory CancelPolicy.fromJson(Map<String, dynamic> json) {
    return CancelPolicy(
      index: json['Index']?.toString() ?? '',
      fromDate: json['FromDate']?.toString() ?? '',
      chargeType: json['ChargeType']?.toString() ?? '',
      cancellationCharge: (json['CancellationCharge'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'Index': index,
        'FromDate': fromDate,
        'ChargeType': chargeType,
        'CancellationCharge': cancellationCharge,
      };
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
      index: json['Index'] ?? 0,
      type: json['Type']?.toString() ?? '',
      description: json['Description']?.toString() ?? '',
      price: (json['Price'] ?? 0).toDouble(),
      currency: json['Currency']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'Index': index,
        'Type': type,
        'Description': description,
        'Price': price,
        'Currency': currency,
      };
}

class ValidationInfo {
  final bool panMandatory;
  final bool passportMandatory;
  final bool corporateBookingAllowed;
  final int panCountRequired;
  final bool samePaxNameAllowed;
  final bool spaceAllowed;
  final bool specialCharAllowed;
  final int paxNameMinLength;
  final int paxNameMaxLength;
  final bool charLimit;
  final bool packageFare;
  final bool packageDetailsMandatory;
  final bool departureDetailsMandatory;
  final bool gstAllowed;

  ValidationInfo({
    required this.panMandatory,
    required this.passportMandatory,
    required this.corporateBookingAllowed,
    required this.panCountRequired,
    required this.samePaxNameAllowed,
    required this.spaceAllowed,
    required this.specialCharAllowed,
    required this.paxNameMinLength,
    required this.paxNameMaxLength,
    required this.charLimit,
    required this.packageFare,
    required this.packageDetailsMandatory,
    required this.departureDetailsMandatory,
    required this.gstAllowed,
  });

  factory ValidationInfo.fromJson(Map<String, dynamic> json) {
    return ValidationInfo(
      panMandatory: json['PanMandatory'] ?? false,
      passportMandatory: json['PassportMandatory'] ?? false,
      corporateBookingAllowed: json['CorporateBookingAllowed'] ?? false,
      panCountRequired: json['PanCountRequired'] ?? 0,
      samePaxNameAllowed: json['SamePaxNameAllowed'] ?? true,
      spaceAllowed: json['SpaceAllowed'] ?? true,
      specialCharAllowed: json['SpecialCharAllowed'] ?? false,
      paxNameMinLength: json['PaxNameMinLength'] ?? 0,
      paxNameMaxLength: json['PaxNameMaxLength'] ?? 50,
      charLimit: json['CharLimit'] ?? true,
      packageFare: json['PackageFare'] ?? false,
      packageDetailsMandatory: json['PackageDetailsMandatory'] ?? false,
      departureDetailsMandatory: json['DepartureDetailsMandatory'] ?? false,
      gstAllowed: json['GSTAllowed'] ?? false,
    );
  }
}

class ApiStatus {
  final int code;
  final String description;

  ApiStatus({
    required this.code,
    required this.description,
  });

  factory ApiStatus.fromJson(Map<String, dynamic> json) {
    return ApiStatus(
      code: json['Code'] ?? 0,
      description: json['Description'] ?? '',
    );
  }
}

// Generic result class for API responses
class ApiResult<T> {
  final T? data;
  final String? error;
  final bool isSuccess;

  ApiResult.success(this.data) 
      : error = null, 
        isSuccess = true;

  ApiResult.error(this.error) 
      : data = null, 
        isSuccess = false;
}