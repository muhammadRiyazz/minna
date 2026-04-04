import 'dart:convert';

class HotelReportResponse {
  final bool status;
  final String message;
  final List<HotelBookingRecord> data;

  HotelReportResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory HotelReportResponse.fromJson(Map<String, dynamic> json) {
    return HotelReportResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List? ?? [])
          .map((e) => HotelBookingRecord.fromJson(e))
          .toList(),
    );
  }
}

class HotelBookingRecord {
  final BookingInfo booking;
  final PaymentInfo? payment;

  HotelBookingRecord({
    required this.booking,
    this.payment,
  });

  factory HotelBookingRecord.fromJson(Map<String, dynamic> json) {
    return HotelBookingRecord(
      booking: BookingInfo.fromJson(json['booking']),
      payment: json['payment'] != null ? PaymentInfo.fromJson(json['payment']) : null,
    );
  }
}

class BookingInfo {
  final String id;
  final String? bookingId;
  final String? confirmationNo;
  final String bookingStatus;
  final String? bookingResponse; // Stringified JSON from TBO
  final String hotelName;
  final String checkIn;
  final String checkOut;
  final String guests;
  final String netAmount;
  final String currency;
  final String createdAt;
  final String paymentStatus;
  final String? failureReason;

  BookingInfo({
    required this.id,
    this.bookingId,
    this.confirmationNo,
    required this.bookingStatus,
    this.bookingResponse,
    required this.hotelName,
    required this.checkIn,
    required this.checkOut,
    required this.guests,
    required this.netAmount,
    required this.currency,
    required this.createdAt,
    required this.paymentStatus,
    this.failureReason,
  });

  factory BookingInfo.fromJson(Map<String, dynamic> json) {
    return BookingInfo(
      id: json['id']?.toString() ?? '',
      bookingId: json['booking_id']?.toString(),
      confirmationNo: json['confirmation_no']?.toString(),
      bookingStatus: json['booking_status']?.toString() ?? 'UNKNOWN',
      bookingResponse: json['booking_response'],
      hotelName: json['hotel_name']?.toString() ?? 'Unknown Hotel',
      checkIn: json['check_in']?.toString() ?? '',
      checkOut: json['check_out']?.toString() ?? '',
      guests: json['guests']?.toString() ?? '0',
      netAmount: json['net_amount']?.toString() ?? '0',
      currency: json['currency']?.toString() ?? 'INR',
      createdAt: json['created_at']?.toString() ?? '',
      paymentStatus: json['payment_status']?.toString() ?? 'PENDING',
      failureReason: json['failure_reason'],
    );
  }

  TboBookingDetail? get parsedTboResponse {
    if (bookingResponse == null || bookingResponse!.isEmpty) return null;
    try {
      final decoded = jsonDecode(bookingResponse!);
      if (decoded['GetBookingDetailResult'] != null) {
        return TboBookingDetail.fromJson(decoded['GetBookingDetailResult']);
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}

class PaymentInfo {
  final String id;
  final String? razorpayPaymentId;
  final String amount;
  final String status;
  final String createdAt;

  PaymentInfo({
    required this.id,
    this.razorpayPaymentId,
    required this.amount,
    required this.status,
    required this.createdAt,
  });

  factory PaymentInfo.fromJson(Map<String, dynamic> json) {
    return PaymentInfo(
      id: json['id']?.toString() ?? '',
      razorpayPaymentId: json['razorpay_payment_id'],
      amount: json['amount']?.toString() ?? '0',
      status: json['status']?.toString() ?? 'PENDING',
      createdAt: json['created_at']?.toString() ?? '',
    );
  }
}

class TboBookingDetail {
  final String? tboReferenceNo;
  final String? hotelBookingStatus;
  final String? confirmationNo;
  final String? bookingRefNo;
  final int? bookingId;
  final String? hotelName;
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? checkInDate;
  final String? checkOutDate;
  final double? netAmount;
  final List<TboRoomDetail> rooms;

  TboBookingDetail({
    this.tboReferenceNo,
    this.hotelBookingStatus,
    this.confirmationNo,
    this.bookingRefNo,
    this.bookingId,
    this.hotelName,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.checkInDate,
    this.checkOutDate,
    this.netAmount,
    required this.rooms,
  });

  factory TboBookingDetail.fromJson(Map<String, dynamic> json) {
    return TboBookingDetail(
      tboReferenceNo: json['TBOReferenceNo'],
      hotelBookingStatus: json['HotelBookingStatus'],
      confirmationNo: json['ConfirmationNo'],
      bookingRefNo: json['BookingRefNo'],
      bookingId: json['BookingId'],
      hotelName: json['HotelName'],
      addressLine1: json['AddressLine1'],
      addressLine2: json['AddressLine2'],
      city: json['City'],
      checkInDate: json['CheckInDate'],
      checkOutDate: json['CheckOutDate'],
      netAmount: (json['NetAmount'] as num?)?.toDouble(),
      rooms: (json['Rooms'] as List? ?? [])
          .map((e) => TboRoomDetail.fromJson(e))
          .toList(),
    );
  }
}

class TboRoomDetail {
  final String? roomTypeName;
  final String? inclusion;
  final List<TboPassenger> passengers;

  TboRoomDetail({
    this.roomTypeName,
    this.inclusion,
    required this.passengers,
  });

  factory TboRoomDetail.fromJson(Map<String, dynamic> json) {
    return TboRoomDetail(
      roomTypeName: json['RoomTypeName'],
      inclusion: json['Inclusion'],
      passengers: (json['HotelPassenger'] as List? ?? [])
          .map((e) => TboPassenger.fromJson(e))
          .toList(),
    );
  }
}

class TboPassenger {
  final String? firstName;
  final String? lastName;
  final String? title;
  final String? email;
  final String? phone;
  final bool? leadPassenger;

  TboPassenger({
    this.firstName,
    this.lastName,
    this.title,
    this.email,
    this.phone,
    this.leadPassenger,
  });

  factory TboPassenger.fromJson(Map<String, dynamic> json) {
    return TboPassenger(
      firstName: json['FirstName'],
      lastName: json['LastName'],
      title: json['Title'],
      email: json['Email'],
      phone: json['Phoneno'],
      leadPassenger: json['LeadPassenger'] ?? false,
    );
  }
}
