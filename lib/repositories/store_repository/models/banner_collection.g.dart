// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerCollection _$BannerCollectionFromJson(Map<String, dynamic> json) =>
    BannerCollection(
      json['isProduct'] as bool?,
      json['productId'] as String?,
      json['eventBanner'] as String?,
    );

Map<String, dynamic> _$BannerCollectionToJson(BannerCollection instance) =>
    <String, dynamic>{
      'isProduct': instance.isProduct,
      'productId': instance.productId,
      'eventBanner': instance.eventBanner,
    };
