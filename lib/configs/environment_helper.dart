abstract interface class IEnvironmentHelper {
  String? get urlAuthentication;
  String? get urlUserInformation;
}

final class EnvironmentHelper implements IEnvironmentHelper {
  const EnvironmentHelper();

  String get _urlBase => 'https://127.0.0.1';

  @override
  String? get urlAuthentication => '$_urlBase/authentication';

  @override
  String get urlUserInformation => '$_urlBase/user_information';
}
