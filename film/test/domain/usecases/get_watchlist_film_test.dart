import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:film/domain/usecases/get_film_watchlist.dart';

import '../../data_dummy/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistFilm usecase;
  late MockFilmRepository mockFilmRepository;

  setUp(() {
    mockFilmRepository = MockFilmRepository();
    usecase = GetWatchlistFilm(mockFilmRepository);
  });


  group('Test Mengambil Watchlist Film', () {
    test('should get Watchlist list of film from the repository', () async {
      // arrange
      when(mockFilmRepository.getWatchlistFilm())
          .thenAnswer((_) async => Right(testListFilm));
      // act
      final result = await usecase.execute();
      // assert
      expect(result, Right(testListFilm));
    });
  });
}
