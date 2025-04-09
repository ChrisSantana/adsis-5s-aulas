import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_manager/configs/factory_viewmodel.dart';
import 'package:order_manager/core/widgets/show_dialog_widget.dart';
import 'package:order_manager/data/repositories/login/login_repository.dart';
import 'package:order_manager/domain/entities/core/request_state_entity.dart';
import 'package:order_manager/domain/entities/login/login_entity.dart';
import 'package:order_manager/domain/error/login/login_exception.dart';
import 'package:order_manager/routing/route_generator.dart';
import 'package:order_manager/utils/util_text.dart';
import 'package:order_manager/utils/util_validator.dart';

final class LoginViewModel extends Cubit<IRequestState<String>> {
  final ILoginRepository _repository;
  
  LoginViewModel(this._repository) : super(const RequestInitiationState());

  void onAuthentication(String login, String password) async {
    try {
      _emitter(RequestProcessingState());

      if (!UtilValidator.isValidEmail(login)) throw EmailInvalidException();
      if (!UtilValidator.isValidPassword(password)) throw PasswordInvalidException();

      final String token = await _repository.authenticationAsync(LoginEntity(login: login, password: password))!;
      if (token.trim().isNotEmpty) _onNavigateGoHome();

      _emitter(RequestCompletedState(value: token));
    } catch (error) {
      final String erorrDescription = _createErrorDescription(error);
      showSnackBar(erorrDescription);
      _emitter(RequestErrorState(error: error));
    }
  }

  void _onNavigateGoHome() {
    getIt<IAppService>().navigateNamedReplacementTo(RouteGeneratorHelper.kHome);
  }

  String _createErrorDescription(Object? error) {
    if (error is EmailInvalidException) return UtilText.labelLoginInvalidEmail;
    if (error is PasswordInvalidException) return UtilText.labelLoginInvalidPassword;
    return UtilText.labelLoginFailure;
  }

  void _emitter(IRequestState<String> state) {
    if (isClosed) return;
    emit(state);
  }
}


