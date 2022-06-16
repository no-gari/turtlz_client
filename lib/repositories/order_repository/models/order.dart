import 'package:turtlz/repositories/address_repository/models/address.dart';
import 'package:turtlz/repositories/coupon_repository/models/coupon.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

part 'order.g.dart';

@JsonSerializable()
class Order extends Equatable {
  const Order({
    this.merchantUid,
    this.name,
    this.amount,
    this.currency,
    this.buyerName,
    this.buyerTel,
    this.buyerEmail,
  });

  final String? merchantUid;
  final String? name;
  final int? amount;
  final String? currency;
  final String? buyerName;
  final String? buyerTel;
  final String? buyerEmail;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  Order copyWith({
    String? merchantUid,
    String? name,
    int? amount,
    String? currency,
    String? buyerName,
    String? buyerTel,
    String? buyerEmail,
  }) {
    return Order(
      merchantUid: merchantUid ?? this.merchantUid,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      buyerName: buyerName ?? this.buyerName,
      buyerTel: buyerTel ?? this.buyerTel,
      buyerEmail: buyerEmail ?? this.buyerEmail,
    );
  }

  @override
  List<Object?> get props =>
      [merchantUid, name, amount, currency, buyerName, buyerEmail, buyerEmail];
}
