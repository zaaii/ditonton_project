import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:core/core.dart';
import 'package:film/data/datasources/film_remote_data_source.dart';
import 'package:film/data/models/film_detail_response.dart';
import 'package:film/data/models/film_response.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late FilmRemoteDataSourceImpl filmRemoteDataSourceImpl;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    filmRemoteDataSourceImpl = FilmRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('Mengambil Now Playing Film', () {
    final tListFilm = FilmResponse.fromJson(json.decode(readJson('data_dummy/film_now_playing.json')))
        .filmList;

    test('should return list of Film Model when the response code is 200', () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY')))
              .thenAnswer((_) async => http.Response(readJson('data_dummy/film_now_playing.json'), 200));
          // act
          final result = await filmRemoteDataSourceImpl.getNowPlayingFilm();
          // assert
          expect(result, equals(tListFilm));
        });

    test('should throw a ServerException when the response code is 404 or other', () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = filmRemoteDataSourceImpl.getNowPlayingFilm();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('Mengambil Film Populer', () {
    final tListFilm = FilmResponse.fromJson(json.decode(readJson('data_dummy/film_populer.json')))
            .filmList;

    test('should return list of film when response is success (200)', () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('data_dummy/film_populer.json'), 200));
          // act
          final result = await filmRemoteDataSourceImpl.getFilmPopuler();
          // assert
          expect(result, tListFilm);
        });

    test('should throw a ServerException when the response code is 404 or other', () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = filmRemoteDataSourceImpl.getFilmPopuler();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('Mengambil Film Top Rated', () {
    final tListFilm = FilmResponse.fromJson(json.decode(readJson('data_dummy/film_top_rated.json')))
        .filmList;

    test('should return list of film when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('data_dummy/film_top_rated.json'), 200));
      // act
      final result = await filmRemoteDataSourceImpl.getFilmTopRated();
      // assert
      expect(result, tListFilm);
    });

    test('should throw ServerException when response code is other than 200', () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = filmRemoteDataSourceImpl.getFilmTopRated();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('Mengambil Detail Film', () {
    const tId = 1;
    final tDetailFilm = FilmDetailResponse.fromJson(json.decode(readJson('data_dummy/film_detail.json')));

    test('should return detail film when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/$tId?$API_KEY')))
          .thenAnswer((_) async =>
          http.Response(readJson('data_dummy/film_detail.json'), 200));
      // act
      final result = await filmRemoteDataSourceImpl.getDetailFilm(tId);
      // assert
      expect(result, equals(tDetailFilm));
    });

    test('should throw Server Exception when the response code is 404 or other', () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/$tId?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = filmRemoteDataSourceImpl.getDetailFilm(tId);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('Mengambil Rekomendasi Film', () {
    const tId = 1;
    final tListFilm = FilmResponse.fromJson(json.decode(readJson('data_dummy/film_recommendations.json')))
        .filmList;

    test('should return list of Film Model when the response code is 200',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/$tId/recommendations?$API_KEY')))
              .thenAnswer((_) async => http.Response(readJson('data_dummy/film_recommendations.json'), 200));
          // act
          final result = await filmRemoteDataSourceImpl.getRecommendationsFilm(tId);
          // assert
          expect(result, equals(tListFilm));
        });

    test('should throw Server Exception when the response code is 404 or other', () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/$tId/recommendations?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = filmRemoteDataSourceImpl.getRecommendationsFilm(tId);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('Pencarian Film', () {
    const tQuery = 'Spiderman';
    final tHasilCari = FilmResponse.fromJson(json.decode(readJson('data_dummy/pencarian_film_spiderman.json')))
        .filmList;


    test('should return list of film when response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
          readJson('data_dummy/pencarian_film_spiderman.json'), 200));
      // act
      final result = await filmRemoteDataSourceImpl.searchFilm(tQuery);
      // assert
      expect(result, tHasilCari);
    });

    test('should throw ServerException when response code is other than 200', () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = filmRemoteDataSourceImpl.searchFilm(tQuery);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });
}