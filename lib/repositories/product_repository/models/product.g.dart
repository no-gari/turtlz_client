// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      Id: json['Id'] as String?,
      name: json['name'] as String?,
      keywords: json['keywords'] as String?,
      summary: json['summary'] as String?,
      description: json['description'] as String?,
      rating: json['rating'] as int?,
      originalPrice: json['originalPrice'] as int?,
      discountPrice: json['discountPrice'] as int?,
      discountRate: json['discountRate'] as int?,
      brand: json['brand'] == null
          ? null
          : Brand.fromJson(json['brand'] as Map<String, dynamic>),
      thumbnail: json['thumbnail'] as String?,
      available: json['available'] as bool?,
      hashtags: (json['hashtags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      totalReviews: json['totalReviews'] as int?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
      variants: (json['variants'] as List<dynamic>?)
          ?.map((e) => Variants.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'Id': instance.Id,
      'name': instance.name,
      'keywords': instance.keywords,
      'summary': instance.summary,
      'description': instance.description,
      'rating': instance.rating,
      'originalPrice': instance.originalPrice,
      'discountPrice': instance.discountPrice,
      'discountRate': instance.discountRate,
      'brand': instance.brand,
      'available': instance.available,
      'thumbnail': instance.thumbnail,
      'hashtags': instance.hashtags,
      'totalReviews': instance.totalReviews,
      'options': instance.options,
      'variants': instance.variants,
    };
