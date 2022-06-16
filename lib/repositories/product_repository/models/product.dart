import 'package:turtlz/repositories/product_repository/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'brand.dart';

part 'product.g.dart';

@JsonSerializable()
class Product extends Equatable {
  const Product(
      {this.Id,
      this.name,
      this.keywords,
      this.summary,
      this.description,
      this.rating,
      this.originalPrice,
      this.discountPrice,
      this.discountRate,
      this.brand,
      this.thumbnail,
      this.available,
      this.hashtags,
      this.totalReviews,
      this.options,
      this.variants});

  final String? Id;
  final String? name;
  final String? keywords;
  final String? summary;
  final String? description;
  final int? rating;
  final int? originalPrice;
  final int? discountPrice;
  final int? discountRate;
  final Brand? brand;
  final bool? available;
  final String? thumbnail;
  final List<String>? hashtags;
  final int? totalReviews;
  final List<Option>? options;
  final List<Variants>? variants;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object?> get props => [
        Id,
        name,
        summary,
        description,
        rating,
        originalPrice,
        discountRate,
        discountPrice,
        brand,
        thumbnail,
        available,
        keywords,
        hashtags,
        totalReviews,
        options,
        variants,
      ];

  Product copyWith(
      {String? Id,
      String? name,
      String? summary,
      String? description,
      int? rating,
      int? originalPrice,
      int? discountPrice,
      int? discountRate,
      Brand? brand,
      String? thumbnail,
      String? keywords,
      bool? available,
      List<String>? hashtags,
      int? totalReviews,
      List<Option>? options,
      List<Variants>? variants}) {
    return Product(
      Id: Id ?? this.Id,
      name: name ?? this.name,
      summary: summary ?? this.summary,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      originalPrice: originalPrice ?? this.originalPrice,
      discountPrice: discountPrice ?? this.discountPrice,
      discountRate: discountRate ?? this.discountRate,
      available: available ?? this.available,
      keywords: keywords ?? this.keywords,
      hashtags: hashtags ?? this.hashtags,
      totalReviews: totalReviews ?? this.totalReviews,
      brand: brand ?? this.brand,
      options: options ?? this.options,
      variants: variants ?? this.variants,
    );
  }
}
