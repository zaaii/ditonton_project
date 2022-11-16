import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:film/presentation/bloc/film_toprated/film_toprated_bloc.dart';
import 'package:film/presentation/pages/toprated_film_page.dart';

import '../../data_dummy/dummy_objects.dart';

class MockFilmTopRatedBloc extends MockBloc<FilmTopRatedEvent, FilmTopRatedState>
    implements FilmTopRatedBloc {}

class FilmTopRatedEventFake extends Fake
    implements FilmTopRatedEvent {}

class FilmTopRatedStateFake extends Fake
    implements FilmTopRatedState {}

void main() {
  late MockFilmTopRatedBloc mockFilmTopRatedBloc;

  setUpAll(() {
    registerFallbackValue(FilmTopRatedEventFake());
    registerFallbackValue(FilmTopRatedStateFake());
  });

  setUp(() {
    mockFilmTopRatedBloc = MockFilmTopRatedBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<FilmTopRatedBloc>.value(
      value: mockFilmTopRatedBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    when(() => mockFilmTopRatedBloc.state).thenReturn(FilmTopRatedLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);
    await tester.pumpWidget(_makeTestableWidget(FilmTopRatedPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
    when(() => mockFilmTopRatedBloc.state).thenReturn(FilmTopRatedHasData(testListFilm));

    final listViewFinder = find.byType(ListView);
    await tester.pumpWidget(_makeTestableWidget(FilmTopRatedPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Empty', (WidgetTester tester) async {
    when(() => mockFilmTopRatedBloc.state).thenReturn(FilmTopRatedEmpty());

    final textFinder = find.text('Film Top Rated Tidak Ada');
    await tester.pumpWidget(_makeTestableWidget(FilmTopRatedPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
    when(() => mockFilmTopRatedBloc.state).thenReturn(FilmTopRatedError('Failed'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(FilmTopRatedPage()));

    expect(textFinder, findsOneWidget);
  });
}
