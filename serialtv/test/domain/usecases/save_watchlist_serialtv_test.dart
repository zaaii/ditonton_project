import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:serialtv/domain/usecases/save_serialtv_watchlist.dart';

import '../../data_dummy/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistSerialTv usecase;
  late MockSerialTvRepository mockSerialTvRepository;

  setUp(() {
    mockSerialTvRepository = MockSerialTvRepository();
    usecase = SaveWatchlistSerialTv(mockSerialTvRepository);
  });

  group('Test Menyimpan Watchlist Serial Tv', () {
    test('should save serial tv to the repository', () async {
      // arrange
      when(mockSerialTvRepository.saveWatchlistSerialTv(testDetailSerialTv))
          .thenAnswer((_) async => const Right('Serial Tv ditambahkan ke Watchlist'));
      // act
      final result = await usecase.execute(testDetailSerialTv);
      // assert
      verify(mockSerialTvRepository.saveWatchlistSerialTv(testDetailSerialTv));
      expect(result, Right('Serial Tv ditambahkan ke Watchlist'));
    });
  });
}
