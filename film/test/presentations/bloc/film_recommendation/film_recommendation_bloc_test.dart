import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/core.dart';
import 'package:film/domain/entities/film.dart';
import 'package:film/domain/usecases/get_film_recommendations.dart';
import 'package:film/presentation/bloc/film_recommendation/film_recommendation_bloc.dart';

import 'film_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetRecommendationsFilm])
void main() {
  late RecommendationsFilmBloc recommendationsFilmBloc;
  late MockGetRecommendationsFilm mockGetRecommendationsFilm;

  setUp(() {
    mockGetRecommendationsFilm = MockGetRecommendationsFilm();
    recommendationsFilmBloc = RecommendationsFilmBloc(mockGetRecommendationsFilm);
  });

  final tFilm = Film(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  const tId = 1;
  final tFilms = <Film>[tFilm];

  group('Mengambil Rekomendasi Film', () {
    blocTest<RecommendationsFilmBloc, RecommendationsFilmState>('should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetRecommendationsFilm.execute(tId))
            .thenAnswer((_) async => Right(tFilms));
        return recommendationsFilmBloc;
      },
      act: (bloc) => bloc.add(FetchRecommendationsFilm(tId)),
      expect: () => [RecommendationsFilmLoading(), RecommendationsFilmHasData(tFilms),],
    );

    blocTest<RecommendationsFilmBloc, RecommendationsFilmState>('should emit [Loading, Error] when getting data is failed',
        build: () {
          when(mockGetRecommendationsFilm.execute(tId))
              .thenAnswer((_) async => const Left(ServerFailure('Server Gagal')));
          return recommendationsFilmBloc;
        },
        act: (bloc) => bloc.add(FetchRecommendationsFilm(tId)),
        expect: () => [RecommendationsFilmLoading(), const RecommendationsFilmError('Server Gagal'),],
        verify: (bloc) {
          verify(mockGetRecommendationsFilm.execute(tId));
        }
    );
  });
}
