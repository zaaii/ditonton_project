import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:film/data/models/film_model.dart';
import 'package:film/data/models/film_response.dart';

import '../../json_reader.dart';

void main() {
  final tFilmModel = FilmModel(
    adult: false,
    backdropPath: "/path.jpg",
    genreIds: [1, 2, 3, 4],
    id: 1,
    originalTitle: "Original Title",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    releaseDate: "2020-05-05",
    title: "Title",
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
  );
  final tFilmResponseModel = FilmResponse(filmList: <FilmModel>[tFilmModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(readJson('data_dummy/film_now_playing.json'));
      // act
      final result = FilmResponse.fromJson(jsonMap);
      // assert
      expect(result, tFilmResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // act
      final result = tFilmResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "adult": false,
            "backdrop_path": "/path.jpg",
            "genre_ids": [1, 2, 3, 4],
            "id": 1,
            "original_title": "Original Title",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "release_date": "2020-05-05",
            "title": "Title",
            "video": false,
            "vote_average": 1.0,
            "vote_count": 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}