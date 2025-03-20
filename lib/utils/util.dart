final class Util {
  /// #region Config
  static const String extensionPNG = 'png';
  static const String extensionJPG = 'jpg';
  static const String extensionPDF = 'pdf';
  static const String directoryMedia = 'media';

  /// #region Env
  static const String envProd = '.env';

  /// #region Internationalization
  static const String kLanguageCode = 'pt';
  static const String kCountryCode = 'BR';
  static const String kLocaleId = '${kLanguageCode}_$kCountryCode';
  static const String kLocaleUs = 'en_US';
  static const String kHttpHeaderAcceptLanguage = '$kLanguageCode-$kCountryCode';

  static String generateRandomCode() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
