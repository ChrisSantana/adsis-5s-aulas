import 'dart:math';

import 'package:order_manager/configs/environment_helper.dart';
import 'package:order_manager/core/library/constants.dart';
import 'package:order_manager/data/datasources/core/data_source.dart';
import 'package:order_manager/domain/entities/core/http_response_entity.dart';
import 'package:order_manager/core/service/clock_helper.dart';
import 'package:order_manager/core/service/http_service.dart';

base class RemoteDataSource implements IRemoteDataSource {
  final IHttpService _http;
  final IEnvironmentHelper _environment;
  final IClockHelper _clockHelper;
  const RemoteDataSource(this._http, this._environment, this._clockHelper);

  @override
  Future<HttpResponseEntity> get(String url) async {
    try {
      await Future.delayed(Duration(seconds: Random().nextInt(5)));
      return HttpResponseEntity(
        statusCode: HttpConstant.kSuccess,
        data: _toMap(),
      );
      //return await _http.get(url);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<HttpResponseEntity?> post(String url, [String? data]) async {
    try {
      return await _http.post(url, data: data);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<HttpResponseEntity?> put(String url, [String? data]) async {
    try {
      return await _http.put(url, data: data);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<HttpResponseEntity?> patch(String url, [String? data]) async {
    try {
      return await _http.patch(url, data: data);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<HttpResponseEntity?> delete(String url, [String? data]) async {
    try {
      return await _http.delete(url, data: data);
    } catch (_) {
      rethrow;
    }
  }

  @override
  IEnvironmentHelper get environment => _environment;

  @override
  DateTime get currentDateTime => _clockHelper.currentDateTime!;
}

Map<String, dynamic> _toMap() {
  return {
    'id': '815f250d-6101-46ed-8671-a6e6b2dff832',
    'nome': 'Usuario Teste',
    'email': 'test@email.com',
    'fotoPerfil': 'https://picsum.photos/id/1025/200/300',
    'localizacao': {
      'codigo': 'df700126dad7cbd561ac54cfb8c62350',
      'latitude': -23.4273,
      'longitude': -51.9375
    },
    'endereco': {
      'rua': 'Av. da univesidade',
      'numero': '123',
      'bairro': 'Centro',
      'cidade': 'Maringa',
      'estado': 'PR',
      'cep': '01010-000'
    }
  };
}