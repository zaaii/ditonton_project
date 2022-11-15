import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:film/domain/entities/film.dart';
import 'package:pencarian/domain/usecases/pencarian_film.dart';

import '../../helpers/film/film_test_helper.mocks.dart';

void main() {
  late SearchFilm usecase;
  late MockFilmRepository mockFilmRepository;

  setUp(() {
    mockFilmRepository = MockFilmRepository();
    usecase = SearchFilm(mockFilmRepository);
  });

  final tFilm = <Film>[];
  const tQuery = 'Spiderman';

  test('should get list of film from the repository', () async {
    // arrange
    when(mockFilmRepository.searchFilm(tQuery))
        .thenAnswer((_) async => Right(tFilm));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tFilm));
  });
}
