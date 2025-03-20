import 'package:order_manager/core/library/extensions.dart';

const String _kAssetsDirectoryName = 'assets';

final class AssetsHelper {
  static final String assetsIcons = [_kAssetsDirectoryName, 'icons'].joinPath;
  static final String assetsSource = [_kAssetsDirectoryName, 'env', '.env'].joinPath;
}