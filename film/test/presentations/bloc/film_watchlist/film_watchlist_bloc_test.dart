import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/core.dart';
import 'package:film/domain/usecases/get_film_watchlist_status.dart';
import 'package:film/domain/usecases/get_film_watchlist.dart';
import 'package:film/domain/usecases/remove_film_watchlist.dart';
import 'package:film/domain/usecases/save_film_watchlist.dart';
import 'package:film/presentation/bloc/film_watchlist/film_watchlist_bloc.dart';

import '../../../data_dummy/dummy_objects.dart';
import 'film_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistFilm,
  GetWatchListStatusFilm,
  SaveWatchlistFilm,
  RemoveWatchlistFilm
])
void main() {
  late WatchlistFilmBloc watchlistFilmBloc;
  late MockGetWatchlistFilm mockGetWatchlistFilm;
  late MockGetWatchListStatusFilm mockGetWatchListStatusFilm;
  late MockSaveWatchlistFilm mockSaveWatchlistFilm;
  late MockRemoveWatchlistFilm mockRemoveWatchlistFilm;

  setUp(() {
    mockGetWatchlistFilm = MockGetWatchlistFilm();
    mockGetWatchListStatusFilm = MockGetWatchListStatusFilm();
    mockSaveWatchlistFilm = MockSaveWatchlistFilm();
    mockRemoveWatchlistFilm = MockRemoveWatchlistFilm();
    watchlistFilmBloc = WatchlistFilmBloc(
      mockGetWatchlistFilm,
      mockGetWatchListStatusFilm,
      mockSaveWatchlistFilm,
      mockRemoveWatchlistFilm,
    );
  });

  group('Mengambil Watchlist Film', () {
    blocTest<WatchlistFilmBloc, WatchlistFilmState>('should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistFilm.execute()).thenAnswer(
                  (realInvocation) async => Right([testWatchlistFilm]));
          return watchlistFilmBloc;
        },
        act: (bloc) => bloc.add(LoadWatchlistFilm()),
        expect: () => [WatchlistFilmLoading(), WatchlistFilmHasData([testWatchlistFilm])
        ],
        verify: (bloc) {
          verify(mockGetWatchlistFilm.execute());
        });

    blocTest<WatchlistFilmBloc, WatchlistFilmState>('should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetWatchlistFilm.execute()).thenAnswer((realInvocation) async
        => const Left(DatabaseFailure("Tidak Dapat Mengambil Data")));
        return watchlistFilmBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistFilm()),
      expect: () => [WatchlistFilmLoading(), const WatchlistFilmError("Tidak Dapat Mengambil Data")],
      verify: (bloc) {
        verify(mockGetWatchlistFilm.execute());
      },
    );
  });
}