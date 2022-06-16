import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item.g.dart';

@JsonSerializable()
class OrderItem extends Equatable {
  const OrderItem({
    this.brand,
    this.productId,
    this.productName,
    this.productThumbnail,
    this.variantId,
    this.variantName,
    this.available,
    this.salePrice,
    this.quantity,
    this.Id,
    this.status,
    this.tracking,
  });

  final String? brand;
  final String? productId;
  final String? productName;
  final String? productThumbnail;
  final String? variantId;
  final String? variantName;
  final bool? available;
  final int? salePrice;
  final int? quantity;
  final String? Id;
  final String? status;
  final Map? tracking;

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  @override
  List<Object?> get props => [
        brand,
        productId,
        productName,
        productThumbnail,
        variantName,
        variantId,
        available,
        salePrice,
        quantity,
        Id,
        status,
        tracking,
      ];
}
