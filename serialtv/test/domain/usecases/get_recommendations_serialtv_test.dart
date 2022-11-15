import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:serialtv/domain/entities/serialtv.dart';
import 'package:serialtv/domain/usecases/get_serialtv_recommendations.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetRecommendationsSerialTv usecase;
  late MockSerialTvRepository mockSerialTvRepository;

  setUp(() {
    mockSerialTvRepository = MockSerialTvRepository();
    usecase = GetRecommendationsSerialTv(mockSerialTvRepository);
  });

  const tId = 1;
  final tSerialTv = <SerialTv>[];

  group('Test Mengambil Rekomendasi SerialTv', () {
    test('should get list of serial tv recommendations from the repository',
            () async {
          // arrange
          when(mockSerialTvRepository.getRecommendationsSerialTv(tId))
              .thenAnswer((_) async => Right(tSerialTv));
          // act
          final result = await usecase.execute(tId);
          // assert
          expect(result, Right(tSerialTv));
        });
  });
}
