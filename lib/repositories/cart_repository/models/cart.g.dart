// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      brand: json['brand'] as String?,
      productId: json['productId'] as String?,
      productName: json['productName'] as String?,
      productThumbnail: json['productThumbnail'] as String?,
      variantId: json['variantId'] as String?,
      variantName: json['variantName'] as String?,
      salePrice: json['salePrice'] as num?,
      quantity: json['quantity'] as num?,
      Id: json['Id'] as String?,
      isChecked: json['isChecked'] as bool? ?? true,
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'brand': instance.brand,
      'productId': instance.productId,
      'productName': instance.productName,
      'productThumbnail': instance.productThumbnail,
      'variantId': instance.variantId,
      'variantName': instance.variantName,
      'salePrice': instance.salePrice,
      'quantity': instance.quantity,
      'Id': instance.Id,
      'isChecked': instance.isChecked,
    };
