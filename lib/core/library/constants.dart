final class HttpConstant {
  static const int kSuccess = 200;
  static const int kSuccessNoContent = 204;
  static const int kSuccessLimit = 299;
  static const int kInvalidOperation = 400;
  static const int kExpiredToken = 401;
  static const int kNotPermission = 403;
  static const int kNotFound = 404;
  static const int kDefaultError = 500;
}

final class LocationConstant {
  static const int kTimeoutSeconds = 15;
}

final class MapConfigurationConstant {
  static const double kLatitudeDefault = -23.42561054632201;
  static const double kLongitudeDefault = -51.93834256484565;
  static const double kZoomMinimalMaps = 5;
  static const double kZoomMaps = 14;
}