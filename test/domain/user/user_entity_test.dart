import 'package:flutter_test/flutter_test.dart';
import 'package:order_manager/domain/entities/core/address_entity.dart';
import 'package:order_manager/domain/entities/user/user_entity.dart';

import '../../fixture/library/fixture_helper.dart';

void main() {
  test('should valid the entity', () {
    // Arrange
    final Map<String, dynamic> usuarioMap = FixtureHelper.fetchUsuarioRemoteMap();

    // Act
    final UserEntity usuario = UserEntity.fromRemoteMap(usuarioMap);
    final Map<String, dynamic> usuarioCopyMap = usuario.toMap();

    // Assert
    expect(usuario.id, isA<String>());
    expect(usuario.name, isA<String>());
    expect(usuario.email, isA<String>());
    expect(usuario.address, isA<AddressEntity>());
    expect(usuarioCopyMap, isA<Map<String, dynamic>>());
  });
}