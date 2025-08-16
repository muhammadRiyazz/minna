// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

CancelSuccesModal cancelSuccesModalFromJson(String str) =>
    CancelSuccesModal.fromJson(json.decode(str));

String welcomeToJson(CancelSuccesModal data) => json.encode(data.toJson());

class CancelSuccesModal {
  CancelSuccesModal({
    required this.cancellationCharge,
    required this.refundAmount,
    required this.refundServiceTax,
    required this.serviceTaxOnCancellationCharge,
    required this.tin,
  });

  String cancellationCharge;
  String refundAmount;
  String refundServiceTax;
  String serviceTaxOnCancellationCharge;
  String tin;

  factory CancelSuccesModal.fromJson(Map<String, dynamic> json) =>
      CancelSuccesModal(
        cancellationCharge: json["cancellationCharge"],
        refundAmount: json["refundAmount"],
        refundServiceTax: json["refundServiceTax"],
        serviceTaxOnCancellationCharge: json["serviceTaxOnCancellationCharge"],
        tin: json["tin"],
      );

  Map<String, dynamic> toJson() => {
        "cancellationCharge": cancellationCharge,
        "refundAmount": refundAmount,
        "refundServiceTax": refundServiceTax,
        "serviceTaxOnCancellationCharge": serviceTaxOnCancellationCharge,
        "tin": tin,
      };
}
