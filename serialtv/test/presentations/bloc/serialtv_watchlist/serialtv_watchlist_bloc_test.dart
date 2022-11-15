import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:serialtv/domain/usecases/get_serialtv_watchlist.dart';
import 'package:serialtv/domain/usecases/get_serialtv_watchlist_status.dart';
import 'package:serialtv/domain/usecases/save_serialtv_watchlist.dart';
import 'package:serialtv/domain/usecases/remove_serialtv_watchlist.dart';
import 'package:serialtv/presentation/bloc/serialtv_watchlist/serialtv_watchlist_bloc.dart';

import '../../../data_dummy/dummy_objects.dart';
import 'serialtv_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistSerialTv,
  GetWatchListStatusSerialTv,
  SaveWatchlistSerialTv,
  RemoveWatchlistSerialTv
])
void main() {
  late WatchlistSerialTvBloc watchlistSerialTvBloc;
  late MockGetWatchlistSerialTv mockGetWatchlistSerialTv;
  late MockGetWatchListStatusSerialTv mockGetWatchListStatusSerialTv;
  late MockSaveWatchlistSerialTv mockSaveWatchlistSerialTv;
  late MockRemoveWatchlistSerialTv mockRemoveWatchlistSerialTv;

  setUp(() {
    mockGetWatchlistSerialTv = MockGetWatchlistSerialTv();
    mockGetWatchListStatusSerialTv = MockGetWatchListStatusSerialTv();
    mockSaveWatchlistSerialTv = MockSaveWatchlistSerialTv();
    mockRemoveWatchlistSerialTv = MockRemoveWatchlistSerialTv();
    watchlistSerialTvBloc = WatchlistSerialTvBloc(
      mockGetWatchlistSerialTv,
      mockGetWatchListStatusSerialTv,
      mockSaveWatchlistSerialTv,
      mockRemoveWatchlistSerialTv,
    );
  });

  group('Mengambil Watchlist Serial Tv', () {
    blocTest<WatchlistSerialTvBloc, WatchlistSerialTvState>('should emit [Loading, HasData] when data is gotten successfully', build: () {
          when(mockGetWatchlistSerialTv.execute()).thenAnswer(
                  (realInvocation) async => Right([testWatchListSerialTv]));
          return watchlistSerialTvBloc;
        },
        act: (bloc) => bloc.add(LoadWatchlistSerialTv()),
        expect: () => [ WatchlistSerialTvLoading(), WatchlistSerialTvHasData([testWatchListSerialTv])],
        verify: (bloc) => verify(mockGetWatchlistSerialTv.execute())
        );

    blocTest<WatchlistSerialTvBloc, WatchlistSerialTvState>('should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetWatchlistSerialTv.execute()).thenAnswer((realInvocation) async
        => const Left(DatabaseFailure("Tidak Dapat Mengambil Data")));
        return watchlistSerialTvBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistSerialTv()),
      expect: () => [WatchlistSerialTvLoading(), const WatchlistSerialTvError("Tidak Dapat Mengambil Data")],
      verify: (bloc) => verify(mockGetWatchlistSerialTv.execute())
    );
  });
}