import 'package:order_manager/configs/environment_helper.dart';
import 'package:order_manager/domain/entities/core/http_response_entity.dart';

abstract interface class IRelationalDataSource {
  Future<bool>? delete(String tableName, {String? where, List<dynamic>? whereArgs});
  Future<List<Map<String, dynamic>>>? getAtSQL(String tableName, {String? where, List<dynamic>? whereArgs, String? orderBy});
  Future<List<Map<String, dynamic>>>? rawQuery(String sql);
  Future<bool>? insert(String tableName, Map<String, dynamic> map);
  Future<bool>? insertList(String tableName, List<Map<String, dynamic>> listMap, [bool deleteOld = true]);
  Future<bool>? update(String tableName, Map<String, dynamic> map, {String? where, List<dynamic>? whereArgs});
  Future<bool>? rawUpdate(String tableName, String setAtributes, {String? where, List<dynamic>? whereArgs});
  Future<bool>? rawDelete(String sql, [List<Object?>? arguments]);
  Future<bool>? deleteTables([bool deleteAll = false]);
  DateTime? get currentDateTime;
}

abstract interface class INonRelationalDataSource {
  Future<bool>? saveString(String keyName, String value);
  Future<bool>? saveMap(String keyName, Map<String, dynamic> map);
  Future<bool>? saveInt(String keyName, int value);
  Future<bool>? saveDouble(String keyName, double value);
  Future<bool>? saveBool(String keyName, bool value);
  Future<bool>? saveError(String keyName, String value);

  Future<String?>? loadString(String keyName);
  Future<Map<String, dynamic>?>? loadMap(String keyName);
  Future<int?>? loadInt(String keyName);
  Future<double?>? loadDouble(String keyName);
  Future<bool?>? loadBool(String keyName);
  Future<List<String>>? loadErrors(String keyName);

  Future<bool>? remove(String keyName);
  Future<bool>? clear([bool deleteAll = false]);
  DateTime? get currentDateTime;
}

abstract interface class IRemoteDataSource {
  Future<HttpResponseEntity>? get(String url);
  Future<HttpResponseEntity?>? post(String url, [String? data]);
  Future<HttpResponseEntity?>? put(String url, [String? data]);
  Future<HttpResponseEntity?>? patch(String url, [String? data]);
  Future<HttpResponseEntity?>? delete(String url, [String? data]);
  IEnvironmentHelper? get environment;
  DateTime? get currentDateTime;
}
