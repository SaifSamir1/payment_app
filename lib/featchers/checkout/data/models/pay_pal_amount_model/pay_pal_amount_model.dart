import 'details.dart';

class PayPalAmountModel {
  String? total;
  String? currency;
  Details? details;

  PayPalAmountModel({this.total, this.currency, this.details});

  factory PayPalAmountModel.fromJson(Map<String, dynamic> json) {
    return PayPalAmountModel(
      total: json['total'] as String?,
      currency: json['currency'] as String?,
      details: json['details'] == null
          ? null
          : Details.fromJson(json['details'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'total': total,
        'currency': currency,
        'details': details?.toJson(),
      };
}
