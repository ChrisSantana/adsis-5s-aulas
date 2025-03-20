import 'dart:convert';

import 'package:order_manager/domain/entities/user/user_entity.dart';

import 'fixture_reader.dart';

final class FixtureHelper {
  static const String url = 'https://test.com.br';

  static UserEntity fetchUsuario() {
    return UserEntity.fromRemoteMap(jsonDecode(fixture('usuario.json')));
  }

  static Map<String, dynamic> fetchUsuarioRemoteMap() {
    return jsonDecode(fixture('usuario.json'));
  }
}
