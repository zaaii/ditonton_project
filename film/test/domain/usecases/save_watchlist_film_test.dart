import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:film/domain/usecases/save_film_watchlist.dart';

import '../../data_dummy//dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistFilm usecase;
  late MockFilmRepository mockFilmRepository;

  setUp(() {
    mockFilmRepository = MockFilmRepository();
    usecase = SaveWatchlistFilm(mockFilmRepository);
  });
  group('Test Menyimpan Film kedalam Watchlist', () {
    test('should save film to the repository', () async {
      // arrange
      when(mockFilmRepository.saveWatchlistFilm(testDetailFilm))
          .thenAnswer((_) async => Right('Film Ditambahkan ke Watchlist'));
      // act
      final result = await usecase.execute(testDetailFilm);
      // assert
      verify(mockFilmRepository.saveWatchlistFilm(testDetailFilm));
      expect(result, Right('Film Ditambahkan ke Watchlist'));
    });
  });
}
