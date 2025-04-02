import 'dart:convert';

import 'package:order_manager/domain/entities/core/address_entity.dart';
import 'package:order_manager/domain/entities/core/location_entity.dart';

final class UserEntity {
  final String id;
  final String name;
  final String email;
  final String profileImage;
  final LocationEntity location;
  final AddressEntity address;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.location,
    required this.address,
  });

  factory UserEntity.fromRemoteMap(Map<String, dynamic> map) {
    return _fromMap(
      userMap: map, 
      locationMap: map[kKeyLocation] as Map<String, dynamic>,
      addressMap: map[kKeyAddress] as Map<String, dynamic>,
    );
  }

  factory UserEntity.fromStorageMap(Map<String, dynamic> map) {
    return _fromMap(
      userMap: map, 
      locationMap: jsonDecode(map[kKeyLocation]) as Map<String, dynamic>, 
      addressMap: jsonDecode(map[kKeyAddress]) as Map<String, dynamic>,
    );
  }

  static UserEntity _fromMap({
    required Map<String, dynamic> userMap, 
    required Map<String, dynamic> locationMap, 
    required Map<String, dynamic> addressMap,
  }) {
    return UserEntity(
      id: userMap[kKeyId],
      name: userMap[kKeyName],
      email: userMap[kKeyEmail],
      profileImage: userMap[kKeyProfileImage],
      location: LocationEntity.fromMap(locationMap),
      address: AddressEntity.fromMap(addressMap),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      kKeyId: id,
      kKeyName: name,
      kKeyEmail: email,
      kKeyProfileImage: profileImage,
      kKeyLocation: jsonEncode(location.toMap()),
      kKeyAddress: jsonEncode(address.toMap()),
    };
  }

  static const String kKeyId = 'id';
  static const String kKeyName = 'nome';
  static const String kKeyEmail = 'email';
  static const String kKeyProfileImage = 'fotoPerfil';
  static const String kKeyLocation = 'localizacao';
  static const String kKeyAddress = 'endereco';
}