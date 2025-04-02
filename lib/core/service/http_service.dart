import 'dart:io';

import 'package:dio/dio.dart';
import 'package:order_manager/domain/entities/core/http_response_entity.dart';
import 'package:order_manager/core/library/extensions.dart';

abstract interface class IHttpService {
  Future<HttpResponseEntity> get(String url, {int? secondsTimeout});
  Future<HttpResponseEntity> post(String url, {int? secondsTimeout, dynamic data});
  Future<HttpResponseEntity> put(String url, {int? secondsTimeout, dynamic data});
  Future<HttpResponseEntity> patch(String url, {int? secondsTimeout, dynamic data});
  Future<HttpResponseEntity> delete(String url, {int? secondsTimeout, dynamic data});
}

final class HttpService implements IHttpService {
  final Dio _dio;
  const HttpService(this._dio);

  @override
  Future<HttpResponseEntity> get(String url, {int? secondsTimeout}) async {
    try {
      await _changeDioOptionsAsync();
      final Response response = await _dio.get(url);
      return _createHttpResponseFromResponse(response);
    } catch (error) {
      throw error.convertDioToHttpException();
    }
  }

  @override
  Future<HttpResponseEntity> post(String url, {int? secondsTimeout, dynamic data}) async {
    try {
      await _changeDioOptionsAsync();
      final Response response = await _dio.post(url, data: data);
      return _createHttpResponseFromResponse(response);
    } catch (error) {
      throw error.convertDioToHttpException();
    }
  }

  @override
  Future<HttpResponseEntity> put(String url, {int? secondsTimeout, dynamic data}) async {
    try {
      await _changeDioOptionsAsync();
      final Response response = await _dio.put(url, data: data);
      return _createHttpResponseFromResponse(response);
    } catch (error) {
      throw error.convertDioToHttpException();
    }
  }

  @override
  Future<HttpResponseEntity> patch(String url, {int? secondsTimeout, dynamic data}) async {
    try {
      await _changeDioOptionsAsync();
      final Response response = await _dio.patch(url, data: data);
      return _createHttpResponseFromResponse(response);
    } catch (error) {
      throw error.convertDioToHttpException();
    }
  }

  @override
  Future<HttpResponseEntity> delete(String url, {int? secondsTimeout, dynamic data}) async {
    try {
      await _changeDioOptionsAsync();
      final Response response = await _dio.delete(url, data: data);
      return _createHttpResponseFromResponse(response);
    } catch (error) {
      throw error.convertDioToHttpException();
    }
  }

  Future<void> _changeDioOptionsAsync() async {
    _dio.options.headers.clear();
    final String token = await _fetchTokenFromStorageAsync();
    if (token.isNotEmpty) {
      _dio.options.headers = {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };
    }
  }

  Future<String> _fetchTokenFromStorageAsync() {
    return Future.value('');
  }

  HttpResponseEntity _createHttpResponseFromResponse(Response response) {
    return HttpResponseEntity(
      data: response.data,
      statusCode: response.statusCode,
    );
  }
}

final class HttpServiceFactory {
  IHttpService create() {
    return HttpService(
      Dio(
        BaseOptions(
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          validateStatus: (value) => value != null,
        ),
      ),
    );
  }
}