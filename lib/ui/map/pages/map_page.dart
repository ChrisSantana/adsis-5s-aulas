import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_manager/core/library/constants.dart';
import 'package:order_manager/domain/entities/core/location_entity.dart';
import 'package:order_manager/domain/entities/map/map_option_entity.dart';
import 'package:order_manager/ui/map/view_models/map_factory_viewmodel.dart';
import 'package:order_manager/ui/map/view_models/map_viewmodel.dart';
import 'package:order_manager/ui/map/widgets/map_back_button_widget.dart';
import 'package:order_manager/ui/map/widgets/map_widget.dart';

class MapPage extends StatelessWidget {
  final List<LocationEntity> locations;

  const MapPage({
    super.key,
    required this.locations,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: MapFactoryViewModel(locations).create,
      child: _MapPage(),
    );
  }
}

class _MapPage extends StatefulWidget {
  const _MapPage();

  @override
  State<_MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<_MapPage> {
  late final MapViewModel mapViewModel;

  @override
  void initState() {
    super.initState();
    mapViewModel = context.read<MapViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _MapsWidget(),
          _BackButtonWidget(),
        ],
      ),
    );
  }
}

class _MapsWidget extends StatelessWidget {
  const _MapsWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapViewModel, IMapState>(
      builder: (context, state) {
        if (state is MapInitialState) return const Offstage();
        final MapViewModel mapViewModel = context.read<MapViewModel>();
        return MapWidget(
          mapOption: MapOptionEntity(
            onMapCreated: mapViewModel.onExecuteMapCreated,
            initialCameraPosition: mapViewModel.createInitialCameraPosition(zoom: MapConfigurationConstant.kZoomMaps),
            markers: mapViewModel.markers,
          ),
        );
      },
    );
  }
}

class _BackButtonWidget extends StatelessWidget {
  const _BackButtonWidget();

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      top: 10,
      left: 10,
      child: MapBackButtonWidget(),
    );
  }
}
