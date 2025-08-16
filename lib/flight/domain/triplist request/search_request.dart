import 'package:intl/intl.dart';

class FlightSearchRequest {
  String origin;
  String destination;
  DateTime onwardDate;
  DateTime returnDate;
  int adult;
  int child;
  int infant;
  String tripMode;
  String travelType;
  dynamic airlineClass;
  String userId;
  String password;
  dynamic error;
  dynamic includeAirline;
  dynamic excludeAirline;
  dynamic status;
  String destinationNation;
  String originNation;
  String classes;

  FlightSearchRequest({
    required this.origin,
    required this.destination,
    required this.onwardDate,
    required this.returnDate,
    required this.adult,
    required this.child,
    required this.infant,
    required this.tripMode,
    required this.travelType,
    this.airlineClass,
    required this.userId,
    required this.password,
    this.error,
    this.includeAirline,
    this.excludeAirline,
    this.status,
    required this.destinationNation,
    required this.originNation,
    required this.classes,
  });
  final dateFormat = DateFormat('yyyy-MM-dd');

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'Origin': origin,
      'Destination': destination,
      'OnwardDate': dateFormat.format(onwardDate),
      'ReturnDate': dateFormat.format(returnDate),
      'Adult': adult,
      'Child': child,
      'Infant': infant,
      'TripMode': tripMode,
      'TravelType': travelType,
      'AirlineClass': airlineClass,
      'UserId': userId,
      'Password': password,
      'Error': error,
      'IncludeAirline': includeAirline,
      'ExcludeAirline': excludeAirline,
      'Status': status,
      'DestinationNation': destinationNation,
      'OriginNation': originNation,
      'Classes': classes,
    };
  }

  // Create from JSON
  factory FlightSearchRequest.fromJson(Map<String, dynamic> json) {
    return FlightSearchRequest(
      origin: json['Origin'],
      destination: json['Destination'],
      onwardDate: DateTime.fromMillisecondsSinceEpoch(
        int.parse(json['OnwardDate'].replaceAll(RegExp(r'[^0-9]'), '')),
      ),
      returnDate: DateTime.fromMillisecondsSinceEpoch(
        int.parse(json['ReturnDate'].replaceAll(RegExp(r'[^0-9]'), '')),
      ),
      adult: json['Adult'],
      child: json['Child'],
      infant: json['Infant'],
      tripMode: json['TripMode'],
      travelType: json['TravelType'],
      airlineClass: json['AirlineClass'],
      userId: json['UserId'],
      password: json['Password'],
      error: json['Error'],
      includeAirline: json['IncludeAirline'],
      excludeAirline: json['ExcludeAirline'],
      status: json['Status'],
      destinationNation: json['DestinationNation'],
      originNation: json['OriginNation'],
      classes: json['Classes'],
    );
  }
}
