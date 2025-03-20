import 'package:order_manager/configs/environment_helper.dart';
import 'package:order_manager/core/datasource/data_source.dart';
import 'package:order_manager/core/entity/http_response_entity.dart';
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
      return await _http.get(url);
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