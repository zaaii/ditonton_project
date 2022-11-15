import 'package:film/data/models/film_table.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final Map<String, dynamic> testFilmJsonMap = {
    'id': 1,
    'title': 'title',
    'posterPath': 'posterPath',
    'overview': 'overview',
  };

  final testFilmTable = FilmTable(
    id: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  test('should return valid JsonMap film from table correctly', () {
    final result = testFilmTable.toJson();
    expect(result, testFilmJsonMap);
  });
}