import 'package:flutter/services.dart';

abstract interface class IRootBundleService {
  Future<String> loadStringAsync(String key);
  Future<ByteData> loadBytesAsync(String key);
  Future<Uint8List> loadAsUint8ListAsync(String key);
}

final class RootBundleService implements IRootBundleService {
  const RootBundleService();

  @override
  Future<String> loadStringAsync(String key) {
    return Future<String>.value(rootBundle.loadString(key));
  }

  @override
  Future<ByteData> loadBytesAsync(String key) {
    return Future<ByteData>.value(rootBundle.load(key));
  }

  @override
  Future<Uint8List> loadAsUint8ListAsync(String key) async {
    return (await rootBundle.load(key)).buffer.asUint8List();
  }
}
