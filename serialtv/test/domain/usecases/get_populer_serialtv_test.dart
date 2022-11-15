import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:serialtv/domain/entities/serialtv.dart';
import 'package:serialtv/domain/usecases/get_serialtv_populer.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetSerialTvPopuler usecase;
  late MockSerialTvRepository mockSerialTvRepository;

  setUp(() {
    mockSerialTvRepository = MockSerialTvRepository();
    usecase = GetSerialTvPopuler(mockSerialTvRepository);
  });

  final tSerialTv = <SerialTv>[];

  group('Test Mengambil Serial Tv Populer', () {
      test('should get popular list of tv from the repository when execute function is called', () async {
            // arrange
            when(mockSerialTvRepository.getSerialTvPopuler())
                .thenAnswer((_) async => Right(tSerialTv));
            // act
            final result = await usecase.execute();
            // assert
            expect(result, Right(tSerialTv));
          });
    });
}
