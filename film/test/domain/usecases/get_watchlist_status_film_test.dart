import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:film/domain/usecases/get_film_watchlist_status.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatusFilm usecase;
  late MockFilmRepository mockFilmRepository;

  setUp(() {
    mockFilmRepository = MockFilmRepository();
    usecase = GetWatchListStatusFilm(mockFilmRepository);
  });

  group('Test Mengambil Status Watchlist Film', () {
    test('should get Film watchlist status from repository', () async {
      // arrange
      when(mockFilmRepository.isFilmAddedToWatchlist(1))
          .thenAnswer((_) async => true);
      // act
      final result = await usecase.execute(1);
      // assert
      expect(result, true);
    });
  });
}
