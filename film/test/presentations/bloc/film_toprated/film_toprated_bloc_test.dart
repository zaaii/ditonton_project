import 'package:film/domain/entities/film.dart';
import 'package:film/presentation/bloc/film_topRated/film_toprated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/core.dart';
import 'package:film/domain/usecases/get_film_topRated.dart';

import 'film_toprated_bloc_test.mocks.dart';

@GenerateMocks([GetFilmTopRated])
void main(){
  late FilmTopRatedBloc topRatedMoviesBloc;
  late MockGetTopRatedFilm mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedFilm();
    topRatedMoviesBloc = FilmTopRatedBloc(mockGetTopRatedMovies);
  });

  final tFilmList = <Film>[];

  group('Now Playing Movies BLoC Test', () {
    blocTest<FilmTopRatedBloc, FilmTopRatedState>(
        'Should emit [Loading, HasData] when data is loaded successfully',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Right(tFilmList));
          return topRatedMoviesBloc;
        },
        act: (bloc) => bloc.add(FetchFilmTopRated()),
        expect: () =>
        [FilmTopRatedLoading(), FilmTopRatedHasData(tFilmList)],
        verify: (bloc) {
          verify(mockGetTopRatedMovies.execute());
        });

    blocTest<FilmTopRatedBloc, FilmTopRatedState>(
        'Should emit [Loading, Error] when data is failed to loaded',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => const Left(ServerFailure('Server Gagal')));
          return topRatedMoviesBloc;
        },
        act: (bloc) => bloc.add(FetchFilmTopRated()),
        expect: () =>
        [FilmTopRatedLoading(), const FilmTopRatedError('Server Gagal')],
        verify: (bloc) {
          verify(mockGetTopRatedMovies.execute());
        });
  });
}