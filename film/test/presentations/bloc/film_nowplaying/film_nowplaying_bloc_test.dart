import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/core.dart';
import 'package:film/domain/entities/film.dart';
import 'package:film/domain/usecases/get_film_nowplaying.dart';
import 'package:film/presentation/bloc/film_nowPlaying/film_nowplaying_bloc.dart';

import 'film_nowplaying_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingFilm])
void main() {
  late NowPlayingFilmBloc nowPlayingFilmBloc;
  late MockGetNowPlayingFilm mockGetNowPlayingFilm;

  setUp(() {
    mockGetNowPlayingFilm = MockGetNowPlayingFilm();
    nowPlayingFilmBloc = NowPlayingFilmBloc(mockGetNowPlayingFilm);
  });

  final tFilm = <Film>[];

  group('Mengambil Film Now Playing', () {
    blocTest<NowPlayingFilmBloc, NowPlayingFilmState>('should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingFilm.execute())
            .thenAnswer((_) async => Right(tFilm));
        return nowPlayingFilmBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingFilm()),
      expect: () => [NowPlayingFilmLoading(), NowPlayingFilmHasData(tFilm),],
    );

    blocTest<NowPlayingFilmBloc, NowPlayingFilmState>('should emit [Loading, Error] when getting data is failed',
        build: () {
          when(mockGetNowPlayingFilm.execute())
              .thenAnswer((_) async => const Left(ServerFailure('Server Gagal')));
          return nowPlayingFilmBloc;
        },
        act: (bloc) => bloc.add(FetchNowPlayingFilm()),
        expect: () => [NowPlayingFilmLoading(), const NowPlayingFilmError('Server Gagal'),
        ],
        verify: (bloc) {
          verify(mockGetNowPlayingFilm.execute());
        }
    );
  });
}
