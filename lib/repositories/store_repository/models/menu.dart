import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'collection.dart';

part 'menu.g.dart';

@JsonSerializable()
class Menu extends Equatable {
  const Menu(
    this.name,
    this.Id,
    this.thumbnail,
  );

  final String name;
  final String Id;
  final String thumbnail;

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

  Map<String, dynamic> toJson() => _$MenuToJson(this);

  @override
  List<Object?> get props => [name, Id, thumbnail];
}
