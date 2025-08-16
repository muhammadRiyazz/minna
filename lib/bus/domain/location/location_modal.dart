import 'dart:convert';

CityModelList cityModelDataFromJson(String str) =>
    CityModelList.fromJson(json.decode(str));
String cityModelToJson(CityModelList data) => json.encode(data.toJson());

class CityModelList {
  List<City> cities;

  CityModelList({
    required this.cities,
  });

  factory CityModelList.fromJson(Map<String, dynamic> json) => CityModelList(
        cities: List<City>.from(json["cities"].map((x) => City.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cities": List<dynamic>.from(cities.map((x) => x.toJson())),
      };
}

class City {
  String id;
  String latitude;
  String locationType;
  String longitude;
  String name;
  String state;
  String stateId;

  City({
    required this.id,
    required this.latitude,
    required this.locationType,
    required this.longitude,
    required this.name,
    required this.state,
    required this.stateId,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"] ?? '',
        latitude: json["latitude"] ?? '',
        locationType: json["locationType"] ?? '',
        longitude: json["longitude"] ?? '',
        name: json["name"] ?? '',
        state: json["state"] ?? '',
        stateId: json["stateId"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "latitude": latitude,
        "locationType": locationType,
        "longitude": longitude,
        "name": name,
        "state": state,
        "stateId": stateId,
      };
}
