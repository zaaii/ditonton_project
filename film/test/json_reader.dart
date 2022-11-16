import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
 if (dir.endsWith('film')) {
    return File('$dir/test/$name').readAsStringSync();
  }
  return File('$dir/film/test/$name').readAsStringSync();
}