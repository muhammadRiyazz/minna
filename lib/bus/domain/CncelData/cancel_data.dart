// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

CancelDataModal cancelDataModalFromJson(String str) =>
    CancelDataModal.fromJson(json.decode(str));

String welcomeToJson(CancelDataModal data) => json.encode(data.toJson());

class CancelDataModal {
  CancelDataModal({
    required this.cancellable,
    required this.cancellationCharges,
    required this.fares,
    required this.partiallyCancellable,
    required this.serviceCharge,
    required this.serviceTaxOnCancellationCharge,
    required this.totalCancellationCharge,
    required this.totalRefundAmount,
  });

  String cancellable;
  CancellationCharges cancellationCharges;
  CancellationCharges fares;
  String partiallyCancellable;
  String serviceCharge;
  String serviceTaxOnCancellationCharge;
  String totalCancellationCharge;
  String totalRefundAmount;

  factory CancelDataModal.fromJson(Map<String, dynamic> json) =>
      CancelDataModal(
        cancellable: json["cancellable"],
        cancellationCharges:
            CancellationCharges.fromJson(json["cancellationCharges"]),
        fares: CancellationCharges.fromJson(json["fares"]),
        partiallyCancellable: json["partiallyCancellable"],
        serviceCharge: json["serviceCharge"],
        serviceTaxOnCancellationCharge: json["serviceTaxOnCancellationCharge"],
        totalCancellationCharge: json["totalCancellationCharge"],
        totalRefundAmount: json["totalRefundAmount"],
      );

  Map<String, dynamic> toJson() => {
        "cancellable": cancellable,
        "cancellationCharges": cancellationCharges.toJson(),
        "fares": fares.toJson(),
        "partiallyCancellable": partiallyCancellable,
        "serviceCharge": serviceCharge,
        "serviceTaxOnCancellationCharge": serviceTaxOnCancellationCharge,
        "totalCancellationCharge": totalCancellationCharge,
        "totalRefundAmount": totalRefundAmount,
      };
}

class CancellationCharges {
  CancellationCharges({
    required this.entry,
  });

  List<Entry> entry;

  factory CancellationCharges.fromJson(Map<String, dynamic> json) {
    final cancellationChargesJson = json['entry'];

    List<Entry> cancellationCharges = [];
    if (cancellationChargesJson is List) {
      cancellationCharges = List<Entry>.from(
        cancellationChargesJson.map((x) => Entry.fromJson(x)),
      );
    } else if (cancellationChargesJson is Map) {
      cancellationCharges = [
        Entry.fromJson(cancellationChargesJson as Map<String, dynamic>)
      ];
    }

    return CancellationCharges(entry: cancellationCharges);
  }
  Map<String, dynamic> toJson() => {
        "entry": List<dynamic>.from(entry.map((x) => x.toJson())),
      };
}

class Entry {
  Entry({
    required this.key,
    required this.value,
  });

  String key;
  String value;

  factory Entry.fromJson(Map<String, dynamic> json) => Entry(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}
