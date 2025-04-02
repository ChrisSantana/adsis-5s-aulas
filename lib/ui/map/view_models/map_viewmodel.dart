import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:order_manager/configs/assets_helper.dart';
import 'package:order_manager/core/library/constants.dart';
import 'package:order_manager/data/repositories/map/map_repository.dart';
import 'package:order_manager/domain/entities/core/location_entity.dart';

part 'map_state.dart';

final class MapViewModel extends Cubit<IMapState> {
  final IMapRepository _mapRepsitory;
  final List<LocationEntity> _locations;

  GoogleMapController? _mapController;
  BitmapDescriptor? _markerUnselected;
  BitmapDescriptor? _markerSelected;
  late final MapRepositionedState repositionedState;

  MapViewModel(this._mapRepsitory, this._locations) : super(const MapInitialState()) {
    repositionedState = MapRepositionedState.init().toCopyWith(locations: _locations);
    _onExecuteMapPrepareState();
  }

  Future<void> repositionCamera({
    LocationEntity? position,
    double zoom = MapConfigurationConstant.kZoomMaps,
  }) async {
    try {
      if (!_validateCameraPosition()) return;
      await Future.delayed(const Duration(milliseconds: 600));
      final LocationEntity currentLocation = repositionedState.currentLocation!;
      final LatLng latLng = LatLng(
        position?.latitude ?? currentLocation.latitude,
        position?.longitude ?? currentLocation.longitude,
      );
      await _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: latLng, zoom: zoom),
        ),
      );
    } catch (_) {}
  }

  CameraPosition createInitialCameraPosition({
    LocationEntity? position,
    double zoom = MapConfigurationConstant.kZoomMinimalMaps,
  }) {
    return CameraPosition(
      target: LatLng(
        position?.latitude ?? MapConfigurationConstant.kLatitudeDefault,
        position?.longitude ?? MapConfigurationConstant.kLongitudeDefault,
      ),
      zoom: zoom,
    );
  }

  void onExecuteMapCreated(GoogleMapController mapController) {
    _mapController = mapController;
    _onExecuteMapReposition();
  }

  void _onExecuteMapPrepareState() async {
    try {
      await _updateMarkersBitmaps();
      _updateMarkers();
      _emitter(const MapPreparedState());
    } catch (error) {
      _emitter(MapErrorState(error));
    }
  }

  void onTapButtonRepositionCamera() {
    if (isClosed) return;
    _onExecuteMapReposition();
  }

  bool _validateCameraPosition() {
    return _mapController != null && repositionedState.currentLocation != null;
  }

  void _onExecuteMapReposition() async {
    try {
      await _updateCurrentLocation();
      await repositionCamera(zoom: MapConfigurationConstant.kZoomMaps);
    } catch (error) {
      _emitter(MapErrorState(error));
    }
  }

  Future<void> _updateCurrentLocation([LocationEntity? position]) async {
    repositionedState.currentLocation = position ?? await _mapRepsitory.fetchLocationAsync();
  }

  void _onTapMarker(MarkerId markerId) {
    if (isClosed) return;
    _updateselectedLocationCode(markerId.value);
    _updateMarkers();
    _emitter(repositionedState.toCopyWith());
  }

  void _updateselectedLocationCode(String selectedCode) {
    repositionedState.selectedLocationCode = selectedCode;
  }

  void _updateMarkers() {
    repositionedState.markers.clear();
    repositionedState.markers.addAll(
      _mapRepsitory.createMarkers(
        repositionedState.locations,
        repositionedState.selectedLocationCode,
        _markerUnselected,
        _markerSelected,
        _onTapMarker,
      ).map((visit) => visit).toSet(),
    );
  }

  Future<void> _updateMarkersBitmaps() async {
    await Future.wait([_updateBitmapUnseletected(), _updateBitmapSeletected()]);
  }

  Future<void> _updateBitmapUnseletected() async {
    if (_markerUnselected != null) return;
    _markerUnselected = _markerUnselected ?? await _createBitmapDescriptorFromAssets(AssetsHelper.assetsMapsUnselected, const Size(38.6, 50));
  }

  Future<void> _updateBitmapSeletected() async {
    if (_markerSelected != null) return;
    _markerSelected = _markerSelected ?? await _createBitmapDescriptorFromAssets(AssetsHelper.assetsMapsSelected, const Size(44.43, 58));
  }

  Future<BitmapDescriptor?> _createBitmapDescriptorFromAssets(String assets, Size size) async {
    try {
      return await BitmapDescriptor.asset(ImageConfiguration(size: size), assets);
    } catch (_) {
      return null;
    }
  }

  void _emitter(IMapState state) {
    if (isClosed) return;
    emit(state);
  }

  Set<Marker> get markers => repositionedState.markers.toSet();
}
