import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:film/domain/entities/film.dart';
import 'package:film/domain/usecases/get_film_recommendations.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetRecommendationsFilm usecase;
  late MockFilmRepository mockFilmRepository;

  setUp(() {
    mockFilmRepository = MockFilmRepository();
    usecase = GetRecommendationsFilm(mockFilmRepository);
  });

  const tId = 1;
  final tFilm = <Film>[];
  group('Test Mengambil Rekomendasi Film', () {
    test('should get recommendation list of film from the repository', () async {
          // arrange
          when(mockFilmRepository.getRecommendationsFilm(tId))
              .thenAnswer((_) async => Right(tFilm));
          // act
          final result = await usecase.execute(tId);
          // assert
          expect(result, Right(tFilm));
        });
  });
}
