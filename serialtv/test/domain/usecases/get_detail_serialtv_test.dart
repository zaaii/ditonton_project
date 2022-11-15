import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:serialtv/domain/usecases/get_serialtv_detail.dart';

import '../../data_dummy/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetDetailSerialTv usecase;
  late MockSerialTvRepository mockSerialTvRepository;

  setUp(() {
    mockSerialTvRepository = MockSerialTvRepository();
    usecase = GetDetailSerialTv(mockSerialTvRepository);
  });

  const tId = 1;

  group('Test Mengambil Detail Serial Tv', () {
    test('should get serial tv detail from the repository', () async {
      // arrange
      when(mockSerialTvRepository.getDetailSerialTv(tId))
          .thenAnswer((_) async => Right(testDetailSerialTv));
      // act
      final result = await usecase.execute(tId);
      // assert
      expect(result, Right(testDetailSerialTv));
    });
  });
}
