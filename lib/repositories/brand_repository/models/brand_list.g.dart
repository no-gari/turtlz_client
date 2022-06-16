// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandList _$BrandListFromJson(Map<String, dynamic> json) {
  return BrandList(
    json['Id'] as String?,
    json['name'] as String?,
    json['description'] as String?,
    json['logo'] as String?,
  );
}

Map<String, dynamic> _$BrandListToJson(BrandList instance) => <String, dynamic>{
      'Id': instance.Id,
      'name': instance.name,
      'description': instance.description,
      'logo': instance.logo,
    };
