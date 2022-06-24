import 'package:turtlz/repositories/product_repository/models/product.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'banner_collection.g.dart';

@JsonSerializable()
class BannerCollection extends Equatable {
  const BannerCollection(this.isProduct, this.productId, this.eventBanner);

  final bool? isProduct;
  final String? productId;
  final String? eventBanner;

  factory BannerCollection.fromJson(Map<String, dynamic> json) =>
      _$BannerCollectionFromJson(json);
  Map<String, dynamic> toJson() => _$BannerCollectionToJson(this);

  @override
  List<Object?> get props => [isProduct, productId, eventBanner];
}
