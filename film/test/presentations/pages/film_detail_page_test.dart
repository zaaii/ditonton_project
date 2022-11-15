import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:film/domain/entities/film.dart';
import 'package:film/presentation/bloc/film_detail/film_detail_bloc.dart';
import 'package:film/presentation/bloc/film_recommendation/film_recommendation_bloc.dart';
import 'package:film/presentation/bloc/film_watchlist/film_watchlist_bloc.dart';
import 'package:film/presentation/pages/detail_film_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../data_dummy/dummy_objects.dart';

class MockDetailFilmBloc extends MockBloc<DetailFilmEvent, DetailFilmState>
    implements DetailFilmBloc {}

class FakeDetailFilmEvent extends Fake
    implements DetailFilmEvent {}

class FakeDetailFilmState extends Fake
    implements DetailFilmState {}


class MockRecommendationFilmBloc extends MockBloc<RecommendationsFilmEvent, RecommendationsFilmState>
    implements RecommendationsFilmBloc {}

class FakeRecommendationFilmEvent extends Fake
    implements RecommendationsFilmEvent {}

class FakeRecommendationFilmState extends Fake
    implements RecommendationsFilmState {}


class MockWatchlistFilmBloc extends MockBloc<WatchlistFilmEvent, WatchlistFilmState>
    implements WatchlistFilmBloc {}

class FakeWatchlistFilmEvent extends Fake
    implements WatchlistFilmEvent {}

class FakeWatchlistFilmState extends Fake
    implements WatchlistFilmState {}

void main() {
  late MockDetailFilmBloc mockDetailFilmBloc;
  late MockRecommendationFilmBloc mockRecommendationFilmBloc;
  late MockWatchlistFilmBloc mockWatchlistFilmBloc;

  setUpAll(() {
    registerFallbackValue(FakeDetailFilmEvent());
    registerFallbackValue(FakeDetailFilmState());
    registerFallbackValue(FakeRecommendationFilmEvent());
    registerFallbackValue(FakeRecommendationFilmState());
    registerFallbackValue(FakeWatchlistFilmEvent());
    registerFallbackValue(FakeWatchlistFilmState());
  });

  setUp(() {
    mockDetailFilmBloc = MockDetailFilmBloc();
    mockRecommendationFilmBloc = MockRecommendationFilmBloc();
    mockWatchlistFilmBloc = MockWatchlistFilmBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<DetailFilmBloc>(create: (_) => mockDetailFilmBloc),
          BlocProvider<RecommendationsFilmBloc>(create: (_) => mockRecommendationFilmBloc),
          BlocProvider<WatchlistFilmBloc>(create: (_) => mockWatchlistFilmBloc),
        ],
        child: MaterialApp(
          home: body,
        ));
  }

  tearDown(() {
    mockDetailFilmBloc.close();
    mockRecommendationFilmBloc.close();
    mockWatchlistFilmBloc.close();
  });

  final tId = 1;

  final tFilm = Film(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tFilms = <Film>[tFilm];

  testWidgets('Watchlist button should display add icon when movie not added to watchlist', (WidgetTester tester) async {
        when(() => mockDetailFilmBloc.add(FetchDetailFilm(tId)))
            .thenAnswer((invocation) {});
        when(() => mockDetailFilmBloc.state)
            .thenAnswer((invocation) => DetailFilmHasData(testDetailFilm));
        when(() => mockRecommendationFilmBloc.add(FetchRecommendationsFilm(tId)))
            .thenAnswer((invocation) {});
        when(() => mockRecommendationFilmBloc.state)
            .thenAnswer((invocation) => RecommendationsFilmHasData(tFilms));
        when(() => mockWatchlistFilmBloc.add(LoadWatchListStatusFilm(tId)))
            .thenAnswer((invocation) {});
        when(() => mockWatchlistFilmBloc.state)
            .thenAnswer((invocation) => WatchlistFilmStatus(false));

        final watchlistButtonIcon = find.byIcon(Icons.add);
        await tester.pumpWidget(_makeTestableWidget(DetailFilmPage(id: 1)));
        expect(watchlistButtonIcon, findsOneWidget);
      });

  testWidgets('Watchlist button should dispay check icon when movie is added to wathclist', (WidgetTester tester) async {
        when(() => mockDetailFilmBloc.add(FetchDetailFilm(tId)))
            .thenAnswer((invocation) {});
        when(() => mockDetailFilmBloc.state)
            .thenAnswer((invocation) => DetailFilmHasData(testDetailFilm));
        when(() => mockRecommendationFilmBloc.add(FetchRecommendationsFilm(tId)))
            .thenAnswer((invocation) {});
        when(() => mockRecommendationFilmBloc.state)
            .thenAnswer((invocation) => RecommendationsFilmHasData(tFilms));
        when(() => mockWatchlistFilmBloc.add(LoadWatchListStatusFilm(tId)))
            .thenAnswer((invocation) {});
        when(() => mockWatchlistFilmBloc.add(AddWatchlistFilm(testDetailFilm)))
            .thenAnswer((invocation) {});
        when(() => mockWatchlistFilmBloc.state).thenAnswer(
                (invocation) => WatchlistFilmStatus(true));

        final watchlistButtonIcon = find.byIcon(Icons.check);

        await tester.pumpWidget(_makeTestableWidget(DetailFilmPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });
}