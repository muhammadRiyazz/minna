class VisaModel {
  final String id;
  final String name;
  final String flag;
  final String visaType;
  final String deliveryDate;
  final String highlight;
  final String stats;
  final String price;
  final String serviceFee;
  final String hasVoucher;
  final String createdAt;

  VisaModel({
    required this.id,
    required this.name,
    required this.flag,
    required this.visaType,
    required this.deliveryDate,
    required this.highlight,
    required this.stats,
    required this.price,
    required this.serviceFee,
    required this.hasVoucher,
    required this.createdAt,
  });

  factory VisaModel.fromJson(Map<String, dynamic> json) {
    return VisaModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      flag: json['flag']?.toString() ?? '',
      visaType: json['visa_type']?.toString() ?? '',
      deliveryDate: json['delivery_date']?.toString() ?? '',
      highlight: json['highlight']?.toString() ?? '',
      stats: json['stats']?.toString() ?? '',
      price: json['price']?.toString() ?? '0.00',
      serviceFee: json['service_fee']?.toString() ?? '0.00',
      hasVoucher: json['has_voucher']?.toString() ?? '0',
      createdAt: json['created_at']?.toString() ?? '',
    );
  }
}
