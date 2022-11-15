import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/core.dart';
import 'package:film/domain/entities/film.dart';
import 'package:pencarian/domain/usecases/pencarian_film.dart';
import 'package:pencarian/presentation/bloc/pencarian_film/pencarian_film_bloc.dart';

import 'pencarian_film_bloc_test.mocks.dart';

@GenerateMocks([SearchFilm])
void main() {
  late SearchFilmBloc searchFilmBloc;
  late MockSearchFilm mockSearchFilm;

  setUp(() {
    mockSearchFilm = MockSearchFilm();
    searchFilmBloc = SearchFilmBloc(mockSearchFilm);
  });

  test('initial state should be empty', () {
    expect(searchFilmBloc.state, SearchFilmEmpty());
  });

  final tFilmModel = Film(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tListFilm = <Film>[tFilmModel];
  final tQuery = 'Spiderman';

  group('Test Mencari Film', () {
    blocTest<SearchFilmBloc, SearchFilmState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchFilm.execute(tQuery))
            .thenAnswer((_) async => Right(tListFilm));
        return searchFilmBloc;
      },

      act: (bloc) => bloc.add(OnQueryChangedFilm(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [ SearchFilmLoading(), SearchFilmHasData(tListFilm)],
      verify: (bloc) => verify(mockSearchFilm.execute(tQuery))
    );

    blocTest<SearchFilmBloc, SearchFilmState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchFilm.execute(tQuery))
            .thenAnswer((_) async =>
        const Left(ServerFailure('Server Failure')));
        return searchFilmBloc;
      },
      act: (bloc) => bloc.add(OnQueryChangedFilm(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [ SearchFilmLoading(), SearchFilmError('Server Failure'),],
      verify: (bloc) => verify(mockSearchFilm.execute(tQuery))
    );
  });
}
