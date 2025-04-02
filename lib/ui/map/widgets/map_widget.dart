import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:order_manager/domain/entities/map/map_option_entity.dart';

class MapWidget extends StatelessWidget {
  final MapOptionEntity mapOption;
  const MapWidget({
    super.key,
    required this.mapOption,
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: mapOption.initialCameraPosition,
      onMapCreated: mapOption.onMapCreated,
      markers: mapOption.markers ?? {},
      myLocationButtonEnabled: mapOption.myLocationButtonEnabled,
      myLocationEnabled: true,
      mapToolbarEnabled: true,
      compassEnabled: false,
      trafficEnabled: false,
      zoomControlsEnabled: false,
    );
  }
}
