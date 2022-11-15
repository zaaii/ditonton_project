import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:serialtv/data/models/serialtv_model.dart';
import 'package:serialtv/data/models/serialtv_response.dart';

import '../../json_reader.dart';

void main() {
  final tSerialTvModel = SerialTvModel(
    backdropPath: "/path.jpg",
    genreIds: [1],
    id: 1,
    originalName: "Original Name",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    firstAirDate: "2022-11-07",
    name: "Name",
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tSerialTvResponseModel = SerialTvResponse(serialTvList: <SerialTvModel>[tSerialTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(readJson('data_dummy/serialtv_now_playing.json'));
      // act
      final result = SerialTvResponse.fromJson(jsonMap);
      // assert
      expect(result, tSerialTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // act
      final result = tSerialTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "genre_ids": [1],
            "id": 1,
            "original_name": "Original Name",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "release_date": "2022-11-07",
            "name": "Name",
            "vote_average": 1.0,
            "vote_count": 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}