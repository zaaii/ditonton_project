import 'package:flutter_test/flutter_test.dart';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:core/core.dart';
import 'package:serialtv/data/models/serialtv_model.dart';
import 'package:serialtv/data/models/serialtv_genre_model.dart';
import 'package:serialtv/data/models/serialtv_detail_response.dart';
import 'package:serialtv/data/repositories/serialtv_repository_impl.dart';
import 'package:serialtv/domain/entities/serialtv.dart';

import '../../data_dummy/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SerialTvRepositoryImpl serialTvRepositoryImpl;
  late MockSerialTvRemoteDataSource mockSerialTvRemoteDataSource;
  late MockSerialTvLocalDataSource mockSerialTvLocalDataSource;

  setUp(() {
    mockSerialTvRemoteDataSource = MockSerialTvRemoteDataSource();
    mockSerialTvLocalDataSource = MockSerialTvLocalDataSource();
    serialTvRepositoryImpl = SerialTvRepositoryImpl(
      serialTvRemoteDataSource: mockSerialTvRemoteDataSource,
      serialTvLocalDataSource: mockSerialTvLocalDataSource,
    );
  });

  final tSerialTvModel = SerialTvModel(
      backdropPath: "/maFEWU41jdUOzDfRVkojq7fluIm.jpg",
      genreIds: [16, 35, 10751, 10765],
      id: 387,
      originalName: "SpongeBob SquarePants",
      overview: "Deep down in the Pacific Ocean in the subterranean city of Bikini Bottom lives a square yellow sponge named SpongeBob SquarePants. SpongeBob lives in a pineapple with his pet snail, Gary, loves his job as a fry cook at the Krusty Krab, and has a knack for getting into all kinds of trouble without really trying. When he's not getting on the nerves of his cranky next door neighbor Squidward, SpongeBob can usually be found smack in the middle of all sorts of strange situations with his best buddy, the simple yet lovable starfish, Patrick, or his thrill-seeking surfer-girl squirrel pal, Sandy Cheeks.",
      popularity: 30.068,
      posterPath: "/amvtZgiTty0GHIgD56gpouBWrcy.jpg",
      firstAirDate: "1999-05-01",
      name: "SpongeBob SquarePants",
      voteAverage: 7.576,
      voteCount: 2525
  );

  final tSerialTv = SerialTv(
      backdropPath: "/maFEWU41jdUOzDfRVkojq7fluIm.jpg",
      genreIds: [16, 35, 10751, 10765],
      id: 387,
      originalName: "SpongeBob SquarePants",
      overview: "Deep down in the Pacific Ocean in the subterranean city of Bikini Bottom lives a square yellow sponge named SpongeBob SquarePants. SpongeBob lives in a pineapple with his pet snail, Gary, loves his job as a fry cook at the Krusty Krab, and has a knack for getting into all kinds of trouble without really trying. When he's not getting on the nerves of his cranky next door neighbor Squidward, SpongeBob can usually be found smack in the middle of all sorts of strange situations with his best buddy, the simple yet lovable starfish, Patrick, or his thrill-seeking surfer-girl squirrel pal, Sandy Cheeks.",
      popularity: 30.068,
      posterPath: "/amvtZgiTty0GHIgD56gpouBWrcy.jpg",
      firstAirDate: "1999-05-01",
      name: "SpongeBob SquarePants",
      voteAverage: 7.576,
      voteCount: 2525
  );

  final tListSerialTvModel = <SerialTvModel>[tSerialTvModel];
  final tListSerialTv = <SerialTv>[tSerialTv];

  group('Now Playing Serial Tv', () {
    test('should return remote data when the call to remote data source is successful', () async {
          // arrange
          when(mockSerialTvRemoteDataSource.getNowPlayingSerialTv())
              .thenAnswer((_) async => tListSerialTvModel);
          // act
          final result = await serialTvRepositoryImpl.getNowPlayingSerialTv();
          // assert
          verify(mockSerialTvRemoteDataSource.getNowPlayingSerialTv());
          final resultList = result.getOrElse(() => []);
          expect(resultList, tListSerialTv);
        });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
          // arrange
          when(mockSerialTvRemoteDataSource.getNowPlayingSerialTv()).thenThrow(ServerException());
          // act
          final result = await serialTvRepositoryImpl.getNowPlayingSerialTv();
          // assert
          verify(mockSerialTvRemoteDataSource.getNowPlayingSerialTv());
          expect(result, equals(Left(ServerFailure(''))));
        });

    test('should return connection failure when the device is not connected to internet', () async {
          // arrange
          when(mockSerialTvRemoteDataSource.getNowPlayingSerialTv())
              .thenThrow(SocketException('Gagal Terhubung Ke Internet'));
          // act
          final result = await serialTvRepositoryImpl.getNowPlayingSerialTv();
          // assert
          verify(mockSerialTvRemoteDataSource.getNowPlayingSerialTv());
          expect(result, equals(Left(ConnectionFailure('Gagal Terhubung Ke Internet'))));
        });
  });

  group('Serial Tv Populer', () {
    test('should return serial tv populer list when call to data source is success', () async {
          // arrange
          when(mockSerialTvRemoteDataSource.getSerialTvPopuler())
              .thenAnswer((_) async => tListSerialTvModel);
          // act
          final result = await serialTvRepositoryImpl.getSerialTvPopuler();
          // assert
          final resultList = result.getOrElse(() => []);
          expect(resultList, tListSerialTv);
        });

    test('should return server failure when call to data source is unsuccessful', () async {
          // arrange
          when(mockSerialTvRemoteDataSource.getSerialTvPopuler())
              .thenThrow(ServerException());
          // act
          final result = await serialTvRepositoryImpl.getSerialTvPopuler();
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test('should return connection failure when device is not connected to the internet', () async {
          // arrange
          when(mockSerialTvRemoteDataSource.getSerialTvPopuler())
              .thenThrow(SocketException('Gagal Terhubung Ke Internet'));
          // act
          final result = await serialTvRepositoryImpl.getSerialTvPopuler();
          // assert
          expect(
              result, Left(ConnectionFailure('Gagal Terhubung Ke Internet')));
        });
  });

  group('Serial Tv Top Rated', () {
    test('should return top rated serial tv list when call to data source is successful', () async {
          // arrange
          when(mockSerialTvRemoteDataSource.getSerialTvTopRated())
              .thenAnswer((_) async => tListSerialTvModel);
          // act
          final result = await serialTvRepositoryImpl.getSerialTvTopRated();
          // assert
          final resultList = result.getOrElse(() => []);
          expect(resultList, tListSerialTv);
        });

    test('should return ServerFailure when call to data source is unsuccessful', () async {
          // arrange
          when(mockSerialTvRemoteDataSource.getSerialTvTopRated())
              .thenThrow(ServerException());
          // act
          final result = await serialTvRepositoryImpl.getSerialTvTopRated();
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test('should return ConnectionFailure when device is not connected to the internet', () async {
          // arrange
          when(mockSerialTvRemoteDataSource.getSerialTvTopRated())
              .thenThrow(SocketException('Gagal Terhubung Ke Internet'));
          // act
          final result = await serialTvRepositoryImpl.getSerialTvTopRated();
          // assert
          expect(result, Left(ConnectionFailure('Gagal Terhubung Ke Internet')));
        });
  });

  group('Mengambil Detail Serial Tv', () {
    const tId = 1;
    final tSerialTvResponse = SerialTvDetailResponse(
        backdropPath: "/maFEWU41jdUOzDfRVkojq7fluIm.jpg",
        originalName: "SpongeBob SquarePants",
        tagline: "The Best Day Ever",
        status: "OnGoing Series",
        genres: [SerialTvGenreModel(id: 16, name: "Animation"), SerialTvGenreModel(id: 35, name: "Comedy"), SerialTvGenreModel(id: 10751, name: "Family"), SerialTvGenreModel(id: 10765, name: "Sci-Fi & Fantasy")],
        id: 387,
        firstAirDate: "1999-05-01",
        numberOfSeasons: 13,
        popularity: 60.441,
        numberOfEpisodes: 537,
        overview:
        "Deep down in the Pacific Ocean in the subterranean city of Bikini Bottom lives a square yellow sponge named SpongeBob SquarePants. SpongeBob lives in a pineapple with his pet snail, Gary, loves his job as a fry cook at the Krusty Krab, and has a knack for getting into all kinds of trouble without really trying. When he's not getting on the nerves of his cranky next door neighbor Squidward, SpongeBob can usually be found smack in the middle of all sorts of strange situations with his best buddy, the simple yet lovable starfish, Patrick, or his thrill-seeking surfer-girl squirrel pal, Sandy Cheeks.",
        posterPath: "/amvtZgiTty0GHIgD56gpouBWrcy.jpg",
        name: "SpongeBob SquarePants",
        voteAverage: 7.576,
        voteCount: 2525,
        originalLanguage: "EN"
    );

    test('should return Serial Tv data when the call to remote data source is successful', () async {
          // arrange
          when(mockSerialTvRemoteDataSource.getDetailSerialTv(tId))
              .thenAnswer((_) async => tSerialTvResponse);
          // act
          final result = await serialTvRepositoryImpl.getDetailSerialTv(tId);
          // assert
          verify(mockSerialTvRemoteDataSource.getDetailSerialTv(tId));
          expect(result, equals(Right(testDetailSerialTv)));
        });

    test('should return Server Failure when the call to remote data source is unsuccessful', () async {
          // arrange
          when(mockSerialTvRemoteDataSource.getDetailSerialTv(tId))
              .thenThrow(ServerException());
          // act
          final result = await serialTvRepositoryImpl.getDetailSerialTv(tId);
          // assert
          verify(mockSerialTvRemoteDataSource.getDetailSerialTv(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test('should return connection failure when the device is not connected to internet', () async {
          // arrange
          when(mockSerialTvRemoteDataSource.getDetailSerialTv(tId))
              .thenThrow(SocketException('Gagal Terhubung Ke Internet'));
          // act
          final result = await serialTvRepositoryImpl.getDetailSerialTv(tId);
          // assert
          verify(mockSerialTvRemoteDataSource.getDetailSerialTv(tId));
          expect(result, equals(Left(ConnectionFailure('Gagal Terhubung Ke Internet'))));
        });
  });

  group('Mengambil Rekomendasi Serial Tv', () {
    const tId = 1;
    final tListSerialTv = <SerialTvModel>[];

    test('should return data rekomendasi serial tv list when the call is successful', () async {
          // arrange
          when(mockSerialTvRemoteDataSource.getRecommendationsSerialTv(tId))
              .thenAnswer((_) async => tListSerialTv);
          // act
          final result = await serialTvRepositoryImpl.getRecommendationsSerialTv(tId);
          // assert
          verify(mockSerialTvRemoteDataSource.getRecommendationsSerialTv(tId));
          final resultList = result.getOrElse(() => []);
          expect(resultList, equals(tListSerialTv));
        });

    test('should return server failure when call to remote data source is unsuccessful', () async {
          // arrange
          when(mockSerialTvRemoteDataSource.getRecommendationsSerialTv(tId))
              .thenThrow(ServerException());
          // act
          final result = await serialTvRepositoryImpl.getRecommendationsSerialTv(tId);
          // assertbuild runner
          verify(mockSerialTvRemoteDataSource.getRecommendationsSerialTv(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test('should return connection failure when the device is not connected to the internet', () async {
          // arrange
          when(mockSerialTvRemoteDataSource.getRecommendationsSerialTv(tId))
              .thenThrow(SocketException('Gagal Terhubung Ke Internet'));
          // act
          final result = await serialTvRepositoryImpl.getRecommendationsSerialTv(tId);
          // assert
          verify(mockSerialTvRemoteDataSource.getRecommendationsSerialTv(tId));
          expect(result, equals(Left(ConnectionFailure('Gagal Terhubung Ke Internet'))));
        });
  });

  group('Pencarian Serial Tv', () {
    final tQuery = 'Spongebob';

    test('should return list of pencarian serial tv when call to data source is successful', () async {
          // arrange
          when(mockSerialTvRemoteDataSource.searchSerialTv(tQuery))
              .thenAnswer((_) async => tListSerialTvModel);
          // act
          final result = await serialTvRepositoryImpl.searchSerialTv(tQuery);
          // assert
          final resultList = result.getOrElse(() => []);
          expect(resultList, tListSerialTv);
        });

    test('should return ServerFailure when call to data source is unsuccessful', () async {
          // arrange
          when(mockSerialTvRemoteDataSource.searchSerialTv(tQuery))
              .thenThrow(ServerException());
          // act
          final result = await serialTvRepositoryImpl.searchSerialTv(tQuery);
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test('should return ConnectionFailure when device is not connected to the internet', () async {
          // arrange
          when(mockSerialTvRemoteDataSource.searchSerialTv(tQuery))
              .thenThrow(SocketException('Gagal Terhubung Ke Internet'));
          // act
          final result = await serialTvRepositoryImpl.searchSerialTv(tQuery);
          // assert
          expect(result, Left(ConnectionFailure('Gagal Terhubung Ke Internet')));
        });
  });

  group('Mengambil Watchlist Serial Tv', () {
    test('should return list of watchlist serial tv when call to data source is successful', () async {
      // arrange
      when(mockSerialTvLocalDataSource.getWatchlistSerialTv())
          .thenAnswer((_) async => [testSerialTvTable]);
      // act
      final result = await serialTvRepositoryImpl.getWatchlistSerialTv();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchListSerialTv]);
    });
  });

  group('Mengambil Status Watchlist Serial Tv', () {
    test('should return watchlist status of serial tv whether data is found', () async {
      const tId = 1;
      // arrange
      when(mockSerialTvLocalDataSource.getSerialTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await serialTvRepositoryImpl.isSerialTvAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('Menyimpan Watchlist Serial Tv', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockSerialTvLocalDataSource.insertWatchlistSerialTv(testSerialTvTable))
          .thenAnswer((_) async => 'Serial Tv ditambahkan ke Watchlist');
      // act
      final result = await serialTvRepositoryImpl.saveWatchlistSerialTv(testDetailSerialTv);
      // assert
      expect(result, const Right('Serial Tv ditambahkan ke Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockSerialTvLocalDataSource.insertWatchlistSerialTv(testSerialTvTable))
          .thenThrow(DatabaseException('Gagal Menambahkan Serial Tv ke Watchlist'));
      // act
      final result = await serialTvRepositoryImpl.saveWatchlistSerialTv(testDetailSerialTv);
      // assert
      expect(result, const Left(DatabaseFailure('Gagal Menambahkan Serial Tv ke Watchlist')));
    });
  });

  group('Menghapus Watchlist Serial Tv', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockSerialTvLocalDataSource.removeWatchlistSerialTv(testSerialTvTable))
          .thenAnswer((_) async => 'Serial Tv dihapus dari Watchlist');
      // act
      final result = await serialTvRepositoryImpl.removeWatchlistSerialTv(testDetailSerialTv);
      // assert
      expect(result, Right('Serial Tv dihapus dari Watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockSerialTvLocalDataSource.removeWatchlistSerialTv(testSerialTvTable))
          .thenThrow(DatabaseException('Gagal Menghapus Serial Tv dari Watchlist'));
      // act
      final result = await serialTvRepositoryImpl.removeWatchlistSerialTv(testDetailSerialTv);
      // assert
      expect(result, Left(DatabaseFailure('Gagal Menghapus Serial Tv dari Watchlist')));
    });
  });
}