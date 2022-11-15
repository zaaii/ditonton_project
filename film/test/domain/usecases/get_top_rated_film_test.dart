import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:film/domain/entities/film.dart';
import 'package:film/domain/usecases/get_film_topRated.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetFilmTopRated usecase;
  late MockFilmRepository mockFilmRepository;

  setUp(() {
    mockFilmRepository = MockFilmRepository();
    usecase = GetFilmTopRated(mockFilmRepository);
  });

  final tFilm = <Film>[];
  group('Test Mengambil Film Top Rated', () {
    test('should get top rated list of film from repository', () async {
      // arrange
      when(mockFilmRepository.getFilmTopRated())
          .thenAnswer((_) async => Right(tFilm));
      // act
      final result = await usecase.execute();
      // assert
      expect(result, Right(tFilm));
    });
  });
}
