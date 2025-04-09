import 'package:order_manager/configs/factory_viewmodel.dart';
import 'package:order_manager/data/datasources/core/data_source_factory.dart';
import 'package:order_manager/data/repositories/user/user_repository.dart';
import 'package:order_manager/ui/user/view_models/user_viewmodel.dart';

final class UserFactoryViewModel implements IFactoryViewModel<UserViewModel> {
  @override
  UserViewModel create(BuildContext context) {
    final IRemoteDataSource remoteDataSource = RemoteFactoryDataSource().create();
    final IRelationalDataSource relationalDataSource = RelationalFactoryDataSource().create();
    final IUserRepository userRepository = UserRepository(remoteDataSource, relationalDataSource);
    return UserViewModel(userRepository);
  }

  @override
  void dispose(BuildContext context, UserViewModel viewModel) {
    viewModel.close();
  }
}