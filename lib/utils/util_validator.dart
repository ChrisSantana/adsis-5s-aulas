final class UtilValidator {
  static bool isValidEmail(String email) {
    if (email.trim().isEmpty) return false;
    const String regex =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    return _hasMatch(email, regex);
  }

  static bool isValidPhone(String phone) {
    if (phone.trim().isEmpty) return false;
    const String regex = r'^\(?[1-9]{2}\)? ?(?:[2-8]|9[1-9])[0-9]{3}\-?[0-9]{4}$';
    return _hasMatch(phone, regex);
  }

  static bool isValidPassword(String password) {
    return password.trim().length >= 6;
  }

  static bool _hasMatch(String value, String regex) {
    final RegExp regExp = RegExp(regex);
    return regExp.hasMatch(value);
  }
}
