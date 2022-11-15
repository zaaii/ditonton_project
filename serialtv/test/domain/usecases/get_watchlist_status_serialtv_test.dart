import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:serialtv/domain/usecases/get_serialtv_watchlist_status.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatusSerialTv usecase;
  late MockSerialTvRepository mockSerialTvRepository;

  setUp(() {
    mockSerialTvRepository = MockSerialTvRepository();
    usecase = GetWatchListStatusSerialTv(mockSerialTvRepository);
  });
  group('Mengambil Status Watchlist Serial Tv', () {
    test('should get watchlist status of serial tv from repository', () async {
      // arrange
      when(mockSerialTvRepository.isSerialTvAddedToWatchlist(1))
          .thenAnswer((_) async => true);
      // act
      final result = await usecase.execute(1);
      // assert
      expect(result, true);
    });
  });
}
