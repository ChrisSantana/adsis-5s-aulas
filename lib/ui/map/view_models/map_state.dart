part of 'map_viewmodel.dart';

sealed class IMapState {
  const IMapState();
}

final class MapInitialState extends IMapState {
  const MapInitialState();
}

final class MapPreparedState extends IMapState {
  const MapPreparedState();
}

final class MapRepositionedState extends IMapState {
  LocationEntity? currentLocation;
  String? selectedLocationCode;
  List<LocationEntity> locations;
  List<Marker> markers;

  MapRepositionedState({
    required this.currentLocation,
    required this.selectedLocationCode,
    required this.locations,
    required this.markers,
  });

  factory MapRepositionedState.init() {
    return MapRepositionedState(
      currentLocation: null,
      selectedLocationCode: null,
      locations: List<LocationEntity>.empty(growable: true),
      markers: List<Marker>.empty(growable: true),
    );
  }

  MapRepositionedState toCopyWith({
    LocationEntity? currentLocation,
    String? selectedLocationCode,
    List<LocationEntity>? locations,
    List<Marker>? markers,
  }) {
    return MapRepositionedState(
      currentLocation: currentLocation ?? this.currentLocation,
      selectedLocationCode: selectedLocationCode ?? this.selectedLocationCode,
      locations: locations ?? this.locations,
      markers: markers ?? this.markers,
    );
  }
}

final class MapErrorState extends IMapState {
  final Object error;
  const MapErrorState(this.error);
}
