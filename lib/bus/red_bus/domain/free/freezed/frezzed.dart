// // To parse this JSON data, do
// //
// //     final frezzed = frezzedFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'dart:convert';

// part 'frezzed.freezed.dart';
// part 'frezzed.g.dart';

// Frezzed frezzedFromJson(String str) => Frezzed.fromJson(json.decode(str));

// String frezzedToJson(Frezzed data) => json.encode(data.toJson());

// @freezed
// class Frezzed with _$Frezzed {
  
//   const factory Frezzed({
//     required String bookingFee,
//     required String busType,
//     required DateTime cancellationCalculationTimestamp,
//     required String cancellationMessage,
//     required String cancellationPolicy,
//     required DateTime dateOfIssue,
//     required String destinationCity,
//     required String destinationCityId,
//     required DateTime doj,
//     required String dropLocation,
//     required String dropLocationId,
//     required String dropTime,
//     required String firstBoardingPointTime,
//     required String hasRtcBreakup,
//     required String hasSpecialTemplate,
//     required String inventoryId,
//     required InventoryItems inventoryItems,
//     required String mTicketEnabled,
//     required String partialCancellationAllowed,
//     required String pickUpContactNo,
//     required String pickUpLocationAddress,
//     required String pickupLocation,
//     required String pickupLocationId,
//     required String pickupLocationLandmark,
//     required String pickupTime,
//     required String pnr,
//     required String primeDepartureTime,
//     required String primoBooking,
//     required ReschedulingPolicy reschedulingPolicy,
//     required String serviceCharge,
//     required String sourceCity,
//     required String sourceCityId,
//     required String status,
//     required String tin,
//     required String travels,
//     required String vaccinatedBus,
//     required String vaccinatedStaff,
//   }) = _Frezzed;

//   factory Frezzed.fromJson(Map<String, dynamic> json) =>
//       _$FrezzedFromJson(json);
// }

// @freezed
// class InventoryItems with _$InventoryItems {
//   const factory InventoryItems({
//     required String baseFare,
//     required String fare,
//     required String ladiesSeat,
//     required String malesSeat,
//     required String operatorServiceCharge,
//     required Passenger passenger,
//     required String seatName,
//     required String serviceTax,
//   }) = _InventoryItems;

//   factory InventoryItems.fromJson(Map<String, dynamic> json) =>
//       _$InventoryItemsFromJson(json);
// }

// @freezed
// class Passenger with _$Passenger {
//   const factory Passenger({
//     required String address,
//     required String age,
//     required String email,
//     required String gender,
//     required String idNumber,
//     required String idType,
//     required String mobile,
//     required String name,
//     required String primary,
//     required String singleLadies,
//     required String title,
//   }) = _Passenger;

//   factory Passenger.fromJson(Map<String, dynamic> json) =>
//       _$PassengerFromJson(json);
// }

// @freezed
// class ReschedulingPolicy with _$ReschedulingPolicy {
//   const factory ReschedulingPolicy({
//     required String reschedulingCharge,
//     required String windowTime,
//   }) = _ReschedulingPolicy;

//   factory ReschedulingPolicy.fromJson(Map<String, dynamic> json) =>
//       _$ReschedulingPolicyFromJson(json);
// }
