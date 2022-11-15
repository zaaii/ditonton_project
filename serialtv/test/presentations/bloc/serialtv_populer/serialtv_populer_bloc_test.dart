import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:serialtv/domain/entities/serialtv.dart';
import 'package:serialtv/domain/usecases/get_serialtv_populer.dart';
import 'package:serialtv/presentation/bloc/serialtv_populer/serialtv_populer_bloc.dart';

import 'serialtv_populer_bloc_test.mocks.dart';

@GenerateMocks([GetSerialTvPopuler])
void main() {
  late SerialTvPopulerBloc serialTvPopulerBloc;
  late MockGetSerialTvPopuler mockGetSerialTvPopuler;

  setUp(() {
    mockGetSerialTvPopuler = MockGetSerialTvPopuler();
    serialTvPopulerBloc = SerialTvPopulerBloc(mockGetSerialTvPopuler);
  });

  final tSerialTv = <SerialTv>[];

  group('Mengambil Serial Tv Populer', () {
    blocTest<SerialTvPopulerBloc, SerialTvPopulerState>('should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetSerialTvPopuler.execute())
            .thenAnswer((_) async => Right(tSerialTv));
        return serialTvPopulerBloc;
      },
      act: (bloc) => bloc.add(FetchSerialTvPopuler()),
      expect: () => [SerialTvPopulerLoading(), SerialTvPopulerHasData(tSerialTv),],
    );

    blocTest<SerialTvPopulerBloc, SerialTvPopulerState>('should emit [Loading, Error] when getting data is failed',
        build: () {
          when(mockGetSerialTvPopuler.execute())
              .thenAnswer((_) async => const Left(ServerFailure('Server Gagal')));
          return serialTvPopulerBloc;
        },
        act: (bloc) => bloc.add(FetchSerialTvPopuler()),
        expect: () => [SerialTvPopulerLoading(), const SerialTvPopulerError('Server Gagal')],
        verify: (bloc) => verify(mockGetSerialTvPopuler.execute())
    );
  });
}
