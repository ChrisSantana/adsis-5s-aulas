import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:order_manager/core/service/location_service.dart';
import 'package:order_manager/domain/entities/core/location_entity.dart';

abstract interface class IMapRepository {
  Future<LocationEntity?> fetchLocationAsync();
  List<Marker> createMarkers(
    List<LocationEntity> locations,
    String? selectedLocationCode,
    BitmapDescriptor? markerUnselected,
    BitmapDescriptor? markerSelected,
    void Function(MarkerId markerId) onTapMarker,
  );
}

class MapRepository implements IMapRepository {
  final ILocationService _locationService;
  const MapRepository(this._locationService);

  @override
  Future<LocationEntity?> fetchLocationAsync() {
    return Future<LocationEntity?>.value(_locationService.fetchCurrentLocation());
  }

  @override
  List<Marker> createMarkers(
    List<LocationEntity> locations,
    String? selectedLocationCode,
    BitmapDescriptor? markerUnselected,
    BitmapDescriptor? markerSelected,
    void Function(MarkerId markerId) onTapMarker,
  ) {
    return locations.map<Marker>((location) {
      final bool isSelected = location.code == selectedLocationCode;
      final MarkerId markerId = MarkerId(location.code);
      return Marker(
        markerId: markerId,
        position: LatLng(location.latitude, location.longitude),
        icon: (isSelected ? markerSelected : markerUnselected) ?? BitmapDescriptor.defaultMarker,
        zIndex: isSelected ? 1 : 0,
        onTap: () => onTapMarker(markerId),
      );
    }).toList();
  }
}
