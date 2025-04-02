import 'package:order_manager/configs/factory_viewmodel.dart';
import 'package:order_manager/core/service/location_service.dart';
import 'package:order_manager/data/repositories/map/map_repository.dart';
import 'package:order_manager/domain/entities/core/location_entity.dart';
import 'package:order_manager/ui/map/view_models/map_viewmodel.dart';

final class MapFactoryViewModel implements IFactoryViewModel<MapViewModel> {
  final List<LocationEntity> _locations;
  const MapFactoryViewModel(this._locations);

  @override
  MapViewModel create(BuildContext context) {
    final IMapRepository mapRepository = MapRepository(LocationService());
    return MapViewModel(mapRepository, _locations);
  }

  @override
  void dispose(BuildContext context, MapViewModel bloc) async {
    await bloc.close();
  }
}
