import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:pencarian/domain/usecases/pencarian_serialtv.dart';
import 'package:pencarian/presentation/bloc/pencarian_serialtv/pencarian_serialtv_bloc.dart';
import 'package:serialtv/domain/entities/serialtv.dart';

import 'pencarian_serialtv_bloc_test.mocks.dart';

@GenerateMocks([SearchSerialTv])
void main() {
  late SearchSerialTvBloc searchSerialTvBloc;
  late MockSearchSerialTv mockSearchSerialTv;

  setUp(() {
    mockSearchSerialTv = MockSearchSerialTv();
    searchSerialTvBloc = SearchSerialTvBloc(mockSearchSerialTv);
  });

  test('initial state should be empty', () {
    expect(searchSerialTvBloc.state, SearchSerialTvEmpty());
  });

  final tSerialTvModel = SerialTv(
    backdropPath: '/maFEWU41jdUOzDfRVkojq7fluIm.jpg',
    genreIds: [16, 35, 10751, 10765],
    id: 387,
    originalName: 'SpongeBob SquarePants',
    overview:
    'Deep down in the Pacific Ocean in the subterranean city of Bikini Bottom lives a square yellow sponge named SpongeBob SquarePants. SpongeBob lives in a pineapple with his pet snail, Gary, loves his job as a fry cook at the Krusty Krab, and has a knack for getting into all kinds of trouble without really trying. When he\'s not getting on the nerves of his cranky next door neighbor Squidward, SpongeBob can usually be found smack in the middle of all sorts of strange situations with his best buddy, the simple yet lovable starfish, Patrick, or his thrill-seeking surfer-girl squirrel pal, Sandy Cheeks.',
    popularity: 30.068,
    posterPath: '/amvtZgiTty0GHIgD56gpouBWrcy.jpg',
    firstAirDate: '1999-05-01',
    name: 'SpongeBob SquarePants',
    voteAverage: 7.6,
    voteCount: 2525,
  );

  final tListSerialTv = <SerialTv>[tSerialTvModel];
  const tQuery = 'Spongebob';

  group('Test Mencari Serial Tv', () {
    blocTest<SearchSerialTvBloc, SearchSerialTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchSerialTv.execute(tQuery))
            .thenAnswer((_) async => Right(tListSerialTv));
        return searchSerialTvBloc;
      },
      act: (bloc) => bloc.add(OnQueryChangedSerialTv(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [ SearchSerialTvLoading(), SearchSerialTvHasData(tListSerialTv),],
      verify: (bloc) => verify(mockSearchSerialTv.execute(tQuery))
    );

    blocTest<SearchSerialTvBloc, SearchSerialTvState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchSerialTv.execute(tQuery))
            .thenAnswer((_) async =>
        const Left(ServerFailure('Server Failure')));
        return searchSerialTvBloc;
      },
      act: (bloc) => bloc.add(OnQueryChangedSerialTv(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [ SearchSerialTvLoading(), SearchSerialTvError('Server Failure'),],
      verify: (bloc) => verify(mockSearchSerialTv.execute(tQuery))
    );
  });
}
