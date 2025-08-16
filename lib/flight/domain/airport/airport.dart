class Airport {
  final String name;
  final String code;
  final String type; // "I" (International) or "D" (Domestic)
  final String countryCode; // e.g., "IN" for India, "AE" for UAE

  Airport({
    required this.name,
    required this.code,
    required this.type,
    required this.countryCode,
  });

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      name: json['AirportName'],
      code: json['AirportCode'],
      type: json['AirportType'] ?? 'I', // Default to International if not specified
      countryCode: json['CountryCode'], // Ensure this is in the API response
    );
  }
}