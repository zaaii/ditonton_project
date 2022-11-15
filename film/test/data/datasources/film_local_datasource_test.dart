import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:core/core.dart';
import 'package:film/data/datasources/film_local_data_source.dart';

import '../../data_dummy/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late FilmLocalDataSourceImpl filmLocalDataSourceImpl;
  late MockFilmDatabaseHelper mockFilmDatabaseHelper;

  setUp(() {
    mockFilmDatabaseHelper = MockFilmDatabaseHelper();
    filmLocalDataSourceImpl = FilmLocalDataSourceImpl(filmDatabaseHelper: mockFilmDatabaseHelper);
  });

  group('Menyimpan Watchlist Film', () {
    test('should return success message when insert to database is success', () async {
          // arrange
          when(mockFilmDatabaseHelper.insertWatchlistFilm(testFilmTable))
              .thenAnswer((_) async => 1);
          // act
          final result = await filmLocalDataSourceImpl.insertWatchlistFilm(testFilmTable);
          // assert
          expect(result, 'Film Ditambahkan ke Watchlist');
        });

    test('should throw DatabaseException when insert to database is failed', () async {
          // arrange
          when(mockFilmDatabaseHelper.insertWatchlistFilm(testFilmTable))
              .thenThrow(Exception());
          // act
          final call = filmLocalDataSourceImpl.insertWatchlistFilm(testFilmTable);
          // assert
          expect(() => call, throwsA(isA<DatabaseException>()));
        });
  });

  group('Mengahpus Watchlist Film', () {
    test('should return success message when remove from database is success', () async {
          // arrange
          when(mockFilmDatabaseHelper.removeWatchlistFilm(testFilmTable))
              .thenAnswer((_) async => 1);
          // act
          final result = await filmLocalDataSourceImpl.removeWatchlistFilm(testFilmTable);
          // assert
          expect(result, 'Film Dihapus dari Watchlist');
        });

    test('should throw DatabaseException when remove from database is failed', () async {
          // arrange
          when(mockFilmDatabaseHelper.removeWatchlistFilm(testFilmTable))
              .thenThrow(Exception());
          // act
          final call = filmLocalDataSourceImpl.removeWatchlistFilm(testFilmTable);
          // assert
          expect(() => call, throwsA(isA<DatabaseException>()));
        });
  });

  group('Mengambil Detail Film dari Id', () {
    const tId = 1;

    test('should return Film Detail Table when data is found', () async {
      // arrange
      when(mockFilmDatabaseHelper.getFilmById(tId))
          .thenAnswer((_) async => testFilmMap);
      // act
      final result = await filmLocalDataSourceImpl.getFilmById(tId);
      // assert
      expect(result, testFilmTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockFilmDatabaseHelper.getFilmById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await filmLocalDataSourceImpl.getFilmById(tId);
      // assert
      expect(result, null);
    });
  });

  group('Mengambil Watchlist Film', () {
    test('should return list of FilmTable from database', () async {
      // arrange
      when(mockFilmDatabaseHelper.getWatchlistFilm())
          .thenAnswer((_) async => [testFilmMap]);
      // act
      final result = await filmLocalDataSourceImpl.getWatchlistFilm();
      // assert
      expect(result, [testFilmTable]);
    });
  });
}