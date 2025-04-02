import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_manager/configs/factory_viewmodel.dart';
import 'package:order_manager/domain/entities/core/location_entity.dart';
import 'package:order_manager/domain/entities/core/request_state_entity.dart';
import 'package:order_manager/data/repositories/user/user_repository.dart';
import 'package:order_manager/domain/entities/user/user_entity.dart';
import 'package:order_manager/routing/route_generator.dart';

final class UserViewModel extends Cubit<IRequestState<UserEntity>> {
  final IUserRepository _repository;
  
  UserViewModel(this._repository) : super(const RequestInitiationState()) {
    onFetchUser();
  }

  Future<void> onRefreshIndicator() async {
    onFetchUser();
  }

  void onFetchUser() async {
    try {
      _emitter(RequestProcessingState());

      final UserEntity usuario = await _repository.fetchFromApiAsync();

      _emitter(RequestCompletedState(value: usuario));
    } catch (error) {
      _emitter(RequestErrorState(error: error));
    }
  }

  void onTapLocation() {
    if (state.dataOrNull == null) return;
    final List<LocationEntity> locations = [state.data.location];
    getIt<IAppService>().navigateNamedTo(RouteGeneratorHelper.kMapPage, arguments: locations);
  }

  void _emitter(IRequestState<UserEntity> state) {
    if (isClosed) return;
    emit(state);
  }
}


