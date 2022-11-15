import 'package:flutter_test/flutter_test.dart';
import 'package:film/data/models/film_detail_response.dart';

void main() {
  final testFilmDetail = FilmDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    budget: 1,
    genres: [],
    homepage: '',
    id: 1,
    imdbId: '1',
    originalLanguage: "en",
    originalTitle: 'Original Title',
    overview: 'Overview',
    popularity: 1,
    posterPath: '/path.jpg',
    releaseDate: '',
    revenue: 1,
    runtime: 1,
    status: '',
    tagline: '',
    title: 'Title',
    video: true,
    voteAverage: 1.0,
    voteCount: 1,
  );
  final testJson = {
    "adult": false,
    "backdrop_path": 'backdropPath',
    "budget": 1,
    "genres": [],
    "homepage": '',
    "id": 1,
    "imdb_id": '1',
    "original_language": 'en',
    "original_title": 'Original Title',
    "overview": 'Overview',
    "popularity": 1,
    "poster_path": '/path.jpg',
    "release_date": '',
    "revenue": 1,
    "runtime": 1,
    "status": '',
    "tagline": '',
    "title": 'Title',
    "video": true,
    "vote_average": 1,
    "vote_count": 1,
  };
  test('should return valid object when use factory fromJson', () {
    var detail = FilmDetailResponse.fromJson(testJson);
    expect(detail, testFilmDetail);
  });

  test('should return valid jsonMap', () {
    var map = testFilmDetail.toJson();
    expect(map, testJson);
  });
}