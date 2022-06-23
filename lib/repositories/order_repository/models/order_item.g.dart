// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      brand: json['brand'] as String?,
      productId: json['productId'] as String?,
      productName: json['productName'] as String?,
      productThumbnail: json['productThumbnail'] as String?,
      variantId: json['variantId'] as String?,
      variantName: json['variantName'] as String?,
      available: json['available'] as bool?,
      salePrice: json['salePrice'] as int?,
      quantity: json['quantity'] as int?,
      Id: json['Id'] as String?,
      status: json['status'] as String?,
      tracking: json['tracking'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'brand': instance.brand,
      'productId': instance.productId,
      'productName': instance.productName,
      'productThumbnail': instance.productThumbnail,
      'variantId': instance.variantId,
      'variantName': instance.variantName,
      'available': instance.available,
      'salePrice': instance.salePrice,
      'quantity': instance.quantity,
      'Id': instance.Id,
      'status': instance.status,
      'tracking': instance.tracking,
    };
