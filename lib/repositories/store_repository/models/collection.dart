import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collection.g.dart';

@JsonSerializable()
class Collection extends Equatable {
  const Collection(this.Id, this.name, this.thumbnail);

  final String Id;
  final String name;
  final String thumbnail;

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionToJson(this);

  @override
  List<Object?> get props => [Id, name, thumbnail];
}
