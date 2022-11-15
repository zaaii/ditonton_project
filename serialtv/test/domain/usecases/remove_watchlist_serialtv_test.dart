import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:serialtv/domain/usecases/remove_serialtv_watchlist.dart';

import '../../data_dummy/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistSerialTv usecase;
  late MockSerialTvRepository mockSerialTvRepository;

  setUp(() {
    mockSerialTvRepository = MockSerialTvRepository();
    usecase = RemoveWatchlistSerialTv(mockSerialTvRepository);
  });

  group('Menghapus Watchlist Serial Tv', () {
    test('should remove watchlist serial tv from repository', () async {
      // arrange
      when(mockSerialTvRepository.removeWatchlistSerialTv(testDetailSerialTv))
          .thenAnswer((_) async => const Right('Serial Tv dihapus dari Watchlist'));
      // act
      final result = await usecase.execute(testDetailSerialTv);
      // assert
      verify(mockSerialTvRepository.removeWatchlistSerialTv(testDetailSerialTv));
      expect(result, Right('Serial Tv dihapus dari Watchlist'));
    });
  });
}
