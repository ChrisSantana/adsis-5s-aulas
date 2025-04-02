import 'dart:io';

String fixture(String name) {
  return File('test/fixture/assets/$name').readAsStringSync();
}
