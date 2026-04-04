class DestinationModel {
  final String id;
  final String title;
  final String location;
  final String inclusions;
  final String exclusions;
  final String hotelDetails;
  final String price;
  final String priceToShow;
  final String image;
  final String createdAt;
  final List<DayPlan> days;

  DestinationModel({
    required this.id,
    required this.title,
    required this.location,
    required this.inclusions,
    required this.exclusions,
    required this.hotelDetails,
    required this.price,
    required this.priceToShow,
    required this.image,
    required this.createdAt,
    required this.days,
  });

  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      inclusions: json['inclusions']?.toString() ?? '',
      exclusions: json['exclusions']?.toString() ?? '',
      hotelDetails: json['hotel_details']?.toString() ?? '',
      price: json['price']?.toString() ?? '0.00',
      priceToShow: json['priceToShow']?.toString() ?? '0.00',
      image: json['image']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      days: (json['days'] as List<dynamic>?)
              ?.map((e) => DayPlan.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class DayPlan {
  final String id;
  final String packageId;
  final String dayNumber;
  final String title;
  final String description;
  final String meals;

  DayPlan({
    required this.id,
    required this.packageId,
    required this.dayNumber,
    required this.title,
    required this.description,
    required this.meals,
  });

  factory DayPlan.fromJson(Map<String, dynamic> json) {
    return DayPlan(
      id: json['id']?.toString() ?? '',
      packageId: json['package_id']?.toString() ?? '',
      dayNumber: json['day_number']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      meals: json['meals']?.toString() ?? '',
    );
  }
}
