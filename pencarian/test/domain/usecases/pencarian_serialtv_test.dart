import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:serialtv/domain/entities/serialtv.dart';
import 'package:pencarian/domain/usecases/pencarian_serialtv.dart';

import '../../helpers/serialtv/serialtv_test_helper.mocks.dart';

void main() {
  late SearchSerialTv usecase;
  late MockSerialTvRepository mockSerialTvRepository;

  setUp(() {
    mockSerialTvRepository = MockSerialTvRepository();
    usecase = SearchSerialTv(mockSerialTvRepository);
  });

  final tSerialTv = <SerialTv>[];
  final tQuery = 'Spongebob';

  test('should get list of Serial Tv from the repository', () async {
    // arrange
    when(mockSerialTvRepository.searchSerialTv(tQuery))
        .thenAnswer((_) async => Right(tSerialTv));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tSerialTv));
  });
}
