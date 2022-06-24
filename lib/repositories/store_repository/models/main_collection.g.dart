// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainCollection _$MainCollectionFromJson(Map<String, dynamic> json) =>
    MainCollection(
      json['collection'] == null
          ? null
          : Collection.fromJson(json['collection'] as Map<String, dynamic>),
      (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MainCollectionToJson(MainCollection instance) =>
    <String, dynamic>{
      'collection': instance.collection,
      'products': instance.products,
    };
