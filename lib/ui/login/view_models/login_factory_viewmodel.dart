import 'package:order_manager/configs/factory_viewmodel.dart';
import 'package:order_manager/data/datasources/core/data_source_factory.dart';
import 'package:order_manager/data/repositories/login/login_repository.dart';
import 'package:order_manager/ui/login/view_models/login_viewmodel.dart';

final class LoginFactoryViewModel implements IFactoryViewModel<LoginViewModel> {
  @override
  LoginViewModel create(BuildContext context) {
    final IRemoteDataSource remoteDataSource = RemoteFactoryDataSource().create();
    final INonRelationalDataSource nonRelationalDataSource = NonRelationalFactoryDataSource().create();
    final ILoginRepository loginRepository = LoginRepository(remoteDataSource, nonRelationalDataSource);
    return LoginViewModel(loginRepository);
  }

  @override
  void dispose(BuildContext context, LoginViewModel viewModel) {
    viewModel.close();
  }
}