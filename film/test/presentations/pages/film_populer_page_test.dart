import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:film/presentation/bloc/film_populer/film_populer_bloc.dart';
import 'package:film/presentation/pages/populer_film_page.dart';

import '../../data_dummy/dummy_objects.dart';

class MockFilmPopulerBloc
    extends MockBloc<FilmPopulerEvent, FilmPopulerState>
    implements FilmPopulerBloc {}

class FilmPopulerEventFake extends Fake
    implements FilmPopulerEvent {}

class FilmPopulerStateFake extends Fake
    implements FilmPopulerState {}

void main() {
  late MockFilmPopulerBloc mockFilmPopulerBloc;

  setUpAll(() {
    registerFallbackValue(FilmPopulerEventFake());
    registerFallbackValue(FilmPopulerStateFake());
  });

  setUp(() {
    mockFilmPopulerBloc = MockFilmPopulerBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<FilmPopulerBloc>.value(
      value: mockFilmPopulerBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    when(() => mockFilmPopulerBloc.state).thenReturn(FilmPopulerLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);
    await tester.pumpWidget(_makeTestableWidget(FilmPopulerPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
    when(() => mockFilmPopulerBloc.state).thenReturn(FilmPopulerHasData(testListFilm));

    final listViewFinder = find.byType(ListView);
    await tester.pumpWidget(_makeTestableWidget(FilmPopulerPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Empty', (WidgetTester tester) async {
    when(() => mockFilmPopulerBloc.state).thenReturn(FilmPopulerEmpty());

    final textFinder = find.text('Film Populer Tidak Ada');
    await tester.pumpWidget(_makeTestableWidget(FilmPopulerPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
    when(() => mockFilmPopulerBloc.state).thenReturn(const FilmPopulerError('Failed'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(FilmPopulerPage()));

    expect(textFinder, findsOneWidget);
  });
}
