import 'package:order_manager/data/datasources/core/data_source.dart';
import 'package:order_manager/core/service/clock_helper.dart';
import 'package:order_manager/core/service/storage_service.dart';

final class RelationalDataSource implements IRelationalDataSource {
  final IStorageService _storage;
  final IClockHelper _clockHelper;
  const RelationalDataSource(this._storage, this._clockHelper);

  @override
  Future<bool> delete(String tableName, {String? where, List<dynamic>? whereArgs}) async {
    try {
      final Database? db = await _storage.getDb();
      return await db?.delete(
            tableName,
            where: where,
            whereArgs: whereArgs,
          ) !=
          null;
    } catch (_) {}
    return false;
  }

  @override
  Future<List<Map<String, dynamic>>> getAtSQL(String tableName, {String? where, List<dynamic>? whereArgs, String? orderBy}) async {
    try {
      final Database? db = await _storage.getDb();
      final List<Map<String, dynamic>>? result = await db?.query(
        tableName,
        where: where,
        whereArgs: whereArgs,
        orderBy: orderBy,
      );
      return (result?.isNotEmpty ?? false) ? result! : [];
    } catch (_) {}
    return [];
  }

  @override
  Future<List<Map<String, dynamic>>> rawQuery(String sql) async {
    try {
      final Database? db = await _storage.getDb();
      final List<Map<String, dynamic>>? result = await db?.rawQuery(sql);
      return (result?.isNotEmpty ?? false) ? result! : [];
    } catch (_) {}
    return [];
  }

  @override
  Future<bool> insert(String tableName, Map<String, dynamic> map) async {
    try {
      final Database? db = await _storage.getDb();
      return await db?.insert(
            tableName,
            map,
            conflictAlgorithm: ConflictAlgorithm.replace,
          ) !=
          null;
    } catch (_) {}
    return false;
  }

  @override
  Future<bool> insertList(String tableName, List<Map<String, dynamic>> listMap, [bool deleteOld = true]) async {
    try {
      final Database? db = await _storage.getDb();
      if (db == null) return false;

      final Batch batch = db.batch();
      if (deleteOld) batch.delete(tableName);
      for (final value in listMap) {
        batch.insert(tableName, value);
      }
      await batch.commit();

      return true;
    } catch (_) {}
    return false;
  }

  @override
  Future<bool> update(String tableName, Map<String, dynamic> map, {String? where, List<dynamic>? whereArgs}) async {
    try {
      final Database? db = await _storage.getDb();
      return await db?.update(
            tableName,
            map,
            where: where,
            whereArgs: whereArgs,
          ) !=
          null;
    } catch (_) {}
    return false;
  }

  @override
  Future<bool> rawUpdate(String tableName, String setAtributes, {String? where, List<dynamic>? whereArgs}) async {
    if (tableName.trim().isEmpty || setAtributes.trim().isEmpty) return false;
    try {
      final Database? db = await _storage.getDb();
      return await db?.rawUpdate(
            '''
            UPDATE $tableName
            SET $setAtributes
            ${where != null && where.trim().isNotEmpty ? 'WHERE $where' : ''}
            ''',
            where != null && where.trim().isNotEmpty && whereArgs != null ? whereArgs : [],
          ) !=
          null;
    } catch (_) {}
    return false;
  }

  @override
  Future<bool> rawDelete(String sql, [List<Object?>? arguments]) async {
    try {
      final Database? db = await _storage.getDb();
      return await db?.rawDelete(sql, arguments) != null;
    } catch (_) {}
    return false;
  }

  @override
  Future<bool> deleteTables([bool deleteAll = false]) {
    return Future.value(_storage.deleteTables(deleteAll: deleteAll));
  }

  @override
  DateTime get currentDateTime => _clockHelper.currentDateTime!;
}
