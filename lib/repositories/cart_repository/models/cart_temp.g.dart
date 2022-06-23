// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_temp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartTemp _$CartTempFromJson(Map<String, dynamic> json) => CartTemp(
      variants: json['variants'] == null
          ? null
          : Variants.fromJson(json['variants'] as Map<String, dynamic>),
      quantity: json['quantity'] as num?,
    );

Map<String, dynamic> _$CartTempToJson(CartTemp instance) => <String, dynamic>{
      'variants': instance.variants,
      'quantity': instance.quantity,
    };
