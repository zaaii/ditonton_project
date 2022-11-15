import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/core.dart';
import 'package:film/domain/entities/film_genre.dart';
import 'package:film/domain/entities/film_detail.dart';
import 'package:film/domain/usecases/get_film_detail.dart';
import 'package:film/presentation/bloc/film_detail/film_detail_bloc.dart';

import 'film_detail_bloc_test.mocks.dart';


@GenerateMocks([GetDetailFilm])
void main() {
  late DetailFilmBloc detailFilmBloc;
  late MockGetDetailFilm mockGetDetailFilm;

  setUp(() {
    mockGetDetailFilm = MockGetDetailFilm();
    detailFilmBloc = DetailFilmBloc(mockGetDetailFilm);
  });

  final tId = 1;

  final tDetailFilm = DetailFilm(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [GenreFilm(id: 1, name: 'Animation')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 1,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  group('Mengambil Detail Film', () {
    blocTest<DetailFilmBloc, DetailFilmState>('should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetDetailFilm.execute(tId))
            .thenAnswer((_) async => Right(tDetailFilm));
        return detailFilmBloc;
      },
      act: (bloc) => bloc.add(FetchDetailFilm(tId)),
      expect: () => [DetailFilmLoading(), DetailFilmHasData(tDetailFilm)],
    );

    blocTest<DetailFilmBloc, DetailFilmState>('should emit [Loading, Error] when getting data is failed',
      build: () {
        when(mockGetDetailFilm.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Gagal')));
        return detailFilmBloc;
      },
      act: (bloc) => bloc.add(FetchDetailFilm(tId)),
      expect: () => [DetailFilmLoading(), DetailFilmError('Server Gagal')],
    );
  });
}
