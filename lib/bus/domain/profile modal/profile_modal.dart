// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ProfileModal profileModalFromJson(String str) => ProfileModal.fromJson(json.decode(str));

String profileModalToJson(ProfileModal data) => json.encode(data.toJson());

class ProfileModal {
  ProfileModal({
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
  });

  String name;
  String address;
  String phone;
  String email;

  factory ProfileModal.fromJson(Map<String, dynamic> json) => ProfileModal(
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "phone": phone,
        "email": email,
      };
}
