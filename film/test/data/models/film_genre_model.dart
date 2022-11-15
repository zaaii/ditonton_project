import 'package:flutter_test/flutter_test.dart';
import 'package:film/data/models/film_genre_model.dart';
import 'package:film/domain/entities/film_genre.dart';

void main() {
  final testFilmGenreModel = FilmGenreModel(
    id: 1,
    name: 'name',
  );
  final testGenreJsonMap = {
    "id": 1,
    'name': 'name',
  };
  final testEntity = GenreFilm(
    id: 1,
    name: 'name',
  );

  test('return a valid model from JSON', () async {
    final result = FilmGenreModel.fromJson(testGenreJsonMap);
    expect(result, testFilmGenreModel);
  });

  test('return a JSON map containing proper data', () async {
    final jsonMap = testFilmGenreModel.toJson();
    expect(jsonMap, testGenreJsonMap);
  });

  test('return a valid entity', () {
    final entity = testFilmGenreModel.toEntity();
    expect(entity, testEntity);
  });
}