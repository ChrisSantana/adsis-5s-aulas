import 'package:google_maps_flutter/google_maps_flutter.dart';

final class MapOptionEntity {
  final void Function(GoogleMapController) onMapCreated;
  final CameraPosition initialCameraPosition;
  final Set<Marker>? markers;
  final bool myLocationButtonEnabled;

  const MapOptionEntity({
    required this.onMapCreated,
    required this.initialCameraPosition,
    this.markers,
    this.myLocationButtonEnabled = false,
  });
}