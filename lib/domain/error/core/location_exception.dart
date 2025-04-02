abstract interface class GPSException implements Exception {}

final class LocationGPSException implements GPSException {}

final class LocationInativeGPSException implements GPSException {}

final class LocationPermissionGPSException implements GPSException {}
