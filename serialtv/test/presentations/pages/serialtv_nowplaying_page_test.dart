import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:serialtv/presentation/bloc/serialtv_nowplaying/serialtv_nowplaying_bloc.dart';
import 'package:serialtv/presentation/pages/nowplaying_serialtv_page.dart';

import '../../data_dummy/dummy_objects.dart';

class MockNowPlayingSerialTvBloc extends MockBloc<NowPlayingSerialTvEvent, NowPlayingSerialTvState>
    implements NowPlayingSerialTvBloc {}

class NowPlayingSerialTvEventFake extends Fake
    implements NowPlayingSerialTvEvent {}

class NowPlayingSerialTvStateFake extends Fake
    implements NowPlayingSerialTvState {}

void main() {
  late MockNowPlayingSerialTvBloc mockNowPlayingSerialTvBloc;

  setUpAll(() {
    registerFallbackValue(NowPlayingSerialTvEventFake());
    registerFallbackValue(NowPlayingSerialTvStateFake());
  });

  setUp(() {
    mockNowPlayingSerialTvBloc = MockNowPlayingSerialTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingSerialTvBloc>
        .value(value: mockNowPlayingSerialTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    when(() => mockNowPlayingSerialTvBloc.state).thenReturn(NowPlayingSerialTvLoading());
    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(NowPlayingSerialTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
    when(() => mockNowPlayingSerialTvBloc.state).thenReturn(NowPlayingSerialTvHasData(testSerialTvList));
    final listViewFinder = find.byType(ListView);
    await tester.pumpWidget(_makeTestableWidget(NowPlayingSerialTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Empty', (WidgetTester tester) async {
    when(() => mockNowPlayingSerialTvBloc.state).thenReturn(NowPlayingSerialTvEmpty());

    final textFinder = find.text('Serial Tv Now Playing Tidak Ditemukan');
    await tester.pumpWidget(_makeTestableWidget(NowPlayingSerialTvPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
    when(() => mockNowPlayingSerialTvBloc.state).thenReturn(const NowPlayingSerialTvError('Failed'));

    final textFinder = find.byKey(const Key('error_message'));
    await tester.pumpWidget(_makeTestableWidget(NowPlayingSerialTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
