import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:serialtv/presentation/bloc/serialtv_toprated/serialtv_toprated_bloc.dart';
import 'package:serialtv/presentation/pages/toprated_serialtv_page.dart';

import '../../data_dummy/dummy_objects.dart';

class MockSerialTvTopRatedBloc extends MockBloc<SerialTvTopRatedEvent, SerialTvTopRatedState>
    implements SerialTvTopRatedBloc {}

class SerialTvTopRatedEventFake extends Fake
    implements SerialTvTopRatedEvent {}

class SerialTvTopRatedStateFake extends Fake
    implements SerialTvTopRatedState {}

void main() {
  late MockSerialTvTopRatedBloc mockSerialTvTopRatedBloc;

  setUpAll(() {
    registerFallbackValue(SerialTvTopRatedEventFake());
    registerFallbackValue(SerialTvTopRatedStateFake());
  });

  setUp(() {
    mockSerialTvTopRatedBloc = MockSerialTvTopRatedBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SerialTvTopRatedBloc>.value(
      value: mockSerialTvTopRatedBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    when(() => mockSerialTvTopRatedBloc.state).thenReturn(SerialTvTopRatedLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);
    await tester.pumpWidget(_makeTestableWidget(SerialTvTopRatedPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
    when(() => mockSerialTvTopRatedBloc.state).thenReturn(SerialTvTopRatedHasData(testSerialTvList));

    final listViewFinder = find.byType(ListView);
    await tester.pumpWidget(_makeTestableWidget(SerialTvTopRatedPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Empty', (WidgetTester tester) async {
    when(() => mockSerialTvTopRatedBloc.state).thenReturn(SerialTvTopRatedEmpty());

    final textFinder = find.text('Serial Tv Top Rated Tidak Ditemukan');
    await tester.pumpWidget(_makeTestableWidget(SerialTvTopRatedPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
    when(() => mockSerialTvTopRatedBloc.state).thenReturn(SerialTvTopRatedError('Failed'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(SerialTvTopRatedPage()));

    expect(textFinder, findsOneWidget);
  });
}
