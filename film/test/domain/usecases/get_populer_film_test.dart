import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:film/domain/entities/film.dart';
import 'package:film/domain/usecases/get_film_populer.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetFilmPopuler usecase;
  late MockFilmRepository mockFilmRepository;

  setUp(() {
    mockFilmRepository = MockFilmRepository();
    usecase = GetFilmPopuler(mockFilmRepository);
  });

  final tFilm = <Film>[];

  group('Test Mengambil Film Populer', () {
    test('should get popular list of movies from the repository when execute function is called', () async {
            // arrange
            when(mockFilmRepository.getFilmPopuler())
                .thenAnswer((_) async => Right(tFilm));
            // act
            final result = await usecase.execute();
            // assert
            expect(result, Right(tFilm));
          });
    });
}
