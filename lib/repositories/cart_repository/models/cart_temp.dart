import 'package:turtlz/repositories/product_repository/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_temp.g.dart';

@JsonSerializable()
class CartTemp extends Equatable {
  const CartTemp({
    this.variants,
    this.quantity,
  });

  final Variants? variants;
  final num? quantity;

  factory CartTemp.fromJson(Map<String, dynamic> json) =>
      _$CartTempFromJson(json);

  Map<String, dynamic> toJson() => _$CartTempToJson(this);

  CartTemp copyWith({
    Variants? variants,
    num? quantity,
  }) {
    return CartTemp(
      variants: variants ?? this.variants,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [
        variants,
        quantity,
      ];
}
