import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:serialtv/domain/entities/serialtv.dart';
import 'package:serialtv/domain/usecases/get_serialtv_topRated.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetSerialTvTopRated usecase;
  late MockSerialTvRepository mockSerialTvRepository;

  setUp(() {
    mockSerialTvRepository = MockSerialTvRepository();
    usecase = GetSerialTvTopRated(mockSerialTvRepository);
  });

  final tSerialTv = <SerialTv>[];

  group('Mengambil Serial Tv Top Rated', () {
    test('should get top rated list of serial tv from repository', () async {
      // arrange
      when(mockSerialTvRepository.getSerialTvTopRated())
          .thenAnswer((_) async => Right(tSerialTv));
      // act
      final result = await usecase.execute();
      // assert
      expect(result, Right(tSerialTv));
    });
  });
}
