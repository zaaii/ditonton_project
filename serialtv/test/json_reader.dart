import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
 if (dir.endsWith('serialtv')) {
    return File('$dir/test/$name').readAsStringSync();
  }
  return File('$dir/serialtv/test/$name').readAsStringSync();
}