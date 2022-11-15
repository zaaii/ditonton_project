import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:serialtv/domain/usecases/get_serialtv_watchlist.dart';

import '../../data_dummy/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistSerialTv usecase;
  late MockSerialTvRepository mockSerialTvRepository;

  setUp(() {
    mockSerialTvRepository = MockSerialTvRepository();
    usecase = GetWatchlistSerialTv(mockSerialTvRepository);
  });

  group('Test Mengambil Watchlist Serial Tv', () {
    test('should get watchlist of serial tv from the repository', () async {
      // arrange
      when(mockSerialTvRepository.getWatchlistSerialTv())
          .thenAnswer((_) async => Right(testSerialTvList));
      // act
      final result = await usecase.execute();
      // assert
      expect(result, Right(testSerialTvList));
    });
  });
}
