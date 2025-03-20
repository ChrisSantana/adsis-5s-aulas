import 'package:order_manager/configs/environment_helper.dart';
import 'package:order_manager/configs/injection_container.dart';
import 'package:order_manager/core/datasource/data_source.dart';
import 'package:order_manager/core/datasource/non_relational_datasource.dart';
import 'package:order_manager/core/datasource/relational_datasource.dart';
import 'package:order_manager/core/datasource/remote_datasource.dart';
import 'package:order_manager/core/service/clock_helper.dart';
import 'package:order_manager/core/service/http_service.dart';
import 'package:order_manager/core/service/storage_service.dart';

final class NonRelationalFactoryDataSource {
  INonRelationalDataSource create() {
    final IStorageService storageService = getIt<IStorageService>();
    final IClockHelper clockHelper = ClockHelper();

    return NonRelationalDataSource(
      storageService,
      clockHelper,
    );
  }
}

final class RelationalFactoryDataSource {
  IRelationalDataSource create() {
    final IStorageService storageService = getIt<IStorageService>();
    final IClockHelper clockHelper = ClockHelper();

    return RelationalDataSource(
      storageService, 
      clockHelper,
    );
  }
}

final class RemoteFactoryDataSource {
  IRemoteDataSource create() {
    final IHttpService httpService = HttpServiceFactory().create();
    final IEnvironmentHelper environmentHelper = getIt<IEnvironmentHelper>();
    final IClockHelper clockHelper = ClockHelper();
    return RemoteDataSource(
      httpService, 
      environmentHelper, 
      clockHelper,
    );
  }
}