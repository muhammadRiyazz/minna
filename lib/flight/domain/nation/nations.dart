class CountryResponse {
  final String status;
  final int statusCode;
  final String statusDesc;
  final List<Country> data;

  CountryResponse({
    required this.status,
    required this.statusCode,
    required this.statusDesc,
    required this.data,
  });

  factory CountryResponse.fromJson(Map<String, dynamic> json) {
    return CountryResponse(
      status: json['status'],
      statusCode: json['statusCode'],
      statusDesc: json['statusDesc'],
      data: (json['data'] as List).map((i) => Country.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'statusCode': statusCode,
      'statusDesc': statusDesc,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class Country {
  final String countryCode;
  final String countryName;

  Country({required this.countryCode, required this.countryName});
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Country &&
          runtimeType == other.runtimeType &&
          countryCode == other.countryCode;

  @override
  int get hashCode => countryCode.hashCode;

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      countryCode: json['CountryCode'],
      countryName: json['CountryName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'CountryCode': countryCode, 'CountryName': countryName};
  }
}
