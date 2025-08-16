// To parse this JSON data, do
//
//     final modelSearchLocation = modelSearchLocationFromJson(jsonString);

import 'dart:convert';

List<ModelSearchLocation> modelSearchLocationFromJson(String str) => List<ModelSearchLocation>.from(json.decode(str).map((x) => ModelSearchLocation.fromJson(x)));

String modelSearchLocationToJson(List<ModelSearchLocation> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelSearchLocation {
    ModelSearchLocation({
       required this.id,
       required this.cityName,
       required this.aliasNames,
    });

    int id;
    String cityName;
    List<String> aliasNames;

    factory ModelSearchLocation.fromJson(Map<String, dynamic> json) => ModelSearchLocation(
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
