import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:serialtv/domain/entities/serialtv.dart';
import 'package:serialtv/domain/usecases/get_serialtv_recommendations.dart';
import 'package:serialtv/presentation/bloc/serialtv_recommendation/serialtv_recommendation_bloc.dart';

import 'serialtv_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetRecommendationsSerialTv])
void main() {
  late RecommendationsSerialTvBloc recommendationsSerialTvBloc;
  late MockGetRecommendationsSerialTv mockGetRecommendationsSerialTv;

  setUp(() {
    mockGetRecommendationsSerialTv = MockGetRecommendationsSerialTv();
    recommendationsSerialTvBloc = RecommendationsSerialTvBloc(mockGetRecommendationsSerialTv);
  });

  const tId = 1;

  final tSerialTv = SerialTv(
      backdropPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
      genreIds: [10765, 18, 10759],
      id: 94997,
      originalName: "House of the Dragon",
      overview:
      "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
      popularity: 5516.822,
      posterPath: "/z2yahl2uefxDCl0nogcRBstwruJ.jpg",
      firstAirDate: "2022-08-21",
      name: "House of the Dragon",
      voteAverage: 8.6,
      voteCount: 1452
  );

  final tSerialTvs = <SerialTv>[tSerialTv];

  group('Mengambil Rekomendasi Serial Tv', () {
    blocTest<RecommendationsSerialTvBloc, RecommendationsSerialTvState>('should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetRecommendationsSerialTv.execute(tId))
            .thenAnswer((_) async => Right(tSerialTvs));
        return recommendationsSerialTvBloc;
      },
      act: (bloc) => bloc.add(FetchRecommendationsSerialTv(tId)),
      expect: () => [RecommendationsSerialTvLoading(), RecommendationsSerialTvHasData(tSerialTvs)],
    );

    blocTest<RecommendationsSerialTvBloc, RecommendationsSerialTvState>('should emit [Loading, Error] when getting data is failed',
        build: () {
          when(mockGetRecommendationsSerialTv.execute(tId))
              .thenAnswer((_) async => const Left(ServerFailure('Server Gagal')));
          return recommendationsSerialTvBloc;
        },
        act: (bloc) => bloc.add(const FetchRecommendationsSerialTv(tId)),
        expect: () => [RecommendationsSerialTvLoading(), const RecommendationsSerialTvError('Server Gagal')],
        verify: (bloc) {
          verify(mockGetRecommendationsSerialTv.execute(tId));
        }
    );
  });
}
