// // To parse this JSON data, do
// //
// //     final boarding = boardingFromMap(jsondynamic);

// import 'dart:convert';

// CityModel boardingFromMap(dynamic str) => CityModel.fromMap(json.decode(str));

// dynamic boardingToMap(CityModel? data) => json.encode(data!.toMap());

// class CityModel {
//   CityModel({
//     required this.cities,
//   });

//   List<City?> cities;

//   factory CityModel.fromMap(Map<dynamic, dynamic> json) => CityModel(
//         cities: json["cities"] == null
//             ? []
//             : List<City?>.from(
//                 json["cities"]!.map(
//                   (x) => City.fromMap(x),
//                 ),
//               ),
//       );

//   Map<dynamic, dynamic> toMap() => {
//         "cities": cities == null
//             ? []
//             : List<dynamic>.from(
//                 cities.map(
//                   (x) => x!.toMap(),
//                 ),
//               ),
//       };
// }

// class City {
//   City({
//     required this.id,
//     required this.latitude,
//     required this.locationType,
//     required this.longitude,
//     required this.name,
//     required this.state,
//     required this.stateId,
//   });

//   dynamic id;
//   dynamic latitude;
//   LocationType? locationType;
//   dynamic longitude;
//   dynamic name;
//   State? state;
//   dynamic stateId;

//   factory City.fromMap(Map<dynamic, dynamic> json) => City(
//         id: json["id"],
//         latitude: json["latitude"],
//         locationType: locationTypeValues.map[json["locationType"]],
//         longitude: json["longitude"],
//         name: json["name"],
//         state: stateValues.map[json["state"]],
//         stateId: json["stateId"],
//       );

//   Map<dynamic, dynamic> toMap() => {
//         "id": id,
//         "latitude": latitude,
//         "locationType": locationTypeValues.reverse![locationType],
//         "longitude": longitude,
//         "name": name,
//         "state": stateValues.reverse![state],
//         "stateId": stateId,
//       };
// }

// enum LocationType { CITY }

// final locationTypeValues = EnumValues({"CITY": LocationType.CITY});

// enum State {
//   MAHARASHTRA,
//   HIMACHAL_PRADESH,
//   RAJASTHAN,
//   MADHYA_PRADESH,
//   KERALA,
//   GUJARAT,
//   KARNATAKA,
//   ANDHRA_PRADESH,
//   UTTARAKHAND,
//   BIHAR,
//   CHHATTISGARH,
//   TAMIL_NADU,
//   PUNJAB,
//   HARYANA,
//   UTTAR_PRADESH,
//   JHARKHAND,
//   JAMMU_AND_KASHMIR,
//   MEGHALAYA,
//   WEST_BENGAL,
//   GOA,
//   ASSAM,
//   ODISHA,
//   MIZORAM,
//   ARUNACHAL_PRADESH,
//   TRIPURA,
//   DELHI_STATE,
//   TELANGANA,
//   NEPAL,
//   NAGALAND,
//   PONDICHERRY_STATE,
//   ANDAMAN_AND_NICOBAR_ISLANDS,
//   PONDICHERRY,
//   STATE_ANDAMAN_AND_NICOBAR_ISLANDS,
//   SIKKIM,
//   DHAKA_DIVISION,
//   MANIPUR,
//   NEAR_BUS_STAND_BANSWARA,
//   DAMAN_AND_DIU,
//   AMBEDKAR_NAGAR_UTTAR_PRADESH
// }

// final stateValues = EnumValues({
//   "Ambedkar Nagar (uttar Pradesh)": State.AMBEDKAR_NAGAR_UTTAR_PRADESH,
//   "Andaman And Nicobar Islands": State.ANDAMAN_AND_NICOBAR_ISLANDS,
//   "Andhra Pradesh": State.ANDHRA_PRADESH,
//   "Arunachal Pradesh": State.ARUNACHAL_PRADESH,
//   "Assam": State.ASSAM,
//   "Bihar": State.BIHAR,
//   "Chhattisgarh": State.CHHATTISGARH,
//   "Daman and Diu": State.DAMAN_AND_DIU,
//   "Delhi State": State.DELHI_STATE,
//   "Dhaka Division": State.DHAKA_DIVISION,
//   "Goa": State.GOA,
//   "Gujarat": State.GUJARAT,
//   "Haryana": State.HARYANA,
//   "Himachal Pradesh": State.HIMACHAL_PRADESH,
//   "Jammu and Kashmir": State.JAMMU_AND_KASHMIR,
//   "Jharkhand": State.JHARKHAND,
//   "Karnataka": State.KARNATAKA,
//   "Kerala": State.KERALA,
//   "Madhya Pradesh": State.MADHYA_PRADESH,
//   "Maharashtra": State.MAHARASHTRA,
//   "Manipur": State.MANIPUR,
//   "Meghalaya": State.MEGHALAYA,
//   "Mizoram": State.MIZORAM,
//   "Nagaland": State.NAGALAND,
//   "Near Bus Stand,Banswara": State.NEAR_BUS_STAND_BANSWARA,
//   "Nepal": State.NEPAL,
//   "Odisha": State.ODISHA,
//   "Pondicherry": State.PONDICHERRY,
//   "Pondicherry State": State.PONDICHERRY_STATE,
//   "Punjab": State.PUNJAB,
//   "Rajasthan": State.RAJASTHAN,
//   "Sikkim": State.SIKKIM,
//   "Andaman and Nicobar Islands": State.STATE_ANDAMAN_AND_NICOBAR_ISLANDS,
//   "Tamil Nadu": State.TAMIL_NADU,
//   "Telangana": State.TELANGANA,
//   "Tripura": State.TRIPURA,
//   "Uttarakhand": State.UTTARAKHAND,
//   "Uttar Pradesh": State.UTTAR_PRADESH,
//   "West Bengal": State.WEST_BENGAL
// });

// class EnumValues<T> {
//   Map<dynamic, T> map;
//   Map<T, dynamic>? reverseMap;

//   EnumValues(this.map);

//   Map<T, dynamic>? get reverse {
//     reverseMap ??= map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
