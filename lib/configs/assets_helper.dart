import 'package:order_manager/core/library/extensions.dart';

const String _kAssetsDirectoryName = 'assets';

final class AssetsHelper {
  static final String _assetsMaps = [_kAssetsDirectoryName, 'maps'].joinPath;
  static final String _assetsLogin = [_kAssetsDirectoryName, 'login'].joinPath;

  static final String assetsMapsUnselected = [_assetsMaps, 'marker_unselected.png'].joinPath;
  static final String assetsMapsSelected = [_assetsMaps, 'marker_selected.png'].joinPath;

  static final String assetsLoginFacebook = [_assetsLogin, 'facebook.png'].joinPath;
  static final String assetsLoginGoogle = [_assetsLogin, 'google.png'].joinPath;
  static final String assetsLoginIcon = [_assetsLogin, 'login_icon.png'].joinPath;
  static final String assetsLoginBottom = [_assetsLogin, 'login_bottom.png'].joinPath;
  static final String assetsLoginTop = [_assetsLogin, 'login_top.png'].joinPath;
}