import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:core/core.dart';
import 'package:film/data/models/film_model.dart';
import 'package:film/data/models/film_genre_model.dart';
import 'package:film/data/models/film_detail_response.dart';
import 'package:film/data/repositories/film_repository_impl.dart';
import 'package:film/domain/entities/film.dart';

import '../../data_dummy/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late FilmRepositoryImpl filmRepositoryImpl;
  late MockFilmRemoteDataSource mockFilmRemoteDataSource;
  late MockFilmLocalDataSource mockFilmLocalDataSource;

  setUp(() {
    mockFilmRemoteDataSource = MockFilmRemoteDataSource();
    mockFilmLocalDataSource = MockFilmLocalDataSource();
    filmRepositoryImpl = FilmRepositoryImpl(
      filmremoteDataSource: mockFilmRemoteDataSource,
      filmlocalDataSource: mockFilmLocalDataSource,
    );
  });

  final tFilmModel = FilmModel(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tFilm = Film(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tListFilmModel = <FilmModel>[tFilmModel];
  final tListFilm = <Film>[tFilm];

  group('Film Now Playing', () {
    test('should return remote data when the call to remote data source is successful', () async {
          // arrange
          when(mockFilmRemoteDataSource.getNowPlayingFilm())
              .thenAnswer((_) async => tListFilmModel);
          // act
          final result = await filmRepositoryImpl.getNowPlayingFilm();
          // assert
          verify(mockFilmRemoteDataSource.getNowPlayingFilm());
          final resultList = result.getOrElse(() => []);
          expect(resultList, tListFilm);
        });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
          // arrange
          when(mockFilmRemoteDataSource.getNowPlayingFilm())
              .thenThrow(ServerException());
          // act
          final result = await filmRepositoryImpl.getNowPlayingFilm();
          // assert
          verify(mockFilmRemoteDataSource.getNowPlayingFilm());
          expect(result, equals(Left(ServerFailure(''))));
        });

    test('should return connection failure when the device is not connected to internet', () async {
          // arrange
          when(mockFilmRemoteDataSource.getNowPlayingFilm())
              .thenThrow(SocketException('Gagal Terhubung Ke Internet'));
          // act
          final result = await filmRepositoryImpl.getNowPlayingFilm();
          // assert
          verify(mockFilmRemoteDataSource.getNowPlayingFilm());
          expect(result, equals(Left(ConnectionFailure('Gagal Terhubung Ke Internet'))));
        });
  });

  group('Film Populer', () {
    test('should return film list when call to data source is success', () async {
          // arrange
          when(mockFilmRemoteDataSource.getFilmPopuler())
              .thenAnswer((_) async => tListFilmModel);
          // act
          final result = await filmRepositoryImpl.getFilmPopuler();
          // assert
          final resultList = result.getOrElse(() => []);
          expect(resultList, tListFilm);
        });

    test('should return server failure when call to data source is unsuccessful', () async {
          // arrange
          when(mockFilmRemoteDataSource.getFilmPopuler())
              .thenThrow(ServerException());
          // act
          final result = await filmRepositoryImpl.getFilmPopuler();
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test('should return connection failure when device is not connected to the internet', () async {
          // arrange
          when(mockFilmRemoteDataSource.getFilmPopuler())
              .thenThrow(SocketException('Gagal Terhubung Ke Internet'));
          // act
          final result = await filmRepositoryImpl.getFilmPopuler();
          // assert
          expect(result, Left(ConnectionFailure('Gagal Terhubung Ke Internet')));
        });
  });

  group('Film Top Rated', () {
    test('should return film list when call to data source is successful', () async {
          // arrange
          when(mockFilmRemoteDataSource.getFilmTopRated())
              .thenAnswer((_) async => tListFilmModel);
          // act
          final result = await filmRepositoryImpl.getFilmTopRated();
          // assert
          final resultList = result.getOrElse(() => []);
          expect(resultList, tListFilm);
        });

    test('should return ServerFailure when call to data source is unsuccessful', () async {
          // arrange
          when(mockFilmRemoteDataSource.getFilmTopRated())
              .thenThrow(ServerException());
          // act
          final result = await filmRepositoryImpl.getFilmTopRated();
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test('should return ConnectionFailure when device is not connected to the internet', () async {
          // arrange
          when(mockFilmRemoteDataSource.getFilmTopRated())
              .thenThrow(SocketException('Gagal Terhubung Ke Internet'));
          // act
          final result = await filmRepositoryImpl.getFilmTopRated();
          // assert
          expect(
              result,
              Left(ConnectionFailure('Gagal Terhubung Ke Internet')));
        });
  });

  group('Mengambil Detail Film', () {
    const tId = 1;
    final tFilmResponse = FilmDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      budget: 100,
      genres: [FilmGenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      imdbId: 'imdb1',
      originalLanguage: 'en',
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      revenue: 12000,
      runtime: 120,
      status: 'Status',
      tagline: 'Tagline',
      title: 'title',
      video: false,
      voteAverage: 1,
      voteCount: 1,
    );

    test('should return data Film when the call to remote data source is successful', () async {
          // arrange
          when(mockFilmRemoteDataSource.getDetailFilm(tId))
              .thenAnswer((_) async => tFilmResponse);
          // act
          final result = await filmRepositoryImpl.getDetailFilm(tId);
          // assert
          verify(mockFilmRemoteDataSource.getDetailFilm(tId));
          expect(result, equals(Right(testDetailFilm)));
        });

    test('should return Server Failure when the call to remote data source is unsuccessful', () async {
          // arrange
          when(mockFilmRemoteDataSource.getDetailFilm(tId))
              .thenThrow(ServerException());
          // act
          final result = await filmRepositoryImpl.getDetailFilm(tId);
          // assert
          verify(mockFilmRemoteDataSource.getDetailFilm(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test('should return connection failure when the device is not connected to internet', () async {
          // arrange
          when(mockFilmRemoteDataSource.getDetailFilm(tId))
              .thenThrow(SocketException('Gagal Terhubung Ke Internet'));
          // act
          final result = await filmRepositoryImpl.getDetailFilm(tId);
          // assert
          verify(mockFilmRemoteDataSource.getDetailFilm(tId));
          expect(result, equals(Left(ConnectionFailure('Gagal Terhubung Ke Internet'))));
        });
  });

  group('Mengambil Rekomendasi Film', () {
    const tId = 1;
    final tListFilm = <FilmModel>[];

    test('should return data list film when the call is successful', () async {
          // arrange
          when(mockFilmRemoteDataSource.getRecommendationsFilm(tId))
              .thenAnswer((_) async => tListFilm);
          // act
          final result = await filmRepositoryImpl.getRecommendationsFilm(tId);
          // assert
          verify(mockFilmRemoteDataSource.getRecommendationsFilm(tId));
          final resultList = result.getOrElse(() => []);
          expect(resultList, equals(tListFilm));
        });

    test('should return Certification Failure when the call to remote data source is unsuccessful', () async {
          // arrange
          when(mockFilmRemoteDataSource.getRecommendationsFilm(tId))
              .thenThrow(const TlsException());
          // act
          final result = await filmRepositoryImpl.getRecommendationsFilm(tId);
          // assert
          verify(mockFilmRemoteDataSource.getRecommendationsFilm(tId));
          expect(result, equals(const Left(CommonFailure('Sertifikat Tidak Valid\n'))));
        });

    test('should return server failure when call to remote data source is unsuccessful', () async {
          // arrange
          when(mockFilmRemoteDataSource.getRecommendationsFilm(tId))
              .thenThrow(ServerException());
          // act
          final result = await filmRepositoryImpl.getRecommendationsFilm(tId);
          // assertbuild runner
          verify(mockFilmRemoteDataSource.getRecommendationsFilm(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test('should return connection failure when the device is not connected to the internet', () async {
          // arrange
          when(mockFilmRemoteDataSource.getRecommendationsFilm(tId))
              .thenThrow(SocketException('Gagal Terhubung Ke Internet'));
          // act
          final result = await filmRepositoryImpl.getRecommendationsFilm(tId);
          // assert
          verify(mockFilmRemoteDataSource.getRecommendationsFilm(tId));
          expect(result,
              equals(
                  Left(ConnectionFailure('Gagal Terhubung Ke Internet'))));
        });
  });

  group('Pencarian Film', () {
    const tQuery = 'Spiderman';

    test('should return list film when call to data source is successful', () async {
          // arrange
          when(mockFilmRemoteDataSource.searchFilm(tQuery))
              .thenAnswer((_) async => tListFilmModel);
          // act
          final result = await filmRepositoryImpl.searchFilm(tQuery);
          // assert
          final resultList = result.getOrElse(() => []);
          expect(resultList, tListFilm);
        });

    test('should return ServerFailure when call to data source is unsuccessful', () async {
          // arrange
          when(mockFilmRemoteDataSource.searchFilm(tQuery))
              .thenThrow(ServerException());
          // act
          final result = await filmRepositoryImpl.searchFilm(tQuery);
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test('should return ConnectionFailure when device is not connected to the internet', () async {
          // arrange
          when(mockFilmRemoteDataSource.searchFilm(tQuery))
              .thenThrow(SocketException('Gagal Terhubung Ke Internet'));
          // act
          final result = await filmRepositoryImpl.searchFilm(tQuery);
          // assert
          expect(result, Left(ConnectionFailure('Gagal Terhubung Ke Internet')));
        });
  });

  group('Mengambil Watchlist Film', () {
    test('should return list of Film', () async {
      // arrange
      when(mockFilmLocalDataSource.getWatchlistFilm())
          .thenAnswer((_) async => [testFilmTable]);
      // act
      final result = await filmRepositoryImpl.getWatchlistFilm();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistFilm]);
    });
  });

  group('Mengambil Status Watchlist Film', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      when(mockFilmLocalDataSource.getFilmById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await filmRepositoryImpl.isFilmAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('Menyimpan Watchlist Film', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockFilmLocalDataSource.insertWatchlistFilm(testFilmTable))
          .thenAnswer((_) async => 'Film Ditambahkan ke Watchlist');
      // act
      final result = await filmRepositoryImpl.saveWatchlistFilm(testDetailFilm);
      // assert
      expect(result, Right('Film Ditambahkan ke Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockFilmLocalDataSource.insertWatchlistFilm(testFilmTable))
          .thenThrow(DatabaseException('Film Gagal Ditambahkan ke Watchlist'));
      // act
      final result = await filmRepositoryImpl.saveWatchlistFilm(testDetailFilm);
      // assert
      expect(result, Left(DatabaseFailure('Film Gagal Ditambahkan ke Watchlist')));
    });
  });

  group('Menghapus Watchlist Film', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockFilmLocalDataSource.removeWatchlistFilm(testFilmTable))
          .thenAnswer((_) async => 'Film Dihapus dari Watchlist');
      // act
      final result = await filmRepositoryImpl.removeWatchlistFilm(testDetailFilm);
      // assert
      expect(result, Right('Film Dihapus dari Watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockFilmLocalDataSource.removeWatchlistFilm(testFilmTable))
          .thenThrow(DatabaseException('Film Gagal Dihapus dari Watchlist'));
      // act
      final result = await filmRepositoryImpl.removeWatchlistFilm(testDetailFilm);
      // assert
      expect(result, Left(DatabaseFailure('Film Gagal Dihapus dari Watchlist')));
    });
  });
}