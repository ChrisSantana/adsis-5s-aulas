import 'package:order_manager/core/library/extensions.dart';

const String _kAssetsDirectoryName = 'assets';

final class AssetsHelper {
  static final String assetsIcons = [_kAssetsDirectoryName, 'icons'].joinPath;
  static final String assetsSource = [_kAssetsDirectoryName, 'env', '.env'].joinPath;
  static final String assetsMaps = [_kAssetsDirectoryName, 'maps'].joinPath;

  static final String assetsMapsUnselected = [assetsMaps, 'marker_unselected.png'].joinPath;
  static final String assetsMapsSelected = [assetsMaps, 'marker_selected.png'].joinPath;
}