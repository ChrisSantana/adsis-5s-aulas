import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract interface class IEnvironmentHelper {
  String? get urlUserInformation;
  String? get urlOrderInformation;
}

final class EnvironmentHelper implements IEnvironmentHelper {
  final DotEnv _dotEnv;
  const EnvironmentHelper(this._dotEnv);

  @override
  String get urlUserInformation => _fetchValueFromEnv('URL_USER_INFORMATION');

  @override
  String get urlOrderInformation => _fetchValueFromEnv('URL_ORDER_INFORMATION');

  String _fetchValueFromEnv(String envPropertyName) {
    try {
      return _dotEnv.env[envPropertyName] ?? '';
    } catch (_) {}
    return '';
  }
}
