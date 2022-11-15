import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:core/core.dart';
import 'package:serialtv/data/datasources/serialtv_remote_data_source.dart';
import 'package:serialtv/data/models/serialtv_detail_response.dart';
import 'package:serialtv/data/models/serialtv_response.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late SerialTvRemoteDataSourceImpl serialTvRemoteDataSourceImpl;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    serialTvRemoteDataSourceImpl = SerialTvRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('Mengambil Serial Tv Now Playing', () {
    final tSerialTvList = SerialTvResponse.fromJson(json.decode(readJson('data_dummy/serialtv_now_playing.json')))
        .serialTvList;

    test('should return list of Serial Tv Model when the response code is 200', () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
              .thenAnswer((_) async => http.Response(readJson('data_dummy/serialtv_now_playing.json'), 200));
          // act
          final result = await serialTvRemoteDataSourceImpl.getNowPlayingSerialTv();
          // assert
          expect(result, equals(tSerialTvList));
        });

    test('should throw a ServerException when the response code is 404 or other', () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = serialTvRemoteDataSourceImpl.getNowPlayingSerialTv();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('Mengambil Serial Tv Populer', () {
    final tListSerialTv = SerialTvResponse.fromJson(json.decode(readJson('data_dummy/serialtv_populer.json')))
            .serialTvList;

    test('should return populer list of serial tv when response is success (200)', () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
              .thenAnswer((_) async => http.Response(readJson('data_dummy/serialtv_populer.json'), 200));
          // act
          final result = await serialTvRemoteDataSourceImpl.getSerialTvPopuler();
          // assert
          expect(result, tListSerialTv);
        });

    test('should throw a ServerException when the response code is 404 or other', () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = serialTvRemoteDataSourceImpl.getSerialTvPopuler();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('Mengambil Serial Tv Top Rated', () {
    final tListSerialTv = SerialTvResponse.fromJson(json.decode(readJson('data_dummy/serialtv_top_rated.json')))
        .serialTvList;

    test('should return Top Rated list of serial tv when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('data_dummy/serialtv_top_rated.json'), 200));
      // act
      final result = await serialTvRemoteDataSourceImpl.getSerialTvTopRated();
      // assert
      expect(result, tListSerialTv);
    });

    test('should throw ServerException when response code is other than 200', () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = serialTvRemoteDataSourceImpl.getSerialTvTopRated();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('Mengambil Detail Serial Tv', () {
    final tId = 1;
    final tDetailSerialTv = SerialTvDetailResponse.fromJson(json.decode(readJson('data_dummy/serialtv_detail.json')));

    test('should return detail serial tv when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('data_dummy/serialtv_detail.json'), 200));
      // act
      final result = await serialTvRemoteDataSourceImpl.getDetailSerialTv(tId);
      // assert
      expect(result, equals(tDetailSerialTv));
    });

    test('should throw Server Exception when the response code is 404 or other', () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = serialTvRemoteDataSourceImpl.getDetailSerialTv(tId);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('Mengambil Rekomendasi Serial Tv', () {
    const tId = 1;
    final tListSerialTv = SerialTvResponse.fromJson(json.decode(readJson('data_dummy/serialtv_recommendations.json')))
        .serialTvList;

    test('should return recommendation list of Serial Tv when the response code is 200', () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
              .thenAnswer((_) async => http.Response(readJson('data_dummy/serialtv_recommendations.json'), 200));
          // act
          final result = await serialTvRemoteDataSourceImpl.getRecommendationsSerialTv(tId);
          // assert
          expect(result, equals(tListSerialTv));
        });

    test('should throw Server Exception when the response code is 404 or other', () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = serialTvRemoteDataSourceImpl.getRecommendationsSerialTv(tId);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('Pencarian Serial Tv', () {
    const tQuery = 'Spongebob';
    final tSerialTvSearchResult = SerialTvResponse.fromJson(json.decode(readJson('data_dummy/pencarian_serialtv_spongebob.json')))
        .serialTvList;

    test('should return search list of serial tv when response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(readJson('data_dummy/pencarian_serialtv_spongebob.json'), 200));
      // act
      final result = await serialTvRemoteDataSourceImpl.searchSerialTv(tQuery);
      // assert
      expect(result, tSerialTvSearchResult);
    });

    test('should throw ServerException when response code is other than 200', () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = serialTvRemoteDataSourceImpl.searchSerialTv(tQuery);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });
}