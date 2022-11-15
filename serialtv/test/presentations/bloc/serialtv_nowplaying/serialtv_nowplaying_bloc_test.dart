import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/core.dart';
import 'package:serialtv/domain/entities/serialtv.dart';
import 'package:serialtv/domain/usecases/get_serialtv_now_playing.dart';
import 'package:serialtv/presentation/bloc/serialtv_nowPlaying/serialtv_nowplaying_bloc.dart';

import 'serialtv_nowplaying_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingSerialTv])
void main() {
  late NowPlayingSerialTvBloc nowPlayingSerialTvBloc;
  late MockGetNowPlayingSerialTv mockGetNowPlayingSerialTv;

  setUp(() {
    mockGetNowPlayingSerialTv = MockGetNowPlayingSerialTv();
    nowPlayingSerialTvBloc = NowPlayingSerialTvBloc(mockGetNowPlayingSerialTv);
  });

  final tSerialTv = <SerialTv>[];

  group('Mengambil Now Playing Serial Tv', () {
    blocTest<NowPlayingSerialTvBloc, NowPlayingSerialTvState>('should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingSerialTv.execute())
            .thenAnswer((_) async => Right(tSerialTv));
        return nowPlayingSerialTvBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingSerialTv()),
      expect: () => [NowPlayingSerialTvLoading(), NowPlayingSerialTvHasData(tSerialTv),],
    );

    blocTest<NowPlayingSerialTvBloc, NowPlayingSerialTvState>('should emit [Loading, Error] when getting data is failed',
        build: () {
          when(mockGetNowPlayingSerialTv.execute())
              .thenAnswer((_) async => const Left(ServerFailure('Server Gagal')));
          return nowPlayingSerialTvBloc;
        },
        act: (bloc) => bloc.add(FetchNowPlayingSerialTv()),
        expect: () => [NowPlayingSerialTvLoading(), const NowPlayingSerialTvError('Server Gagal')],
        verify: (bloc) => verify(mockGetNowPlayingSerialTv.execute())
    );
  });
}
