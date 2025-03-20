import 'package:order_manager/configs/data_base_schema_helper.dart';
import 'package:order_manager/core/datasource/data_source.dart';
import 'package:order_manager/core/entity/http_response_entity.dart';
import 'package:order_manager/core/library/extensions.dart';
import 'package:order_manager/domain/entities/user/user_entity.dart';
import 'package:order_manager/domain/error/usuario/usuario_exception.dart';

abstract interface class IUserRepository {
  Future<UserEntity> fetchFromApiAsync();
}

final class UserRepository implements IUserRepository {
  final IRemoteDataSource _remoteDataSource;
  final IRelationalDataSource _relationalDataSource;

  const UserRepository(this._remoteDataSource, this._relationalDataSource);

  @override
  Future<UserEntity> fetchFromApiAsync() async {

    final HttpResponseEntity httpResponse = await _remoteDataSource.get(_urlFetchUser)!;
    
    if (!httpResponse.toBool()) throw UsuarioNotFoundException();

    final UserEntity usuario = UserEntity.fromRemoteMap(httpResponse.data as Map<String, dynamic>);
    await _saveAtStorageAsync(usuario);
    
    return usuario;
  }

  Future<bool> _saveAtStorageAsync(UserEntity usuario) async {
    await _deleteUsuarioAtStorageAsync(usuario.id);
    return await _relationalDataSource.insert(DataBaseSchemaHelper.kUser, usuario.toMap())!;
  }

  Future<bool> _deleteUsuarioAtStorageAsync(String userId) {
    return Future.value(_relationalDataSource.delete(
        DataBaseSchemaHelper.kUser, 
        where: '${UserEntity.kKeyId} = ?',
        whereArgs: [userId],
      ),
    );
  }

  String get _urlFetchUser => _remoteDataSource.environment?.urlUserInformation ?? '';
}