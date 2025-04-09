final class LoginEntity {
  final String login;
  final String password;

  const LoginEntity({
    required this.login,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'email': password,
    };
  }
}