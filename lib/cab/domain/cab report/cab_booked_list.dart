// lib/cab/domain/cab_booking_model.dart
class CabBooking {
  final String id;
  final String tripType;
  final String cabType;
  final String total;
  final String firstName;
  final String lastName;
  final String priContactCode;
  final String priContact;
  final String email;
  final String referenceId;
  final String date;
  final String time;
  final String bookingId;
  final String paymentId;
  final String orderId;
  final String status;
  final String paidStatus;

  CabBooking({
    required this.id,
    required this.tripType,
    required this.cabType,
    required this.total,
    required this.firstName,
    required this.lastName,
    required this.priContactCode,
    required this.priContact,
    required this.email,
    required this.referenceId,
    required this.date,
    required this.time,
    required this.bookingId,
    required this.paymentId,
    required this.orderId,
    required this.status,
    required this.paidStatus,
  });

  factory CabBooking.fromJson(Map<String, dynamic> json) {
    return CabBooking(
      id: json['id']?.toString() ?? '',
      tripType: json['triptype']?.toString() ?? '',
      cabType: json['cabtype']?.toString() ?? '',
      total: json['total']?.toString() ?? '',
      firstName: json['first_name']?.toString() ?? '',
      lastName: json['last_name']?.toString() ?? '',
      priContactCode: json['pri_con_code']?.toString() ?? '',
      priContact: json['pri_contact']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      referenceId: json['reference_id']?.toString() ?? '',
      date: json['date']?.toString() ?? '',
      time: json['time']?.toString() ?? '',
      bookingId: json['booking_id']?.toString() ?? '',
      paymentId: json['payement_id']?.toString() ?? '',
      orderId: json['order_id']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      paidStatus: json['paid_status']?.toString() ?? '',
    );
  }
}

class CabBookingResponse {
  final String status;
  final List<CabBooking> bookings;
  final String? errorMessage;

  CabBookingResponse({
    required this.status,
    required this.bookings,
    this.errorMessage,
  });

  factory CabBookingResponse.fromJson(Map<String, dynamic> json) {
    if (json['status'] == 'success') {
      final List<dynamic> data = json['message'] ?? [];
      return CabBookingResponse(
        status: json['status'],
        bookings: data.map((item) => CabBooking.fromJson(item)).toList(),
      );
    } else {
      return CabBookingResponse(
        status: json['status'],
        bookings: [],
        errorMessage: json['message'],
      );
    }
  }
}