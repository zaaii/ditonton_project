import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:film/domain/usecases/get_film_detail.dart';

import '../../data_dummy/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetDetailFilm usecase;
  late MockFilmRepository mockFilmRepository;

  setUp(() {
    mockFilmRepository = MockFilmRepository();
    usecase = GetDetailFilm(mockFilmRepository);
  });

  const tId = 1;
  group('Test Mengambil Detail Film', () {
    test('should get detail film from the repository', () async {
      // arrange
      when(mockFilmRepository.getDetailFilm(tId))
          .thenAnswer((_) async => Right(testDetailFilm));
      // act
      final result = await usecase.execute(tId);
      // assert
      expect(result, Right(testDetailFilm));
    });
  });
}
