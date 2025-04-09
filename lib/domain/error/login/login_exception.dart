abstract interface class ILoginException implements Exception {}

final class LoginNotFoundException implements ILoginException {}

final class EmailInvalidException implements ILoginException {}

final class PasswordInvalidException implements ILoginException {}
