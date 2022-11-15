import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/core.dart';
import 'package:film/domain/entities/film.dart';
import 'package:film/domain/usecases/get_film_populer.dart';
import 'package:film/presentation/bloc/film_populer/film_populer_bloc.dart';

import 'film_populer_bloc_test.mocks.dart';

@GenerateMocks([GetFilmPopuler])
void main() {
  late FilmPopulerBloc filmPopulerBloc;
  late MockGetFilmPopuler mockGetFilmPopuler;

  setUp(() {
    mockGetFilmPopuler = MockGetFilmPopuler();
    filmPopulerBloc = FilmPopulerBloc(mockGetFilmPopuler);
  });

  final tFilm = <Film>[];

  group('Mengambil Film Populer', () {
    blocTest<FilmPopulerBloc, FilmPopulerState>('should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetFilmPopuler.execute())
            .thenAnswer((_) async => Right(tFilm));
        return filmPopulerBloc;
      },
      act: (bloc) => bloc.add(FetchFilmPopuler()),
      expect: () => [FilmPopulerLoading(), FilmPopulerHasData(tFilm)],
    );

    blocTest<FilmPopulerBloc, FilmPopulerState>('should emit [Loading, Error] when getting data is failed',
        build: () {
          when(mockGetFilmPopuler.execute())
              .thenAnswer((_) async => const Left(ServerFailure('Server Gagal')));
          return filmPopulerBloc;
        },
        act: (bloc) => bloc.add(FetchFilmPopuler()),
        expect: () => [FilmPopulerLoading(), const FilmPopulerError('Server Gagal')],
        verify: (bloc) {
          verify(mockGetFilmPopuler.execute());
        }
    );
  });
}
