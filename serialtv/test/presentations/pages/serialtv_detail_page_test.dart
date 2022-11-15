import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:serialtv/domain/entities/serialtv.dart';
import 'package:serialtv/presentation/bloc/serialtv_detail/serialtv_detail_bloc.dart';
import 'package:serialtv/presentation/bloc/serialtv_recommendation/serialtv_recommendation_bloc.dart';
import 'package:serialtv/presentation/bloc/serialtv_watchlist/serialtv_watchlist_bloc.dart';
import 'package:serialtv/presentation/pages/detail_serialtv_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../data_dummy/dummy_objects.dart';

class MockDetailSerialTvBloc extends MockBloc<DetailSerialTvEvent, DetailSerialTvState>
    implements DetailSerialTvBloc {}

class FakeDetailSerialTvEvent extends Fake
    implements DetailSerialTvEvent {}

class FakeDetailSerialTvState extends Fake
    implements DetailSerialTvState {}

class MockRecommendationsSerialTvBloc extends MockBloc<RecommendationsSerialTvEvent, RecommendationsSerialTvState>
    implements RecommendationsSerialTvBloc {}

class FakeRecommendationsSerialTvEvent extends Fake
    implements RecommendationsSerialTvEvent {}

class FakeRecommendationsSerialTvState extends Fake
    implements RecommendationsSerialTvState {}


class MockWatchlistSerialTvBloc extends MockBloc<WatchlistSerialTvEvent, WatchlistSerialTvState>
    implements WatchlistSerialTvBloc {}

class FakeWatchlistSerialTvEvent extends Fake
    implements WatchlistSerialTvEvent {}

class FakeWatchlistSerialTvState extends Fake
    implements WatchlistSerialTvState {}

void main() {
  late MockDetailSerialTvBloc mockDetailSerialTvBloc;
  late MockRecommendationsSerialTvBloc mockRecommendationsSerialTvBloc;
  late MockWatchlistSerialTvBloc mockWatchlistSerialTvBloc;

  setUpAll(() {
    mockDetailSerialTvBloc = MockDetailSerialTvBloc();
    mockRecommendationsSerialTvBloc = MockRecommendationsSerialTvBloc();
    mockWatchlistSerialTvBloc = MockWatchlistSerialTvBloc();

    registerFallbackValue(FakeDetailSerialTvEvent());
    registerFallbackValue(FakeDetailSerialTvState());
    registerFallbackValue(FakeRecommendationsSerialTvEvent());
    registerFallbackValue(FakeRecommendationsSerialTvState());
    registerFallbackValue(FakeWatchlistSerialTvEvent());
    registerFallbackValue(FakeWatchlistSerialTvState());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<DetailSerialTvBloc>(create: (_) => mockDetailSerialTvBloc),
          BlocProvider<RecommendationsSerialTvBloc>(create: (_) => mockRecommendationsSerialTvBloc),
          BlocProvider<WatchlistSerialTvBloc>(create: (_) => mockWatchlistSerialTvBloc),
        ],
        child: MaterialApp(
          home: body,
        ));
  }

  tearDown(() {
    mockDetailSerialTvBloc.close();
    mockRecommendationsSerialTvBloc.close();
    mockWatchlistSerialTvBloc.close();
  });

  final tId = 1;

  final tSerialTv = SerialTv(
      backdropPath: "/path.jpg",
      genreIds: [1, 2],
      id: 1,
      originalName: "Title",
      overview: "Title",
      popularity: 1.0,
      posterPath: "/path.jpg",
      firstAirDate: "2022-08-22",
      name: "Title",
      voteAverage: 1.0,
      voteCount: 1
  );
  final tSerialTvs = <SerialTv>[tSerialTv];

  testWidgets('Watchlist button should display add icon when Serial Tv not added to watchlist', (WidgetTester tester) async {
    when(() => mockDetailSerialTvBloc.add(FetchDetailSerialTv(tId)))
        .thenAnswer((invocation) {});
    when(() => mockDetailSerialTvBloc.state)
        .thenAnswer((invocation) => DetailSerialTvHasData(testDetailSerialTv));
    when(() => mockRecommendationsSerialTvBloc.add(FetchRecommendationsSerialTv(tId)))
        .thenAnswer((invocation) {});
    when(() => mockRecommendationsSerialTvBloc.state)
        .thenAnswer((invocation) => RecommendationsSerialTvHasData(tSerialTvs));
    when(() => mockWatchlistSerialTvBloc.add(LoadWatchListStatusSerialTv(tId)))
        .thenAnswer((invocation) {});
    when(() => mockWatchlistSerialTvBloc.state)
        .thenAnswer((invocation) => WatchlistSerialTvStatus(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);
    await tester.pumpWidget(_makeTestableWidget(DetailSerialTvPage(id: 1)));
    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets('Watchlist button should dispay check icon when serial tv is added to watchlist', (WidgetTester tester) async {
    when(() => mockDetailSerialTvBloc.add(FetchDetailSerialTv(tId)))
        .thenAnswer((invocation) {});
    when(() => mockDetailSerialTvBloc.state)
        .thenAnswer((invocation) => DetailSerialTvHasData(testDetailSerialTv));
    when(() => mockRecommendationsSerialTvBloc.add(FetchRecommendationsSerialTv(tId)))
        .thenAnswer((invocation) {});
    when(() => mockRecommendationsSerialTvBloc.state)
        .thenAnswer((invocation) => RecommendationsSerialTvHasData(tSerialTvs));
    when(() => mockWatchlistSerialTvBloc.add(LoadWatchListStatusSerialTv(tId)))
        .thenAnswer((invocation) {});
    when(() => mockWatchlistSerialTvBloc.state)
        .thenAnswer((invocation) => WatchlistSerialTvStatus(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(DetailSerialTvPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}