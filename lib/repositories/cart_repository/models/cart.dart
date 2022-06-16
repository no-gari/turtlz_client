import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart extends Equatable {
  const Cart({
    this.brand,
    this.productId,
    this.productName,
    this.productThumbnail,
    this.variantId,
    this.variantName,
    this.salePrice,
    this.quantity,
    this.Id,
    this.isChecked = true,
  });

  final String? brand;
  final String? productId;
  final String? productName;
  final String? productThumbnail;
  final String? variantId;
  final String? variantName;
  final num? salePrice;
  final num? quantity;
  final String? Id;
  final bool? isChecked;

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);

  Cart copyWith({
    String? brand,
    String? productId,
    String? productName,
    String? productThumbnail,
    String? variantId,
    String? variantName,
    num? salePrice,
    num? quantity,
    String? Id,
    bool? isChecked,
  }) {
    return Cart(
      brand: brand ?? this.brand,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productThumbnail: productThumbnail ?? this.productThumbnail,
      variantId: variantId ?? this.variantId,
      variantName: variantName ?? this.variantName,
      salePrice: salePrice ?? this.salePrice,
      quantity: quantity ?? this.quantity,
      Id: Id ?? this.Id,
      isChecked: isChecked ?? this.isChecked,
    );
  }

  @override
  List<Object?> get props => [
        brand,
        productId,
        productName,
        productThumbnail,
        variantId,
        variantName,
        salePrice,
        quantity,
        Id,
        isChecked,
      ];
}
