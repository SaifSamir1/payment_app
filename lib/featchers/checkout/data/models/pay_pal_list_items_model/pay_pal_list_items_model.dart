import 'item.dart';

class PayPalListItemsModel {
  List<Item>? items;

  PayPalListItemsModel({this.items});

  factory PayPalListItemsModel.fromJson(Map<String, dynamic> json) {
    return PayPalListItemsModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'items': items?.map((e) => e.toJson()).toList(),
      };
}
