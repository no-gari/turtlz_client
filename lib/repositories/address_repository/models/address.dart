import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address extends Equatable {
  const Address(
      {this.id,
      this.name,
      this.bigAddress,
      this.smallAddress,
      this.postalCode,
      this.phoneNumber,
      this.isDefault = false});

  final int? id;
  final String? name;
  final String? bigAddress;
  final String? smallAddress;
  final String? postalCode;
  final String? phoneNumber;
  final bool? isDefault;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  static const empty = Address(
      id: null,
      name: "",
      bigAddress: "",
      smallAddress: "",
      postalCode: "",
      phoneNumber: "",
      isDefault: false);

  @override
  List<Object?> get props =>
      [id, name, bigAddress, smallAddress, postalCode, phoneNumber, isDefault];

  Address copyWith({
    int? id,
    String? name,
    String? bigAddress,
    String? smallAddress,
    String? postalCode,
    String? phoneNumber,
    bool? isDefault,
  }) {
    return Address(
      id: id ?? this.id,
      name: name ?? this.name,
      bigAddress: bigAddress ?? this.bigAddress,
      smallAddress: smallAddress ?? this.smallAddress,
      postalCode: postalCode ?? this.postalCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
