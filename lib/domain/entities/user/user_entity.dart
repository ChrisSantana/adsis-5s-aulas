import 'dart:convert';

import 'package:order_manager/domain/entities/core/address_entity.dart';

final class UserEntity {
  final String id;
  final String name;
  final String email;
  final AddressEntity address;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
  });

  factory UserEntity.fromRemoteMap(Map<String, dynamic> map) {
    return _fromMap(map, map[kKeyAddress] as Map<String, dynamic>);
  }

  factory UserEntity.fromStorageMap(Map<String, dynamic> map) {
    return _fromMap(map, jsonDecode(map[kKeyAddress]) as Map<String, dynamic>);
  }

  static UserEntity _fromMap(Map<String, dynamic> userMap, Map<String, dynamic> addressMap) {
    return UserEntity(
      id: userMap[kKeyId],
      name: userMap[kKeyName],
      email: userMap[kKeyEmail],
      address: AddressEntity.fromMap(addressMap),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      kKeyId: id,
      kKeyName: name,
      kKeyEmail: email,
      kKeyAddress: jsonEncode(address.toMap()),
    };
  }

  static const String kKeyId = 'id';
  static const String kKeyName = 'nome';
  static const String kKeyEmail = 'email';
  static const String kKeyAddress = 'endereco';
}