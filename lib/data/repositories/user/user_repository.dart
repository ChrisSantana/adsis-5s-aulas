import 'package:order_manager/configs/data_base_schema_helper.dart';
import 'package:order_manager/data/datasources/core/data_source.dart';
import 'package:order_manager/domain/entities/core/http_response_entity.dart';
import 'package:order_manager/core/library/extensions.dart';
import 'package:order_manager/domain/entities/user/user_entity.dart';
import 'package:order_manager/domain/error/user/user_exception.dart';

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
    
    if (!httpResponse.toBool()) throw UserNotFoundException();

    final UserEntity user = UserEntity.fromRemoteMap(httpResponse.data as Map<String, dynamic>);
    await _saveAtStorageAsync(user);
    
    return user;
  }

  Future<bool> _saveAtStorageAsync(UserEntity user) async {
    await _deleteUsuarioAtStorageAsync(user.id);
    return await _relationalDataSource.insert(DataBaseSchemaHelper.kUser, user.toMap())!;
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