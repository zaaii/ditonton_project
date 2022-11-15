import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/core.dart';
import 'package:serialtv/domain/entities/serialtv_genre.dart';
import 'package:serialtv/domain/entities/serialtv_detail.dart';
import 'package:serialtv/domain/usecases/get_serialtv_detail.dart';
import 'package:serialtv/presentation/bloc/serialtv_detail/serialtv_detail_bloc.dart';

import 'serialtv_detail_bloc_test.mocks.dart';

@GenerateMocks([GetDetailSerialTv])
void main() {
  late DetailSerialTvBloc detailSerialTvBloc;
  late MockGetDetailSerialTv mockGetDetailSerialTv;

  setUp(() {
    mockGetDetailSerialTv = MockGetDetailSerialTv();
    detailSerialTvBloc = DetailSerialTvBloc(mockGetDetailSerialTv);
  });

  const tId = 1;

  final tSerialTvDetail = DetailSerialTv(
      backdropPath: "/maFEWU41jdUOzDfRVkojq7fluIm.jpg",
      genres: [
        SerialTvGenre(id: 16, name: "Animation"),
        SerialTvGenre(id: 35, name: "Comedy"),
        SerialTvGenre(id: 10751, name: "Family"),
        SerialTvGenre(id: 10765, name: "Sci-Fi & Fantasy")
      ],
      id: 387,
      firstAirDate: "1999-05-01",
      numberOfSeasons: 13,
      numberOfEpisodes: 537,
      overview:
      "Deep down in the Pacific Ocean in the subterranean city of Bikini Bottom lives a square yellow sponge named SpongeBob SquarePants. SpongeBob lives in a pineapple with his pet snail, Gary, loves his job as a fry cook at the Krusty Krab, and has a knack for getting into all kinds of trouble without really trying. When he's not getting on the nerves of his cranky next door neighbor Squidward, SpongeBob can usually be found smack in the middle of all sorts of strange situations with his best buddy, the simple yet lovable starfish, Patrick, or his thrill-seeking surfer-girl squirrel pal, Sandy Cheeks.",
      posterPath: "/amvtZgiTty0GHIgD56gpouBWrcy.jpg",
      name: "SpongeBob SquarePants",
      voteAverage: 7.576,
      voteCount: 2525
  );

  group('Mengambil detail Serial Tv', () {
    blocTest<DetailSerialTvBloc, DetailSerialTvState>('should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetDetailSerialTv.execute(tId))
            .thenAnswer((_) async => Right(tSerialTvDetail));
        return detailSerialTvBloc;
      },
      act: (bloc) => bloc.add(const FetchDetailSerialTv(tId)),
      expect: () => [DetailSerialTvLoading(), DetailSerialTvHasData(tSerialTvDetail)],
    );

    blocTest<DetailSerialTvBloc, DetailSerialTvState>('should emit [Loading, Error] when getting data is failed',
      build: () {
        when(mockGetDetailSerialTv.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Server Gagal')));
        return detailSerialTvBloc;
      },
      act: (bloc) => bloc.add(const FetchDetailSerialTv(tId)),
      expect: () => [DetailSerialTvLoading(), const DetailSerialTvError('Server Gagal')],
    );
  });
}
