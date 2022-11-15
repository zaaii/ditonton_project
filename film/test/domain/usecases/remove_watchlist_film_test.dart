import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:film/domain/usecases/remove_film_watchlist.dart';

import '../../data_dummy/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistFilm usecase;
  late MockFilmRepository mockFilmRepository;

  setUp(() {
    mockFilmRepository = MockFilmRepository();
    usecase = RemoveWatchlistFilm(mockFilmRepository);
  });

  group('Test Menghapus Film dari Watchlist', () {
    test('should remove watchlist film from repository', () async {
      // arrange
      when(mockFilmRepository.removeWatchlistFilm(testDetailFilm))
          .thenAnswer((_) async => Right('Film Dihapus dari Watchlist'));
      // act
      final result = await usecase.execute(testDetailFilm);
      // assert
      verify(mockFilmRepository.removeWatchlistFilm(testDetailFilm));
      expect(result, Right('Film Dihapus dari Watchlist'));
    });
  });
}
