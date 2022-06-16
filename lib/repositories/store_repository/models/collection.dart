import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collection.g.dart';

@JsonSerializable()
class Collection extends Equatable {
  const Collection(
    this.Id,
    this.name,
  );

  final String Id;
  final String name;


  factory Collection.fromJson(Map<String, dynamic> json) => _$CollectionFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionToJson(this);


  @override
  List<Object?> get props => [Id, name];
}
