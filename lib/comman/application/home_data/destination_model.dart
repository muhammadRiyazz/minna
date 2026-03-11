class DestinationModel {
  final String id;
  final String name;
  final String country;
  final String image;
  final String price;
  final String createdAt;

  DestinationModel({
    required this.id,
    required this.name,
    required this.country,
    required this.image,
    required this.price,
    required this.createdAt,
  });

  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      country: json['country']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      price: json['price']?.toString() ?? '0.00',
      createdAt: json['created_at']?.toString() ?? '',
    );
  }
}
