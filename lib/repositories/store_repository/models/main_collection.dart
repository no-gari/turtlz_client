import 'package:turtlz/repositories/store_repository/models/collection.dart';
import 'package:turtlz/repositories/product_repository/models/product.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'main_collection.g.dart';

@JsonSerializable()
class MainCollection extends Equatable {
  const MainCollection(this.collection, this.products);

  final Collection? collection;
  final List<Product>? products;

  factory MainCollection.fromJson(Map<String, dynamic> json) =>
      _$MainCollectionFromJson(json);
  Map<String, dynamic> toJson() => _$MainCollectionToJson(this);

  @override
  List<Object?> get props => [collection, products];
}
