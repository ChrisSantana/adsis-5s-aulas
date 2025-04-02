import 'package:order_manager/data/datasources/core/data_source.dart';
import 'package:order_manager/core/service/clock_helper.dart';
import 'package:order_manager/core/service/storage_service.dart';

final class NonRelationalDataSource implements INonRelationalDataSource {
  final IStorageService _storage;
  final IClockHelper _clockHelper;
  const NonRelationalDataSource(this._storage, this._clockHelper);

  @override
  Future<bool> saveString(String keyName, String value) {
    return Future.value(_storage.saveString(keyName, value));
  }

  @override
  Future<bool> saveMap(String keyName, Map<String, dynamic> map) {
    return Future.value(_storage.saveMap(keyName, map));
  }

  @override
  Future<bool> saveInt(String keyName, int value) {
    return Future.value(_storage.saveInt(keyName, value));
  }

  @override
  Future<bool> saveDouble(String keyName, double value) {
    return Future.value(_storage.saveDouble(keyName, value));
  }

  @override
  Future<bool> saveBool(String keyName, bool value) {
    return Future.value(_storage.saveBool(keyName, value));
  }

  @override
  Future<String?> loadString(String keyName) {
    return Future.value(_storage.loadString(keyName));
  }

  @override
  Future<Map<String, dynamic>?> loadMap(String keyName) {
    return Future.value(_storage.loadMap(keyName));
  }

  @override
  Future<int?> loadInt(String keyName) {
    return Future.value(_storage.loadInt(keyName));
  }

  @override
  Future<double?> loadDouble(String keyName) {
    return Future.value(_storage.loadDouble(keyName));
  }

  @override
  Future<bool?> loadBool(String keyName) {
    return Future.value(_storage.loadBool(keyName));
  }

  @override
  Future<bool> remove(String keyName) {
    return Future.value(_storage.remove(keyName));
  }

  @override
  Future<bool> clear([bool deleteAll = false]) {
    return Future.value(_storage.clear(deleteAll));
  }

  @override
  Future<List<String>> loadErrors(String keyName) {
    return Future.value(_storage.loadErrors(keyName));
  }

  @override
  Future<bool> saveError(String keyName, String value) {
    return Future.value(_storage.saveError(keyName, value));
  }

  @override
  DateTime get currentDateTime => _clockHelper.currentDateTime!;
}
