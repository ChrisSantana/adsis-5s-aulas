import 'dart:async';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:order_manager/core/library/constants.dart';
import 'package:order_manager/domain/entities/core/location_entity.dart';
import 'package:order_manager/domain/error/core/location_exception.dart';

abstract interface class ILocationService {
  Future<LocationEntity?> fetchCurrentLocation({int timeoutSeconds});
  Future<bool> isLocationEnabled();
  Future<bool> verifyPermission([bool requestionPermission = true]);
  Future<bool> requestPermission([bool openLocationSettings = true]);
  Future<void> openLocationSettings();
}

final class LocationService implements ILocationService {
  const LocationService();

  @override
  Future<LocationEntity?> fetchCurrentLocation({int timeoutSeconds = LocationConstant.kTimeoutSeconds}) async {
    try {
      await _validateFetchLocation();
      final Position position = await Geolocator.getCurrentPosition(locationSettings: _createLocationSettingByPlatform());
      return LocationEntity(
        code: DateTime.now().microsecondsSinceEpoch.toString(),
        latitude: position.latitude, 
        longitude: position.longitude,
      );
    } catch (error) {
      throw error is GPSException ? error : LocationGPSException();
    }
  }

  @override
  Future<bool> isLocationEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  @override
  Future<bool> verifyPermission([bool requestionPermission = true]) async {
    try {
      final LocationPermission permission = await Geolocator.checkPermission();
      switch (permission) {
        case LocationPermission.denied:
        case LocationPermission.deniedForever:
          if (requestionPermission) return await requestPermission();
          return false;
        case LocationPermission.always:
        case LocationPermission.whileInUse:
        case LocationPermission.unableToDetermine:
          return true;
      }
    } catch (_) {}
    return false;
  }

  Future<bool> _validateFetchLocation() async {
    try {
      if (!await isLocationEnabled()) throw (LocationInativeGPSException());
      if (!await verifyPermission()) throw (LocationPermissionGPSException());
      return true;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> requestPermission([bool openLocationSettings = true]) async {
    try {
      final LocationPermission locationPermission = await Geolocator.requestPermission();
      final List<LocationPermission> allowedAccess = [LocationPermission.always, LocationPermission.whileInUse];
      return allowedAccess.contains(locationPermission);
    } catch (_) {}
    return false;
  }

  @override
  Future<void> openLocationSettings() {
    return Future<bool>.value(Geolocator.openLocationSettings());
  }

  LocationSettings _createLocationSettingByPlatform() {
    if (Platform.isIOS || Platform.isMacOS) {
      return AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        pauseLocationUpdatesAutomatically: true,
        showBackgroundLocationIndicator: false,
      );
    }

    return AndroidSettings(
      accuracy: LocationAccuracy.high,
      forceLocationManager: true,
      intervalDuration: const Duration(seconds: 10),
    );
  }
}
