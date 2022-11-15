import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:core/core.dart';
import 'package:serialtv/data/datasources/serialtv_local_data_source.dart';

import '../../data_dummy/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SerialTvLocalDataSourceImpl serialTvLocalDataSourceImpl;
  late MockSerialTvDatabaseHelper mockSerialTvDatabaseHelper;

  setUp(() {
    mockSerialTvDatabaseHelper = MockSerialTvDatabaseHelper();
    serialTvLocalDataSourceImpl = SerialTvLocalDataSourceImpl(serialTvDatabaseHelper: mockSerialTvDatabaseHelper);
  });

  group('Mengambil Serial Tv Watchlist', () {
    test('should return list of SerialTvTable from database', () async {
      // arrange
      when(mockSerialTvDatabaseHelper.getWatchlistSerialTv())
          .thenAnswer((_) async => [testSerialTvMap]);
      // act
      final result = await serialTvLocalDataSourceImpl.getWatchlistSerialTv();
      // assert
      expect(result, [testSerialTvTable]);
    });
  });

  group('Menyimpan Watchlist Serial Tv', () {
    test('should return success message when insert to database is success', () async {
          // arrange
          when(mockSerialTvDatabaseHelper.insertWatchlistSerialTv(testSerialTvTable))
              .thenAnswer((_) async => 1);
          // act
          final result = await serialTvLocalDataSourceImpl.insertWatchlistSerialTv(testSerialTvTable);
          // assert
          expect(result, 'Serial Tv ditambahkan kedalam Watchlist');
        });

    test('should throw DatabaseException when insert to database is failed', () async {
          // arrange
          when(mockSerialTvDatabaseHelper.insertWatchlistSerialTv(testSerialTvTable))
              .thenThrow(Exception());
          // act
          final call = serialTvLocalDataSourceImpl.insertWatchlistSerialTv(testSerialTvTable);
          // assert
          expect(() => call, throwsA(isA<DatabaseException>()));
        });
  });

  group('Menghapus Watchlist Serial Tv', () {
    test('should return success message when remove from database is success', () async {
          // arrange
          when(mockSerialTvDatabaseHelper.removeWatchlistSerialTv(testSerialTvTable))
              .thenAnswer((_) async => 1);
          // act
          final result = await serialTvLocalDataSourceImpl.removeWatchlistSerialTv(testSerialTvTable);
          // assert
          expect(result, 'Serial Tv dihapus dari Watchlist');
        });

    test('should throw DatabaseException when remove from database is failed', () async {
          // arrange
          when(mockSerialTvDatabaseHelper.removeWatchlistSerialTv(testSerialTvTable))
              .thenThrow(Exception());
          // act
          final call = serialTvLocalDataSourceImpl.removeWatchlistSerialTv(testSerialTvTable);
          // assert
          expect(() => call, throwsA(isA<DatabaseException>()));
        });
  });

  group('Mengambil Detail Serial Tv By Id', () {
    const tId = 1;

    test('should return Detail Serial Tv Table when data is found', () async {
      // arrange
      when(mockSerialTvDatabaseHelper.getSerialTvById(tId))
          .thenAnswer((_) async => testSerialTvMap);
      // act
      final result = await serialTvLocalDataSourceImpl.getSerialTvById(tId);
      // assert
      expect(result, testSerialTvTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockSerialTvDatabaseHelper.getSerialTvById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await serialTvLocalDataSourceImpl.getSerialTvById(tId);
      // assert
      expect(result, null);
    });
  });
}