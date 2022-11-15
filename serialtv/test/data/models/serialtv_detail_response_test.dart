import 'package:flutter_test/flutter_test.dart';
import 'package:serialtv/data/models/serialtv_detail_response.dart';

void main() {
  final testDetailSerialTv = SerialTvDetailResponse(
    backdropPath: 'backdropPath',
    genres: [],
    id: 1,
    originalLanguage: 'original Language',
    originalName: 'original Title',
    overview: 'overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    firstAirDate: '2022-11-07',
    status: '',
    tagline: '',
    name: 'name',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    voteAverage: 1.0,
    voteCount: 1,
  );
  final testJson = {
    'backdrop_path': 'backdropPath',
    'genres': [],
    'id': 1,
    'original_language': 'original Language',
    'original_name': 'original Title',
    'overview': 'overview',
    'popularity': 1.0,
    'poster_path': '/path.jpg',
    'first_air_date': '2022-11-07',
    'status': '',
    'tagline': '',
    'name': 'name',
    'number_of_episodes': 1,
    'number_of_seasons': 1,
    'vote_average': 1.0,
    'vote_count': 1
  };
  test('should return valid object when use factory fromJson', () {
    var detail = SerialTvDetailResponse.fromJson(testJson);
    expect(detail, testDetailSerialTv);
  });

  test('should return valid jsonMap', () {
    var map = testDetailSerialTv.toJson();
    expect(map, testJson);
  });
}