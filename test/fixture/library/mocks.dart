import 'package:mockito/mockito.dart';
import 'package:order_manager/configs/environment_helper.dart';
import 'package:order_manager/core/datasource/data_source.dart';
import 'package:order_manager/core/service/app_service.dart';
import 'package:order_manager/core/service/clock_helper.dart';
import 'package:order_manager/core/service/http_service.dart';
import 'package:order_manager/core/service/storage_service.dart';

export 'package:mockito/mockito.dart';

final class MockRelationalDataSource extends Mock implements IRelationalDataSource {}

final class MockEnvironment extends Mock implements IEnvironmentHelper {}

final class MockRemoteDataSource extends Mock implements IRemoteDataSource {}

final class MockNonRelationalDataSource extends Mock implements INonRelationalDataSource {}

final class MockHttpService extends Mock implements IHttpService {}

final class MockStorageService extends Mock implements IStorageService {}

final class MockAppService extends Mock implements IAppService {}

final class MockClockHelper extends Mock implements IClockHelper {}
