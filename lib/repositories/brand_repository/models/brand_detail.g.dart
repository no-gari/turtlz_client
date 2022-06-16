// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandDetail _$BrandDetailFromJson(Map<String, dynamic> json) {
  return BrandDetail(
    json['Id'] as String?,
    json['description'] as String?,
    json['name'] as String?,
    json['logo'] as String?,
    json['products'] as List<dynamic>?,
  );
}

Map<String, dynamic> _$BrandDetailToJson(BrandDetail instance) =>
    <String, dynamic>{
      'Id': instance.Id,
      'description': instance.description,
      'name': instance.name,
      'logo': instance.logo,
      'products': instance.products,
    };
