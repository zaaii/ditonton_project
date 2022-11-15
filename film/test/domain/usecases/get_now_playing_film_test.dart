import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:film/domain/entities/film.dart';
import 'package:film/domain/usecases/get_film_nowplaying.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingFilm usecase;
  late MockFilmRepository mockFilmRepository;

  setUp(() {
    mockFilmRepository = MockFilmRepository();
    usecase = GetNowPlayingFilm(mockFilmRepository);
  });

  final tFilm = <Film>[];
  group('Test Mengambil Now Playing Film', () {
    test('should get now playing list of film from the repository', () async {
      // arrange
      when(mockFilmRepository.getNowPlayingFilm())
          .thenAnswer((_) async => Right(tFilm));
      // act
      final result = await usecase.execute();
      // assert
      expect(result, Right(tFilm));
    });
  });
}
