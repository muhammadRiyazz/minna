// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'frezzed.dart';

// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************

// _$_Frezzed _$$_FrezzedFromJson(Map<String, dynamic> json) => _$_Frezzed(
//       bookingFee: json['bookingFee'] as String,
//       busType: json['busType'] as String,
//       cancellationCalculationTimestamp:
//           DateTime.parse(json['cancellationCalculationTimestamp'] as String),
//       cancellationMessage: json['cancellationMessage'] as String,
//       cancellationPolicy: json['cancellationPolicy'] as String,
//       dateOfIssue: DateTime.parse(json['dateOfIssue'] as String),
//       destinationCity: json['destinationCity'] as String,
//       destinationCityId: json['destinationCityId'] as String,
//       doj: DateTime.parse(json['doj'] as String),
//       dropLocation: json['dropLocation'] as String,
//       dropLocationId: json['dropLocationId'] as String,
//       dropTime: json['dropTime'] as String,
//       firstBoardingPointTime: json['firstBoardingPointTime'] as String,
//       hasRtcBreakup: json['hasRtcBreakup'] as String,
//       hasSpecialTemplate: json['hasSpecialTemplate'] as String,
//       inventoryId: json['inventoryId'] as String,
//       inventoryItems: InventoryItems.fromJson(
//           json['inventoryItems'] as Map<String, dynamic>),
//       mTicketEnabled: json['mTicketEnabled'] as String,
//       partialCancellationAllowed: json['partialCancellationAllowed'] as String,
//       pickUpContactNo: json['pickUpContactNo'] as String,
//       pickUpLocationAddress: json['pickUpLocationAddress'] as String,
//       pickupLocation: json['pickupLocation'] as String,
//       pickupLocationId: json['pickupLocationId'] as String,
//       pickupLocationLandmark: json['pickupLocationLandmark'] as String,
//       pickupTime: json['pickupTime'] as String,
//       pnr: json['pnr'] as String,
//       primeDepartureTime: json['primeDepartureTime'] as String,
//       primoBooking: json['primoBooking'] as String,
//       reschedulingPolicy: ReschedulingPolicy.fromJson(
//           json['reschedulingPolicy'] as Map<String, dynamic>),
//       serviceCharge: json['serviceCharge'] as String,
//       sourceCity: json['sourceCity'] as String,
//       sourceCityId: json['sourceCityId'] as String,
//       status: json['status'] as String,
//       tin: json['tin'] as String,
//       travels: json['travels'] as String,
//       vaccinatedBus: json['vaccinatedBus'] as String,
//       vaccinatedStaff: json['vaccinatedStaff'] as String,
//     );

// Map<String, dynamic> _$$_FrezzedToJson(_$_Frezzed instance) =>
//     <String, dynamic>{
//       'bookingFee': instance.bookingFee,
//       'busType': instance.busType,
//       'cancellationCalculationTimestamp':
//           instance.cancellationCalculationTimestamp.toIso8601String(),
//       'cancellationMessage': instance.cancellationMessage,
//       'cancellationPolicy': instance.cancellationPolicy,
//       'dateOfIssue': instance.dateOfIssue.toIso8601String(),
//       'destinationCity': instance.destinationCity,
//       'destinationCityId': instance.destinationCityId,
//       'doj': instance.doj.toIso8601String(),
//       'dropLocation': instance.dropLocation,
//       'dropLocationId': instance.dropLocationId,
//       'dropTime': instance.dropTime,
//       'firstBoardingPointTime': instance.firstBoardingPointTime,
//       'hasRtcBreakup': instance.hasRtcBreakup,
//       'hasSpecialTemplate': instance.hasSpecialTemplate,
//       'inventoryId': instance.inventoryId,
//       'inventoryItems': instance.inventoryItems,
//       'mTicketEnabled': instance.mTicketEnabled,
//       'partialCancellationAllowed': instance.partialCancellationAllowed,
//       'pickUpContactNo': instance.pickUpContactNo,
//       'pickUpLocationAddress': instance.pickUpLocationAddress,
//       'pickupLocation': instance.pickupLocation,
//       'pickupLocationId': instance.pickupLocationId,
//       'pickupLocationLandmark': instance.pickupLocationLandmark,
//       'pickupTime': instance.pickupTime,
//       'pnr': instance.pnr,
//       'primeDepartureTime': instance.primeDepartureTime,
//       'primoBooking': instance.primoBooking,
//       'reschedulingPolicy': instance.reschedulingPolicy,
//       'serviceCharge': instance.serviceCharge,
//       'sourceCity': instance.sourceCity,
//       'sourceCityId': instance.sourceCityId,
//       'status': instance.status,
//       'tin': instance.tin,
//       'travels': instance.travels,
//       'vaccinatedBus': instance.vaccinatedBus,
//       'vaccinatedStaff': instance.vaccinatedStaff,
//     };

// _$_InventoryItems _$$_InventoryItemsFromJson(Map<String, dynamic> json) =>
//     _$_InventoryItems(
//       baseFare: json['baseFare'] as String,
//       fare: json['fare'] as String,
//       ladiesSeat: json['ladiesSeat'] as String,
//       malesSeat: json['malesSeat'] as String,
//       operatorServiceCharge: json['operatorServiceCharge'] as String,
//       passenger: Passenger.fromJson(json['passenger'] as Map<String, dynamic>),
//       seatName: json['seatName'] as String,
//       serviceTax: json['serviceTax'] as String,
//     );

// Map<String, dynamic> _$$_InventoryItemsToJson(_$_InventoryItems instance) =>
//     <String, dynamic>{
//       'baseFare': instance.baseFare,
//       'fare': instance.fare,
//       'ladiesSeat': instance.ladiesSeat,
//       'malesSeat': instance.malesSeat,
//       'operatorServiceCharge': instance.operatorServiceCharge,
//       'passenger': instance.passenger,
//       'seatName': instance.seatName,
//       'serviceTax': instance.serviceTax,
//     };

// _$_Passenger _$$_PassengerFromJson(Map<String, dynamic> json) => _$_Passenger(
//       address: json['address'] as String,
//       age: json['age'] as String,
//       email: json['email'] as String,
//       gender: json['gender'] as String,
//       idNumber: json['idNumber'] as String,
//       idType: json['idType'] as String,
//       mobile: json['mobile'] as String,
//       name: json['name'] as String,
//       primary: json['primary'] as String,
//       singleLadies: json['singleLadies'] as String,
//       title: json['title'] as String,
//     );

// Map<String, dynamic> _$$_PassengerToJson(_$_Passenger instance) =>
//     <String, dynamic>{
//       'address': instance.address,
//       'age': instance.age,
//       'email': instance.email,
//       'gender': instance.gender,
//       'idNumber': instance.idNumber,
//       'idType': instance.idType,
//       'mobile': instance.mobile,
//       'name': instance.name,
//       'primary': instance.primary,
//       'singleLadies': instance.singleLadies,
//       'title': instance.title,
//     };

// _$_ReschedulingPolicy _$$_ReschedulingPolicyFromJson(
//         Map<String, dynamic> json) =>
//     _$_ReschedulingPolicy(
//       reschedulingCharge: json['reschedulingCharge'] as String,
//       windowTime: json['windowTime'] as String,
//     );

// Map<String, dynamic> _$$_ReschedulingPolicyToJson(
//         _$_ReschedulingPolicy instance) =>
//     <String, dynamic>{
//       'reschedulingCharge': instance.reschedulingCharge,
//       'windowTime': instance.windowTime,
//     };
