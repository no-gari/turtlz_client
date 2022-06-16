import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'option.dart';
import 'variation.dart';

part 'type_group.g.dart';

@JsonSerializable()
class TypeGroup extends Equatable {
  const TypeGroup({
    this.option,
    this.variation,
  });

  final Option? option;
  final Variation? variation;

  factory TypeGroup.fromJson(Map<String, dynamic> json) =>
      _$TypeGroupFromJson(json);

  Map<String, dynamic> toJson() => _$TypeGroupToJson(this);

  @override
  List<Object?> get props => [option, variation];

  TypeGroup copyWith({
    Option? option,
    Variation? variation,
  }) {
    return TypeGroup(
      option: option ?? this.option,
      variation: variation,
    );
  }
}
