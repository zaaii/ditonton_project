import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:serialtv/domain/entities/serialtv.dart';
import 'package:serialtv/domain/usecases/get_serialtv_now_playing.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingSerialTv usecase;
  late MockSerialTvRepository mockSerialTvRepository;

  setUp(() {
    mockSerialTvRepository = MockSerialTvRepository();
    usecase = GetNowPlayingSerialTv(mockSerialTvRepository);
  });

  final tSerialTv = <SerialTv>[];

  group('Test Mengambil Serial Tv Now Playing', () {
    test('should get now playing list of serial tv from the repository', () async {
      // arrange
      when(mockSerialTvRepository.getNowPlayingSerialTv())
          .thenAnswer((_) async => Right(tSerialTv));
      // act
      final result = await usecase.execute();
      // assert
      expect(result, Right(tSerialTv));
    });
  });
}
