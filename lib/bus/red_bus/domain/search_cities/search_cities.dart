// To parse this JSON data, do
//
//     final modelSearchCity = modelSearchCityFromJson(jsonString);

import 'dart:convert';

List<ModelSearchCity> modelSearchCityFromJson(String str) =>
    List<ModelSearchCity>.from(
        json.decode(str).map((x) => ModelSearchCity.fromJson(x)));

String modelSearchCityToJson(List<ModelSearchCity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelSearchCity {
  ModelSearchCity({
    required this.id,
    required this.cityName,
    required this.aliasNames,
  });

  int id;
  String cityName;
  List<String> aliasNames;

  factory ModelSearchCity.fromJson(Map<String, dynamic> json) =>
      ModelSearchCity(
        id: json["id"],
        cityName: json["cityName"],
        aliasNames: List<String>.from(json["aliasNames"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cityName": cityName,
        "aliasNames": List<dynamic>.from(aliasNames.map((x) => x)),
      };
}
