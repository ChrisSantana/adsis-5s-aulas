import 'dart:convert';
import 'package:order_manager/core/service/migrate_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
export 'package:sqflite/sqflite.dart' show Database, ConflictAlgorithm, Batch;

abstract interface class IStorageService {
  /// #region NoSQL
  Future<bool> saveString(String keyName, String value);
  Future<bool> saveMap(String keyName, Map<String, dynamic> map);
  Future<bool> saveListMap(String keyName, List<Map<String, dynamic>> listMap);
  Future<bool> saveInt(String keyName, int value);
  Future<bool> saveDouble(String keyName, double value);
  Future<bool> saveBool(String keyName, bool value);
  Future<bool> saveError(String keyName, String value);

  Future<String?> loadString(String keyName);
  Future<Map<String, dynamic>?> loadMap(String keyName);
  Future<List> loadListMap(String keyName);
  Future<int?> loadInt(String keyName);
  Future<double?> loadDouble(String keyName);
  Future<bool?> loadBool(String keyName);
  Future<List<String>> loadErrors(String keyName);

  Future<bool> remove(String keyName);
  Future<bool> clear([bool deleteAll = false]);

  /// #region SQL
  Future<Database?> getDb();
  Future<void> onCreate(Database db, int version);
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion);
  Future<bool> deleteTables({bool deleteAll = false});
  Future<void> closeDataBase();
}

final class StorageService implements IStorageService {
  final IMigrateService migrate;
  final SharedPreferences prefs;
  const StorageService(this.migrate, this.prefs);

  /// #region NoSQL
  @override
  Future<bool> saveString(String keyName, String value) {
    return Future.value(prefs.setString(keyName, value));
  }

  @override
  Future<bool> saveMap(String keyName, Map<String, dynamic> map) {
    final String jsonMap = jsonEncode(map);
    return Future.value(prefs.setString(keyName, jsonMap));
  }

  @override
  Future<bool> saveListMap(String keyName, List<Map<String, dynamic>> listMap) {
    if (listMap.isEmpty) return Future.value(false);
    final String jsonMap = jsonEncode(listMap);
    return Future.value(prefs.setString(keyName, jsonMap));
  }

  @override
  Future<bool> saveInt(String keyName, int value) {
    return Future.value(prefs.setInt(keyName, value));
  }

  @override
  Future<bool> saveDouble(String keyName, double value) {
    return Future.value(prefs.setDouble(keyName, value));
  }

  @override
  Future<bool> saveBool(String keyName, bool value) {
    return Future.value(prefs.setBool(keyName, value));
  }

  @override
  Future<bool> saveError(String keyName, String value) {
    final List<String> resultList = prefs.getStringList(keyName) ?? [];
    resultList.add(value);
    return Future.value(prefs.setStringList(keyName, resultList));
  }

  @override
  Future<String?> loadString(String keyName) {
    return Future.value(prefs.getString(keyName));
  }

  @override
  Future<Map<String, dynamic>?> loadMap(String keyName) {
    final String? result = prefs.getString(keyName);
    if (result == null) return Future.value(null);
    return jsonDecode(result);
  }

  @override
  Future<List> loadListMap(String keyName) {
    final String? result = prefs.getString(keyName);
    return jsonDecode(result ?? '[]');
  }

  @override
  Future<int?> loadInt(String keyName) {
    return Future.value(prefs.getInt(keyName));
  }

  @override
  Future<double?> loadDouble(String keyName) {
    return Future.value(prefs.getDouble(keyName));
  }

  @override
  Future<bool?> loadBool(String keyName) {
    return Future.value(prefs.getBool(keyName));
  }

  @override
  Future<List<String>> loadErrors(String keyName) {
    return Future.value(prefs.getStringList(keyName) ?? []);
  }

  @override
  Future<bool> remove(String keyName) {
    return Future.value(prefs.remove(keyName));
  }

  @override
  Future<bool> clear([bool deleteAll = false]) async {
    if (deleteAll) return await prefs.clear();

    final List<String> keys = prefs.getKeys().toList();
    final List<bool> success = [true];

    for (final String key in keys) {
      success.add(await remove(key));
    }

    return success.every((value) => value);
  }

  /// #region SQL
  @override
  Future<Database?> getDb() {
    return Future.value(migrate.getDb());
  }

  @override
  Future<void> onCreate(Database db, int version) {
    return Future.value(migrate.onCreate(db, version));
  }

  @override
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) {
    return Future.value(migrate.onUpgrade(db, oldVersion, newVersion));
  }

  @override
  Future<void> closeDataBase() {
    return Future<void>.value(migrate.closeDataBase());
  }

  @override
  Future<bool> deleteTables({bool deleteAll = false}) {
    return Future<bool>.value(migrate.deleteTables(deleteAll: deleteAll));
  }
}
