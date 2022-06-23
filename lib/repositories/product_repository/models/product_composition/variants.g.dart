// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variants.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Variants _$VariantsFromJson(Map<String, dynamic> json) => Variants(
      Id: json['Id'] as String?,
      variantName: json['variantName'] as String?,
      originalPrice: json['originalPrice'] as int?,
      discountPrice: json['discountPrice'] as int?,
      discountRate: json['discountRate'] as int?,
      available: json['available'] as bool?,
      thumbnail: json['thumbnail'] as String?,
      types: (json['types'] as List<dynamic>?)
          ?.map((e) => TypeGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VariantsToJson(Variants instance) => <String, dynamic>{
      'Id': instance.Id,
      'variantName': instance.variantName,
      'originalPrice': instance.originalPrice,
      'discountPrice': instance.discountPrice,
      'discountRate': instance.discountRate,
      'available': instance.available,
      'thumbnail': instance.thumbnail,
      'types': instance.types,
    };
