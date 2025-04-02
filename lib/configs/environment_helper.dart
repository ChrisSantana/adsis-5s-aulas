abstract interface class IEnvironmentHelper {
  String? get urlUserInformation;
  String? get urlClients;
}

final class EnvironmentHelper implements IEnvironmentHelper {
  const EnvironmentHelper();

  @override
  String get urlUserInformation => 'https://127.0.0.1/user_information';

  @override
  String get urlClients => 'https://127.0.0.1/clients';
}
